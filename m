Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266084AbUGILrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266084AbUGILrf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 07:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266113AbUGILrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 07:47:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:22709 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266084AbUGILod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 07:44:33 -0400
X-Authenticated: #438326
From: Michael Geithe <warpy@gmx.de>
Reply-To: warpy@gmx.de
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm7
Date: Fri, 9 Jul 2004 13:44:32 +0200
User-Agent: KMail/1.6.2
References: <20040708235025.5f8436b7.akpm@osdl.org>
In-Reply-To: <20040708235025.5f8436b7.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gUo7ApZE6IVG1TY"
Message-Id: <200407091344.32938.warpy@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_gUo7ApZE6IVG1TY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Freitag, 9. Juli 2004 08:50 schrieben Sie:
> 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/

Hi,
reverting bk-usb.patch makes it boot.

Shutdown will not work with the latest bk-acpi.patch in mm7.
Stops with 

Power down
acpi_power_off called

Michael

--Boundary-00=_gUo7ApZE6IVG1TY
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci"

0000:00:00.0 Host bridge: Intel Corp.: Unknown device 2578 (rev 02)
0000:00:01.0 PCI bridge: Intel Corp.: Unknown device 2579 (rev 02)
0000:00:1d.0 USB Controller: Intel Corp.: Unknown device 24d2 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp.: Unknown device 24d4 (rev 02)
0000:00:1d.2 USB Controller: Intel Corp.: Unknown device 24d7 (rev 02)
0000:00:1d.3 USB Controller: Intel Corp.: Unknown device 24de (rev 02)
0000:00:1d.7 USB Controller: Intel Corp.: Unknown device 24dd (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp.: Unknown device 24d0 (rev 02)
0000:00:1f.1 IDE interface: Intel Corp.: Unknown device 24db (rev 02)
0000:00:1f.3 SMBus: Intel Corp.: Unknown device 24d3 (rev 02)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti4200] (rev a3)
0000:02:01.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
0000:02:01.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 04)
0000:02:01.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04)
0000:02:02.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
0000:02:02.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
0000:02:03.0 SCSI storage controller: Advanced System Products, Inc ABP940-U / ABP960-U (rev 03)
0000:02:08.0 Ethernet controller: Intel Corp.: Unknown device 1050 (rev 02)
 

--Boundary-00=_gUo7ApZE6IVG1TY
Content-Type: text/plain;
  charset="iso-8859-1";
  name="config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=15
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_KMOD is not set
CONFIG_STOP_MACHINE=y

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
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_SCHED_SMT=y
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_IRQBALANCE=y
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set

#
# Performance-monitoring counters support
#
# CONFIG_PERFCTR is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_PM_DISK is not set

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
# CONFIG_ACPI_FAN is not set
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set

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
# CONFIG_PCI_USE_VECTOR is not set
CONFIG_PCI_LEGACY_PROC=y
# CONFIG_PCI_NAMES is not set
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_PCMCIA_PROBE=y

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
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set

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
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

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
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
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
CONFIG_BLK_DEV_PIIX=y
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
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set
# CONFIG_IEEE1394_EXTRA_CONFIG_ROMS is not set

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
# CONFIG_IEEE1394_VIDEO1394 is not set
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_SBP2_PHYS_DMA=y
# CONFIG_IEEE1394_ETH1394 is not set
# CONFIG_IEEE1394_DV1394 is not set
CONFIG_IEEE1394_RAWIO=m
# CONFIG_IEEE1394_CMP is not set

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
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=y
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
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_ETHERTAP=m
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
CONFIG_EEPRO100=y
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
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
# CONFIG_VIA_VELOCITY is not set
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
# CONFIG_SK98LIN is not set
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
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
# CONFIG_PPP_DEFLATE is not set
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
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
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
# CONFIG_SERIO_RAW is not set

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
CONFIG_MOUSE_PS2=m
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
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
# CONFIG_QIC02_TAPE is not set

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
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_ALGOPCF is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=m
# CONFIG_I2C_I810 is not set
CONFIG_I2C_ISA=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set

#
# Other I2C Chip support
#
CONFIG_SENSORS_EEPROM=m
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=y

#
# Video For Linux
#

#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set
# CONFIG_VIDEO_OVCAMCHIP is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m
CONFIG_VIDEO_IR=m

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
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

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

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
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
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
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=m
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
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
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

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
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_SPLIT_ISO is not set
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m

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
CONFIG_USB_STORAGE_RW_DETECT=y
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
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

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
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_W9968CF is not set

#
# USB Network adaptors
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
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS_FS=m
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m

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
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
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
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
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
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_LOCKMETER is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
# CONFIG_TRAP_BAD_SYSCALL_EXITS is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
CONFIG_CRC32=m
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y

--Boundary-00=_gUo7ApZE6IVG1TY
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

Jul  9 13:31:29 stargate kernel: Linux version 2.6.7-mm7 (root@stargate) (gcc-Version 3.3.3 20040412 (Gentoo Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #2 SMP Fri Jul 9 12:34:26 CEST 2004
Jul  9 13:31:29 stargate kernel: BIOS-provided physical RAM map:
Jul  9 13:31:29 stargate kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jul  9 13:31:29 stargate kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jul  9 13:31:29 stargate kernel:  BIOS-e820: 00000000000d4000 - 00000000000de014 (reserved)
Jul  9 13:31:29 stargate kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jul  9 13:31:29 stargate kernel:  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
Jul  9 13:31:29 stargate kernel:  BIOS-e820: 000000003fff0000 - 000000003fff8000 (ACPI data)
Jul  9 13:31:29 stargate kernel:  BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
Jul  9 13:31:29 stargate kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Jul  9 13:31:29 stargate kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Jul  9 13:31:29 stargate kernel:  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Jul  9 13:31:29 stargate kernel: 127MB HIGHMEM available.
Jul  9 13:31:29 stargate kernel: 896MB LOWMEM available.
Jul  9 13:31:29 stargate kernel: found SMP MP-table at 000fc0f0
Jul  9 13:31:29 stargate kernel: On node 0 totalpages: 262128
Jul  9 13:31:29 stargate kernel:   DMA zone: 4096 pages, LIFO batch:1
Jul  9 13:31:29 stargate kernel:   Normal zone: 225280 pages, LIFO batch:16
Jul  9 13:31:29 stargate kernel:   HighMem zone: 32752 pages, LIFO batch:7
Jul  9 13:31:29 stargate kernel: DMI 2.3 present.
Jul  9 13:31:29 stargate kernel: ACPI: RSDP (v000 AMI                                       ) @ 0x000fa390
Jul  9 13:31:29 stargate kernel: ACPI: RSDT (v001 AMIINT INTEL875 0x00000010 MSFT 0x00000097) @ 0x3fff0000
Jul  9 13:31:29 stargate kernel: ACPI: FADT (v001 AMIINT INTEL875 0x00000011 MSFT 0x00000097) @ 0x3fff0030
Jul  9 13:31:29 stargate kernel: ACPI: MADT (v001 AMIINT INTEL875 0x00000009 MSFT 0x00000097) @ 0x3fff00c0
Jul  9 13:31:29 stargate kernel: ACPI: DSDT (v001  INTEL     I875 0x00001000 MSFT 0x0100000d) @ 0x00000000
Jul  9 13:31:29 stargate kernel: ACPI: Local APIC address 0xfee00000
Jul  9 13:31:29 stargate kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Jul  9 13:31:29 stargate kernel: Processor #0 15:2 APIC version 20
Jul  9 13:31:29 stargate kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Jul  9 13:31:29 stargate kernel: Processor #1 15:2 APIC version 20
Jul  9 13:31:29 stargate kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jul  9 13:31:29 stargate kernel: IOAPIC[0]: Assigned apic_id 2
Jul  9 13:31:29 stargate kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Jul  9 13:31:29 stargate kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jul  9 13:31:29 stargate kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jul  9 13:31:29 stargate kernel: ACPI: IRQ0 used by override.
Jul  9 13:31:29 stargate kernel: ACPI: IRQ2 used by override.
Jul  9 13:31:29 stargate kernel: ACPI: IRQ9 used by override.
Jul  9 13:31:29 stargate kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Jul  9 13:31:29 stargate kernel: Using ACPI (MADT) for SMP configuration information
Jul  9 13:31:29 stargate kernel: Built 1 zonelists
Jul  9 13:31:29 stargate kernel: Initializing CPU#0
Jul  9 13:31:29 stargate kernel: Kernel command line: root=/dev/hda1  video=vesafb:ypan,vram:16 vga=0x317
Jul  9 13:31:29 stargate kernel: CPU 0 irqstacks, hard=c03cf000 soft=c03cd000
Jul  9 13:31:29 stargate kernel: PID hash table entries: 4096 (order 12: 32768 bytes)
Jul  9 13:31:29 stargate kernel: Detected 2800.176 MHz processor.
Jul  9 13:31:29 stargate kernel: Using tsc for high-res timesource
Jul  9 13:31:29 stargate kernel: Console: colour dummy device 80x25
Jul  9 13:31:29 stargate kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Jul  9 13:31:29 stargate kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Jul  9 13:31:29 stargate kernel: Memory: 1035148k/1048512k available (2037k kernel code, 12456k reserved, 645k data, 172k init, 131008k highmem)
Jul  9 13:31:29 stargate kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jul  9 13:31:29 stargate kernel: Calibrating delay loop... 5537.79 BogoMIPS
Jul  9 13:31:29 stargate kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Jul  9 13:31:29 stargate kernel: CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
Jul  9 13:31:29 stargate kernel: CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
Jul  9 13:31:29 stargate kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jul  9 13:31:29 stargate kernel: CPU: L2 cache: 512K
Jul  9 13:31:29 stargate kernel: CPU: Physical Processor ID: 0
Jul  9 13:31:29 stargate kernel: CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Jul  9 13:31:29 stargate kernel: Intel machine check architecture supported.
Jul  9 13:31:29 stargate kernel: Intel machine check reporting enabled on CPU#0.
Jul  9 13:31:29 stargate kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Jul  9 13:31:29 stargate kernel: CPU0: Thermal monitoring enabled
Jul  9 13:31:29 stargate kernel: Enabling fast FPU save and restore... done.
Jul  9 13:31:29 stargate kernel: Enabling unmasked SIMD FPU exception support... done.
Jul  9 13:31:29 stargate kernel: Checking 'hlt' instruction... OK.
Jul  9 13:31:29 stargate kernel: CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Jul  9 13:31:29 stargate kernel: per-CPU timeslice cutoff: 1462.65 usecs.
Jul  9 13:31:29 stargate kernel: task migration cache decay timeout: 2 msecs.
Jul  9 13:31:29 stargate kernel: enabled ExtINT on CPU#0
Jul  9 13:31:29 stargate kernel: ESR value before enabling vector: 00000000
Jul  9 13:31:29 stargate kernel: ESR value after enabling vector: 00000000
Jul  9 13:31:29 stargate kernel: Booting processor 1/1 eip 2000
Jul  9 13:31:29 stargate kernel: CPU 1 irqstacks, hard=c03d0000 soft=c03ce000
Jul  9 13:31:29 stargate kernel: Initializing CPU#1
Jul  9 13:31:29 stargate kernel: masked ExtINT on CPU#1
Jul  9 13:31:29 stargate kernel: ESR value before enabling vector: 00000000
Jul  9 13:31:29 stargate kernel: ESR value after enabling vector: 00000000
Jul  9 13:31:29 stargate kernel: Calibrating delay loop... 5586.94 BogoMIPS
Jul  9 13:31:29 stargate kernel: CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
Jul  9 13:31:29 stargate kernel: CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
Jul  9 13:31:29 stargate kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jul  9 13:31:29 stargate kernel: CPU: L2 cache: 512K
Jul  9 13:31:29 stargate kernel: CPU: Physical Processor ID: 0
Jul  9 13:31:29 stargate kernel: CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Jul  9 13:31:29 stargate kernel: Intel machine check architecture supported.
Jul  9 13:31:29 stargate kernel: Intel machine check reporting enabled on CPU#1.
Jul  9 13:31:29 stargate kernel: CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
Jul  9 13:31:29 stargate kernel: CPU1: Thermal monitoring enabled
Jul  9 13:31:29 stargate kernel: CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Jul  9 13:31:29 stargate kernel: Total of 2 processors activated (11124.73 BogoMIPS).
Jul  9 13:31:29 stargate kernel: ENABLING IO-APIC IRQs
Jul  9 13:31:29 stargate kernel: init IO_APIC IRQs
Jul  9 13:31:29 stargate kernel:  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
Jul  9 13:31:29 stargate kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Jul  9 13:31:29 stargate kernel: Using local APIC timer interrupts.
Jul  9 13:31:29 stargate kernel: calibrating APIC timer ...
Jul  9 13:31:29 stargate kernel: ..... CPU clock speed is 2799.0697 MHz.
Jul  9 13:31:29 stargate kernel: ..... host bus clock speed is 199.0978 MHz.
Jul  9 13:31:29 stargate kernel: checking TSC synchronization across 2 CPUs: passed.
Jul  9 13:31:29 stargate kernel: Brought up 2 CPUs
Jul  9 13:31:29 stargate kernel: CPU0:  online
Jul  9 13:31:29 stargate kernel:  domain 0: span 3
Jul  9 13:31:29 stargate kernel:   groups: 1 2
Jul  9 13:31:29 stargate kernel:   domain 1: span 3
Jul  9 13:31:29 stargate kernel:    groups: 3
Jul  9 13:31:29 stargate kernel: CPU1:  online
Jul  9 13:31:29 stargate kernel:  domain 0: span 3
Jul  9 13:31:29 stargate kernel:   groups: 2 1
Jul  9 13:31:29 stargate kernel:   domain 1: span 3
Jul  9 13:31:29 stargate kernel:    groups: 3
Jul  9 13:31:29 stargate kernel: checking if image is initramfs...it isn't (ungzip failed); looks like an initrd
Jul  9 13:31:29 stargate kernel: Freeing initrd memory: 117k freed
Jul  9 13:31:29 stargate kernel: NET: Registered protocol family 16
Jul  9 13:31:29 stargate kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=2
Jul  9 13:31:29 stargate kernel: PCI: Using configuration type 1
Jul  9 13:31:29 stargate kernel: mtrr: v2.0 (20020519)
Jul  9 13:31:29 stargate kernel: ACPI: Subsystem revision 20040615
Jul  9 13:31:29 stargate kernel: ACPI: Interpreter enabled
Jul  9 13:31:29 stargate kernel: ACPI: Using IOAPIC for interrupt routing
Jul  9 13:31:29 stargate kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jul  9 13:31:29 stargate kernel: PCI: Probing PCI hardware (bus 00)
Jul  9 13:31:29 stargate kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Jul  9 13:31:29 stargate kernel: PCI: Transparent bridge - 0000:00:1e.0
Jul  9 13:31:29 stargate kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jul  9 13:31:29 stargate kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.ICHB._PRT]
Jul  9 13:31:29 stargate kernel: ACPI: Power Resource [URP1] (off)
Jul  9 13:31:29 stargate kernel: ACPI: Power Resource [URP2] (off)
Jul  9 13:31:29 stargate kernel: ACPI: Power Resource [FDDP] (off)
Jul  9 13:31:29 stargate kernel: ACPI: Power Resource [LPTP] (off)
Jul  9 13:31:29 stargate kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Jul  9 13:31:29 stargate kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Jul  9 13:31:29 stargate kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Jul  9 13:31:29 stargate kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Jul  9 13:31:29 stargate kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Jul  9 13:31:29 stargate kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Jul  9 13:31:29 stargate kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Jul  9 13:31:29 stargate kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Jul  9 13:31:29 stargate kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jul  9 13:31:29 stargate kernel: SCSI subsystem initialized
Jul  9 13:31:29 stargate kernel: PCI: Using ACPI for IRQ routing
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 17 (level, low) -> IRQ 17
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:02:01.2[B] -> GSI 18 (level, low) -> IRQ 18
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 18 (level, low) -> IRQ 18
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:02:02.1[A] -> GSI 18 (level, low) -> IRQ 18
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 20
Jul  9 13:31:29 stargate kernel: number of MP IRQ sources: 15.
Jul  9 13:31:29 stargate kernel: number of IO-APIC #2 registers: 24.
Jul  9 13:31:29 stargate kernel: testing the IO APIC.......................
Jul  9 13:31:29 stargate kernel: IO APIC #2......
Jul  9 13:31:29 stargate kernel: .... register #00: 02000000
Jul  9 13:31:29 stargate kernel: .......    : physical APIC id: 02
Jul  9 13:31:29 stargate kernel: .......    : Delivery Type: 0
Jul  9 13:31:29 stargate kernel: .......    : LTS          : 0
Jul  9 13:31:29 stargate kernel: .... register #01: 00178020
Jul  9 13:31:29 stargate kernel: .......     : max redirection entries: 0017
Jul  9 13:31:29 stargate kernel: .......     : PRQ implemented: 1
Jul  9 13:31:29 stargate kernel: .......     : IO APIC version: 0020
Jul  9 13:31:29 stargate kernel: .... IRQ redirection table:
Jul  9 13:31:29 stargate kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Jul  9 13:31:29 stargate kernel:  00 000 00  1    0    0   0   0    0    0    00
Jul  9 13:31:29 stargate kernel:  01 003 03  0    0    0   0   0    1    1    39
Jul  9 13:31:29 stargate kernel:  02 003 03  0    0    0   0   0    1    1    31
Jul  9 13:31:29 stargate kernel:  03 003 03  0    0    0   0   0    1    1    41
Jul  9 13:31:29 stargate kernel:  04 003 03  0    0    0   0   0    1    1    49
Jul  9 13:31:29 stargate kernel:  05 003 03  0    0    0   0   0    1    1    51
Jul  9 13:31:29 stargate kernel:  06 003 03  0    0    0   0   0    1    1    59
Jul  9 13:31:29 stargate kernel:  07 003 03  0    0    0   0   0    1    1    61
Jul  9 13:31:29 stargate kernel:  08 003 03  0    0    0   0   0    1    1    69
Jul  9 13:31:29 stargate kernel:  09 003 03  0    1    0   0   0    1    1    71
Jul  9 13:31:29 stargate kernel:  0a 003 03  0    0    0   0   0    1    1    79
Jul  9 13:31:29 stargate kernel:  0b 003 03  0    0    0   0   0    1    1    81
Jul  9 13:31:29 stargate kernel:  0c 003 03  0    0    0   0   0    1    1    89
Jul  9 13:31:29 stargate kernel:  0d 003 03  0    0    0   0   0    1    1    91
Jul  9 13:31:29 stargate kernel:  0e 003 03  0    0    0   0   0    1    1    99
Jul  9 13:31:29 stargate kernel:  0f 003 03  0    0    0   0   0    1    1    A1
Jul  9 13:31:29 stargate kernel:  10 003 03  1    1    0   1   0    1    1    A9
Jul  9 13:31:29 stargate kernel:  11 003 03  1    1    0   1   0    1    1    C9
Jul  9 13:31:29 stargate kernel:  12 003 03  1    1    0   1   0    1    1    B9
Jul  9 13:31:29 stargate kernel:  13 003 03  1    1    0   1   0    1    1    B1
Jul  9 13:31:29 stargate kernel:  14 003 03  1    1    0   1   0    1    1    D1
Jul  9 13:31:29 stargate kernel:  15 000 00  1    0    0   0   0    0    0    00
Jul  9 13:31:29 stargate kernel:  16 000 00  1    0    0   0   0    0    0    00
Jul  9 13:31:29 stargate kernel:  17 003 03  1    1    0   1   0    1    1    C1
Jul  9 13:31:29 stargate kernel: IRQ to pin mappings:
Jul  9 13:31:29 stargate kernel: IRQ0 -> 0:2
Jul  9 13:31:29 stargate kernel: IRQ1 -> 0:1
Jul  9 13:31:29 stargate kernel: IRQ3 -> 0:3
Jul  9 13:31:29 stargate kernel: IRQ4 -> 0:4
Jul  9 13:31:29 stargate kernel: IRQ5 -> 0:5
Jul  9 13:31:29 stargate kernel: IRQ6 -> 0:6
Jul  9 13:31:29 stargate kernel: IRQ7 -> 0:7
Jul  9 13:31:29 stargate kernel: IRQ8 -> 0:8
Jul  9 13:31:29 stargate kernel: IRQ9 -> 0:9
Jul  9 13:31:29 stargate kernel: IRQ10 -> 0:10
Jul  9 13:31:29 stargate kernel: IRQ11 -> 0:11
Jul  9 13:31:29 stargate kernel: IRQ12 -> 0:12
Jul  9 13:31:29 stargate kernel: IRQ13 -> 0:13
Jul  9 13:31:29 stargate kernel: IRQ14 -> 0:14
Jul  9 13:31:29 stargate kernel: IRQ15 -> 0:15
Jul  9 13:31:29 stargate kernel: IRQ16 -> 0:16
Jul  9 13:31:29 stargate kernel: IRQ17 -> 0:17
Jul  9 13:31:29 stargate kernel: IRQ18 -> 0:18
Jul  9 13:31:29 stargate kernel: IRQ19 -> 0:19
Jul  9 13:31:29 stargate kernel: IRQ20 -> 0:20
Jul  9 13:31:29 stargate kernel: IRQ23 -> 0:23
Jul  9 13:31:29 stargate kernel: .................................... done.
Jul  9 13:31:29 stargate kernel: vesafb: framebuffer at 0xe8000000, mapped to 0xf8880000, size 16384k
Jul  9 13:31:29 stargate kernel: vesafb: mode is 1024x768x16, linelength=2048, pages=1
Jul  9 13:31:29 stargate kernel: vesafb: protected mode interface info at c000:e9d0
Jul  9 13:31:29 stargate kernel: vesafb: pmi: set display start = c00cea15, set palette = c00cea9a
Jul  9 13:31:29 stargate kernel: vesafb: pmi: ports = b4c3 b503 ba03 c003 c103 c403 c503 c603 c703 c803 c903 cc03 ce03 cf03 d003 d103 d203 d303 d403 d503 da03 ff03 
Jul  9 13:31:29 stargate kernel: vesafb: scrolling: ypan using protected mode interface, yres_virtual=8192
Jul  9 13:31:29 stargate kernel: vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Jul  9 13:31:29 stargate kernel: fb0: VESA VGA frame buffer device
Jul  9 13:31:29 stargate kernel: Machine check exception polling timer started.
Jul  9 13:31:29 stargate kernel: Starting balanced_irq
Jul  9 13:31:29 stargate kernel: highmem bounce pool size: 64 pages
Jul  9 13:31:29 stargate kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Jul  9 13:31:29 stargate kernel: ACPI: Processor [CPU1] (supports C1, 8 throttling states)
Jul  9 13:31:29 stargate kernel: ACPI: Processor [CPU2] (supports C1, 8 throttling states)
Jul  9 13:31:29 stargate kernel: Console: switching to colour frame buffer device 128x48
Jul  9 13:31:29 stargate kernel: Real Time Clock Driver v1.12
Jul  9 13:31:29 stargate kernel: Using anticipatory io scheduler
Jul  9 13:31:29 stargate kernel: Floppy drive(s): fd0 is 1.44M
Jul  9 13:31:29 stargate kernel: FDC 0 is a post-1991 82077
Jul  9 13:31:29 stargate kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Jul  9 13:31:29 stargate kernel: loop: loaded (max 8 devices)
Jul  9 13:31:29 stargate kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
Jul  9 13:31:29 stargate kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 20
Jul  9 13:31:29 stargate kernel: eth0: 0000:02:08.0, 00:0C:76:27:61:10, IRQ 20.
Jul  9 13:31:29 stargate kernel:   Board assembly 000000-000, Physical connectors present: RJ45
Jul  9 13:31:29 stargate kernel:   Primary interface chip i82555 PHY #1.
Jul  9 13:31:29 stargate kernel:   General self-test: passed.
Jul  9 13:31:29 stargate kernel:   Serial sub-system self-test: passed.
Jul  9 13:31:29 stargate kernel:   Internal registers self-test: passed.
Jul  9 13:31:29 stargate kernel:   ROM checksum self-test: passed (0xed626fe2).
Jul  9 13:31:29 stargate kernel: Linux video capture interface: v1.00
Jul  9 13:31:29 stargate kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jul  9 13:31:29 stargate kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jul  9 13:31:29 stargate kernel: ICH5: IDE controller at PCI slot 0000:00:1f.1
Jul  9 13:31:29 stargate kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
Jul  9 13:31:29 stargate kernel: ICH5: chipset revision 2
Jul  9 13:31:29 stargate kernel: ICH5: not 100%% native mode: will probe irqs later
Jul  9 13:31:29 stargate kernel:     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
Jul  9 13:31:29 stargate kernel:     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
Jul  9 13:31:29 stargate kernel: hda: WDC WD600AB-00CDB0, ATA DISK drive
Jul  9 13:31:29 stargate kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul  9 13:31:29 stargate kernel: hdc: ST340015A, ATA DISK drive
Jul  9 13:31:29 stargate kernel: hdd: LITEON DVD-ROM LTD163D, ATAPI CD/DVD-ROM drive
Jul  9 13:31:29 stargate kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul  9 13:31:29 stargate kernel: hda: max request size: 128KiB
Jul  9 13:31:29 stargate kernel: hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Jul  9 13:31:29 stargate kernel: hda: cache flushes supported
Jul  9 13:31:29 stargate kernel:  hda: hda1
Jul  9 13:31:29 stargate kernel: hdc: max request size: 128KiB
Jul  9 13:31:29 stargate kernel: hdc: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Jul  9 13:31:29 stargate kernel: hdc: cache flushes supported
Jul  9 13:31:29 stargate kernel:  hdc: hdc1 hdc2 hdc3
Jul  9 13:31:29 stargate kernel: hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Jul  9 13:31:29 stargate kernel: Uniform CD-ROM driver Revision: 3.20
Jul  9 13:31:29 stargate kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jul  9 13:31:29 stargate kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul  9 13:31:29 stargate kernel: mice: PS/2 mouse device common for all mice
Jul  9 13:31:29 stargate kernel: i2c /dev entries driver
Jul  9 13:31:29 stargate kernel: NET: Registered protocol family 2
Jul  9 13:31:29 stargate kernel: IP: routing cache hash table of 8192 buckets, 64Kbytes
Jul  9 13:31:29 stargate kernel: TCP: Hash tables configured (established 262144 bind 65536)
Jul  9 13:31:29 stargate kernel: NET: Registered protocol family 1
Jul  9 13:31:29 stargate kernel: NET: Registered protocol family 17
Jul  9 13:31:29 stargate kernel: RAMDISK: Couldn't find valid RAM disk image starting at 0.
Jul  9 13:31:29 stargate kernel: ReiserFS: hda1: found reiserfs format "3.6" with standard journal
Jul  9 13:31:29 stargate kernel: ReiserFS: hda1: using ordered data mode
Jul  9 13:31:29 stargate kernel: ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jul  9 13:31:29 stargate kernel: ReiserFS: hda1: checking transaction log (hda1)
Jul  9 13:31:29 stargate kernel: ReiserFS: hda1: Using r5 hash to sort names
Jul  9 13:31:29 stargate kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Jul  9 13:31:29 stargate kernel: Freeing unused kernel memory: 172k freed
Jul  9 13:31:29 stargate kernel: Adding 847720k swap on /dev/hdc3.  Priority:-1 extents:1
Jul  9 13:31:29 stargate kernel: nvidia: module license 'NVIDIA' taints kernel.
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
Jul  9 13:31:29 stargate kernel: NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6106  Wed Jun 23 08:14:01 PDT 2004
Jul  9 13:31:29 stargate kernel: ReiserFS: hdc2: found reiserfs format "3.6" with standard journal
Jul  9 13:31:29 stargate kernel: ReiserFS: hdc2: using ordered data mode
Jul  9 13:31:29 stargate kernel: ReiserFS: hdc2: journal params: device hdc2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jul  9 13:31:29 stargate kernel: ReiserFS: hdc2: checking transaction log (hdc2)
Jul  9 13:31:29 stargate kernel: ReiserFS: hdc2: Using r5 hash to sort names
Jul  9 13:31:29 stargate kernel: usbcore: registered new driver usbfs
Jul  9 13:31:29 stargate kernel: usbcore: registered new driver hub
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 17 (level, low) -> IRQ 17
Jul  9 13:31:29 stargate kernel: USB Universal Host Controller Interface driver v2.2
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
Jul  9 13:31:29 stargate kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Jul  9 13:31:29 stargate kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Jul  9 13:31:29 stargate kernel: uhci_hcd 0000:00:1d.0: irq 16, io base 0000e000
Jul  9 13:31:29 stargate kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
Jul  9 13:31:29 stargate kernel: hub 1-0:1.0: USB hub found
Jul  9 13:31:29 stargate kernel: hub 1-0:1.0: 2 ports detected
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
Jul  9 13:31:29 stargate kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Jul  9 13:31:29 stargate kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Jul  9 13:31:29 stargate kernel: uhci_hcd 0000:00:1d.1: irq 19, io base 0000e400
Jul  9 13:31:29 stargate kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
Jul  9 13:31:29 stargate kernel: hub 2-0:1.0: USB hub found
Jul  9 13:31:29 stargate kernel: hub 2-0:1.0: 2 ports detected
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
Jul  9 13:31:29 stargate kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Jul  9 13:31:29 stargate kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Jul  9 13:31:29 stargate kernel: uhci_hcd 0000:00:1d.2: irq 18, io base 0000e800
Jul  9 13:31:29 stargate kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
Jul  9 13:31:29 stargate kernel: hub 3-0:1.0: USB hub found
Jul  9 13:31:29 stargate kernel: hub 3-0:1.0: 2 ports detected
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
Jul  9 13:31:29 stargate kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Jul  9 13:31:29 stargate kernel: PCI: Setting latency timer of device 0000:00:1d.3 to 64
Jul  9 13:31:29 stargate kernel: uhci_hcd 0000:00:1d.3: irq 16, io base 0000ec00
Jul  9 13:31:29 stargate kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
Jul  9 13:31:29 stargate kernel: hub 4-0:1.0: USB hub found
Jul  9 13:31:29 stargate kernel: hub 4-0:1.0: 2 ports detected
Jul  9 13:31:29 stargate kernel: usb 1-1: new full speed USB device using address 2
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
Jul  9 13:31:29 stargate kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Jul  9 13:31:29 stargate kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Jul  9 13:31:29 stargate kernel: ehci_hcd 0000:00:1d.7: irq 23, pci mem f8878c00
Jul  9 13:31:29 stargate kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
Jul  9 13:31:29 stargate kernel: PCI: cache line size of 128 is not supported by device 0000:00:1d.7
Jul  9 13:31:29 stargate kernel: ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
Jul  9 13:31:29 stargate kernel: hub 5-0:1.0: USB hub found
Jul  9 13:31:29 stargate kernel: hub 5-0:1.0: 8 ports detected
Jul  9 13:31:29 stargate kernel: Initializing USB Mass Storage driver...
Jul  9 13:31:29 stargate kernel: usb 1-1: string descriptor 0 read error: -71
Jul  9 13:31:29 stargate last message repeated 2 times
Jul  9 13:31:29 stargate kernel: usb-storage: probe of 1-1:1.0 failed with error -1
Jul  9 13:31:29 stargate kernel: usbcore: registered new driver usb-storage
Jul  9 13:31:29 stargate kernel: USB Mass Storage support registered.
Jul  9 13:31:29 stargate kernel: usb 1-1: USB disconnect, address 2
Jul  9 13:31:29 stargate kernel: ohci1394: $Rev: 1226 $ Ben Collins <bcollins@debian.org>
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:02:01.2[B] -> GSI 18 (level, low) -> IRQ 18
Jul  9 13:31:29 stargate kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[18]  MMIO=[feaff000-feaff7ff]  Max Packet=[2048]
Jul  9 13:31:29 stargate kernel: bttv: driver version 0.9.15 loaded
Jul  9 13:31:29 stargate kernel: bttv: using 8 buffers with 2080k (520 pages) each for capture
Jul  9 13:31:29 stargate kernel: bttv: Bt8xx card found (0).
Jul  9 13:31:29 stargate kernel: ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 18 (level, low) -> IRQ 18
Jul  9 13:31:29 stargate kernel: bttv0: Bt878 (rev 17) at 0000:02:02.0, irq: 18, latency: 32, mmio: 0xf7efe000
Jul  9 13:31:29 stargate kernel: bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
Jul  9 13:31:29 stargate kernel: bttv0: using: Pinnacle PCTV Studio/Rave [card=39,autodetected]
Jul  9 13:31:29 stargate kernel: bttv0: gpio: en=00000000, out=00000000 in=00ff67ff [init]
Jul  9 13:31:29 stargate kernel: bttv0: i2c: checking for MSP34xx @ 0x80... not found
Jul  9 13:31:29 stargate kernel: bttv0: miro: id=25 tuner=1 radio=no stereo=no
Jul  9 13:31:29 stargate kernel: bttv0: using tuner=1
Jul  9 13:31:29 stargate kernel: bttv0: i2c: checking for MSP34xx @ 0x80... not found
Jul  9 13:31:29 stargate kernel: bttv0: i2c: checking for TDA9875 @ 0xb0... not found
Jul  9 13:31:29 stargate kernel: bttv0: i2c: checking for TDA7432 @ 0x8a... not found
Jul  9 13:31:29 stargate kernel: bttv0: registered device video0
Jul  9 13:31:29 stargate kernel: bttv0: registered device vbi0
Jul  9 13:31:29 stargate kernel: bttv0: PLL: 28636363 => 35468950 .<6>usb 5-1: new high speed USB device using address 2
Jul  9 13:31:29 stargate kernel: . ok
Jul  9 13:31:29 stargate kernel: scsi0 : SCSI emulation for USB Mass Storage devices
Jul  9 13:31:29 stargate kernel:   Vendor: SAMSUNG   Model: SV1296A           Rev:  0 0
Jul  9 13:31:29 stargate kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jul  9 13:31:29 stargate kernel: SCSI device sda: 25238304 512-byte hdwr sectors (12922 MB)
Jul  9 13:31:29 stargate kernel: sda: assuming drive cache: write through
Jul  9 13:31:29 stargate kernel:  sda: sda1
Jul  9 13:31:29 stargate kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Jul  9 13:31:29 stargate kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Jul  9 13:31:29 stargate kernel: USB Mass Storage device found at 2
Jul  9 13:31:29 stargate kernel: usb 2-1: new low speed USB device using address 2
Jul  9 13:31:29 stargate kernel: usbcore: registered new driver hiddev
Jul  9 13:31:29 stargate kernel: input: USB HID v1.10 Keyboard [Logitech Logitech USB Keyboard] on usb-0000:00:1d.1-1
Jul  9 13:31:29 stargate kernel: input: USB HID v1.10 Mouse [Logitech Logitech USB Keyboard] on usb-0000:00:1d.1-1
Jul  9 13:31:29 stargate kernel: usbcore: registered new driver usbhid
Jul  9 13:31:29 stargate kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Jul  9 13:31:29 stargate kernel: ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c0151028a1f]
Jul  9 13:31:29 stargate kernel: usb 3-2: new low speed USB device using address 2
Jul  9 13:31:29 stargate kernel: input: USB HID v1.10 Mouse [B16_b_02 USB-PS/2 Optical Mouse] on usb-0000:00:1d.2-2
Jul  9 13:31:29 stargate kernel: hdd: CHECK for good STATUS
Jul  9 13:31:33 stargate rpc.statd[8428]: Version 1.0.6 Starting
Jul  9 13:31:33 stargate cron[8470]: (CRON) STARTUP (fork ok) 
Jul  9 13:31:33 stargate init: Activating demand-procedures for 'A'
Jul  9 13:31:37 stargate kernel: drivers/usb/input/hid-input.c: event field not found
Jul  9 13:31:37 stargate kernel: drivers/usb/input/hid-input.c: event field not found
Jul  9 13:38:51 stargate kernel: ReiserFS: hdc1: found reiserfs format "3.6" with standard journal
Jul  9 13:38:51 stargate kernel: ReiserFS: hdc1: using ordered data mode
Jul  9 13:38:51 stargate kernel: ReiserFS: hdc1: journal params: device hdc1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jul  9 13:38:51 stargate kernel: ReiserFS: hdc1: checking transaction log (hdc1)
Jul  9 13:38:51 stargate kernel: ReiserFS: hdc1: Using r5 hash to sort names

--Boundary-00=_gUo7ApZE6IVG1TY--
