Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVBZQDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVBZQDt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 11:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVBZQDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 11:03:49 -0500
Received: from [200.55.33.207] ([200.55.33.207]:13843 "EHLO smtp.bensa.ar")
	by vger.kernel.org with ESMTP id S261223AbVBZQB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 11:01:56 -0500
From: Norberto Bensa <nbensa@gmx.net>
Subject: NVRM: rm_init_adapter failed (2.6.11-rc4-RT-V0.7.39-02)
Date: Sat, 26 Feb 2005 12:54:04 -0300
User-Agent: KMail/1.7.2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3379706.nCKikgMCP3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200502261254.04329.nbensa@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3379706.nCKikgMCP3
Content-Type: multipart/mixed;
  boundary="Boundary-01=_cuJICXCrJodEX6y"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_cuJICXCrJodEX6y
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello list,

/* please, CC me since I'm on dialup and not subscribed to LKML anymore :(
*/

It seems nvidia is broken with latest kernels; in fact, the last kernel I
could use is 2.6.9-rc4-mm1-RT-U4.

With 2.6.11-rc4-RT-V0.7.39-02 modprobing nvidia goes without error but X
doesn't start, screen goes black and then it kicks back to the terminal. In
dmesg I see:

	NVRM: rm_init_adapter failed


I'm attaching .config, Xorg.0.log and dmesg.

Is this a know bug/problem with nvidia, or is there some option I'm missing
 in my config?

Thanks,
Norberto

--Boundary-01=_cuJICXCrJodEX6y
Content-Type: text/plain;
  charset="us-ascii";
  name="dotconfig"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="dotconfig"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.11-rc4-RT-V0.7.39-02
# Fri Feb 25 19:30:18 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
CONFIG_EMBEDDED=y
# CONFIG_KALLSYMS is not set
CONFIG_FUTEX=y
# CONFIG_EPOLL is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

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
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT_DESKTOP is not set
# CONFIG_PREEMPT_RT is not set
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
CONFIG_PREEMPT_BKL=y
CONFIG_ASM_SEMAPHORES=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
# CONFIG_ACPI_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_VIDEO is not set
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set
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
# CONFIG_PCI_MSI is not set
CONFIG_PCI_LEGACY_PROC=y
# CONFIG_PCI_NAMES is not set
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PC-card bridges
#

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_FAKE is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

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
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=y
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
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
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
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=y
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID10 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_RAID6 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_MD_FAULTY is not set
# CONFIG_BLK_DEV_DM is not set

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=m
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_IP_TCPDIAG is not set
# CONFIG_IP_TCPDIAG_IPV6 is not set
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

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
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
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
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=m
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

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
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
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
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

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
CONFIG_INPUT_MOUSEDEV=m
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
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
# CONFIG_SERIO is not set
# CONFIG_SERIO_I8042 is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

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
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=m
CONFIG_RTC=m
# CONFIG_RTC_HISTOGRAM is not set
# CONFIG_BLOCKER is not set
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
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=m
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

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
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
# CONFIG_SND is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
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
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
#
# CONFIG_USB_STORAGE is not set

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set

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

#
# USB port drivers
#

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
# CONFIG_USB_TEST is not set

#
# USB ATM/DSL drivers
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
# File systems
#
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y

#
# XFS support
#
CONFIG_XFS_FS=m
# CONFIG_XFS_RT is not set
CONFIG_XFS_QUOTA=y
CONFIG_XFS_SECURITY=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_MINIX_FS=m
# CONFIG_ROMFS_FS is not set
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

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
CONFIG_FAT_DEFAULT_CODEPAGE=850
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-15"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS_XATTR=y
CONFIG_DEVPTS_FS_SECURITY=y
CONFIG_TMPFS=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_SECURITY=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

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
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
CONFIG_NFS_DIRECTIO=y
# CONFIG_NFSD is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SUNRPC=m
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=m
CONFIG_NLS_DEFAULT="utf8"
# CONFIG_NLS_CODEPAGE_437 is not set
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
# CONFIG_NLS_ASCII is not set
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
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_WAKEUP_TIMING is not set
# CONFIG_CRITICAL_IRQSOFF_TIMING is not set
# CONFIG_DEBUG_BUGVERBOSE is not set
# CONFIG_USE_FRAME_POINTER is not set
# CONFIG_EARLY_PRINTK is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
CONFIG_SECURITY=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_ROOTPLUG is not set
# CONFIG_SECURITY_SECLVL is not set
# CONFIG_SECURITY_SELINUX is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Hardware crypto devices
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
CONFIG_CRC32=m
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y

--Boundary-01=_cuJICXCrJodEX6y
Content-Type: text/x-log;
  charset="us-ascii";
  name="Xorg.0.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="Xorg.0.log"


X Window System Version 6.8.2
Release Date: 9 February 2005
X Protocol Version 11, Revision 0, Release 6.8.2
Build Operating System: Linux 2.6.9-rc4-mm1-RT-U4-5 i686 [ELF]=20
Current Operating System: Linux venkman 2.6.11-rc4-RT-V0.7.39-02 #1 Fri Feb=
 25 19:15:16 ART 2005 i686
Build Date: 15 February 2005
	Before reporting problems, check http://wiki.X.Org
	to make sure that you have the latest version.
Module Loader present
Markers: (--) probed, (**) from config file, (=3D=3D) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(=3D=3D) Log file: "/var/log/Xorg.0.log", Time: Sat Feb 26 12:43:58 2005
(=3D=3D) Using config file: "/etc/X11/xorg.conf"
(=3D=3D) ServerLayout "Layout0"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "Monitor0"
(**) |   |-->Device "Video0"
(**) |-->Input Device "Mouse0"
(**) |-->Input Device "Keyboard0"
(**) FontPath set to "/usr/share/fonts/misc,/usr/local/share/fonts/ttf,/usr=
/share/fonts/corefonts,/usr/share/fonts/TTF,/usr/share/fonts/Type1"
(**) RgbPath set to "/usr/lib/rgb"
(=3D=3D) ModulePath set to "/usr/lib/modules"
(**) Option "BlankTime" "0"
(**) Option "StandbyTime" "1"
(**) Option "SuspendTime" "0"
(**) Option "OffTime" "0"
(**) Option "AllowDeactivateGrabs"
(**) Option "AllowClosedownGrabs"
(**) Extension "Composite" is disabled
(WW) Open APM failed (/dev/apm_bios) (No such file or directory)
Couldn't open RGB_DB '/usr/lib/rgb'
(II) Module ABI versions:
	X.Org ANSI C Emulation: 0.2
	X.Org Video Driver: 0.7
	X.Org XInput driver : 0.4
	X.Org Server Extension : 0.2
	X.Org Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor=3D"X.Org Foundation"
	compiled for 6.8.2, module version =3D 1.0.0
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/lib/modules/libpcidata.a
(II) Module pcidata: vendor=3D"X.Org Foundation"
	compiled for 6.8.2, module version =3D 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(++) using VT number 2

(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 1106,0691 card 0000,0000 rev c4 class 06,00,00 hdr =
00
(II) PCI: 00:01:0: chip 1106,8598 card 0000,0000 rev 00 class 06,04,00 hdr =
01
(II) PCI: 00:07:0: chip 1106,0686 card 1106,0000 rev 40 class 06,01,00 hdr =
80
(II) PCI: 00:07:1: chip 1106,0571 card 1106,0571 rev 06 class 01,01,8a hdr =
00
(II) PCI: 00:07:2: chip 1106,3038 card 0925,1234 rev 16 class 0c,03,00 hdr =
00
(II) PCI: 00:07:4: chip 1106,3057 card 0000,0000 rev 40 class 06,80,00 hdr =
00
(II) PCI: 00:0a:0: chip 10ec,8139 card 10ec,8139 rev 10 class 02,00,00 hdr =
00
(II) PCI: 00:0c:0: chip 1102,0002 card 1102,8040 rev 05 class 04,01,00 hdr =
80
(II) PCI: 00:0c:1: chip 1102,7002 card 1102,0020 rev 05 class 09,80,00 hdr =
80
(II) PCI: 01:00:0: chip 10de,0110 card 0000,0000 rev b2 class 03,00,00 hdr =
00
(II) PCI: End of PCI scan
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,1), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:1:0), (0,1,1), BCTRL: 0x000c (VGA_EN is set)
(II) Bus 1 non-prefetchable memory range:
	[0] -1	0	0xdc000000 - 0xddffffff (0x2000000) MX[B]
(II) Bus 1 prefetchable memory range:
	[0] -1	0	0xd0000000 - 0xd7ffffff (0x8000000) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:7:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(--) PCI:*(1:0:0) nVidia Corporation NV11 [GeForce2 MX/MX 400] rev 178, Mem=
 @ 0xdc000000/24, 0xd0000000/27
(II) Addressable bus resource ranges are
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
	[1] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) PCI Memory resource overlap reduced 0xd8000000 from 0xdbffffff to 0xd7=
ffffff
(II) Active PCI resource ranges:
	[0] -1	0	0xde000000 - 0xde0000ff (0x100) MX[B]
	[1] -1	0	0xd8000000 - 0xd7ffffff (0x0) MX[B]O
	[2] -1	0	0xd0000000 - 0xd7ffffff (0x8000000) MX[B](B)
	[3] -1	0	0xdc000000 - 0xdcffffff (0x1000000) MX[B](B)
	[4] -1	0	0x0000e400 - 0x0000e407 (0x8) IX[B]
	[5] -1	0	0x0000e000 - 0x0000e01f (0x20) IX[B]
	[6] -1	0	0x0000dc00 - 0x0000dcff (0x100) IX[B]
	[7] -1	0	0x0000d400 - 0x0000d41f (0x20) IX[B]
	[8] -1	0	0x0000d000 - 0x0000d00f (0x10) IX[B]
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0	0xde000000 - 0xde0000ff (0x100) MX[B]
	[1] -1	0	0xd8000000 - 0xd7ffffff (0x0) MX[B]O
	[2] -1	0	0xd0000000 - 0xd7ffffff (0x8000000) MX[B](B)
	[3] -1	0	0xdc000000 - 0xdcffffff (0x1000000) MX[B](B)
	[4] -1	0	0x0000e400 - 0x0000e407 (0x8) IX[B]
	[5] -1	0	0x0000e000 - 0x0000e01f (0x20) IX[B]
	[6] -1	0	0x0000dc00 - 0x0000dcff (0x100) IX[B]
	[7] -1	0	0x0000d400 - 0x0000d41f (0x20) IX[B]
	[8] -1	0	0x0000d000 - 0x0000d00f (0x10) IX[B]
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xde000000 - 0xde0000ff (0x100) MX[B]
	[6] -1	0	0xd8000000 - 0xd7ffffff (0x0) MX[B]O
	[7] -1	0	0xd0000000 - 0xd7ffffff (0x8000000) MX[B](B)
	[8] -1	0	0xdc000000 - 0xdcffffff (0x1000000) MX[B](B)
	[9] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[10] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[11] -1	0	0x0000e400 - 0x0000e407 (0x8) IX[B]
	[12] -1	0	0x0000e000 - 0x0000e01f (0x20) IX[B]
	[13] -1	0	0x0000dc00 - 0x0000dcff (0x100) IX[B]
	[14] -1	0	0x0000d400 - 0x0000d41f (0x20) IX[B]
	[15] -1	0	0x0000d000 - 0x0000d00f (0x10) IX[B]
(II) LoadModule: "extmod"
(II) Loading /usr/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor=3D"X.Org Foundation"
	compiled for 6.8.2, module version =3D 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension SHAPE
(II) Loading extension MIT-SUNDRY-NONSTANDARD
(II) Loading extension BIG-REQUESTS
(II) Loading extension SYNC
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XC-MISC
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-Misc
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "glx"
(II) Loading /usr/lib/modules/extensions/libglx.so
(II) Module glx: vendor=3D"NVIDIA Corporation"
	compiled for 4.0.2, module version =3D 1.0.6629
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension GLX
(II) LoadModule: "freetype"
(II) Loading /usr/lib/modules/fonts/libfreetype.so
(II) Module freetype: vendor=3D"X.Org Foundation & the After X-TT Project"
	compiled for 6.8.2, module version =3D 2.1.0
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font FreeType
(II) LoadModule: "type1"
(II) Loading /usr/lib/modules/fonts/libtype1.a
(II) Module type1: vendor=3D"X.Org Foundation"
	compiled for 6.8.2, module version =3D 1.0.2
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "nvidia"
(II) Loading /usr/lib/modules/drivers/nvidia_drv.o
(II) Module nvidia: vendor=3D"NVIDIA Corporation"
	compiled for 4.0.2, module version =3D 1.0.6629
	Module class: XFree86 Video Driver
(II) LoadModule: "mouse"
(II) Loading /usr/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor=3D"X.Org Foundation"
	compiled for 6.8.2, module version =3D 1.0.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.4
(II) LoadModule: "kbd"
(II) Loading /usr/lib/modules/input/kbd_drv.o
(II) Module kbd: vendor=3D"X.Org Foundation"
	compiled for 6.8.2, module version =3D 1.0.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.4
(II) NVIDIA X Driver  1.0-6629  Wed Nov  3 13:14:07 PST 2004
(II) NVIDIA Unified Driver for all NVIDIA GPUs
(II) Primary Device is: PCI 01:00:0
(--) Assigning device section with no busID to primary device
(--) Chipset NVIDIA GPU found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xde000000 - 0xde0000ff (0x100) MX[B]
	[6] -1	0	0xd8000000 - 0xd7ffffff (0x0) MX[B]O
	[7] -1	0	0xd0000000 - 0xd7ffffff (0x8000000) MX[B](B)
	[8] -1	0	0xdc000000 - 0xdcffffff (0x1000000) MX[B](B)
	[9] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[10] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[11] -1	0	0x0000e400 - 0x0000e407 (0x8) IX[B]
	[12] -1	0	0x0000e000 - 0x0000e01f (0x20) IX[B]
	[13] -1	0	0x0000dc00 - 0x0000dcff (0x100) IX[B]
	[14] -1	0	0x0000d400 - 0x0000d41f (0x20) IX[B]
	[15] -1	0	0x0000d000 - 0x0000d00f (0x10) IX[B]
(II) resource ranges after probing:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xde000000 - 0xde0000ff (0x100) MX[B]
	[6] -1	0	0xd8000000 - 0xd7ffffff (0x0) MX[B]O
	[7] -1	0	0xd0000000 - 0xd7ffffff (0x8000000) MX[B](B)
	[8] -1	0	0xdc000000 - 0xdcffffff (0x1000000) MX[B](B)
	[9] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[10] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[11] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[12] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[13] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[14] -1	0	0x0000e400 - 0x0000e407 (0x8) IX[B]
	[15] -1	0	0x0000e000 - 0x0000e01f (0x20) IX[B]
	[16] -1	0	0x0000dc00 - 0x0000dcff (0x100) IX[B]
	[17] -1	0	0x0000d400 - 0x0000d41f (0x20) IX[B]
	[18] -1	0	0x0000d000 - 0x0000d00f (0x10) IX[B]
	[19] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[20] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(**) NVIDIA(0): Depth 24, (--) framebuffer bpp 32
(=3D=3D) NVIDIA(0): RGB weight 888
(=3D=3D) NVIDIA(0): Default visual is TrueColor
(**) NVIDIA(0): Using gamma correction (0.8, 0.8, 0.8)
(**) NVIDIA(0): Option "NoLogo"
(**) NVIDIA(0): Option "NvAGP" "2"
(**) NVIDIA(0): Option "RenderAccel"
(**) NVIDIA(0): Option "AllowGLXWithComposite"
(**) NVIDIA(0): Enabling experimental RENDER acceleration
(**) NVIDIA(0): Use of AGPGART requested
(--) NVIDIA(0): Linear framebuffer at 0xD0000000
(--) NVIDIA(0): MMIO registers at 0xDC000000
(EE) NVIDIA(0): Failed to initialize the NVIDIA graphics device!
(EE) NVIDIA(0):  *** Aborting ***
(II) UnloadModule: "nvidia"
(EE) Screen(s) found, but none have a usable configuration.

=46atal server error:
no screens found

Please consult the The X.Org Foundation support=20
	 at http://wiki.X.Org
 for help.=20
Please also check the log file at "/var/log/Xorg.0.log" for additional info=
rmation.


--Boundary-01=_cuJICXCrJodEX6y
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg"

Linux version 2.6.11-rc4-RT-V0.7.39-02 (root@venkman) (gcc version 3.4.3 20=
050110 (Gentoo Linux 3.4.3.20050110, ssp-3.4.3.20050110-0, pie-8.7.7)) #1 F=
ri Feb 25 19:15:16 ART 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.1 present.
ACPI: RSDP (v000 VIA694                                ) @ 0x000f7e90
ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Built 1 zonelists
Kernel command line: elevator=3Dcfq vga=3D0x030c
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01401000)
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1000.243 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 132x60
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 516976k/524224k available (1198k kernel code, 6700k reserved, 306k =
data, 120k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1978.36 BogoMIPS (lpj=3D989184)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 0000=
0000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000=
000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00=
000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0080 (from 0ca0)
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
softirq RT prio: 24.
desched cpu_callback 2/00000000
desched thread 0 started up.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb4b0, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050125
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 7 devices
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=3Drouteirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
PCI: Disabling Via external APIC routing
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
io scheduler noop registered
io scheduler cfq registered (default)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: QUANTUM FIREBALLP AS20.5, ATA DISK drive
hdd: ST330630A, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 128KiB
hdc: 40132503 sectors (20547 MB) w/1902KiB Cache, CHS=3D39813/16/63, UDMA(1=
00)
hdc: cache flushes not supported
 hdc: hdc1 < hdc5 hdc6 hdc7 hdc8 hdc9 hdc10 >
hdd: max request size: 128KiB
hdd: 59777640 sectors (30606 MB) w/2048KiB Cache, CHS=3D59303/16/63, UDMA(6=
6)
hdd: cache flushes not supported
 hdd: hdd1
md: raid0 personality registered as nr 2
md: md driver 0.90.1 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdd1 ...
md:  adding hdd1 ...
md:  adding hdc10 ...
md: created md0
md: bind<hdc10>
md: bind<hdd1>
md: running: <hdd1><hdc10>
md0: setting max_sectors to 64, segment boundary to 16383
raid0: looking at hdd1
raid0:   comparing hdd1(29880768) with hdd1(29880768)
raid0:   END
raid0:   =3D=3D> UNIQUE
raid0: 1 zones
raid0: looking at hdc10
raid0:   comparing hdc10(17470592) with hdd1(29880768)
raid0:   NOT EQUAL
raid0:   comparing hdc10(17470592) with hdc10(17470592)
raid0:   END
raid0:   =3D=3D> UNIQUE
raid0: 2 zones
raid0: FINAL 2 zones
raid0: zone 1
raid0: checking hdd1 ... contained as device 0
  (29880768) is smallest!.
raid0: checking hdc10 ... nope.
raid0: zone->nb_dev: 1, size: 12410176
raid0: current zone offset: 29880768
raid0: done.
raid0 : md_size is 47351360 blocks.
raid0 : conf->hash_spacing is 34941184 blocks.
raid0 : nb_zone is 2.
raid0 : Allocating 8 bytes for hash.
md: ... autorun DONE.
ReiserFS: hdc9: found reiserfs format "3.6" with standard journal
ReiserFS: hdc9: using ordered data mode
ReiserFS: hdc9: journal params: device hdc9, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc9: checking transaction log (hdc9)
ReiserFS: hdc9: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
=46reeing unused kernel memory: 120k freed
NET: Registered protocol family 1
Adding 265032k swap on /dev/discs/disc0/part6.  Priority:-1 extents:1
Non-volatile memory driver v1.2
Real Time Clock Driver v1.12
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 11, io base 0xd400
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using uhci_hcd and address 2
usb 1-2: new low speed USB device using uhci_hcd and address 3
input: USB HID v1.10 Keyboard [DARFON USB Composite Keyboard] on usb-0000:0=
0:07.2-1
input: USB HID v1.10 Device [DARFON USB Composite Keyboard] on usb-0000:00:=
07.2-1
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse=AE Explorer] o=
n usb-0000:00:07.2-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
=46loppy drive(s): fd0 is 1.44M
=46DC 0 is a post-1991 82077
PCI: 0000:00:0c.0 has unsupported PM cap regs version (1)
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 11 (level, low) -> IRQ 11
loop: loaded (max 8 devices)
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xd8000000
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6629  Wed Nov  3 1=
3:12:51 PST 2004
ReiserFS: hdc7: found reiserfs format "3.6" with standard journal
ReiserFS: hdc7: using ordered data mode
ReiserFS: hdc7: journal params: device hdc7, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc7: checking transaction log (hdc7)
ReiserFS: hdc7: Using r5 hash to sort names
ReiserFS: hdc8: found reiserfs format "3.6" with standard journal
ReiserFS: hdc8: using ordered data mode
ReiserFS: hdc8: journal params: device hdc8, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc8: checking transaction log (hdc8)
ReiserFS: hdc8: Using r5 hash to sort names
SGI XFS with ACLs, security attributes, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem md0
Ending clean XFS mount for filesystem: md0
Adding 262136k swap on /home/.swap.  Priority:-2 extents:2
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 5 (level, low) -> IRQ 5
eth0: RealTek RTL8139 at 0xdc00, 00:e0:7d:9f:1f:90, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8139C'
NET: Registered protocol family 17
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
NVRM: rm_init_adapter failed

--Boundary-01=_cuJICXCrJodEX6y--

--nextPart3379706.nCKikgMCP3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.15 (GNU/Linux)

iD8DBQBCIJucyDSg81NUg48RAljZAJ9cE+Hi/wQV+p0l5PXS5pTKaJjevQCgl8c1
RC3tZW9KpfXVNiI5XArSzSc=
=yvxT
-----END PGP SIGNATURE-----

--nextPart3379706.nCKikgMCP3--
