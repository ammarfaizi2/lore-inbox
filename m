Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261273AbSI1MRl>; Sat, 28 Sep 2002 08:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261277AbSI1MRl>; Sat, 28 Sep 2002 08:17:41 -0400
Received: from rhenium.btinternet.com ([194.73.73.93]:19709 "EHLO
	rhenium.btinternet.com") by vger.kernel.org with ESMTP
	id <S261273AbSI1MR1>; Sat, 28 Sep 2002 08:17:27 -0400
From: Nick Sanders <sandersn@btinternet.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic 2.5.39 when starting hotplug
Date: Sat, 28 Sep 2002 13:24:47 +0100
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_P+Zl9AoRXElX3O7"
Message-Id: <200209281324.47486.sandersn@btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_P+Zl9AoRXElX3O7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi,

I get a kernel panic when starting the hotplug daemon when running 2.5.39, the 
config and boot log are attached.

I can get the oops if someone could tell me how.

Nick


--Boundary-00=_P+Zl9AoRXElX3O7
Content-Type: text/plain;
  charset="us-ascii";
  name="config-2.5"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="config-2.5"

#
# Automatically generated make config: don't edit
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
# CONFIG_BSD_PROCESS_ACCT is not set
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
# CONFIG_PREEMPT is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set
# CONFIG_X86_MCE is not set
# CONFIG_X86_MCE_NONFATAL is not set
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

#
# Power management options (ACPI, APM)
#

#
# ACPI Support
#
# CONFIG_ACPI is not set
CONFIG_PM=y
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

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
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play configuration
#
CONFIG_PNP=y
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

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
# CONFIG_BLK_DEV_LOOP is not set
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

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
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
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
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
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
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
CONFIG_SCSI_SYM53C8XX=m
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
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
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
# CONFIG_IP_NF_QUEUE is not set
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
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

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
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
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_FILTER=y
# CONFIG_PPP_ASYNC is not set
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPPOE is not set
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
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set

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
# Input I/O drivers
#
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

#
# Input Device Drivers
#
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
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_COMPUTONE is not set
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_DIGI is not set
# CONFIG_ESPSERIAL is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
CONFIG_N_HDLC=m
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set

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

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
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
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=m
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
CONFIG_DRM_R128=m
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
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
# CONFIG_TMPFS is not set
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
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
# CONFIG_XFS_FS is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
# CONFIG_EXPORTFS is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
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
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
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
CONFIG_SOUND_PRIME=m
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=m
CONFIG_MIDI_EMU10K1=y
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# Advanced Linux Sound Architecture
#
# CONFIG_SND is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_LONG_TIMEOUT is not set
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD_ALT=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set
# CONFIG_USB_HIDINPUT is not set
# CONFIG_HID_FF is not set
# CONFIG_HID_PID is not set
# CONFIG_LOGITECH_FF is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
#   Video4Linux support is needed for USB Multimedia device support
#
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_SPEEDTOUCH is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_DEBUG_KERNEL is not set

#
# Security options
#
CONFIG_SECURITY_CAPABILITIES=y

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

--Boundary-00=_P+Zl9AoRXElX3O7
Content-Type: text/plain;
  charset="us-ascii";
  name="2.5.39-boot"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.5.39-boot"

Sep 28 13:07:48 gandalf kernel: Linux version 2.5.39 (sandersn@gandalf) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Sat Sep 28 10:42:38 BST 2002
Sep 28 13:07:48 gandalf kernel: Video mode to be used for restore is ffff
Sep 28 13:07:48 gandalf kernel: BIOS-provided physical RAM map:
Sep 28 13:07:48 gandalf kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Sep 28 13:07:48 gandalf kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Sep 28 13:07:48 gandalf kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Sep 28 13:07:48 gandalf kernel:  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
Sep 28 13:07:48 gandalf kernel:  BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
Sep 28 13:07:48 gandalf kernel:  BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
Sep 28 13:07:48 gandalf kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Sep 28 13:07:48 gandalf kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Sep 28 13:07:48 gandalf kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Sep 28 13:07:48 gandalf kernel: 255MB LOWMEM available.
Sep 28 13:07:48 gandalf kernel: On node 0 totalpages: 65520
Sep 28 13:07:48 gandalf kernel:   DMA zone: 4096 pages
Sep 28 13:07:48 gandalf kernel:   Normal zone: 61424 pages
Sep 28 13:07:48 gandalf kernel:   HighMem zone: 0 pages
Sep 28 13:07:48 gandalf kernel: Building zonelist for node : 0
Sep 28 13:07:48 gandalf kernel: Kernel command line: root=/dev/hda1 ro 1
Sep 28 13:07:48 gandalf kernel: Initializing CPU#0
Sep 28 13:07:48 gandalf kernel: Detected 1474.490 MHz processor.
Sep 28 13:07:48 gandalf kernel: Console: colour VGA+ 80x25
Sep 28 13:07:48 gandalf kernel: Calibrating delay loop... 2899.96 BogoMIPS
Sep 28 13:07:48 gandalf kernel: Memory: 257208k/262080k available (1017k kernel code, 4484k reserved, 470k data, 68k init, 0k highmem)
Sep 28 13:07:48 gandalf kernel: Security Scaffold v1.0.0 initialized
Sep 28 13:07:48 gandalf kernel: Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Sep 28 13:07:48 gandalf kernel: Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Sep 28 13:07:48 gandalf kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Sep 28 13:07:48 gandalf kernel: CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
Sep 28 13:07:48 gandalf kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Sep 28 13:07:48 gandalf kernel: CPU: L2 Cache: 256K (64 bytes/line)
Sep 28 13:07:48 gandalf kernel: CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Sep 28 13:07:48 gandalf kernel: CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
Sep 28 13:07:48 gandalf kernel: CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Sep 28 13:07:48 gandalf kernel: CPU: AMD Athlon(tm) XP 1700+ stepping 02
Sep 28 13:07:48 gandalf kernel: Enabling fast FPU save and restore... done.
Sep 28 13:07:48 gandalf kernel: Enabling unmasked SIMD FPU exception support... done.
Sep 28 13:07:48 gandalf kernel: Checking 'hlt' instruction... OK.
Sep 28 13:07:48 gandalf kernel: POSIX conformance testing by UNIFIX
Sep 28 13:07:48 gandalf kernel: Linux NET4.0 for Linux 2.4
Sep 28 13:07:48 gandalf kernel: Based upon Swansea University Computer Society NET3.039
Sep 28 13:07:48 gandalf kernel: Initializing RT netlink socket
Sep 28 13:07:48 gandalf kernel: mtrr: v2.0 (20020519)
Sep 28 13:07:48 gandalf kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=1
Sep 28 13:07:48 gandalf kernel: PCI: Using configuration type 1
Sep 28 13:07:48 gandalf kernel: adding '' to cpu class interfaces
Sep 28 13:07:48 gandalf kernel: PCI: Probing PCI hardware
Sep 28 13:07:48 gandalf kernel: PCI: Probing PCI hardware (bus 00)
Sep 28 13:07:48 gandalf kernel: PCI: Using IRQ router default [1106/3147] at 00:11.0
Sep 28 13:07:48 gandalf kernel: PCI: IRQ 0 for device 00:11.1 doesn't match PIRQ mask - try pci=usepirqmask
Sep 28 13:07:48 gandalf kernel: PCI: Hardcoded IRQ 14 for device 00:11.1
Sep 28 13:07:48 gandalf kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Sep 28 13:07:48 gandalf kernel: Starting kswapd
Sep 28 13:07:48 gandalf kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Sep 28 13:07:48 gandalf kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Sep 28 13:07:48 gandalf kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Sep 28 13:07:48 gandalf kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
Sep 28 13:07:48 gandalf kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
Sep 28 13:07:48 gandalf kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
Sep 28 13:07:48 gandalf kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Sep 28 13:07:48 gandalf kernel: aio_setup: sizeof(struct page) = 40
Sep 28 13:07:48 gandalf kernel: VFS: Disk quotas vdquot_6.5.1
Sep 28 13:07:48 gandalf kernel: Journalled Block Device driver loaded
Sep 28 13:07:48 gandalf kernel: Capability LSM initialized
Sep 28 13:07:48 gandalf kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
Sep 28 13:07:48 gandalf kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Sep 28 13:07:48 gandalf kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Sep 28 13:07:48 gandalf kernel: pty: 256 Unix98 ptys configured
Sep 28 13:07:48 gandalf kernel: block request queues:
Sep 28 13:07:48 gandalf kernel:  128 requests per read queue
Sep 28 13:07:48 gandalf kernel:  128 requests per write queue
Sep 28 13:07:48 gandalf kernel:  8 requests per batch
Sep 28 13:07:48 gandalf kernel:  enter congestion at 31
Sep 28 13:07:48 gandalf kernel:  exit congestion at 33
Sep 28 13:07:48 gandalf kernel: Floppy drive(s): fd0 is 1.44M
Sep 28 13:07:48 gandalf kernel: FDC 0 is a post-1991 82077
Sep 28 13:07:48 gandalf kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Sep 28 13:07:48 gandalf kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep 28 13:07:48 gandalf kernel: VP_IDE: IDE controller at PCI slot 00:11.1
Sep 28 13:07:48 gandalf kernel: PCI: Hardcoded IRQ 14 for device 00:11.1
Sep 28 13:07:48 gandalf kernel: VP_IDE: chipset revision 6
Sep 28 13:07:48 gandalf kernel: VP_IDE: not 100%% native mode: will probe irqs later
Sep 28 13:07:48 gandalf kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep 28 13:07:48 gandalf kernel: VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
Sep 28 13:07:48 gandalf kernel:     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
Sep 28 13:07:48 gandalf kernel:     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio
Sep 28 13:07:48 gandalf kernel: hda: WDC WD400BB-00CAA0, ATA DISK drive
Sep 28 13:07:48 gandalf kernel: hdb: TOSHIBA DVD-ROM SD-M1402, ATAPI CD/DVD-ROM drive
Sep 28 13:07:48 gandalf kernel: hda: DMA disabled
Sep 28 13:07:48 gandalf kernel: hdb: DMA disabled
Sep 28 13:07:48 gandalf kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 28 13:07:48 gandalf kernel: hdc: LITE-ON LTR-24102B, ATAPI CD/DVD-ROM drive
Sep 28 13:07:48 gandalf kernel: hdc: DMA disabled
Sep 28 13:07:48 gandalf kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep 28 13:07:48 gandalf kernel: hda: host protected area => 1
Sep 28 13:07:48 gandalf kernel: hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, UDMA(100)
Sep 28 13:07:48 gandalf kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
Sep 28 13:07:48 gandalf kernel: register interface 'mouse' with class 'input
Sep 28 13:07:48 gandalf kernel: mice: PS/2 mouse device common for all mice
Sep 28 13:07:48 gandalf kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Sep 28 13:07:48 gandalf kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep 28 13:07:48 gandalf kernel: input: AT Set 2 Extended keyboard on isa0060/serio0
Sep 28 13:07:48 gandalf kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Sep 28 13:07:48 gandalf kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Sep 28 13:07:48 gandalf kernel: IP Protocols: ICMP, UDP, TCP
Sep 28 13:07:48 gandalf kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Sep 28 13:07:48 gandalf kernel: TCP: Hash tables configured (established 16384 bind 16384)
Sep 28 13:07:48 gandalf kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Sep 28 13:07:48 gandalf kernel: kjournald starting.  Commit interval 5 seconds
Sep 28 13:07:48 gandalf kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 28 13:07:48 gandalf kernel: VFS: Mounted root (ext3 filesystem) readonly.
Sep 28 13:07:48 gandalf kernel: Freeing unused kernel memory: 68k freed
Sep 28 13:07:48 gandalf kernel: Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1
Sep 28 13:07:48 gandalf kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
Sep 28 13:07:48 gandalf kernel: Real Time Clock Driver v1.11
Sep 28 13:07:48 gandalf kernel: Linux Tulip driver version 1.1.13 (May 11, 2002)
Sep 28 13:07:48 gandalf kernel: tulip0:  MII transceiver #1 config 3000 status 7809 advertising 01e1.
Sep 28 13:07:48 gandalf kernel: eth0: Lite-On 82c168 PNIC rev 32 at 0xd800, 00:A0:CC:5D:5E:01, IRQ 10.
Sep 28 13:07:48 gandalf kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Sep 28 13:07:48 gandalf kernel: agpgart: Maximum main memory to use for agp memory: 203M
Sep 28 13:07:48 gandalf kernel: agpgart: Detected Via Apollo Pro KT266 chipset
Sep 28 13:07:48 gandalf kernel: agpgart: AGP aperture is 64M @ 0xe0000000
Sep 28 13:07:48 gandalf kernel: [drm] AGP 0.99 on VIA Apollo KT133 @ 0xe0000000 64MB
Sep 28 13:07:48 gandalf kernel: [drm] Initialized r128 2.2.0 20010917 on minor 0
Sep 28 13:07:48 gandalf kernel: Creative EMU10K1 PCI Audio Driver, version 0.16, 10:43:47 Sep 28 2002
Sep 28 13:07:48 gandalf kernel: emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0xd400-0xd41f, IRQ 11
Sep 28 13:07:48 gandalf kernel: ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
Sep 28 13:07:48 gandalf kernel: SCSI subsystem driver Revision: 1.00
Sep 28 13:07:48 gandalf kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Sep 28 13:07:48 gandalf kernel:   Vendor: TOSHIBA   Model: DVD-ROM SD-M1402  Rev: 1008
Sep 28 13:07:48 gandalf kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Sep 28 13:07:48 gandalf kernel:   Vendor: LITE-ON   Model: LTR-24102B        Rev: 5S54
Sep 28 13:07:48 gandalf kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Sep 28 13:07:48 gandalf kernel: parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
Sep 28 13:07:48 gandalf kernel: parport0: irq 7 detected
Sep 28 13:07:48 gandalf kernel: kjournald starting.  Commit interval 5 seconds
Sep 28 13:07:48 gandalf kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,3), internal journal
Sep 28 13:07:48 gandalf kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 28 13:07:48 gandalf kernel: kjournald starting.  Commit interval 5 seconds
Sep 28 13:07:48 gandalf kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
Sep 28 13:07:48 gandalf kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 28 13:07:48 gandalf kernel: kjournald starting.  Commit interval 5 seconds
Sep 28 13:07:48 gandalf kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,6), internal journal
Sep 28 13:07:48 gandalf kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 28 13:08:58 gandalf kernel: serio: kseriod exiting<6>usb.c: registered new driver usbfs
Sep 28 13:08:58 gandalf kernel: usb.c: registered new driver hub
Sep 28 13:08:58 gandalf kernel: uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
Sep 28 13:08:58 gandalf kernel: hcd-pci.c: uhci-hcd @ 00:11.2, VIA Technologies, Inc. USB
Sep 28 13:08:58 gandalf kernel: hcd-pci.c: irq 10, io base 0000c800
Sep 28 13:08:58 gandalf kernel: hcd.c: new USB bus registered, assigned bus number 1
Sep 28 13:08:58 gandalf kernel: hub.c: USB hub found at 0
Sep 28 13:08:58 gandalf kernel: hub.c: 2 ports detected
Sep 28 13:08:58 gandalf kernel: hcd-pci.c: uhci-hcd @ 00:11.3, VIA Technologies, Inc. USB (#2)
Sep 28 13:08:58 gandalf kernel: hcd-pci.c: irq 10, io base 0000cc00
Sep 28 13:08:58 gandalf kernel: hcd.c: new USB bus registered, assigned bus number 2
Sep 28 13:08:58 gandalf kernel: hub.c: USB hub found at 0
Sep 28 13:08:58 gandalf kernel: hub.c: 2 ports detected
Sep 28 13:08:59 gandalf kernel: hub.c: new USB device 00:11.2-1, assigned address 2

--Boundary-00=_P+Zl9AoRXElX3O7--

