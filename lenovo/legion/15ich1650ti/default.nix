{ lib, config, ... }:

{
  imports = [
    ../../../common/cpu/intel
    ../../../common/pc/laptop
    ../../../common/pc/ssd
    ../../../common/gpu/nvidia/prime.nix
    ../../../common/gpu/nvidia/turing
  ];

  boot.initrd.kernelModules = [ "nvidia" ];
  boot.extraModulePackages = [
    config.boot.kernelPackages.lenovo-legion-module
    config.boot.kernelPackages.nvidia_x11
  ];

  hardware = {
    nvidia = {
      modesetting.enable = lib.mkDefault true;
      powerManagement.enable = lib.mkDefault true;

      prime = {
        intelBusId = "PCI:00:02:0";
        nvidiaBusId = "PCI:01:00:0";
      };
    };
  };

  # Cooling management
  services.thermald.enable = lib.mkDefault true;

  # √(3840² + 2160²) px / 15.60 in ≃ 282 dpi
  services.xserver.dpi = 282;
}
