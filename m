Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbVK3T0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbVK3T0G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 14:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbVK3T0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 14:26:05 -0500
Received: from pm-mx5.mgn.net ([195.46.220.209]:24490 "EHLO pm-mx5.mx.noos.fr")
	by vger.kernel.org with ESMTP id S1751512AbVK3T0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 14:26:01 -0500
Date: Wed, 30 Nov 2005 20:25:56 +0100
From: Damien Wyart <damien.wyart@free.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: BUG in kernel checked out 24 hours ago
Message-ID: <20051130192556.GA2121@localhost.localdomain>
References: <20051130192050.GA13596@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20051130192050.GA13596@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Damien Wyart <damien.wyart@gmail.com> [2005-11-30 20:20]:
> Please find the log from a BUG I encountered this evening while running
> a kernel I had checkouted from git and compiled arond 6pm UTC yesterday.
> The computer froze and I could reboot it with Sysrq.

Sorry, forgot the dmesg and .config...

-- 
Damien Wyart

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config.2615"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.15-rc2-git-24112005dw
# Sun Nov 27 15:02:59 2005
#
CONFIG_X86_32=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
# CONFIG_CPUSETS is not set
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Block layer
#
CONFIG_LBD=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_SCHED_SMT=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_BKL=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_HIGHPTE=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_IRQBALANCE=y
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_PHYSICAL_START=0x100000
# CONFIG_KEXEC is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_HOTKEY=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_MSI=y
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG_CPU is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
CONFIG_NET_KEY=m
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_IDEDISK is not set
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
CONFIG_SCSI_ATA_PIIX=y
# CONFIG_SCSI_SATA_MV is not set
# CONFIG_SCSI_SATA_NV is not set
# CONFIG_SCSI_PDC_ADMA is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIL24 is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
CONFIG_SCSI_SATA_INTEL_COMBINED=y
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA24XX is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_UINPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

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
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_GENERIC_DRIVER=y

#
# Generic devices
#
CONFIG_SND_DUMMY=m
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=m
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_HDA_INTEL is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Input Devices
#
# CONFIG_USB_HID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISER4_FS=y
# CONFIG_REISER4_DEBUG is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_SECURITY=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_RELAYFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
CONFIG_ACORN_PARTITION_CUMANA=y
# CONFIG_ACORN_PARTITION_EESOX is not set
CONFIG_ACORN_PARTITION_ICS=y
# CONFIG_ACORN_PARTITION_ADFS is not set
# CONFIG_ACORN_PARTITION_POWERTEC is not set
CONFIG_ACORN_PARTITION_RISCIX=y
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
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
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=15
# CONFIG_DETECT_SOFTLOCKUP is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_TEST=m

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kern.log"

Nov 30 20:00:56 brouette kernel: Linux version 2.6.15-rc3-git-29112005dw (root@brouette) (gcc version 4.0.3 20051111 (prerelease) (Debian 4.0.2-4)) #1 SMP Tue Nov 29 18:38:03 CET 2005
Nov 30 20:00:56 brouette kernel: BIOS-provided physical RAM map:
Nov 30 20:00:56 brouette kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Nov 30 20:00:56 brouette kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Nov 30 20:00:56 brouette kernel:  BIOS-e820: 0000000000100000 - 000000003ff74000 (usable)
Nov 30 20:00:56 brouette kernel:  BIOS-e820: 000000003ff74000 - 000000003ff76000 (ACPI NVS)
Nov 30 20:00:56 brouette kernel:  BIOS-e820: 000000003ff76000 - 000000003ff97000 (ACPI data)
Nov 30 20:00:56 brouette kernel:  BIOS-e820: 000000003ff97000 - 0000000040000000 (reserved)
Nov 30 20:00:56 brouette kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
Nov 30 20:00:56 brouette kernel:  BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
Nov 30 20:00:56 brouette kernel:  BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
Nov 30 20:00:56 brouette kernel:  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
Nov 30 20:00:56 brouette kernel:  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Nov 30 20:00:56 brouette kernel: 127MB HIGHMEM available.
Nov 30 20:00:56 brouette kernel: 896MB LOWMEM available.
Nov 30 20:00:56 brouette kernel: found SMP MP-table at 000fe710
Nov 30 20:00:56 brouette kernel: On node 0 totalpages: 262004
Nov 30 20:00:56 brouette kernel:   DMA zone: 4096 pages, LIFO batch:2
Nov 30 20:00:56 brouette kernel:   DMA32 zone: 0 pages, LIFO batch:2
Nov 30 20:00:56 brouette kernel:   Normal zone: 225280 pages, LIFO batch:64
Nov 30 20:00:56 brouette kernel:   HighMem zone: 32628 pages, LIFO batch:16
Nov 30 20:00:56 brouette kernel: DMI 2.3 present.
Nov 30 20:00:56 brouette kernel: ACPI: RSDP (v000 DELL                                  ) @ 0x000feb90
Nov 30 20:00:56 brouette kernel: ACPI: RSDT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd1ca
Nov 30 20:00:56 brouette kernel: ACPI: FADT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd1fe
Nov 30 20:00:56 brouette kernel: ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffc929b
Nov 30 20:00:56 brouette kernel: ACPI: MADT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd272
Nov 30 20:00:56 brouette kernel: ACPI: BOOT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd2de
Nov 30 20:00:56 brouette kernel: ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
Nov 30 20:00:56 brouette kernel: ACPI: PM-Timer IO Port: 0x808
Nov 30 20:00:56 brouette kernel: ACPI: Local APIC address 0xfee00000
Nov 30 20:00:56 brouette kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Nov 30 20:00:56 brouette kernel: Processor #0 15:3 APIC version 20
Nov 30 20:00:56 brouette kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Nov 30 20:00:56 brouette kernel: Processor #1 15:3 APIC version 20
Nov 30 20:00:56 brouette kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
Nov 30 20:00:56 brouette kernel: ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
Nov 30 20:00:56 brouette kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Nov 30 20:00:56 brouette kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Nov 30 20:00:56 brouette kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Nov 30 20:00:56 brouette kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Nov 30 20:00:56 brouette kernel: ACPI: IRQ0 used by override.
Nov 30 20:00:56 brouette kernel: ACPI: IRQ2 used by override.
Nov 30 20:00:56 brouette kernel: ACPI: IRQ9 used by override.
Nov 30 20:00:56 brouette kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Nov 30 20:00:56 brouette kernel: Using ACPI (MADT) for SMP configuration information
Nov 30 20:00:56 brouette kernel: Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Nov 30 20:00:56 brouette kernel: Built 1 zonelists
Nov 30 20:00:56 brouette kernel: Kernel command line: root=/dev/sdb2 ro vga=0x31B selinux=0 elevator=cfq 
Nov 30 20:00:56 brouette kernel: mapped APIC to ffffd000 (fee00000)
Nov 30 20:00:56 brouette kernel: mapped IOAPIC to ffffc000 (fec00000)
Nov 30 20:00:56 brouette kernel: Initializing CPU#0
Nov 30 20:00:56 brouette kernel: PID hash table entries: 4096 (order: 12, 65536 bytes)
Nov 30 20:00:56 brouette kernel: Detected 2993.475 MHz processor.
Nov 30 20:00:56 brouette kernel: Using pmtmr for high-res timesource
Nov 30 20:00:56 brouette kernel: Console: colour dummy device 80x25
Nov 30 20:00:56 brouette kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Nov 30 20:00:56 brouette kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Nov 30 20:00:56 brouette kernel: Memory: 1034448k/1048016k available (2404k kernel code, 12700k reserved, 730k data, 192k init, 130512k highmem)
Nov 30 20:00:56 brouette kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Nov 30 20:00:56 brouette kernel: Calibrating delay using timer specific routine.. 5988.69 BogoMIPS (lpj=2994349)
Nov 30 20:00:56 brouette kernel: Mount-cache hash table entries: 512
Nov 30 20:00:56 brouette kernel: CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
Nov 30 20:00:56 brouette kernel: CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
Nov 30 20:00:56 brouette kernel: monitor/mwait feature present.
Nov 30 20:00:56 brouette kernel: using mwait in idle threads.
Nov 30 20:00:56 brouette kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Nov 30 20:00:56 brouette kernel: CPU: L2 cache: 1024K
Nov 30 20:00:56 brouette kernel: CPU: Physical Processor ID: 0
Nov 30 20:00:56 brouette kernel: CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 0000041d 00000000 00000000
Nov 30 20:00:56 brouette kernel: Intel machine check architecture supported.
Nov 30 20:00:56 brouette kernel: Intel machine check reporting enabled on CPU#0.
Nov 30 20:00:56 brouette kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Nov 30 20:00:56 brouette kernel: CPU0: Thermal monitoring enabled
Nov 30 20:00:56 brouette kernel: mtrr: v2.0 (20020519)
Nov 30 20:00:56 brouette kernel: Enabling fast FPU save and restore... done.
Nov 30 20:00:56 brouette kernel: Enabling unmasked SIMD FPU exception support... done.
Nov 30 20:00:56 brouette kernel: Checking 'hlt' instruction... OK.
Nov 30 20:00:56 brouette kernel: CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Nov 30 20:00:56 brouette kernel: Booting processor 1/1 eip 2000
Nov 30 20:00:56 brouette kernel: Initializing CPU#1
Nov 30 20:00:56 brouette kernel: Calibrating delay using timer specific routine.. 5984.18 BogoMIPS (lpj=2992093)
Nov 30 20:00:56 brouette kernel: CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
Nov 30 20:00:56 brouette kernel: CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
Nov 30 20:00:56 brouette kernel: monitor/mwait feature present.
Nov 30 20:00:56 brouette kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Nov 30 20:00:56 brouette kernel: CPU: L2 cache: 1024K
Nov 30 20:00:56 brouette kernel: CPU: Physical Processor ID: 0
Nov 30 20:00:56 brouette kernel: CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 0000041d 00000000 00000000
Nov 30 20:00:56 brouette kernel: Intel machine check architecture supported.
Nov 30 20:00:56 brouette kernel: Intel machine check reporting enabled on CPU#1.
Nov 30 20:00:56 brouette kernel: CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
Nov 30 20:00:56 brouette kernel: CPU1: Thermal monitoring enabled
Nov 30 20:00:56 brouette kernel: CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Nov 30 20:00:56 brouette kernel: Total of 2 processors activated (11972.88 BogoMIPS).
Nov 30 20:00:56 brouette kernel: ENABLING IO-APIC IRQs
Nov 30 20:00:56 brouette kernel: ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Nov 30 20:00:56 brouette kernel: checking TSC synchronization across 2 CPUs: passed.
Nov 30 20:00:56 brouette kernel: Brought up 2 CPUs
Nov 30 20:00:56 brouette kernel: NET: Registered protocol family 16
Nov 30 20:00:56 brouette kernel: ACPI: bus type pci registered
Nov 30 20:00:56 brouette kernel: PCI: PCI BIOS revision 2.10 entry at 0xfbb30, last bus=2
Nov 30 20:00:56 brouette kernel: PCI: Using configuration type 1
Nov 30 20:00:56 brouette kernel: ACPI: Subsystem revision 20050902
Nov 30 20:00:56 brouette kernel: ACPI: Interpreter enabled
Nov 30 20:00:56 brouette kernel: ACPI: Using IOAPIC for interrupt routing
Nov 30 20:00:56 brouette kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Nov 30 20:00:56 brouette kernel: PCI: Probing PCI hardware (bus 00)
Nov 30 20:00:56 brouette kernel: ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Nov 30 20:00:56 brouette kernel: PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
Nov 30 20:00:56 brouette kernel: PCI quirk: region 0880-08bf claimed by ICH4 GPIO
Nov 30 20:00:56 brouette kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Nov 30 20:00:56 brouette kernel: Boot video device is 0000:01:00.0
Nov 30 20:00:56 brouette kernel: PCI: Transparent bridge - 0000:00:1e.0
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 9 10 11 12 15)
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 15)
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 15)
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12 15)
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 15)
Nov 30 20:00:56 brouette kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Nov 30 20:00:56 brouette kernel: pnp: PnP ACPI init
Nov 30 20:00:56 brouette kernel: pnp: PnP ACPI: found 11 devices
Nov 30 20:00:56 brouette kernel: SCSI subsystem initialized
Nov 30 20:00:56 brouette kernel: PCI: Using ACPI for IRQ routing
Nov 30 20:00:56 brouette kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Nov 30 20:00:56 brouette kernel: pnp: 00:0a: ioport range 0x800-0x85f could not be reserved
Nov 30 20:00:56 brouette kernel: pnp: 00:0a: ioport range 0xc00-0xc7f has been reserved
Nov 30 20:00:56 brouette kernel: pnp: 00:0a: ioport range 0x860-0x8ff could not be reserved
Nov 30 20:00:56 brouette kernel: PCI: Bridge: 0000:00:01.0
Nov 30 20:00:56 brouette kernel:   IO window: disabled.
Nov 30 20:00:56 brouette kernel:   MEM window: fd000000-feafffff
Nov 30 20:00:56 brouette kernel:   PREFETCH window: f0000000-f7ffffff
Nov 30 20:00:56 brouette kernel: PCI: Bridge: 0000:00:1e.0
Nov 30 20:00:56 brouette kernel:   IO window: d000-dfff
Nov 30 20:00:56 brouette kernel:   MEM window: fcf00000-fcffffff
Nov 30 20:00:56 brouette kernel:   PREFETCH window: disabled.
Nov 30 20:00:56 brouette kernel: PCI: Setting latency timer of device 0000:00:1e.0 to 64
Nov 30 20:00:56 brouette kernel: Simple Boot Flag value 0x87 read from CMOS RAM was invalid
Nov 30 20:00:56 brouette kernel: Simple Boot Flag at 0x7a set to 0x1
Nov 30 20:00:56 brouette kernel: Machine check exception polling timer started.
Nov 30 20:00:56 brouette kernel: highmem bounce pool size: 64 pages
Nov 30 20:00:56 brouette kernel: Loading Reiser4. See www.namesys.com for a description of Reiser4.
Nov 30 20:00:56 brouette kernel: Initializing Cryptographic API
Nov 30 20:00:56 brouette kernel: io scheduler noop registered
Nov 30 20:00:56 brouette kernel: io scheduler anticipatory registered
Nov 30 20:00:56 brouette kernel: io scheduler deadline registered
Nov 30 20:00:56 brouette kernel: io scheduler cfq registered (default)
Nov 30 20:00:56 brouette kernel: vesafb: framebuffer at 0xf0000000, mapped to 0xf8880000, using 10240k, total 131072k
Nov 30 20:00:56 brouette kernel: vesafb: mode is 1280x1024x32, linelength=5120, pages=0
Nov 30 20:00:56 brouette kernel: vesafb: protected mode interface info at c000:f080
Nov 30 20:00:56 brouette kernel: vesafb: scrolling: redraw
Nov 30 20:00:56 brouette kernel: vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Nov 30 20:00:56 brouette kernel: vesafb: Mode is VGA compatible
Nov 30 20:00:56 brouette kernel: Console: switching to colour frame buffer device 160x64
Nov 30 20:00:56 brouette kernel: fb0: VESA VGA frame buffer device
Nov 30 20:00:56 brouette kernel: Real Time Clock Driver v1.12
Nov 30 20:00:56 brouette kernel: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
Nov 30 20:00:56 brouette kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Nov 30 20:00:56 brouette kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Nov 30 20:00:56 brouette kernel: pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Nov 30 20:00:56 brouette kernel: e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
Nov 30 20:00:56 brouette kernel: e100: Copyright(c) 1999-2005 Intel Corporation
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 169
Nov 30 20:00:56 brouette kernel: e100: eth0: e100_probe: addr 0xfcfff000, irq 169, MAC addr 00:0C:F1:B6:BA:54
Nov 30 20:00:56 brouette kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Nov 30 20:00:56 brouette kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov 30 20:00:56 brouette kernel: ICH5: IDE controller at PCI slot 0000:00:1f.1
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 177
Nov 30 20:00:56 brouette kernel: ICH5: chipset revision 2
Nov 30 20:00:56 brouette kernel: ICH5: not 100%% native mode: will probe irqs later
Nov 30 20:00:56 brouette kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
Nov 30 20:00:56 brouette kernel: Probing IDE interface ide1...
Nov 30 20:00:56 brouette kernel: hdc: SAMSUNG DVD-ROM SD-616T, ATAPI CD/DVD-ROM drive
Nov 30 20:00:56 brouette kernel: hdd: SAMSUNG CD-R/RW SW-252S, ATAPI CD/DVD-ROM drive
Nov 30 20:00:56 brouette kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov 30 20:00:56 brouette kernel: Probing IDE interface ide0...
Nov 30 20:00:56 brouette kernel: hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Nov 30 20:00:56 brouette kernel: Uniform CD-ROM driver Revision: 3.20
Nov 30 20:00:56 brouette kernel: hdd: ATAPI 16X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Nov 30 20:00:56 brouette kernel: libata version 1.20 loaded.
Nov 30 20:00:56 brouette kernel: ata_piix 0000:00:1f.2: version 1.05
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 177
Nov 30 20:00:56 brouette kernel: PCI: Setting latency timer of device 0000:00:1f.2 to 64
Nov 30 20:00:56 brouette kernel: ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 177
Nov 30 20:00:56 brouette kernel: ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 177
Nov 30 20:00:56 brouette kernel: ata1: dev 0 cfg 49:2f00 82:74e9 83:7f63 84:4003 85:74e9 86:3e43 87:4003 88:207f
Nov 30 20:00:56 brouette kernel: ata1: dev 0 ATA-6, max UDMA/133, 144531250 sectors: LBA48
Nov 30 20:00:56 brouette kernel: ata1(0): applying bridge limits
Nov 30 20:00:56 brouette kernel: ata1: dev 0 configured for UDMA/100
Nov 30 20:00:56 brouette kernel: scsi0 : ata_piix
Nov 30 20:00:56 brouette kernel: ata2: dev 0 cfg 49:2f00 82:74e9 83:7f63 84:4003 85:74e9 86:3e43 87:4003 88:207f
Nov 30 20:00:56 brouette kernel: ata2: dev 0 ATA-6, max UDMA/133, 144531250 sectors: LBA48
Nov 30 20:00:56 brouette kernel: ata2(0): applying bridge limits
Nov 30 20:00:56 brouette kernel: ata2: dev 0 configured for UDMA/100
Nov 30 20:00:56 brouette kernel: scsi1 : ata_piix
Nov 30 20:00:56 brouette kernel:   Vendor: ATA       Model: WDC WD740GD-75FL  Rev: 21.0
Nov 30 20:00:56 brouette kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Nov 30 20:00:56 brouette kernel:   Vendor: ATA       Model: WDC WD740GD-75FL  Rev: 21.0
Nov 30 20:00:56 brouette kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Nov 30 20:00:56 brouette kernel: SCSI device sda: 144531250 512-byte hdwr sectors (74000 MB)
Nov 30 20:00:56 brouette kernel: SCSI device sda: drive cache: write back
Nov 30 20:00:56 brouette kernel: SCSI device sda: 144531250 512-byte hdwr sectors (74000 MB)
Nov 30 20:00:56 brouette kernel: SCSI device sda: drive cache: write back
Nov 30 20:00:56 brouette kernel:  sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
Nov 30 20:00:56 brouette kernel: sd 0:0:0:0: Attached scsi disk sda
Nov 30 20:00:56 brouette kernel: SCSI device sdb: 144531250 512-byte hdwr sectors (74000 MB)
Nov 30 20:00:56 brouette kernel: SCSI device sdb: drive cache: write back
Nov 30 20:00:56 brouette kernel: SCSI device sdb: 144531250 512-byte hdwr sectors (74000 MB)
Nov 30 20:00:56 brouette kernel: SCSI device sdb: drive cache: write back
Nov 30 20:00:56 brouette kernel:  sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 sdb11 >
Nov 30 20:00:56 brouette kernel: sd 1:0:0:0: Attached scsi disk sdb
Nov 30 20:00:56 brouette kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Nov 30 20:00:56 brouette kernel: sd 1:0:0:0: Attached scsi generic sg1 type 0
Nov 30 20:00:56 brouette kernel: mice: PS/2 mouse device common for all mice
Nov 30 20:00:56 brouette kernel: NET: Registered protocol family 2
Nov 30 20:00:56 brouette kernel: IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
Nov 30 20:00:56 brouette kernel: TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
Nov 30 20:00:56 brouette kernel: TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
Nov 30 20:00:56 brouette kernel: TCP: Hash tables configured (established 262144 bind 65536)
Nov 30 20:00:56 brouette kernel: TCP reno registered
Nov 30 20:00:56 brouette kernel: TCP bic registered
Nov 30 20:00:56 brouette kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Nov 30 20:00:56 brouette kernel: NET: Registered protocol family 1
Nov 30 20:00:56 brouette kernel: NET: Registered protocol family 17
Nov 30 20:00:56 brouette kernel: Starting balanced_irq
Nov 30 20:00:56 brouette kernel: Using IPI Shortcut mode
Nov 30 20:00:56 brouette kernel: EXT3-fs: INFO: recovery required on readonly filesystem.
Nov 30 20:00:56 brouette kernel: EXT3-fs: write access will be enabled during recovery.
Nov 30 20:00:56 brouette kernel: kjournald starting.  Commit interval 5 seconds
Nov 30 20:00:56 brouette kernel: EXT3-fs: recovery complete.
Nov 30 20:00:56 brouette kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov 30 20:00:56 brouette kernel: VFS: Mounted root (ext3 filesystem) readonly.
Nov 30 20:00:56 brouette kernel: Freeing unused kernel memory: 192k freed
Nov 30 20:00:56 brouette kernel: logips2pp: Detected unknown logitech mouse model 63
Nov 30 20:00:56 brouette kernel: input: ImExPS/2 Logitech Explorer Mouse as /class/input/input1
Nov 30 20:00:56 brouette kernel: usbcore: registered new driver usbfs
Nov 30 20:00:56 brouette kernel: usbcore: registered new driver hub
Nov 30 20:00:56 brouette kernel: USB Universal Host Controller Interface driver v2.3
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 185
Nov 30 20:00:56 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Nov 30 20:00:56 brouette kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Nov 30 20:00:56 brouette kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
Nov 30 20:00:56 brouette kernel: uhci_hcd 0000:00:1d.0: irq 185, io base 0x0000ff80
Nov 30 20:00:56 brouette kernel: hub 1-0:1.0: USB hub found
Nov 30 20:00:56 brouette kernel: hub 1-0:1.0: 2 ports detected
Nov 30 20:00:56 brouette kernel: input: PC Speaker as /class/input/input2
Nov 30 20:00:56 brouette kernel: parport: PnPBIOS parport detected.
Nov 30 20:00:56 brouette kernel: parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
Nov 30 20:00:56 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Nov 30 20:00:56 brouette kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Nov 30 20:00:56 brouette kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
Nov 30 20:00:56 brouette kernel: uhci_hcd 0000:00:1d.1: irq 193, io base 0x0000ff60
Nov 30 20:00:56 brouette kernel: hub 2-0:1.0: USB hub found
Nov 30 20:00:56 brouette kernel: hub 2-0:1.0: 2 ports detected
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 177
Nov 30 20:00:56 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Nov 30 20:00:56 brouette kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Nov 30 20:00:56 brouette kernel: usb 1-1: new full speed USB device using uhci_hcd and address 2
Nov 30 20:00:56 brouette kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
Nov 30 20:00:56 brouette kernel: uhci_hcd 0000:00:1d.2: irq 177, io base 0x0000ff40
Nov 30 20:00:56 brouette kernel: hub 3-0:1.0: USB hub found
Nov 30 20:00:56 brouette kernel: hub 3-0:1.0: 2 ports detected
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 185
Nov 30 20:00:56 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.3 to 64
Nov 30 20:00:56 brouette kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Nov 30 20:00:56 brouette kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
Nov 30 20:00:56 brouette kernel: uhci_hcd 0000:00:1d.3: irq 185, io base 0x0000ff20
Nov 30 20:00:56 brouette kernel: hub 4-0:1.0: USB hub found
Nov 30 20:00:56 brouette kernel: hub 4-0:1.0: 2 ports detected
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 201
Nov 30 20:00:56 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Nov 30 20:00:56 brouette kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Nov 30 20:00:56 brouette kernel: ehci_hcd 0000:00:1d.7: debug port 1
Nov 30 20:00:56 brouette kernel: PCI: cache line size of 128 is not supported by device 0000:00:1d.7
Nov 30 20:00:56 brouette kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
Nov 30 20:00:56 brouette kernel: ehci_hcd 0000:00:1d.7: irq 201, io mem 0xffa80800
Nov 30 20:00:56 brouette kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Nov 30 20:00:56 brouette kernel: hub 5-0:1.0: USB hub found
Nov 30 20:00:56 brouette kernel: usb 1-1: USB disconnect, address 2
Nov 30 20:00:56 brouette kernel: hub 5-0:1.0: 8 ports detected
Nov 30 20:00:56 brouette kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 21 (level, low) -> IRQ 209
Nov 30 20:00:56 brouette kernel: usb 1-1: new full speed USB device using uhci_hcd and address 3
Nov 30 20:00:56 brouette kernel: Adding 2048248k swap on /dev/sdb10.  Priority:-1 extents:1 across:2048248k
Nov 30 20:00:56 brouette kernel: EXT3 FS on sdb2, internal journal
Nov 30 20:00:56 brouette kernel: ReiserFS: sdb5: found reiserfs format "3.6" with standard journal
Nov 30 20:00:56 brouette kernel: ReiserFS: sdb5: using ordered data mode
Nov 30 20:00:56 brouette kernel: ReiserFS: sdb5: journal params: device sdb5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Nov 30 20:00:56 brouette kernel: ReiserFS: sdb5: checking transaction log (sdb5)
Nov 30 20:00:56 brouette kernel: ReiserFS: sdb5: Using r5 hash to sort names
Nov 30 20:00:56 brouette kernel: ReiserFS: sdb5: Removing [34992 8676 0x0 SD]..done
Nov 30 20:00:56 brouette kernel: ReiserFS: sdb5: There were 1 uncompleted unlinks/truncates. Completed
Nov 30 20:00:56 brouette kernel: ReiserFS: sdb6: found reiserfs format "3.6" with standard journal
Nov 30 20:00:56 brouette kernel: ReiserFS: sdb6: using ordered data mode
Nov 30 20:00:56 brouette kernel: ReiserFS: sdb6: journal params: device sdb6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Nov 30 20:00:56 brouette kernel: ReiserFS: sdb6: checking transaction log (sdb6)
Nov 30 20:00:56 brouette kernel: ReiserFS: sdb6: Using r5 hash to sort names
Nov 30 20:00:56 brouette kernel: JFS: nTxBlock = 8086, nTxLock = 64695
Nov 30 20:00:56 brouette kernel: SGI XFS with ACLs, security attributes, large block numbers, no debug enabled
Nov 30 20:00:56 brouette kernel: XFS mounting filesystem sdb9
Nov 30 20:00:56 brouette kernel: Ending clean XFS mount for filesystem: sdb9
Nov 30 20:00:56 brouette kernel: XFS mounting filesystem sda5
Nov 30 20:00:56 brouette kernel: Starting XFS recovery on filesystem: sda5 (logdev: internal)
Nov 30 20:00:56 brouette kernel: Ending XFS recovery on filesystem: sda5 (logdev: internal)
Nov 30 20:00:56 brouette kernel: e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex

--vkogqOf2sHV7VnPd--
