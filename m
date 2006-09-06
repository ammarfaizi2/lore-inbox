Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWIFS62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWIFS62 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 14:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbWIFS62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 14:58:28 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:49161 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S932065AbWIFS6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 14:58:25 -0400
Date: Wed, 06 Sep 2006 19:56:23 +0100
From: Darren Salt <linux@youmustbejoking.demon.co.uk>
Message-ID: <4E623F81FD%linux@youmustbejoking.demon.co.uk>
User-Agent: Messenger-Pro/4.12 (MsgServe/3.25) (RISC-OS/4.02) POPstar/2.06+cvs
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org, dtor_core@ameritech.net
Subject: Touchpad sometimes detected twice
X-Editor: Zap 1.47 (27 Apr 2006) [TEST], ZapEmail 0.28.3 (25 Mar 2005) (32)
X-SDate: Wed, 4754 Sep 1993 19:56:23 +0100
X-Message-Flag: Outlook Express is broken. Upgrade to mail(1).
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="298232266--698669670--761615436"
X-SA-Exim-Connect-IP: 192.168.0.2
X-SA-Exim-Mail-From: linux@youmustbejoking.demon.co.uk
X-SA-Exim-Scanned: No (on pentagram.youmustbejoking.demon.co.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format which your mailer apparently does not support.
You either require a newer version of your software which supports MIME, or
a separate MIME decoding utility.  Alternatively, ask the sender of this
message to resend it in a different format.

--298232266--698669670--761615436
Content-Type: text/plain; charset=us-ascii

Sometimes, the touchpad on my (new) laptop is detected twice. This can cause
problems with udev: there may or may not be links in /dev/input/by-*, and if
present, the links may be broken.

Config etc. attached.

-- 
| Darren Salt    | linux or ds at              | nr. Ashington, | Toon
| RISC OS, Linux | youmustbejoking,demon,co,uk | Northumberland | Army
| + Buy local produce. Try to walk or cycle. TRANSPORT CAUSES GLOBAL WARMING.

There is always something new out of Africa.

--298232266--698669670--761615436
Content-Type: text/plain; charset=iso-8859-1; name="config"
Content-Disposition: attachment; filename="config"
Content-Transfer-Encoding: quoted-printable

# Linux kernel version: 2.6.18-rc6
# Tue Sep  5 19:27:35 2006
#
CONFIG_X86_32=3Dy
CONFIG_GENERIC_TIME=3Dy
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_SEMAPHORE_SLEEPERS=3Dy
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_IOMAP=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
CONFIG_DMI=3Dy
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32

#
# General setup
#
CONFIG_LOCALVERSION=3D""
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_UID16=3Dy
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
CONFIG_KALLSYMS=3Dy
CONFIG_KALLSYMS_ALL=3Dy
CONFIG_HOTPLUG=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_RT_MUTEXES=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SHMEM=3Dy
CONFIG_SLAB=3Dy
CONFIG_VM_EVENT_COUNTERS=3Dy
CONFIG_BASE_SMALL=3D0

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_KMOD=3Dy

#
# Block layer
#

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
CONFIG_DEFAULT_AS=3Dy
CONFIG_DEFAULT_IOSCHED=3D"anticipatory"

#
# Processor type and features
#
CONFIG_X86_PC=3Dy
CONFIG_MPENTIUM4=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D7
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_CMPXCHG64=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_PREEMPT_VOLUNTARY=3Dy
CONFIG_X86_UP_APIC=3Dy
CONFIG_X86_UP_IOAPIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_NONFATAL=3Dy
CONFIG_X86_MCE_P4THERMAL=3Dy
CONFIG_VM86=3Dy
CONFIG_X86_MSR=3Dm

#
# Firmware Drivers
#
CONFIG_NOHIGHMEM=3Dy
CONFIG_PAGE_OFFSET=3D0xC0000000
CONFIG_ARCH_FLATMEM_ENABLE=3Dy
CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_FLATMEM_MANUAL=3Dy
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
CONFIG_SPARSEMEM_STATIC=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=3D4
CONFIG_MTRR=3Dy
CONFIG_REGPARM=3Dy
CONFIG_SECCOMP=3Dy
CONFIG_HZ_250=3Dy
CONFIG_HZ=3D250
CONFIG_PHYSICAL_START=3D0x100000

#
# Power management options (ACPI, APM)
#
CONFIG_PM=3Dy
CONFIG_PM_LEGACY=3Dy
CONFIG_SOFTWARE_SUSPEND=3Dy
CONFIG_PM_STD_PARTITION=3D"/dev/hda3"

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=3Dy
CONFIG_ACPI_SLEEP=3Dy
CONFIG_ACPI_SLEEP_PROC_FS=3Dy
CONFIG_ACPI_AC=3Dy
CONFIG_ACPI_BATTERY=3Dy
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_VIDEO=3Dy
CONFIG_ACPI_HOTKEY=3Dy
CONFIG_ACPI_FAN=3Dy
CONFIG_ACPI_DOCK=3Dm
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_THERMAL=3Dy
CONFIG_ACPI_BLACKLIST_YEAR=3D0
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_X86_PM_TIMER=3Dy

#
# APM (Advanced Power Management) BIOS Support
#

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_TABLE=3Dy
CONFIG_CPU_FREQ_STAT=3Dy
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy

#
# CPUFreq processor drivers
#
CONFIG_X86_SPEEDSTEP_CENTRINO=3Dy
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=3Dy

#
# shared options
#

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=3Dy
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_MMCONFIG=3Dy
CONFIG_PCIEPORTBUS=3Dy
CONFIG_PCI_MSI=3Dy
CONFIG_ISA_DMA_API=3Dy

#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=3Dy
CONFIG_PCMCIA=3Dm
CONFIG_CARDBUS=3Dy

#
# PC-card bridges
#
CONFIG_YENTA=3Dm
CONFIG_YENTA_O2=3Dy
CONFIG_YENTA_RICOH=3Dy
CONFIG_YENTA_TI=3Dy
CONFIG_YENTA_ENE_TUNE=3Dy
CONFIG_YENTA_TOSHIBA=3Dy
CONFIG_PCCARD_NONSTATIC=3Dm

#
# PCI Hotplug Support
#

#
# Executable file formats
#
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dm

#
# Networking
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dm
CONFIG_PACKET_MMAP=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
CONFIG_IP_FIB_HASH=3Dy
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE=3Dm
CONFIG_SYN_COOKIES=3Dy
CONFIG_INET_TUNNEL=3Dm
CONFIG_TCP_CONG_BIC=3Dy

#
# IP: Virtual Server Configuration
#
CONFIG_NETFILTER=3Dy

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_XTABLES=3Dm
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm
CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm
CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
CONFIG_NETFILTER_XT_MATCH_DCCP=3Dm
CONFIG_NETFILTER_XT_MATCH_HELPER=3Dm
CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_MAC=3Dm
CONFIG_NETFILTER_XT_MATCH_MARK=3Dm
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm
CONFIG_NETFILTER_XT_MATCH_REALM=3Dm
CONFIG_NETFILTER_XT_MATCH_SCTP=3Dm
CONFIG_NETFILTER_XT_MATCH_STATE=3Dm
CONFIG_NETFILTER_XT_MATCH_STRING=3Dm
CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dm

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dm
CONFIG_IP_NF_FTP=3Dm
CONFIG_IP_NF_IRC=3Dm
CONFIG_IP_NF_NETBIOS_NS=3Dm
CONFIG_IP_NF_TFTP=3Dm
CONFIG_IP_NF_QUEUE=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_IPRANGE=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
CONFIG_IP_NF_MATCH_RECENT=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_DSCP=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_MATCH_OWNER=3Dm
CONFIG_IP_NF_MATCH_ADDRTYPE=3Dm
CONFIG_IP_NF_MATCH_HASHLIMIT=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
CONFIG_IP_NF_NAT=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_NAT_IRC=3Dm
CONFIG_IP_NF_NAT_FTP=3Dm
CONFIG_IP_NF_NAT_TFTP=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_TOS=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_DSCP=3Dm
CONFIG_IP_NF_TARGET_TTL=3Dm

#
# DCCP Configuration (EXPERIMENTAL)
#

#
# SCTP Configuration (EXPERIMENTAL)
#

#
# TIPC Configuration (EXPERIMENTAL)
#
CONFIG_VLAN_8021Q=3Dm

#
# QoS and/or fair queueing
#
CONFIG_NET_CLS_ROUTE=3Dy

#
# Network testing
#
CONFIG_IEEE80211=3Dm
CONFIG_IEEE80211_CRYPT_WEP=3Dm
CONFIG_IEEE80211_CRYPT_CCMP=3Dm
CONFIG_IEEE80211_CRYPT_TKIP=3Dm
CONFIG_IEEE80211_SOFTMAC=3Dm
CONFIG_WIRELESS_EXT=3Dy

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dm

#
# Connector - unified userspace <-> kernelspace linker
#

#
# Memory Technology Devices (MTD)
#

#
# Parallel port support
#

#
# Plug and Play support
#
CONFIG_PNP=3Dy

#
# Protocols
#
CONFIG_PNPACPI=3Dy

#
# Block devices
#
CONFIG_BLK_DEV_LOOP=3Dm

#
# ATA/ATAPI/MFM/RLL support
#

#
# SCSI device support
#
CONFIG_SCSI=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dy
CONFIG_BLK_DEV_SR=3Dy
CONFIG_CHR_DEV_SG=3Dy

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#

#
# SCSI Transport Attributes
#

#
# SCSI low-level drivers
#
CONFIG_SCSI_SATA=3Dy
CONFIG_SCSI_ATA_PIIX=3Dy

#
# PCMCIA SCSI adapter support
#

#
# Multi-device support (RAID and LVM)
#

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support
#

#
# I2O device support
#

#
# Network device support
#
CONFIG_NETDEVICES=3Dy
CONFIG_DUMMY=3Dy

#
# ARCnet devices
#

#
# PHY device support
#

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dm

#
# Tulip family network device support
#

#
# Ethernet (1000 Mbit)
#
CONFIG_R8169=3Dm

#
# Ethernet (10000 Mbit)
#

#
# Token Ring devices
#

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=3Dy

#
# Obsolete Wireless cards support (pre-802.11)
#

#
# Wireless 802.11 Frequency Hopping cards support
#

#
# Wireless 802.11b ISA/PCI cards support
#

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
CONFIG_NET_WIRELESS=3Dy

#
# PCMCIA network device support
#

#
# Wan interfaces
#

#
# ISDN subsystem
#

#
# Telephony Support
#

#
# Input device support
#
CONFIG_INPUT=3Dy

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D800
CONFIG_INPUT_JOYDEV=3Dm
CONFIG_INPUT_EVDEV=3Dy

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
CONFIG_INPUT_JOYSTICK=3Dy
CONFIG_INPUT_MISC=3Dy
CONFIG_INPUT_PCSPKR=3Dy

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_LIBPS2=3Dy

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy

#
# Serial drivers
#

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT=3D256

#
# IPMI
#

#
# Watchdog Cards
#
CONFIG_WATCHDOG=3Dy

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=3Dm

#
# PCI-based Watchdog Cards
#

#
# USB-based Watchdog Cards
#
CONFIG_RTC=3Dy

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=3Dy
CONFIG_AGP_INTEL=3Dy
CONFIG_DRM=3Dy
CONFIG_DRM_I915=3Dy

#
# PCMCIA character devices
#
CONFIG_HANGCHECK_TIMER=3Dm

#
# TPM devices
#

#
# I2C support
#
CONFIG_I2C=3Dy
CONFIG_I2C_CHARDEV=3Dy

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=3Dy
CONFIG_I2C_ALGOPCF=3Dy
CONFIG_I2C_ALGOPCA=3Dy

#
# I2C Hardware Bus support
#
CONFIG_I2C_I801=3Dy

#
# Miscellaneous I2C Chip support
#
CONFIG_SENSORS_EEPROM=3Dy

#
# SPI support
#

#
# Dallas's 1-wire bus
#

#
# Hardware Monitoring support
#

#
# Misc devices
#

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=3Dm
CONFIG_VIDEO_V4L1=3Dy
CONFIG_VIDEO_V4L1_COMPAT=3Dy
CONFIG_VIDEO_V4L2=3Dy

#
# Video Capture Adapters
#

#
# Video Capture Adapters
#

#
# Encoders and Decoders
#

#
# V4L USB devices
#
CONFIG_USB_PWC=3Dm

#
# Radio Adapters
#

#
# Digital Video Broadcasting Devices
#

#
# Graphics support
#
CONFIG_FIRMWARE_EDID=3Dy
CONFIG_FB=3Dy
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
CONFIG_FB_MODE_HELPERS=3Dy
CONFIG_FB_TILEBLITTING=3Dy
CONFIG_FB_VESA=3Dy
CONFIG_FB_INTEL=3Dy

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
CONFIG_VIDEO_SELECT=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy

#
# Logo configuration
#
CONFIG_LOGO=3Dy
CONFIG_LOGO_LINUX_VGA16=3Dy
CONFIG_LOGO_LINUX_CLUT224=3Dy
CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
CONFIG_BACKLIGHT_DEVICE=3Dy
CONFIG_LCD_CLASS_DEVICE=3Dy
CONFIG_LCD_DEVICE=3Dy

#
# Sound
#
CONFIG_SOUND=3Dm

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=3Dm
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_PCM_OSS_PLUGINS=3Dy
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_RTCTIMER=3Dm
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=3Dy
CONFIG_SND_SUPPORT_OLD_API=3Dy

#
# Generic devices
#
CONFIG_SND_VIRMIDI=3Dm

#
# PCI devices
#
CONFIG_SND_HDA_INTEL=3Dm

#
# USB devices
#

#
# PCMCIA devices
#

#
# Open Sound System
#

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB_ARCH_HAS_EHCI=3Dy
CONFIG_USB=3Dy

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_BANDWIDTH=3Dy
CONFIG_USB_SUSPEND=3Dy

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=3Dy
CONFIG_USB_UHCI_HCD=3Dy

#
# USB Device Class drivers
#

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=3Dm
CONFIG_USB_STORAGE_DATAFAB=3Dy
CONFIG_USB_STORAGE_FREECOM=3Dy
CONFIG_USB_STORAGE_DPCM=3Dy
CONFIG_USB_STORAGE_USBAT=3Dy
CONFIG_USB_STORAGE_SDDR09=3Dy
CONFIG_USB_STORAGE_SDDR55=3Dy
CONFIG_USB_STORAGE_JUMPSHOT=3Dy
CONFIG_USB_STORAGE_ALAUDA=3Dy

#
# USB Input Devices
#
CONFIG_USB_HID=3Dm
CONFIG_USB_HIDINPUT=3Dy
CONFIG_USB_HIDDEV=3Dy

#
# USB HID Boot Protocol drivers
#

#
# USB Imaging devices
#

#
# USB Network Adapters
#

#
# USB port drivers
#

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=3Dm
CONFIG_USB_SERIAL_GENERIC=3Dy
CONFIG_USB_SERIAL_BELKIN=3Dm
CONFIG_USB_SERIAL_WHITEHEAT=3Dm
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
CONFIG_USB_SERIAL_EMPEG=3Dm
CONFIG_USB_SERIAL_FTDI_SIO=3Dm
CONFIG_USB_SERIAL_VISOR=3Dm
CONFIG_USB_SERIAL_IPAQ=3Dm
CONFIG_USB_SERIAL_IR=3Dm
CONFIG_USB_SERIAL_EDGEPORT=3Dm
CONFIG_USB_SERIAL_EDGEPORT_TI=3Dm
CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
CONFIG_USB_SERIAL_KEYSPAN=3Dm
CONFIG_USB_SERIAL_KLSI=3Dm
CONFIG_USB_SERIAL_KOBIL_SCT=3Dm
CONFIG_USB_SERIAL_MCT_U232=3Dm
CONFIG_USB_SERIAL_PL2303=3Dm
CONFIG_USB_SERIAL_CYBERJACK=3Dm
CONFIG_USB_SERIAL_XIRCOM=3Dm
CONFIG_USB_SERIAL_OMNINET=3Dm
CONFIG_USB_EZUSB=3Dy

#
# USB Miscellaneous drivers
#

#
# USB DSL modem support
#

#
# USB Gadget Support
#

#
# MMC/SD Card support
#
CONFIG_MMC=3Dm
CONFIG_MMC_BLOCK=3Dm
CONFIG_MMC_SDHCI=3Dm

#
# LED devices
#

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#

#
# Real Time Clock
#

#
# DMA Engine support
#

#
# DMA Clients
#

#
# DMA Devices
#

#
# File systems
#
CONFIG_EXT2_FS=3Dy
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT3_FS=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_JBD=3Dy
CONFIG_FS_MBCACHE=3Dy
CONFIG_INOTIFY=3Dy
CONFIG_INOTIFY_USER=3Dy
CONFIG_DNOTIFY=3Dy

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_RAMFS=3Dy

#
# Miscellaneous filesystems
#

#
# Network File Systems
#
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dy
CONFIG_SMB_FS=3Dy
CONFIG_SMB_NLS_DEFAULT=3Dy
CONFIG_SMB_NLS_REMOTE=3D"cp437"

#
# Partition Types
#
CONFIG_MSDOS_PARTITION=3Dy

#
# Native Language Support
#
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"cp437"
CONFIG_NLS_CODEPAGE_437=3Dm
CONFIG_NLS_CODEPAGE_850=3Dm
CONFIG_NLS_ISO8859_1=3Dy
CONFIG_NLS_UTF8=3Dy

#
# Instrumentation Support
#

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_DETECT_SOFTLOCKUP=3Dy
CONFIG_DEBUG_BUGVERBOSE=3Dy
CONFIG_EARLY_PRINTK=3Dy

#
# Page alloc debug is incompatible with Software Suspend on i386
#
CONFIG_X86_FIND_SMP_CONFIG=3Dy
CONFIG_X86_MPPARSE=3Dy
CONFIG_DOUBLEFAULT=3Dy

#
# Security options
#
CONFIG_SECURITY=3Dy
CONFIG_SECURITY_CAPABILITIES=3Dy

#
# Cryptographic options
#
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_AES=3Dm
CONFIG_CRYPTO_ARC4=3Dm
CONFIG_CRYPTO_MICHAEL_MIC=3Dm

#
# Hardware crypto devices
#

#
# Library routines
#
CONFIG_CRC_CCITT=3Dm
CONFIG_CRC32=3Dy
CONFIG_TEXTSEARCH=3Dy
CONFIG_TEXTSEARCH_KMP=3Dm
CONFIG_TEXTSEARCH_BM=3Dm
CONFIG_TEXTSEARCH_FSM=3Dm
CONFIG_PLIST=3Dy
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_X86_BIOS_REBOOT=3Dy
CONFIG_KTIME_SCALAR=3Dy

--298232266--698669670--761615436
Content-Type: text/plain; charset=iso-8859-1; name="proc.bus.input.devices"
Content-Disposition: attachment; filename="proc.bus.input.devices"
Content-Transfer-Encoding: quoted-printable

I: Bus=3D0010 Vendor=3D001f Product=3D0001 Version=3D0100
N: Name=3D"PC Speaker"
P: Phys=3Disa0061/input0
S: Sysfs=3D/class/input/input0
H: Handlers=3Dkbd event0=20
B: EV=3D40001
B: SND=3D6

I: Bus=3D0011 Vendor=3D0001 Product=3D0001 Version=3Dab41
N: Name=3D"AT Translated Set 2 keyboard"
P: Phys=3Disa0060/serio0/input0
S: Sysfs=3D/class/input/input1
H: Handlers=3Dkbd event1=20
B: EV=3D120013
B: KEY=3D4 27d003f 3bf207f f87fd683 feffffdf ffefffff ffffffff ffffffff
B: MSC=3D10
B: LED=3D7

I: Bus=3D0011 Vendor=3D0002 Product=3D0008 Version=3D0000
N: Name=3D"PS/2 Mouse"
P: Phys=3Disa0060/serio4/input1
S: Sysfs=3D/class/input/input4
H: Handlers=3Dmouse0 event2=20
B: EV=3D7
B: KEY=3D70000 0 0 0 0 0 0 0 0
B: REL=3D3

I: Bus=3D0011 Vendor=3D0002 Product=3D0008 Version=3D7321
N: Name=3D"AlpsPS/2 ALPS GlidePoint"
P: Phys=3Disa0060/serio4/input0
S: Sysfs=3D/class/input/input5
H: Handlers=3Dmouse1 event3=20
B: EV=3Df
B: KEY=3D420 0 70000 0 0 0 0 0 0 0 0
B: REL=3D3
B: ABS=3D1000003


--298232266--698669670--761615436
Content-Type: text/plain; charset=iso-8859-1; name="dmesg"
Content-Disposition: attachment; filename="dmesg"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.18-rc6 (root@alien8) (gcc version 4.1.2 20060814 (prere=
lease) (Debian 4.1.1-11)) #1 Tue Sep 5 19:31:46 BST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001f680000 (usable)
 BIOS-e820: 000000001f680000 - 000000001f700000 (ACPI NVS)
 BIOS-e820: 000000001f700000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
502MB LOWMEM available.
found SMP MP-table at 000f7670
On node 0 totalpages: 128640
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 124544 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v000 TOSCPL                                ) @ 0x000f75e0
ACPI: RSDT (v001 TOSCPL Capell00 0x06040000  LTP 0x00000000) @ 0x1f681b68=

ACPI: FADT (v001 TOSCPL CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x1f688dfc=

ACPI: MADT (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x1f688e70=

ACPI: HPET (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x1f688ed8=

ACPI: MCFG (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x1f688f10=

ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1f688fd8=

ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x1f688f7e=

ACPI: SSDT (v001 SataRe  SataPri 0x00001000 INTL 0x20050624) @ 0x1f682b3c=

ACPI: SSDT (v001 SataRe  SataSec 0x00001000 INTL 0x20050624) @ 0x1f6824aa=

ACPI: SSDT (v001  PmRef  Cpu0Ist 0x00003000 INTL 0x20050624) @ 0x1f68228a=

ACPI: SSDT (v001  PmRef  Cpu0Cst 0x00003001 INTL 0x20050624) @ 0x1f6820ae=

ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20050624) @ 0x1f681bb8=

ACPI: DSDT (v001 TOSCPL CALISTGA 0x06040000 INTL 0x20050624) @ 0x00000000=

ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: 2 duplicate APIC table ignored.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:14 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
Detected 1862.189 MHz processor.
Built 1 zonelists.  Total pages: 128640
Kernel command line: BOOT_IMAGE=3D2.6.18-rc6 ro root=3D802 video=3Dintelf=
b:1280x800-32@60 pci=3Dassign-busses log_buf_len=3D128k resume2=3Dswap:/d=
ev/sda3
log_buf_len: 131072
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 506632k/514560k available (1724k kernel code, 7504k reserved, 862=
k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... =
Ok.
Calibrating delay using timer specific routine.. 3728.17 BogoMIPS (lpj=3D=
7456358)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00=
00c189 00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 000=
0c189 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00000940 0000c189 =
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Genuine Intel(R) CPU           T1350  @ 1.86GHz stepping 08
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ENABLING IO-APIC IRQs
..TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabl=
ed.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 25) interrupt mode.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a=
 report
pnp: 00:01: ioport range 0xfe00-0xfe7f has been reserved
pnp: 00:01: ioport range 0xfe80-0xfeff has been reserved
pnp: 00:01: ioport range 0xff00-0xff7f has been reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
  IO window: 2000-2fff
  MEM window: d6000000-d7ffffff
  PREFETCH window: d0000000-d1ffffff
PCI: Bridge: 0000:00:1c.1
  IO window: 3000-3fff
  MEM window: d8000000-d9ffffff
  PREFETCH window: d2000000-d3ffffff
PCI: Bridge: 0000:00:1c.2
  IO window: 4000-4fff
  MEM window: da000000-dbffffff
  PREFETCH window: d4000000-d5ffffff
PCI: Bus 5, cardbus bridge: 0000:04:04.0
  IO window: 00005400-000054ff
  IO window: 00005800-000058ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 5000-5fff
  MEM window: dc000000-dc0fffff
  PREFETCH window: 30000000-31ffffff
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1c.2 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:04:04.0[A] -> GSI 16 (level, low) -> IRQ 177
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
Allocate Port Service[0000:00:1c.1:pcie03]
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
Allocate Port Service[0000:00:1c.2:pcie03]
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Power Button (CM) [PWRB]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Getting cpuindex for acpiid 0x1
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 945GM Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xc0000000
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 177
[drm] Initialized i915 1.5.0 20060119 on minor 0
intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G/=
915GM/945G/945GM chipsets
intelfb: Version 0.9.4
intelfb: 00:02.0: Intel(R) 945GM, aperture size 256MB, stolen memory 7932=
kB
intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode switchi=
ng.
intelfb: Video mode must be programmed at boot time.
libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18B0 irq 14
scsi0 : ata_piix
ata1.00: ATA-6, max UDMA/100, 78140160 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
  Vendor: ATA       Model: TOSHIBA MK4032GS  Rev: AS21
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x18B8 irq 15
scsi1 : ata_piix
ata2.00: ATAPI, max UDMA/33
ata2.00: configured for UDMA/33
  Vendor: MATSHITA  Model: DVD-RAM UJ-841S   Rev: 1.60
  Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 1:0:0:0: Attached scsi generic sg1 type 5
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 233, io mem 0xdc444000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 233, io base 0x00001820
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 225, io base 0x00001840
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 185, io base 0x00001860
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 177, io base 0x00001880
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
i2c /dev entries driver
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 225
TCP bic registered
NET: Registered protocol family 1
Using IPI Shortcut mode
ACPI: (supports S0 S3 S4 S5)
Time: tsc clocksource has been installed.
Time: acpi_pm clocksource has been installed.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k freed
input: AT Translated Set 2 keyboard as /class/input/input1
input: PS/2 Mouse as /class/input/input2
input: AlpsPS/2 ALPS GlidePoint as /class/input/input3
input: PS/2 Mouse as /class/input/input4
input: AlpsPS/2 ALPS GlidePoint as /class/input/input5
sdhci: Secure Digital Host Controller Interface driver, 0.12
sdhci: Copyright(c) Pierre Ossman
sdhci: SDHCI controller found at 0000:04:04.2 [1524:0550] (rev 1)
ACPI: PCI Interrupt 0000:04:04.2[B] -> GSI 17 (level, low) -> IRQ 169
mmc0: SDHCI at 0xdc001c00 irq 169 DMA
r8169 Gigabit Ethernet driver 2.2LK loaded
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:03:00.0 to 64
eth0: RTL8101e at 0xe0032000, 00:16:d4:27:9e:42, IRQ 185
Yenta: CardBus bridge found at 0000:04:04.0 [1179:ff01]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:04:04.0, mfunc 0x89501212, devctl 0x44
Yenta: ISA IRQ mask 0x0cf8, PCI irq 177
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x5000 - 0x5fff
pcmcia: parent PCI bridge Memory window: 0xdc000000 - 0xdc0fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x31ffffff
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...
Adding 1052232k swap on /dev/sda3.  Priority:-1 extents:1 across:1052232k=

EXT3 FS on sda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
r8169: eh0: link down
r8169: eh0: link down
NET: Registered protocol family 17

--298232266--698669670--761615436--
