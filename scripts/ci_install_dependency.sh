#!/bin/bash
# Install the dependency in CI.
set -euxo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
bash "${SCRIPT_DIR}/killall_sglang.sh"

# Clean up existing installations
pip uninstall -y flashinfer flashinfer_python sgl-kernel sglang vllm || true
pip cache purge
rm -rf /root/.cache/flashinfer
rm -rf /usr/local/lib/python3.10/dist-packages/flashinfer*
rm -rf /usr/local/lib/python3.10/dist-packages/sgl_kernel*

# Update pip
pip install --upgrade pip

# Install sgl-kernel
pip install sgl-kernel==0.0.9.post2 --no-cache-dir

# Install the main package
pip install -e "python[all]"

# Install additional dependencies
pip install torch_memory_saver
pip install transformers==4.51.0 sentence_transformers accelerate peft pandas datasets timm torchaudio

# For compling xgrammar kernels
pip install cuda-python nvidia-cuda-nvrtc-cu12
