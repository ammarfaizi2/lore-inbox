Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264555AbSIWFJX>; Mon, 23 Sep 2002 01:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264560AbSIWFJX>; Mon, 23 Sep 2002 01:09:23 -0400
Received: from h106-129-61.datawire.net ([207.61.129.106]:36320 "EHLO
	newmail.datawire.net") by vger.kernel.org with ESMTP
	id <S264555AbSIWFI6>; Mon, 23 Sep 2002 01:08:58 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: 2.5.38 Compile problem - APIC Athlon MP 2000+
Date: Mon, 23 Sep 2002 01:14:04 -0400
User-Agent: KMail/1.4.6
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_cMqj9Ye37ce3Gv/"
Message-Id: <200209230114.04298.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_cMqj9Ye37ce3Gv/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

arch/i386/kernel/built-in.o: In function `disconnect_bsp_APIC':
arch/i386/kernel/built-in.o(.text+0xd4a5): undefined reference to `pic_mode'
arch/i386/kernel/built-in.o: In function `clear_IO_APIC':
arch/i386/kernel/built-in.o(.text+0xe3f8): undefined reference to `nr_ioapi=
cs'
arch/i386/kernel/built-in.o(.text+0xe42d): undefined reference to `nr_ioapi=
cs'
arch/i386/kernel/built-in.o: In function `IO_APIC_get_PCI_irq_vector':
arch/i386/kernel/built-in.o(.text+0xe4f6): undefined reference to=20
`mp_bus_id_to_pci_
bus'
arch/i386/kernel/built-in.o(.text+0xe503): undefined reference to=20
`mp_irq_entries'
arch/i386/kernel/built-in.o(.text+0xe512): undefined reference to `nr_ioapi=
cs'
arch/i386/kernel/built-in.o(.text+0xe51c): undefined reference to `mp_irqs'
arch/i386/kernel/built-in.o(.text+0xe525): undefined reference to `mp_ioapi=
cs'
arch/i386/kernel/built-in.o(.text+0xe52d): undefined reference to `mp_irqs'
arch/i386/kernel/built-in.o(.text+0xe543): undefined reference to=20
`mp_bus_id_to_type
'
arch/i386/kernel/built-in.o(.text+0xe55e): undefined reference to `mp_irqs'
arch/i386/kernel/built-in.o(.text+0xe56f): undefined reference to `mp_irqs'
arch/i386/kernel/built-in.o(.text+0xe583): undefined reference to `mp_irqs'
arch/i386/kernel/built-in.o(.text+0xe5b7): undefined reference to `mp_irqs'
arch/i386/kernel/built-in.o(.text+0xe5d7): undefined reference to=20
`mp_irq_entries'
arch/i386/kernel/built-in.o: In function `pin_2_irq':
arch/i386/kernel/built-in.o(.text+0xe612): undefined reference to `mp_irqs'
arch/i386/kernel/built-in.o(.text+0xe645): undefined reference to=20
`mp_bus_id_to_type
'
arch/i386/kernel/built-in.o(.text+0xe65a): undefined reference to `mp_irqs'
arch/i386/kernel/built-in.o: In function `io_apic_set_pci_routing':
arch/i386/kernel/built-in.o(.text+0xee3c): undefined reference to `mp_ioapi=
cs'
arch/i386/kernel/built-in.o: In function `setup_memory':
arch/i386/kernel/built-in.o(.text.init+0x10e0): undefined reference to=20
`find_smp_con
fig'
arch/i386/kernel/built-in.o: In function `setup_arch':
arch/i386/kernel/built-in.o(.text.init+0x149a): undefined reference to=20
`smp_found_co
nfig'
arch/i386/kernel/built-in.o(.text.init+0x14c1): undefined reference to=20
`get_smp_conf
ig'
arch/i386/kernel/built-in.o: In function `acpi_parse_lapic':
arch/i386/kernel/built-in.o(.text.init+0x49a2): undefined reference to=20
`mp_register_
lapic'
arch/i386/kernel/built-in.o: In function `acpi_parse_ioapic':
arch/i386/kernel/built-in.o(.text.init+0x4a52): undefined reference to=20
`mp_register_
ioapic'
arch/i386/kernel/built-in.o: In function `acpi_parse_int_src_ovr':
arch/i386/kernel/built-in.o(.text.init+0x4aa2): undefined reference to=20
`mp_override_
legacy_irq'
arch/i386/kernel/built-in.o: In function `acpi_boot_init':
arch/i386/kernel/built-in.o(.text.init+0x4c18): undefined reference to=20
`mp_register_
lapic_address'
arch/i386/kernel/built-in.o(.text.init+0x4c91): undefined reference to=20
`mp_config_ac
pi_legacy_irqs'
arch/i386/kernel/built-in.o(.text.init+0x4ce9): undefined reference to=20
`smp_found_co
nfig'
arch/i386/kernel/built-in.o: In function `connect_bsp_APIC':
arch/i386/kernel/built-in.o(.text.init+0x4e54): undefined reference to=20
`pic_mode'
arch/i386/kernel/built-in.o: In function `init_bsp_APIC':
arch/i386/kernel/built-in.o(.text.init+0x4f32): undefined reference to=20
`smp_found_co
nfig'
arch/i386/kernel/built-in.o: In function `setup_local_APIC':
arch/i386/kernel/built-in.o(.text.init+0x4fac): undefined reference to=20
`phys_cpu_pre
sent_map'
arch/i386/kernel/built-in.o(.text.init+0x4fc9): undefined reference to=20
`pic_mode'
arch/i386/kernel/built-in.o: In function `detect_init_APIC':
arch/i386/kernel/built-in.o(.text.init+0x51e7): undefined reference to=20
`mp_lapic_add
r'
arch/i386/kernel/built-in.o(.text.init+0x51f1): undefined reference to=20
`boot_cpu_phy
sical_apicid'
arch/i386/kernel/built-in.o: In function `init_apic_mappings':
arch/i386/kernel/built-in.o(.text.init+0x52a6): undefined reference to=20
`smp_found_co
nfig'
arch/i386/kernel/built-in.o(.text.init+0x52b4): undefined reference to=20
`mp_lapic_add
r'
arch/i386/kernel/built-in.o(.text.init+0x52d6): undefined reference to=20
`boot_cpu_phy
sical_apicid'
arch/i386/kernel/built-in.o(.text.init+0x52e6): undefined reference to=20
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x52f1): undefined reference to=20
`smp_found_co
nfig'
arch/i386/kernel/built-in.o(.text.init+0x52fc): undefined reference to=20
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x531c): undefined reference to=20
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x535a): undefined reference to=20
`boot_cpu_phy
sical_apicid'
arch/i386/kernel/built-in.o: In function `APIC_init_uniprocessor':
arch/i386/kernel/built-in.o(.text.init+0x55c4): undefined reference to=20
`smp_found_co
nfig'
arch/i386/kernel/built-in.o(.text.init+0x55ea): undefined reference to=20
`boot_cpu_phy
sical_apicid'
arch/i386/kernel/built-in.o(.text.init+0x55f1): undefined reference to=20
`apic_version
'
arch/i386/kernel/built-in.o(.text.init+0x5603): undefined reference to=20
`boot_cpu_phy
sical_apicid'
arch/i386/kernel/built-in.o(.text.init+0x5609): undefined reference to=20
`phys_cpu_pre
sent_map'
arch/i386/kernel/built-in.o(.text.init+0x562a): undefined reference to=20
`smp_found_co
nfig'
arch/i386/kernel/built-in.o(.text.init+0x563c): undefined reference to=20
`nr_ioapics'
arch/i386/kernel/built-in.o: In function `find_irq_entry':
arch/i386/kernel/built-in.o(.text.init+0x5938): undefined reference to=20
`mp_irq_entri
es'
arch/i386/kernel/built-in.o(.text.init+0x5945): undefined reference to=20
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x594a): undefined reference to=20
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x5972): undefined reference to=20
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x5984): undefined reference to=20
`mp_irqs'
arch/i386/kernel/built-in.o: In function `find_isa_irq_pin':
arch/i386/kernel/built-in.o(.text.init+0x59a8): undefined reference to=20
`mp_irq_entri
es'
arch/i386/kernel/built-in.o(.text.init+0x59b5): undefined reference to=20
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x59ba): undefined reference to=20
`mp_bus_id_to
_type'
arch/i386/kernel/built-in.o(.text.init+0x59e8): undefined reference to=20
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x59f4): undefined reference to=20
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x5a02): undefined reference to=20
`mp_irqs'
arch/i386/kernel/built-in.o: In function `MPBIOS_polarity':
arch/i386/kernel/built-in.o(.text.init+0x5a5d): undefined reference to=20
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x5a65): undefined reference to=20
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x5aa6): undefined reference to=20
`mp_bus_id_to
_type'
arch/i386/kernel/built-in.o: In function `MPBIOS_trigger':
arch/i386/kernel/built-in.o(.text.init+0x5ae1): undefined reference to=20
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x5ae9): undefined reference to=20
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x5b3f): undefined reference to=20
`mp_bus_id_to
_type'
arch/i386/kernel/built-in.o(.text.init+0x5b67): undefined reference to=20
`mp_irqs'
arch/i386/kernel/built-in.o: In function `setup_IO_APIC_irqs':
arch/i386/kernel/built-in.o(.text.init+0x5c14): undefined reference to=20
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x5da2): undefined reference to=20
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x5e5c): undefined reference to=20
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x5ef0): undefined reference to=20
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x5f12): undefined reference to=20
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x5f4e): undefined reference to=20
`mp_ioapics'
arch/i386/kernel/built-in.o: In function `print_IO_APIC':
arch/i386/kernel/built-in.o(.text.init+0x606a): undefined reference to=20
`mp_irq_entri
es'
arch/i386/kernel/built-in.o(.text.init+0x6080): undefined reference to=20
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x609a): undefined reference to=20
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6121): undefined reference to=20
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6352): undefined reference to=20
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x645c): undefined reference to=20
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x647e): undefined reference to=20
`nr_ioapics'
arch/i386/kernel/built-in.o: In function `enable_IO_APIC':
arch/i386/kernel/built-in.o(.text.init+0x64db): undefined reference to=20
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6523): undefined reference to=20
`nr_ioapics'
arch/i386/kernel/built-in.o: In function `setup_ioapic_ids_from_mpc':
arch/i386/kernel/built-in.o(.text.init+0x6558): undefined reference to=20
`phys_cpu_pre
sent_map'
arch/i386/kernel/built-in.o(.text.init+0x6571): undefined reference to=20
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x65d5): undefined reference to=20
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x65e7): undefined reference to=20
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6651): undefined reference to=20
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6660): undefined reference to=20
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6668): undefined reference to=20
`mp_irq_entri
es'
arch/i386/kernel/built-in.o(.text.init+0x6673): undefined reference to=20
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x6678): undefined reference to=20
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6692): undefined reference to=20
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6738): undefined reference to=20
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6755): undefined reference to=20
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6789): undefined reference to=20
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x67a6): undefined reference to=20
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x67f4): undefined reference to=20
`mp_ioapics'
arch/i386/kernel/built-in.o: In function `io_apic_get_unique_id':
arch/i386/kernel/built-in.o(.text.init+0x68f8): undefined reference to=20
`phys_cpu_pre            sent_map'
drivers/built-in.o: In function `acpi_system_suspend':
drivers/built-in.o(.text+0x234ee): undefined reference to=20
`do_suspend_lowlevel'
drivers/built-in.o: In function `quirk_via_ioapic':
drivers/built-in.o(.text.init+0x1165): undefined reference to `nr_ioapics'
drivers/built-in.o: In function `acpi_bus_init':
drivers/built-in.o(.text.init+0x23d0): undefined reference to=20
`mp_config_ioapic_for_            sci'
drivers/built-in.o: In function `acpi_pci_irq_init':
drivers/built-in.o(.text.init+0x291d): undefined reference to `mp_parse_prt'
arch/i386/pci/built-in.o: In function `pirq_enable_irq':
arch/i386/pci/built-in.o(.text+0x18df): undefined reference to=20
`mp_irq_entries'
arch/i386/pci/built-in.o: In function `pcibios_irq_init':
arch/i386/pci/built-in.o(.text.init+0x1306): undefined reference to=20
`mp_irq_entries'
arch/i386/pci/built-in.o: In function `pcibios_fixup_irqs':
arch/i386/pci/built-in.o(.text.init+0x13c7): undefined reference to=20
`mp_irq_entries'
make: *** [vmlinux] Error 1

Attached is .config below:

Shawn Starr.
--Boundary-00=_cMqj9Ye37ce3Gv/
Content-Type: text/plain;
  charset="us-ascii";
  name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=".config"

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_AC=m
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PM=y
# CONFIG_APM is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_IDE_TASK_IOCTL=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=m
CONFIG_AMD74XX_OVERRIDE=y
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NFORCE is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_IDE_MODES is not set

#
# SCSI device support
#
CONFIG_SCSI=y
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=1
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old non-SCSI/ATAPI CD-ROM drives
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
# CONFIG_NETFILTER is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=y
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_E1000_NAPI is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=800
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=600
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDDLER is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_INPUT_JOYDUMP is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_INTEL_RNG=y
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
CONFIG_AGP_AMD=y
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_EXPORTFS is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=y

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_RTCTIMER is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_DEBUG_MEMORY is not set
# CONFIG_SND_DEBUG_DETECT is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT0197H is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_CMIPCI=y
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA686 is not set
# CONFIG_SND_VIA8233 is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_SOFTWARE_SUSPEND is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y

#
# Security options
#
CONFIG_SECURITY_CAPABILITIES=y

#
# Library routines
#
# CONFIG_CRC32 is not set
# CONFIG_ZLIB_INFLATE is not set
# CONFIG_ZLIB_DEFLATE is not set
CONFIG_X86_BIOS_REBOOT=y

--Boundary-00=_cMqj9Ye37ce3Gv/--

