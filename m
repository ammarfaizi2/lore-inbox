Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbTIBLeb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 07:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbTIBLeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 07:34:31 -0400
Received: from lns-th2-4f-81-56-212-215.adsl.proxad.net ([81.56.212.215]:37529
	"EHLO maverick.homelinux.com") by vger.kernel.org with ESMTP
	id S261273AbTIBLcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 07:32:04 -0400
Message-ID: <3F547FCC.9010906@eskuel.com>
Date: Tue, 02 Sep 2003 13:32:28 +0200
From: Mathieu LESNIAK <maverick@eskuel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCMCIA + orinoco freeze the laptop
Content-Type: multipart/mixed;
 boundary="------------070609040306010006020205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070609040306010006020205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello everyone,

I've just purchased a netgear MA401 pcmcia (orinoco_cs) card and it 
refuses to work on my laptop running 2.6.0-test4-mm4
The symptoms are :
- where inserting the pcmcia card for the first time, it's recognized as 
  a memory card. Ejecting and reinserting it solves that problem
- Once it's recognized correctly, the laptop hang while doing 'modprobe 
orinoco_cs'

Compiling orinoco_cs as module or buitin change nothing. In addition, 
SysRq keys don't work here.

System is a Compaq Presario 2118EA, AMD XP1800+ Mobile under Debian 
unstable.
Please found lspci -v, dmesg and config in attachments

Thanks,

Mathieu LESNIAK

--------------070609040306010006020205
Content-Type: text/plain;
 name="config-netgear"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-netgear"

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
# CONFIG_BROKEN is not set

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
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
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
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
CONFIG_X86_USE_3DNOW=y
# CONFIG_X86_4G is not set
# CONFIG_X86_SWITCH_PAGETABLES is not set
# CONFIG_X86_4G_VM_LAYOUT is not set
# CONFIG_X86_UACCESS_INDIRECT is not set
# CONFIG_X86_HIGH_ENTRY is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_HPET_TIMER=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
CONFIG_EDD=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI_HT is not set
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_PROC_INTF=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_24_API=y
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ_PROC_INTF=y
# CONFIG_X86_POWERNOW_K6 is not set
CONFIG_X86_POWERNOW_K7=y
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_ICH=y
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_P4_CLOCKMOD=y
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_YENTA=y
CONFIG_CARDBUS=y
CONFIG_I82092=y
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Generic Driver Options
#
CONFIG_FW_LOADER=y

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
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_PC_PCMCIA is not set
CONFIG_PARPORT_OTHER=y
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
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
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_IVB=y
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
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
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
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
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
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
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_FERAL_ISP is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set

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
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_ARPD=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
# CONFIG_IP_NF_QUEUE is not set
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
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
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
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
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
CONFIG_NATSEMI=y
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
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_AIRO=y
CONFIG_HERMES=y
CONFIG_PLX_HERMES=y
CONFIG_TMD_HERMES=y
CONFIG_PCI_HERMES=y

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
CONFIG_PCMCIA_HERMES=y
CONFIG_AIRO_CS=y
CONFIG_PCMCIA_ATMEL=y
CONFIG_PCMCIA_WL3501=y
CONFIG_NET_WIRELESS=y

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

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
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

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
CONFIG_MOUSE_PS2_SYNAPTICS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
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
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_ACPI=y
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Hardware Sensors Mainboard support
#

#
# I2C Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
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
# CONFIG_FTAPE is not set
CONFIG_AGP=m
CONFIG_AGP_ALI=m
CONFIG_AGP_ATI=m
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_MGA is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
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
# CONFIG_EXPORTFS is not set
CONFIG_SUNRPC=m
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp850"
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

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
CONFIG_FB_RADEON=y
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
# CONFIG_SND_RTCTIMER is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
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
CONFIG_SND_ALI5451=m
# CONFIG_SND_AZT3328 is not set
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
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_VXP440 is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_UHCI_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=y
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
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
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
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_AX8817X is not set
# CONFIG_USB_CATC is not set
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

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_SPINLINE is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_KGDB is not set
# CONFIG_FRAME_POINTER is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y

--------------070609040306010006020205
Content-Type: text/plain;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

00:00.0 Host bridge: ATI Technologies Inc: Unknown device cab0 (rev 13)
	Flags: bus master, 66Mhz, medium devsel, latency 32
	Memory at d4000000 (32-bit, prefetchable) [size=64M]
	Memory at d0500000 (32-bit, prefetchable) [size=4K]
	I/O ports at 8090 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: ATI Technologies Inc U1/A3 AGP Bridge [IGP 320M] (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: e0000000-efffffff

00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: bus master, medium devsel, latency 64, IRQ 9
	Memory at d0000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2

00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: bus master, medium devsel, latency 64, IRQ 5
	I/O ports at 8400 [size=256]
	Memory at d0001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA Bridge
	Flags: bus master, medium devsel, latency 0
	Capabilities: [a0] Power Management version 1

00:08.0 Modem: ALi Corporation Intel 537 [M5457 AC-Link Modem] (prog-if 00 [Generic])
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: medium devsel, IRQ 3
	Memory at d0002000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 8800 [size=256]
	Capabilities: [40] Power Management version 2

00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: bus master, stepping, slow devsel, latency 168, IRQ 11
	Memory at 80000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 81000000-81100000 (prefetchable)
	Memory window 1: 10000000-103ff000
	I/O window 0: 00003000-0000307f
	I/O window 1: 00001000-000010ff
	16-bit legacy interface ports at 0001

00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if b0)
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: bus master, medium devsel, latency 32
	I/O ports at 8080 [size=16]
	Capabilities: [60] Power Management version 2

00:11.0 Bridge: ALi Corporation M7101 PMU
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: medium devsel

00:12.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: bus master, medium devsel, latency 90, IRQ 11
	I/O ports at 8c00 [size=256]
	Memory at d0003000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 2

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility U1 (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: bus master, stepping, fast Back2Back, 66Mhz, medium devsel, latency 66, IRQ 10
	Memory at e0000000 (32-bit, prefetchable) [size=256M]
	I/O ports at 9000 [size=256]
	Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2


--------------070609040306010006020205
Content-Type: text/plain;
 name="syslog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syslog"

Sep  2 13:28:34 minimaverick syslogd 1.4.1#11: restart.
Sep  2 13:28:35 minimaverick kernel: klogd 1.4.1#11, log source = /proc/kmsg started.
Sep  2 13:28:35 minimaverick kernel: Inspecting /boot/System.map-2.6.0-test4-mm4
Sep  2 13:28:35 minimaverick kernel: Loaded 26938 symbols from /boot/System.map-2.6.0-test4-mm4.
Sep  2 13:28:35 minimaverick kernel: Symbols match kernel version 2.6.0.
Sep  2 13:28:35 minimaverick kernel: No module symbols loaded - kernel modules not enabled. 
Sep  2 13:28:35 minimaverick kernel: Linux version 2.6.0-test4-mm4 (root@athlon) (version gcc 3.3.2 20030831 (Debian prerelease)) #2 Tue Sep 2 11:57:41 CEST 2003
Sep  2 13:28:35 minimaverick kernel: Video mode to be used for restore is 317
Sep  2 13:28:35 minimaverick kernel: BIOS-provided physical RAM map:
Sep  2 13:28:35 minimaverick kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Sep  2 13:28:35 minimaverick kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Sep  2 13:28:35 minimaverick kernel:  BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
Sep  2 13:28:35 minimaverick kernel:  BIOS-e820: 0000000000100000 - 000000000bef0000 (usable)
Sep  2 13:28:35 minimaverick kernel:  BIOS-e820: 000000000bef0000 - 000000000beff000 (ACPI data)
Sep  2 13:28:35 minimaverick kernel:  BIOS-e820: 000000000beff000 - 000000000bf00000 (ACPI NVS)
Sep  2 13:28:35 minimaverick kernel:  BIOS-e820: 000000000bf00000 - 000000000c000000 (reserved)
Sep  2 13:28:35 minimaverick kernel:  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
Sep  2 13:28:35 minimaverick kernel: 190MB LOWMEM available.
Sep  2 13:28:35 minimaverick kernel: On node 0 totalpages: 48880
Sep  2 13:28:35 minimaverick kernel:   DMA zone: 4096 pages, LIFO batch:1
Sep  2 13:28:35 minimaverick kernel:   Normal zone: 44784 pages, LIFO batch:10
Sep  2 13:28:35 minimaverick kernel:   HighMem zone: 0 pages, LIFO batch:1
Sep  2 13:28:35 minimaverick kernel: DMI 2.3 present.
Sep  2 13:28:35 minimaverick kernel: ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7450
Sep  2 13:28:35 minimaverick kernel: ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0bef8bdc
Sep  2 13:28:35 minimaverick kernel: ACPI: FADT (v001 ATI    Raptor   0x06040000 ATI  0x000f4240) @ 0x0befee4c
Sep  2 13:28:35 minimaverick kernel: ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0befeec0
Sep  2 13:28:35 minimaverick kernel: ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x0befeee8
Sep  2 13:28:35 minimaverick kernel: ACPI: DSDT (v001    ATI U1_M1535 0x06040000 MSFT 0x0100000d) @ 0x00000000
Sep  2 13:28:35 minimaverick kernel: Building zonelist for node : 0
Sep  2 13:28:35 minimaverick kernel: Kernel command line: BOOT_IMAGE=Linux ro root=302 hdc=ide-scsi
Sep  2 13:28:35 minimaverick kernel: ide_setup: hdc=ide-scsi
Sep  2 13:28:35 minimaverick kernel: current: c03fe9c0
Sep  2 13:28:35 minimaverick kernel: current->thread_info: c0480000
Sep  2 13:28:35 minimaverick kernel: Initializing CPU#0
Sep  2 13:28:35 minimaverick kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Sep  2 13:28:35 minimaverick kernel: Detected 1523.890 MHz processor.
Sep  2 13:28:35 minimaverick kernel: Console: colour dummy device 80x25
Sep  2 13:28:35 minimaverick kernel: Memory: 188984k/195520k available (2632k kernel code, 5916k reserved, 944k data, 164k init, 0k highmem)
Sep  2 13:28:35 minimaverick kernel: zapping low mappings.
Sep  2 13:28:35 minimaverick kernel: Calibrating delay loop... 3014.65 BogoMIPS
Sep  2 13:28:35 minimaverick kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Sep  2 13:28:35 minimaverick kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Sep  2 13:28:35 minimaverick kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Sep  2 13:28:35 minimaverick kernel: -> /dev
Sep  2 13:28:35 minimaverick kernel: -> /dev/console
Sep  2 13:28:35 minimaverick kernel: -> /root
Sep  2 13:28:35 minimaverick kernel: CPU:     After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
Sep  2 13:28:35 minimaverick kernel: CPU:     After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
Sep  2 13:28:35 minimaverick kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Sep  2 13:28:35 minimaverick kernel: CPU: L2 Cache: 256K (64 bytes/line)
Sep  2 13:28:35 minimaverick kernel: CPU:     After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020
Sep  2 13:28:35 minimaverick kernel: Intel machine check architecture supported.
Sep  2 13:28:35 minimaverick kernel: Intel machine check reporting enabled on CPU#0.
Sep  2 13:28:35 minimaverick kernel: CPU: AMD mobile AMD Athlon(tm) XP1800+ stepping 00
Sep  2 13:28:35 minimaverick kernel: Enabling fast FPU save and restore... done.
Sep  2 13:28:35 minimaverick kernel: Enabling unmasked SIMD FPU exception support... done.
Sep  2 13:28:35 minimaverick kernel: Checking 'hlt' instruction... OK.
Sep  2 13:28:35 minimaverick kernel: POSIX conformance testing by UNIFIX
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for No Bus:legacy
Sep  2 13:28:35 minimaverick kernel: Initializing RT netlink socket
Sep  2 13:28:35 minimaverick kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd87b, last bus=2
Sep  2 13:28:35 minimaverick kernel: PCI: Using configuration type 1
Sep  2 13:28:35 minimaverick kernel: mtrr: v2.0 (20020519)
Sep  2 13:28:35 minimaverick kernel: ACPI: Subsystem revision 20030813
Sep  2 13:28:35 minimaverick kernel: ACPI: Interpreter enabled
Sep  2 13:28:35 minimaverick kernel: ACPI: Using PIC for interrupt routing
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Sep  2 13:28:35 minimaverick kernel: PCI: Probing PCI hardware (bus 00)
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for No Bus:pci0000:00
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:00.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:01.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:02.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:06.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:07.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:08.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:0a.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:10.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:11.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:12.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:01:05.0
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 *10)
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 7 *11)
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 10, disabled)
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 10, disabled)
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 10, disabled)
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs *11)
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 10, enabled at IRQ 3)
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs *5 7)
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKU] (IRQs 3, enabled at IRQ 9)
Sep  2 13:28:35 minimaverick kernel: ACPI: Embedded Controller [EC0] (gpe 24)
Sep  2 13:28:35 minimaverick kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Sep  2 13:28:35 minimaverick kernel: PnPBIOS: Scanning system for PnP BIOS support...
Sep  2 13:28:35 minimaverick kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00f7480
Sep  2 13:28:35 minimaverick kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa096, dseg 0x400
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for No Bus:pnp0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:00
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:01
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:02
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:03
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:04
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:05
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:06
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:07
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:08
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:09
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:0a
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:0b
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:0c
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:0d
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:0e
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:10
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:11
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:13
Sep  2 13:28:35 minimaverick kernel: PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
Sep  2 13:28:35 minimaverick kernel: SCSI subsystem initialized
Sep  2 13:28:35 minimaverick kernel: Linux Kernel Card Services 3.1.22
Sep  2 13:28:35 minimaverick kernel:   options:  [pci] [cardbus] [pm]
Sep  2 13:28:35 minimaverick kernel: drivers/usb/core/usb.c: registered new driver usbfs
Sep  2 13:28:35 minimaverick kernel: drivers/usb/core/usb.c: registered new driver hub
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 9
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 3
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
Sep  2 13:28:35 minimaverick kernel: ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
Sep  2 13:28:35 minimaverick kernel: PCI: Using ACPI for IRQ routing
Sep  2 13:28:35 minimaverick kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Sep  2 13:28:35 minimaverick kernel: vesafb: framebuffer at 0xe0000000, mapped to 0xcc80e000, size 16384k
Sep  2 13:28:35 minimaverick kernel: vesafb: mode is 1024x768x16, linelength=2048, pages=41
Sep  2 13:28:35 minimaverick kernel: vesafb: protected mode interface info at c000:51a9
Sep  2 13:28:35 minimaverick kernel: vesafb: scrolling: redraw
Sep  2 13:28:35 minimaverick kernel: vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Sep  2 13:28:35 minimaverick kernel: fb0: VESA VGA frame buffer device
Sep  2 13:28:35 minimaverick kernel: Console: switching to colour frame buffer device 128x48
Sep  2 13:28:35 minimaverick kernel: pty: 256 Unix98 ptys configured
Sep  2 13:28:35 minimaverick kernel: SBF: Simple Boot Flag extension found and enabled.
Sep  2 13:28:35 minimaverick kernel: SBF: Setting boot flags 0x1
Sep  2 13:28:35 minimaverick kernel: Machine check exception polling timer started.
Sep  2 13:28:35 minimaverick kernel: powernow: AMD K7 CPU detected.
Sep  2 13:28:35 minimaverick kernel: powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
Sep  2 13:28:35 minimaverick kernel: powernow: Found PSB header at c00f17f0
Sep  2 13:28:35 minimaverick kernel: powernow: Table version: 0x12
Sep  2 13:28:35 minimaverick kernel: powernow: Flags: 0x0 (Mobile voltage regulator)
Sep  2 13:28:35 minimaverick kernel: powernow: Settling Time: 100 microseconds.
Sep  2 13:28:35 minimaverick kernel: powernow: Has 14 PST tables. (Only dumping ones relevant to this CPU).
Sep  2 13:28:35 minimaverick kernel: powernow: PST:4 (@c00f1848)
Sep  2 13:28:35 minimaverick kernel: powernow:  cpuid: 0x780^Ifsb: 133^ImaxFID: 0x1^Istartvid: 0x9
Sep  2 13:28:35 minimaverick kernel: powernow:    FID: 0x12 (4.0x [532MHz])^IVID: 0x13 (1.200V)
Sep  2 13:28:35 minimaverick kernel: powernow:    FID: 0x4 (5.0x [665MHz])^IVID: 0x13 (1.200V)
Sep  2 13:28:35 minimaverick kernel: powernow:    FID: 0x6 (6.0x [798MHz])^IVID: 0x13 (1.200V)
Sep  2 13:28:35 minimaverick kernel: powernow:    FID: 0xc (9.0x [1197MHz])^IVID: 0xd (1.350V)
Sep  2 13:28:35 minimaverick kernel: powernow:    FID: 0x1 (11.5x [1529MHz])^IVID: 0x9 (1.550V)
Sep  2 13:28:35 minimaverick kernel: 
Sep  2 13:28:35 minimaverick kernel: powernow: Minimum speed 532 MHz. Maximum speed 1529 MHz.
Sep  2 13:28:35 minimaverick kernel: ikconfig 0.5 with /proc/ikconfig
Sep  2 13:28:35 minimaverick kernel: Initializing Cryptographic API
Sep  2 13:28:35 minimaverick kernel: ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb.
Sep  2 13:28:35 minimaverick kernel: ACPI: AC Adapter [ACAD] (on-line)
Sep  2 13:28:35 minimaverick kernel: ACPI: Battery Slot [BAT1] (battery absent)
Sep  2 13:28:35 minimaverick kernel: ACPI: Power Button (FF) [PWRF]
Sep  2 13:28:35 minimaverick kernel: ACPI: Lid Switch [LID]
Sep  2 13:28:35 minimaverick kernel: ACPI: Processor [CPU0] (supports C1 C2)
Sep  2 13:28:35 minimaverick kernel: ACPI: Thermal Zone [THRM] (50 C)
Sep  2 13:28:35 minimaverick kernel: Real Time Clock Driver v1.12
Sep  2 13:28:35 minimaverick kernel: [drm] Initialized radeon 1.9.0 20020828 on minor 0
Sep  2 13:28:35 minimaverick kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
Sep  2 13:28:35 minimaverick kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Sep  2 13:28:35 minimaverick kernel: ttyS1 at I/O 0x8828 (irq = 3) is a 8250
Sep  2 13:28:35 minimaverick kernel: ttyS2 at I/O 0x8840 (irq = 3) is a 8250
Sep  2 13:28:35 minimaverick kernel: ttyS3 at I/O 0x8850 (irq = 3) is a 8250
Sep  2 13:28:35 minimaverick kernel: Using anticipatory scheduling elevator
Sep  2 13:28:35 minimaverick kernel: Floppy drive(s): fd0 is 1.44M
Sep  2 13:28:35 minimaverick kernel: FDC 0 is a post-1991 82077
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for platform:floppy0
Sep  2 13:28:35 minimaverick kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Sep  2 13:28:35 minimaverick kernel: loop: loaded (max 8 devices)
Sep  2 13:28:35 minimaverick kernel: nbd: registered device at major 43
Sep  2 13:28:35 minimaverick kernel: natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
Sep  2 13:28:35 minimaverick kernel:   originally by Donald Becker <becker@scyld.com>
Sep  2 13:28:35 minimaverick kernel:   http://www.scyld.com/network/natsemi.html
Sep  2 13:28:35 minimaverick kernel:   2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
Sep  2 13:28:35 minimaverick kernel: eth0: NatSemi DP8381[56] at 0xcd811000, 00:0b:cd:18:97:c2, IRQ 11.
Sep  2 13:28:35 minimaverick kernel: orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
Sep  2 13:28:35 minimaverick kernel: orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
Sep  2 13:28:35 minimaverick kernel: orinoco_plx.c 0.13e (Daniel Barlow <dan@telent.net>, David Gibson <hermes@gibson.dropbear.id.au>)
Sep  2 13:28:35 minimaverick kernel: orinoco_pci.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> & Jean Tourrilhes <jt@hpl.hp.com>)
Sep  2 13:28:35 minimaverick kernel: orinoco_tmd.c 0.01 (Joerg Dorchain <joerg@dorchain.net>)
Sep  2 13:28:35 minimaverick kernel: airo:  Probing for PCI adapters
Sep  2 13:28:35 minimaverick kernel: airo:  Finished probing for PCI adapters
Sep  2 13:28:35 minimaverick kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Sep  2 13:28:35 minimaverick kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep  2 13:28:35 minimaverick kernel: Warning: ATI Radeon IGP Northbridge is not yet fully tested.
Sep  2 13:28:35 minimaverick kernel: ALI15X3: IDE controller at PCI slot 0000:00:10.0
Sep  2 13:28:35 minimaverick kernel: ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
Sep  2 13:28:35 minimaverick kernel: ALI15X3: chipset revision 196
Sep  2 13:28:35 minimaverick kernel: ALI15X3: not 100%% native mode: will probe irqs later
Sep  2 13:28:35 minimaverick kernel:     ide0: BM-DMA at 0x8080-0x8087, BIOS settings: hda:DMA, hdb:pio
Sep  2 13:28:35 minimaverick kernel:     ide1: BM-DMA at 0x8088-0x808f, BIOS settings: hdc:pio, hdd:pio
Sep  2 13:28:35 minimaverick kernel: hda: TOSHIBA MK3018GAP, ATA DISK drive
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for No Bus:ide0
Sep  2 13:28:35 minimaverick kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for ide:0.0
Sep  2 13:28:35 minimaverick kernel: hdc: TOSHIBA DVD-ROM SD-R2312, ATAPI CD/DVD-ROM drive
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for No Bus:ide1
Sep  2 13:28:35 minimaverick kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for ide:1.0
Sep  2 13:28:35 minimaverick kernel: hda: max request size: 128KiB
Sep  2 13:28:35 minimaverick kernel: hda: 58605120 sectors (30005 MB), CHS=58140/16/63, UDMA(100)
Sep  2 13:28:35 minimaverick kernel:  hda: hda1 hda2 hda3 < hda5 >
Sep  2 13:28:35 minimaverick kernel: Console: switching to colour frame buffer device 128x48
Sep  2 13:28:35 minimaverick kernel: Yenta: CardBus bridge found at 0000:00:0a.0 [103c:0024]
Sep  2 13:28:35 minimaverick kernel: Yenta: ISA IRQ list 04b8, PCI irq11
Sep  2 13:28:35 minimaverick kernel: Socket status: 30000007
Sep  2 13:28:35 minimaverick kernel: Initializing USB Mass Storage driver...
Sep  2 13:28:35 minimaverick kernel: drivers/usb/core/usb.c: registered new driver usb-storage
Sep  2 13:28:35 minimaverick kernel: USB Mass Storage support registered.
Sep  2 13:28:35 minimaverick kernel: drivers/usb/core/usb.c: registered new driver hiddev
Sep  2 13:28:35 minimaverick kernel: drivers/usb/core/usb.c: registered new driver hid
Sep  2 13:28:35 minimaverick kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Sep  2 13:28:35 minimaverick kernel: mice: PS/2 mouse device common for all mice
Sep  2 13:28:35 minimaverick kernel: Synaptics Touchpad, model: 1
Sep  2 13:28:35 minimaverick kernel:  Firmware: 5.8
Sep  2 13:28:35 minimaverick kernel:  Sensor: 35
Sep  2 13:28:35 minimaverick kernel:  new absolute packet format
Sep  2 13:28:35 minimaverick kernel:  Touchpad has extended capability bits
Sep  2 13:28:35 minimaverick kernel:  -> multifinger detection
Sep  2 13:28:35 minimaverick kernel:  -> palm detection
Sep  2 13:28:35 minimaverick kernel: input: Synaptics Synaptics TouchPad on isa0060/serio1
Sep  2 13:28:35 minimaverick kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep  2 13:28:35 minimaverick kernel: input: AT Set 2 keyboard on isa0060/serio0
Sep  2 13:28:35 minimaverick kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Sep  2 13:28:35 minimaverick kernel: Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed Aug 20 20:27:13 2003 UTC).
Sep  2 13:28:35 minimaverick kernel: ALSA device list:
Sep  2 13:28:35 minimaverick kernel:   No soundcards found.
Sep  2 13:28:35 minimaverick kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Sep  2 13:28:35 minimaverick kernel: IP: routing cache hash table of 1024 buckets, 8Kbytes
Sep  2 13:28:35 minimaverick kernel: TCP: Hash tables configured (established 16384 bind 32768)
Sep  2 13:28:35 minimaverick kernel: Linux IP multicast router 0.06 plus PIM-SM
Sep  2 13:28:35 minimaverick kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Sep  2 13:28:35 minimaverick kernel: cpufreq: No CPUs supporting ACPI performance management found.
Sep  2 13:28:35 minimaverick kernel: BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
Sep  2 13:28:35 minimaverick kernel: PM: Reading swsusp image.
Sep  2 13:28:35 minimaverick kernel: PM: Resume from disk failed.
Sep  2 13:28:35 minimaverick kernel: ACPI: (supports S0 S3 S4 S5)
Sep  2 13:28:35 minimaverick kernel: found reiserfs format "3.6" with standard journal
Sep  2 13:28:35 minimaverick kernel: Reiserfs journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Sep  2 13:28:35 minimaverick kernel: reiserfs: checking transaction log (hda2) for (hda2)
Sep  2 13:28:35 minimaverick kernel: reiserfs: replayed 5 transactions in 0 seconds
Sep  2 13:28:35 minimaverick kernel: Using r5 hash to sort names
Sep  2 13:28:35 minimaverick kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Sep  2 13:28:35 minimaverick kernel: Freeing unused kernel memory: 164k freed
Sep  2 13:28:35 minimaverick kernel: Unable to find swap-space signature
Sep  2 13:28:35 minimaverick kernel: Removing [938 14986 0x0 SD]..done
Sep  2 13:28:35 minimaverick kernel: Removing [939 1721 0x0 SD]..done
Sep  2 13:28:35 minimaverick kernel: There were 2 uncompleted unlinks/truncates. Completed
Sep  2 13:28:35 minimaverick kernel: Linux agpgart interface v0.100 (c) Dave Jones
Sep  2 13:28:35 minimaverick kernel: agpgart: Detected Ati IGP320/M chipset
Sep  2 13:28:35 minimaverick kernel: agpgart: Maximum main memory to use for agp memory: 148M
Sep  2 13:28:35 minimaverick kernel: agpgart: AGP aperture is 64M @ 0xd4000000
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for No Bus:ide-scsi
Sep  2 13:28:35 minimaverick kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for No Bus:host0
Sep  2 13:28:35 minimaverick kernel:   Vendor: TOSHIBA   Model: DVD-ROM SD-R2312  Rev: 1905
Sep  2 13:28:35 minimaverick kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for scsi:0:0:0:0
Sep  2 13:28:35 minimaverick kernel: Unable to find swap-space signature
Sep  2 13:28:36 minimaverick modprobe: FATAL: Module snd_card_1 not found. 
Sep  2 13:28:36 minimaverick modprobe: FATAL: Module snd_card_1 not found. 
Sep  2 13:28:36 minimaverick modprobe: FATAL: Module snd_card_2 not found. 
Sep  2 13:28:36 minimaverick modprobe: FATAL: Module snd_card_2 not found. 
Sep  2 13:28:36 minimaverick modprobe: FATAL: Module snd_card_3 not found. 
Sep  2 13:28:36 minimaverick modprobe: FATAL: Module snd_card_3 not found. 
Sep  2 13:28:36 minimaverick kernel: eth0: link up.
Sep  2 13:28:36 minimaverick kernel: eth0: Setting full-duplex based on negotiated link capability.
Sep  2 13:28:36 minimaverick ifplugd(eth0)[265]: Using interface eth0/00:0B:CD:18:97:C2 with driver <natsemi> (version: 1.07+LK1.0.17)
Sep  2 13:28:36 minimaverick ifplugd(eth0)[265]: Using detection mode: SIOCETHTOOL
Sep  2 13:28:36 minimaverick ifplugd(eth0)[265]: ifplugd 0.15 successfully initialized, link beat detected.
Sep  2 13:28:36 minimaverick ifplugd(eth0)[265]: Executing '/etc/ifplugd/ifplugd.action eth0 up'.
Sep  2 13:28:36 minimaverick dhclient: Internet Software Consortium DHCP Client 2.0pl5
Sep  2 13:28:36 minimaverick ifplugd(eth0)[265]: client: Internet Software Consortium DHCP Client 2.0pl5
Sep  2 13:28:36 minimaverick dhclient: Copyright 1995, 1996, 1997, 1998, 1999 The Internet Software Consortium.
Sep  2 13:28:36 minimaverick ifplugd(eth0)[265]: client: Copyright 1995, 1996, 1997, 1998, 1999 The Internet Software Consortium.
Sep  2 13:28:36 minimaverick dhclient: All rights reserved.
Sep  2 13:28:36 minimaverick ifplugd(eth0)[265]: client: All rights reserved.
Sep  2 13:28:36 minimaverick dhclient: 
Sep  2 13:28:36 minimaverick dhclient: Please contribute if you find this software useful.
Sep  2 13:28:36 minimaverick ifplugd(eth0)[265]: client: Please contribute if you find this software useful.
Sep  2 13:28:36 minimaverick dhclient: For info, please visit http://www.isc.org/dhcp-contrib.html
Sep  2 13:28:36 minimaverick ifplugd(eth0)[265]: client: For info, please visit http://www.isc.org/dhcp-contrib.html
Sep  2 13:28:36 minimaverick dhclient: 
Sep  2 13:28:37 minimaverick dhclient: Listening on LPF/eth0/00:0b:cd:18:97:c2
Sep  2 13:28:37 minimaverick dhclient: Sending on   LPF/eth0/00:0b:cd:18:97:c2
Sep  2 13:28:37 minimaverick dhclient: Sending on   Socket/fallback/fallback-net
Sep  2 13:28:37 minimaverick dhclient: DHCPREQUEST on eth0 to 255.255.255.255 port 67
Sep  2 13:28:37 minimaverick ifplugd(eth0)[265]: client: Listening on LPF/eth0/00:0b:cd:18:97:c2
Sep  2 13:28:37 minimaverick ifplugd(eth0)[265]: client: Sending on   LPF/eth0/00:0b:cd:18:97:c2
Sep  2 13:28:37 minimaverick ifplugd(eth0)[265]: client: Sending on   Socket/fallback/fallback-net
Sep  2 13:28:37 minimaverick ifplugd(eth0)[265]: client: DHCPREQUEST on eth0 to 255.255.255.255 port 67
Sep  2 13:28:37 minimaverick dhclient: DHCPACK from 192.168.100.1
Sep  2 13:28:37 minimaverick ifplugd(eth0)[265]: client: DHCPACK from 192.168.100.1
Sep  2 13:28:37 minimaverick dhclient: bound to 192.168.100.5 -- renewal in 900 seconds.
Sep  2 13:28:37 minimaverick ifplugd(eth0)[265]: client: bound to 192.168.100.5 -- renewal in 900 seconds.
Sep  2 13:28:38 minimaverick modprobe: FATAL: Module ipv6 not found. 
Sep  2 13:28:38 minimaverick ifplugd(eth0)[265]: client: Starting OpenBSD Secure Shell server: sshd.
Sep  2 13:28:38 minimaverick ifplugd(eth0)[265]: Program executed successfully.
Sep  2 13:28:38 minimaverick cardmgr[316]: watching 1 sockets
Sep  2 13:28:38 minimaverick kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Sep  2 13:28:38 minimaverick kernel: cs: IO port probe 0x0800-0x08ff: clean.
Sep  2 13:28:38 minimaverick kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x220-0x22f 0x330-0x337 0x378-0x37f 0x388-0x38f 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
Sep  2 13:28:38 minimaverick kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Sep  2 13:28:38 minimaverick cardmgr[317]: starting, version is 3.2.2
Sep  2 13:28:38 minimaverick modprobe: FATAL: Module ipv6 not found. 
Sep  2 13:28:39 minimaverick /usr/sbin/cron[336]: (CRON) INFO (pidfile fd = 3)
Sep  2 13:28:39 minimaverick /usr/sbin/cron[337]: (CRON) STARTUP (fork ok)
Sep  2 13:28:39 minimaverick /usr/sbin/cron[337]: (CRON) INFO (Running @reboot jobs)


--------------070609040306010006020205--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
This is a multi-part message in MIME format.
--------------070609040306010006020205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello everyone,

I've just purchased a netgear MA401 pcmcia (orinoco_cs) card and it 
refuses to work on my laptop running 2.6.0-test4-mm4
The symptoms are :
- where inserting the pcmcia card for the first time, it's recognized as 
  a memory card. Ejecting and reinserting it solves that problem
- Once it's recognized correctly, the laptop hang while doing 'modprobe 
orinoco_cs'

Compiling orinoco_cs as module or buitin change nothing. In addition, 
SysRq keys don't work here.

System is a Compaq Presario 2118EA, AMD XP1800+ Mobile under Debian 
unstable.
Please found lspci -v, dmesg and config in attachments

Thanks,

Mathieu LESNIAK

--------------070609040306010006020205
Content-Type: text/plain;
 name="config-netgear"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-netgear"

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
# CONFIG_BROKEN is not set

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
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
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
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
CONFIG_X86_USE_3DNOW=y
# CONFIG_X86_4G is not set
# CONFIG_X86_SWITCH_PAGETABLES is not set
# CONFIG_X86_4G_VM_LAYOUT is not set
# CONFIG_X86_UACCESS_INDIRECT is not set
# CONFIG_X86_HIGH_ENTRY is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_HPET_TIMER=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
CONFIG_EDD=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI_HT is not set
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_PROC_INTF=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_24_API=y
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ_PROC_INTF=y
# CONFIG_X86_POWERNOW_K6 is not set
CONFIG_X86_POWERNOW_K7=y
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_ICH=y
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_P4_CLOCKMOD=y
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_YENTA=y
CONFIG_CARDBUS=y
CONFIG_I82092=y
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Generic Driver Options
#
CONFIG_FW_LOADER=y

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
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_PC_PCMCIA is not set
CONFIG_PARPORT_OTHER=y
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
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
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_IVB=y
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
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
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
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
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
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
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_FERAL_ISP is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set

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
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_ARPD=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
# CONFIG_IP_NF_QUEUE is not set
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
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
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
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
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
CONFIG_NATSEMI=y
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
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_AIRO=y
CONFIG_HERMES=y
CONFIG_PLX_HERMES=y
CONFIG_TMD_HERMES=y
CONFIG_PCI_HERMES=y

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
CONFIG_PCMCIA_HERMES=y
CONFIG_AIRO_CS=y
CONFIG_PCMCIA_ATMEL=y
CONFIG_PCMCIA_WL3501=y
CONFIG_NET_WIRELESS=y

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

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
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

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
CONFIG_MOUSE_PS2_SYNAPTICS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
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
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_ACPI=y
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Hardware Sensors Mainboard support
#

#
# I2C Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
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
# CONFIG_FTAPE is not set
CONFIG_AGP=m
CONFIG_AGP_ALI=m
CONFIG_AGP_ATI=m
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_MGA is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
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
# CONFIG_EXPORTFS is not set
CONFIG_SUNRPC=m
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp850"
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

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
CONFIG_FB_RADEON=y
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
# CONFIG_SND_RTCTIMER is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
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
CONFIG_SND_ALI5451=m
# CONFIG_SND_AZT3328 is not set
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
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_VXP440 is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_UHCI_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=y
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
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
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
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_AX8817X is not set
# CONFIG_USB_CATC is not set
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

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_SPINLINE is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_KGDB is not set
# CONFIG_FRAME_POINTER is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y

--------------070609040306010006020205
Content-Type: text/plain;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

00:00.0 Host bridge: ATI Technologies Inc: Unknown device cab0 (rev 13)
	Flags: bus master, 66Mhz, medium devsel, latency 32
	Memory at d4000000 (32-bit, prefetchable) [size=64M]
	Memory at d0500000 (32-bit, prefetchable) [size=4K]
	I/O ports at 8090 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: ATI Technologies Inc U1/A3 AGP Bridge [IGP 320M] (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: e0000000-efffffff

00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: bus master, medium devsel, latency 64, IRQ 9
	Memory at d0000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2

00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: bus master, medium devsel, latency 64, IRQ 5
	I/O ports at 8400 [size=256]
	Memory at d0001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA Bridge
	Flags: bus master, medium devsel, latency 0
	Capabilities: [a0] Power Management version 1

00:08.0 Modem: ALi Corporation Intel 537 [M5457 AC-Link Modem] (prog-if 00 [Generic])
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: medium devsel, IRQ 3
	Memory at d0002000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 8800 [size=256]
	Capabilities: [40] Power Management version 2

00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: bus master, stepping, slow devsel, latency 168, IRQ 11
	Memory at 80000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 81000000-81100000 (prefetchable)
	Memory window 1: 10000000-103ff000
	I/O window 0: 00003000-0000307f
	I/O window 1: 00001000-000010ff
	16-bit legacy interface ports at 0001

00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if b0)
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: bus master, medium devsel, latency 32
	I/O ports at 8080 [size=16]
	Capabilities: [60] Power Management version 2

00:11.0 Bridge: ALi Corporation M7101 PMU
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: medium devsel

00:12.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: bus master, medium devsel, latency 90, IRQ 11
	I/O ports at 8c00 [size=256]
	Memory at d0003000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 2

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility U1 (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: bus master, stepping, fast Back2Back, 66Mhz, medium devsel, latency 66, IRQ 10
	Memory at e0000000 (32-bit, prefetchable) [size=256M]
	I/O ports at 9000 [size=256]
	Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2


--------------070609040306010006020205
Content-Type: text/plain;
 name="syslog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syslog"

Sep  2 13:28:34 minimaverick syslogd 1.4.1#11: restart.
Sep  2 13:28:35 minimaverick kernel: klogd 1.4.1#11, log source = /proc/kmsg started.
Sep  2 13:28:35 minimaverick kernel: Inspecting /boot/System.map-2.6.0-test4-mm4
Sep  2 13:28:35 minimaverick kernel: Loaded 26938 symbols from /boot/System.map-2.6.0-test4-mm4.
Sep  2 13:28:35 minimaverick kernel: Symbols match kernel version 2.6.0.
Sep  2 13:28:35 minimaverick kernel: No module symbols loaded - kernel modules not enabled. 
Sep  2 13:28:35 minimaverick kernel: Linux version 2.6.0-test4-mm4 (root@athlon) (version gcc 3.3.2 20030831 (Debian prerelease)) #2 Tue Sep 2 11:57:41 CEST 2003
Sep  2 13:28:35 minimaverick kernel: Video mode to be used for restore is 317
Sep  2 13:28:35 minimaverick kernel: BIOS-provided physical RAM map:
Sep  2 13:28:35 minimaverick kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Sep  2 13:28:35 minimaverick kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Sep  2 13:28:35 minimaverick kernel:  BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
Sep  2 13:28:35 minimaverick kernel:  BIOS-e820: 0000000000100000 - 000000000bef0000 (usable)
Sep  2 13:28:35 minimaverick kernel:  BIOS-e820: 000000000bef0000 - 000000000beff000 (ACPI data)
Sep  2 13:28:35 minimaverick kernel:  BIOS-e820: 000000000beff000 - 000000000bf00000 (ACPI NVS)
Sep  2 13:28:35 minimaverick kernel:  BIOS-e820: 000000000bf00000 - 000000000c000000 (reserved)
Sep  2 13:28:35 minimaverick kernel:  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
Sep  2 13:28:35 minimaverick kernel: 190MB LOWMEM available.
Sep  2 13:28:35 minimaverick kernel: On node 0 totalpages: 48880
Sep  2 13:28:35 minimaverick kernel:   DMA zone: 4096 pages, LIFO batch:1
Sep  2 13:28:35 minimaverick kernel:   Normal zone: 44784 pages, LIFO batch:10
Sep  2 13:28:35 minimaverick kernel:   HighMem zone: 0 pages, LIFO batch:1
Sep  2 13:28:35 minimaverick kernel: DMI 2.3 present.
Sep  2 13:28:35 minimaverick kernel: ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7450
Sep  2 13:28:35 minimaverick kernel: ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0bef8bdc
Sep  2 13:28:35 minimaverick kernel: ACPI: FADT (v001 ATI    Raptor   0x06040000 ATI  0x000f4240) @ 0x0befee4c
Sep  2 13:28:35 minimaverick kernel: ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0befeec0
Sep  2 13:28:35 minimaverick kernel: ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x0befeee8
Sep  2 13:28:35 minimaverick kernel: ACPI: DSDT (v001    ATI U1_M1535 0x06040000 MSFT 0x0100000d) @ 0x00000000
Sep  2 13:28:35 minimaverick kernel: Building zonelist for node : 0
Sep  2 13:28:35 minimaverick kernel: Kernel command line: BOOT_IMAGE=Linux ro root=302 hdc=ide-scsi
Sep  2 13:28:35 minimaverick kernel: ide_setup: hdc=ide-scsi
Sep  2 13:28:35 minimaverick kernel: current: c03fe9c0
Sep  2 13:28:35 minimaverick kernel: current->thread_info: c0480000
Sep  2 13:28:35 minimaverick kernel: Initializing CPU#0
Sep  2 13:28:35 minimaverick kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Sep  2 13:28:35 minimaverick kernel: Detected 1523.890 MHz processor.
Sep  2 13:28:35 minimaverick kernel: Console: colour dummy device 80x25
Sep  2 13:28:35 minimaverick kernel: Memory: 188984k/195520k available (2632k kernel code, 5916k reserved, 944k data, 164k init, 0k highmem)
Sep  2 13:28:35 minimaverick kernel: zapping low mappings.
Sep  2 13:28:35 minimaverick kernel: Calibrating delay loop... 3014.65 BogoMIPS
Sep  2 13:28:35 minimaverick kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Sep  2 13:28:35 minimaverick kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Sep  2 13:28:35 minimaverick kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Sep  2 13:28:35 minimaverick kernel: -> /dev
Sep  2 13:28:35 minimaverick kernel: -> /dev/console
Sep  2 13:28:35 minimaverick kernel: -> /root
Sep  2 13:28:35 minimaverick kernel: CPU:     After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
Sep  2 13:28:35 minimaverick kernel: CPU:     After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
Sep  2 13:28:35 minimaverick kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Sep  2 13:28:35 minimaverick kernel: CPU: L2 Cache: 256K (64 bytes/line)
Sep  2 13:28:35 minimaverick kernel: CPU:     After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020
Sep  2 13:28:35 minimaverick kernel: Intel machine check architecture supported.
Sep  2 13:28:35 minimaverick kernel: Intel machine check reporting enabled on CPU#0.
Sep  2 13:28:35 minimaverick kernel: CPU: AMD mobile AMD Athlon(tm) XP1800+ stepping 00
Sep  2 13:28:35 minimaverick kernel: Enabling fast FPU save and restore... done.
Sep  2 13:28:35 minimaverick kernel: Enabling unmasked SIMD FPU exception support... done.
Sep  2 13:28:35 minimaverick kernel: Checking 'hlt' instruction... OK.
Sep  2 13:28:35 minimaverick kernel: POSIX conformance testing by UNIFIX
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for No Bus:legacy
Sep  2 13:28:35 minimaverick kernel: Initializing RT netlink socket
Sep  2 13:28:35 minimaverick kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd87b, last bus=2
Sep  2 13:28:35 minimaverick kernel: PCI: Using configuration type 1
Sep  2 13:28:35 minimaverick kernel: mtrr: v2.0 (20020519)
Sep  2 13:28:35 minimaverick kernel: ACPI: Subsystem revision 20030813
Sep  2 13:28:35 minimaverick kernel: ACPI: Interpreter enabled
Sep  2 13:28:35 minimaverick kernel: ACPI: Using PIC for interrupt routing
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Sep  2 13:28:35 minimaverick kernel: PCI: Probing PCI hardware (bus 00)
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for No Bus:pci0000:00
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:00.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:01.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:02.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:06.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:07.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:08.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:0a.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:10.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:11.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:00:12.0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pci:0000:01:05.0
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 *10)
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 7 *11)
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 10, disabled)
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 10, disabled)
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 10, disabled)
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs *11)
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 10, enabled at IRQ 3)
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs *5 7)
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKU] (IRQs 3, enabled at IRQ 9)
Sep  2 13:28:35 minimaverick kernel: ACPI: Embedded Controller [EC0] (gpe 24)
Sep  2 13:28:35 minimaverick kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Sep  2 13:28:35 minimaverick kernel: PnPBIOS: Scanning system for PnP BIOS support...
Sep  2 13:28:35 minimaverick kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00f7480
Sep  2 13:28:35 minimaverick kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa096, dseg 0x400
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for No Bus:pnp0
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:00
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:01
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:02
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:03
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:04
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:05
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:06
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:07
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:08
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:09
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:0a
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:0b
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:0c
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:0d
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:0e
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:10
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:11
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for pnp:00:13
Sep  2 13:28:35 minimaverick kernel: PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
Sep  2 13:28:35 minimaverick kernel: SCSI subsystem initialized
Sep  2 13:28:35 minimaverick kernel: Linux Kernel Card Services 3.1.22
Sep  2 13:28:35 minimaverick kernel:   options:  [pci] [cardbus] [pm]
Sep  2 13:28:35 minimaverick kernel: drivers/usb/core/usb.c: registered new driver usbfs
Sep  2 13:28:35 minimaverick kernel: drivers/usb/core/usb.c: registered new driver hub
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 9
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 3
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
Sep  2 13:28:35 minimaverick kernel: ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
Sep  2 13:28:35 minimaverick kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
Sep  2 13:28:35 minimaverick kernel: PCI: Using ACPI for IRQ routing
Sep  2 13:28:35 minimaverick kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Sep  2 13:28:35 minimaverick kernel: vesafb: framebuffer at 0xe0000000, mapped to 0xcc80e000, size 16384k
Sep  2 13:28:35 minimaverick kernel: vesafb: mode is 1024x768x16, linelength=2048, pages=41
Sep  2 13:28:35 minimaverick kernel: vesafb: protected mode interface info at c000:51a9
Sep  2 13:28:35 minimaverick kernel: vesafb: scrolling: redraw
Sep  2 13:28:35 minimaverick kernel: vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Sep  2 13:28:35 minimaverick kernel: fb0: VESA VGA frame buffer device
Sep  2 13:28:35 minimaverick kernel: Console: switching to colour frame buffer device 128x48
Sep  2 13:28:35 minimaverick kernel: pty: 256 Unix98 ptys configured
Sep  2 13:28:35 minimaverick kernel: SBF: Simple Boot Flag extension found and enabled.
Sep  2 13:28:35 minimaverick kernel: SBF: Setting boot flags 0x1
Sep  2 13:28:35 minimaverick kernel: Machine check exception polling timer started.
Sep  2 13:28:35 minimaverick kernel: powernow: AMD K7 CPU detected.
Sep  2 13:28:35 minimaverick kernel: powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
Sep  2 13:28:35 minimaverick kernel: powernow: Found PSB header at c00f17f0
Sep  2 13:28:35 minimaverick kernel: powernow: Table version: 0x12
Sep  2 13:28:35 minimaverick kernel: powernow: Flags: 0x0 (Mobile voltage regulator)
Sep  2 13:28:35 minimaverick kernel: powernow: Settling Time: 100 microseconds.
Sep  2 13:28:35 minimaverick kernel: powernow: Has 14 PST tables. (Only dumping ones relevant to this CPU).
Sep  2 13:28:35 minimaverick kernel: powernow: PST:4 (@c00f1848)
Sep  2 13:28:35 minimaverick kernel: powernow:  cpuid: 0x780^Ifsb: 133^ImaxFID: 0x1^Istartvid: 0x9
Sep  2 13:28:35 minimaverick kernel: powernow:    FID: 0x12 (4.0x [532MHz])^IVID: 0x13 (1.200V)
Sep  2 13:28:35 minimaverick kernel: powernow:    FID: 0x4 (5.0x [665MHz])^IVID: 0x13 (1.200V)
Sep  2 13:28:35 minimaverick kernel: powernow:    FID: 0x6 (6.0x [798MHz])^IVID: 0x13 (1.200V)
Sep  2 13:28:35 minimaverick kernel: powernow:    FID: 0xc (9.0x [1197MHz])^IVID: 0xd (1.350V)
Sep  2 13:28:35 minimaverick kernel: powernow:    FID: 0x1 (11.5x [1529MHz])^IVID: 0x9 (1.550V)
Sep  2 13:28:35 minimaverick kernel: 
Sep  2 13:28:35 minimaverick kernel: powernow: Minimum speed 532 MHz. Maximum speed 1529 MHz.
Sep  2 13:28:35 minimaverick kernel: ikconfig 0.5 with /proc/ikconfig
Sep  2 13:28:35 minimaverick kernel: Initializing Cryptographic API
Sep  2 13:28:35 minimaverick kernel: ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb.
Sep  2 13:28:35 minimaverick kernel: ACPI: AC Adapter [ACAD] (on-line)
Sep  2 13:28:35 minimaverick kernel: ACPI: Battery Slot [BAT1] (battery absent)
Sep  2 13:28:35 minimaverick kernel: ACPI: Power Button (FF) [PWRF]
Sep  2 13:28:35 minimaverick kernel: ACPI: Lid Switch [LID]
Sep  2 13:28:35 minimaverick kernel: ACPI: Processor [CPU0] (supports C1 C2)
Sep  2 13:28:35 minimaverick kernel: ACPI: Thermal Zone [THRM] (50 C)
Sep  2 13:28:35 minimaverick kernel: Real Time Clock Driver v1.12
Sep  2 13:28:35 minimaverick kernel: [drm] Initialized radeon 1.9.0 20020828 on minor 0
Sep  2 13:28:35 minimaverick kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
Sep  2 13:28:35 minimaverick kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Sep  2 13:28:35 minimaverick kernel: ttyS1 at I/O 0x8828 (irq = 3) is a 8250
Sep  2 13:28:35 minimaverick kernel: ttyS2 at I/O 0x8840 (irq = 3) is a 8250
Sep  2 13:28:35 minimaverick kernel: ttyS3 at I/O 0x8850 (irq = 3) is a 8250
Sep  2 13:28:35 minimaverick kernel: Using anticipatory scheduling elevator
Sep  2 13:28:35 minimaverick kernel: Floppy drive(s): fd0 is 1.44M
Sep  2 13:28:35 minimaverick kernel: FDC 0 is a post-1991 82077
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for platform:floppy0
Sep  2 13:28:35 minimaverick kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Sep  2 13:28:35 minimaverick kernel: loop: loaded (max 8 devices)
Sep  2 13:28:35 minimaverick kernel: nbd: registered device at major 43
Sep  2 13:28:35 minimaverick kernel: natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
Sep  2 13:28:35 minimaverick kernel:   originally by Donald Becker <becker@scyld.com>
Sep  2 13:28:35 minimaverick kernel:   http://www.scyld.com/network/natsemi.html
Sep  2 13:28:35 minimaverick kernel:   2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
Sep  2 13:28:35 minimaverick kernel: eth0: NatSemi DP8381[56] at 0xcd811000, 00:0b:cd:18:97:c2, IRQ 11.
Sep  2 13:28:35 minimaverick kernel: orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
Sep  2 13:28:35 minimaverick kernel: orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
Sep  2 13:28:35 minimaverick kernel: orinoco_plx.c 0.13e (Daniel Barlow <dan@telent.net>, David Gibson <hermes@gibson.dropbear.id.au>)
Sep  2 13:28:35 minimaverick kernel: orinoco_pci.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> & Jean Tourrilhes <jt@hpl.hp.com>)
Sep  2 13:28:35 minimaverick kernel: orinoco_tmd.c 0.01 (Joerg Dorchain <joerg@dorchain.net>)
Sep  2 13:28:35 minimaverick kernel: airo:  Probing for PCI adapters
Sep  2 13:28:35 minimaverick kernel: airo:  Finished probing for PCI adapters
Sep  2 13:28:35 minimaverick kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Sep  2 13:28:35 minimaverick kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep  2 13:28:35 minimaverick kernel: Warning: ATI Radeon IGP Northbridge is not yet fully tested.
Sep  2 13:28:35 minimaverick kernel: ALI15X3: IDE controller at PCI slot 0000:00:10.0
Sep  2 13:28:35 minimaverick kernel: ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
Sep  2 13:28:35 minimaverick kernel: ALI15X3: chipset revision 196
Sep  2 13:28:35 minimaverick kernel: ALI15X3: not 100%% native mode: will probe irqs later
Sep  2 13:28:35 minimaverick kernel:     ide0: BM-DMA at 0x8080-0x8087, BIOS settings: hda:DMA, hdb:pio
Sep  2 13:28:35 minimaverick kernel:     ide1: BM-DMA at 0x8088-0x808f, BIOS settings: hdc:pio, hdd:pio
Sep  2 13:28:35 minimaverick kernel: hda: TOSHIBA MK3018GAP, ATA DISK drive
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for No Bus:ide0
Sep  2 13:28:35 minimaverick kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for ide:0.0
Sep  2 13:28:35 minimaverick kernel: hdc: TOSHIBA DVD-ROM SD-R2312, ATAPI CD/DVD-ROM drive
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for No Bus:ide1
Sep  2 13:28:35 minimaverick kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for ide:1.0
Sep  2 13:28:35 minimaverick kernel: hda: max request size: 128KiB
Sep  2 13:28:35 minimaverick kernel: hda: 58605120 sectors (30005 MB), CHS=58140/16/63, UDMA(100)
Sep  2 13:28:35 minimaverick kernel:  hda: hda1 hda2 hda3 < hda5 >
Sep  2 13:28:35 minimaverick kernel: Console: switching to colour frame buffer device 128x48
Sep  2 13:28:35 minimaverick kernel: Yenta: CardBus bridge found at 0000:00:0a.0 [103c:0024]
Sep  2 13:28:35 minimaverick kernel: Yenta: ISA IRQ list 04b8, PCI irq11
Sep  2 13:28:35 minimaverick kernel: Socket status: 30000007
Sep  2 13:28:35 minimaverick kernel: Initializing USB Mass Storage driver...
Sep  2 13:28:35 minimaverick kernel: drivers/usb/core/usb.c: registered new driver usb-storage
Sep  2 13:28:35 minimaverick kernel: USB Mass Storage support registered.
Sep  2 13:28:35 minimaverick kernel: drivers/usb/core/usb.c: registered new driver hiddev
Sep  2 13:28:35 minimaverick kernel: drivers/usb/core/usb.c: registered new driver hid
Sep  2 13:28:35 minimaverick kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Sep  2 13:28:35 minimaverick kernel: mice: PS/2 mouse device common for all mice
Sep  2 13:28:35 minimaverick kernel: Synaptics Touchpad, model: 1
Sep  2 13:28:35 minimaverick kernel:  Firmware: 5.8
Sep  2 13:28:35 minimaverick kernel:  Sensor: 35
Sep  2 13:28:35 minimaverick kernel:  new absolute packet format
Sep  2 13:28:35 minimaverick kernel:  Touchpad has extended capability bits
Sep  2 13:28:35 minimaverick kernel:  -> multifinger detection
Sep  2 13:28:35 minimaverick kernel:  -> palm detection
Sep  2 13:28:35 minimaverick kernel: input: Synaptics Synaptics TouchPad on isa0060/serio1
Sep  2 13:28:35 minimaverick kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep  2 13:28:35 minimaverick kernel: input: AT Set 2 keyboard on isa0060/serio0
Sep  2 13:28:35 minimaverick kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Sep  2 13:28:35 minimaverick kernel: Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed Aug 20 20:27:13 2003 UTC).
Sep  2 13:28:35 minimaverick kernel: ALSA device list:
Sep  2 13:28:35 minimaverick kernel:   No soundcards found.
Sep  2 13:28:35 minimaverick kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Sep  2 13:28:35 minimaverick kernel: IP: routing cache hash table of 1024 buckets, 8Kbytes
Sep  2 13:28:35 minimaverick kernel: TCP: Hash tables configured (established 16384 bind 32768)
Sep  2 13:28:35 minimaverick kernel: Linux IP multicast router 0.06 plus PIM-SM
Sep  2 13:28:35 minimaverick kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Sep  2 13:28:35 minimaverick kernel: cpufreq: No CPUs supporting ACPI performance management found.
Sep  2 13:28:35 minimaverick kernel: BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
Sep  2 13:28:35 minimaverick kernel: PM: Reading swsusp image.
Sep  2 13:28:35 minimaverick kernel: PM: Resume from disk failed.
Sep  2 13:28:35 minimaverick kernel: ACPI: (supports S0 S3 S4 S5)
Sep  2 13:28:35 minimaverick kernel: found reiserfs format "3.6" with standard journal
Sep  2 13:28:35 minimaverick kernel: Reiserfs journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Sep  2 13:28:35 minimaverick kernel: reiserfs: checking transaction log (hda2) for (hda2)
Sep  2 13:28:35 minimaverick kernel: reiserfs: replayed 5 transactions in 0 seconds
Sep  2 13:28:35 minimaverick kernel: Using r5 hash to sort names
Sep  2 13:28:35 minimaverick kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Sep  2 13:28:35 minimaverick kernel: Freeing unused kernel memory: 164k freed
Sep  2 13:28:35 minimaverick kernel: Unable to find swap-space signature
Sep  2 13:28:35 minimaverick kernel: Removing [938 14986 0x0 SD]..done
Sep  2 13:28:35 minimaverick kernel: Removing [939 1721 0x0 SD]..done
Sep  2 13:28:35 minimaverick kernel: There were 2 uncompleted unlinks/truncates. Completed
Sep  2 13:28:35 minimaverick kernel: Linux agpgart interface v0.100 (c) Dave Jones
Sep  2 13:28:35 minimaverick kernel: agpgart: Detected Ati IGP320/M chipset
Sep  2 13:28:35 minimaverick kernel: agpgart: Maximum main memory to use for agp memory: 148M
Sep  2 13:28:35 minimaverick kernel: agpgart: AGP aperture is 64M @ 0xd4000000
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for No Bus:ide-scsi
Sep  2 13:28:35 minimaverick kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for No Bus:host0
Sep  2 13:28:35 minimaverick kernel:   Vendor: TOSHIBA   Model: DVD-ROM SD-R2312  Rev: 1905
Sep  2 13:28:35 minimaverick kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Sep  2 13:28:35 minimaverick kernel: PM: Adding info for scsi:0:0:0:0
Sep  2 13:28:35 minimaverick kernel: Unable to find swap-space signature
Sep  2 13:28:36 minimaverick modprobe: FATAL: Module snd_card_1 not found. 
Sep  2 13:28:36 minimaverick modprobe: FATAL: Module snd_card_1 not found. 
Sep  2 13:28:36 minimaverick modprobe: FATAL: Module snd_card_2 not found. 
Sep  2 13:28:36 minimaverick modprobe: FATAL: Module snd_card_2 not found. 
Sep  2 13:28:36 minimaverick modprobe: FATAL: Module snd_card_3 not found. 
Sep  2 13:28:36 minimaverick modprobe: FATAL: Module snd_card_3 not found. 
Sep  2 13:28:36 minimaverick kernel: eth0: link up.
Sep  2 13:28:36 minimaverick kernel: eth0: Setting full-duplex based on negotiated link capability.
Sep  2 13:28:36 minimaverick ifplugd(eth0)[265]: Using interface eth0/00:0B:CD:18:97:C2 with driver <natsemi> (version: 1.07+LK1.0.17)
Sep  2 13:28:36 minimaverick ifplugd(eth0)[265]: Using detection mode: SIOCETHTOOL
Sep  2 13:28:36 minimaverick ifplugd(eth0)[265]: ifplugd 0.15 successfully initialized, link beat detected.
Sep  2 13:28:36 minimaverick ifplugd(eth0)[265]: Executing '/etc/ifplugd/ifplugd.action eth0 up'.
Sep  2 13:28:36 minimaverick dhclient: Internet Software Consortium DHCP Client 2.0pl5
Sep  2 13:28:36 minimaverick ifplugd(eth0)[265]: client: Internet Software Consortium DHCP Client 2.0pl5
Sep  2 13:28:36 minimaverick dhclient: Copyright 1995, 1996, 1997, 1998, 1999 The Internet Software Consortium.
Sep  2 13:28:36 minimaverick ifplugd(eth0)[265]: client: Copyright 1995, 1996, 1997, 1998, 1999 The Internet Software Consortium.
Sep  2 13:28:36 minimaverick dhclient: All rights reserved.
Sep  2 13:28:36 minimaverick ifplugd(eth0)[265]: client: All rights reserved.
Sep  2 13:28:36 minimaverick dhclient: 
Sep  2 13:28:36 minimaverick dhclient: Please contribute if you find this software useful.
Sep  2 13:28:36 minimaverick ifplugd(eth0)[265]: client: Please contribute if you find this software useful.
Sep  2 13:28:36 minimaverick dhclient: For info, please visit http://www.isc.org/dhcp-contrib.html
Sep  2 13:28:36 minimaverick ifplugd(eth0)[265]: client: For info, please visit http://www.isc.org/dhcp-contrib.html
Sep  2 13:28:36 minimaverick dhclient: 
Sep  2 13:28:37 minimaverick dhclient: Listening on LPF/eth0/00:0b:cd:18:97:c2
Sep  2 13:28:37 minimaverick dhclient: Sending on   LPF/eth0/00:0b:cd:18:97:c2
Sep  2 13:28:37 minimaverick dhclient: Sending on   Socket/fallback/fallback-net
Sep  2 13:28:37 minimaverick dhclient: DHCPREQUEST on eth0 to 255.255.255.255 port 67
Sep  2 13:28:37 minimaverick ifplugd(eth0)[265]: client: Listening on LPF/eth0/00:0b:cd:18:97:c2
Sep  2 13:28:37 minimaverick ifplugd(eth0)[265]: client: Sending on   LPF/eth0/00:0b:cd:18:97:c2
Sep  2 13:28:37 minimaverick ifplugd(eth0)[265]: client: Sending on   Socket/fallback/fallback-net
Sep  2 13:28:37 minimaverick ifplugd(eth0)[265]: client: DHCPREQUEST on eth0 to 255.255.255.255 port 67
Sep  2 13:28:37 minimaverick dhclient: DHCPACK from 192.168.100.1
Sep  2 13:28:37 minimaverick ifplugd(eth0)[265]: client: DHCPACK from 192.168.100.1
Sep  2 13:28:37 minimaverick dhclient: bound to 192.168.100.5 -- renewal in 900 seconds.
Sep  2 13:28:37 minimaverick ifplugd(eth0)[265]: client: bound to 192.168.100.5 -- renewal in 900 seconds.
Sep  2 13:28:38 minimaverick modprobe: FATAL: Module ipv6 not found. 
Sep  2 13:28:38 minimaverick ifplugd(eth0)[265]: client: Starting OpenBSD Secure Shell server: sshd.
Sep  2 13:28:38 minimaverick ifplugd(eth0)[265]: Program executed successfully.
Sep  2 13:28:38 minimaverick cardmgr[316]: watching 1 sockets
Sep  2 13:28:38 minimaverick kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Sep  2 13:28:38 minimaverick kernel: cs: IO port probe 0x0800-0x08ff: clean.
Sep  2 13:28:38 minimaverick kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x220-0x22f 0x330-0x337 0x378-0x37f 0x388-0x38f 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
Sep  2 13:28:38 minimaverick kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Sep  2 13:28:38 minimaverick cardmgr[317]: starting, version is 3.2.2
Sep  2 13:28:38 minimaverick modprobe: FATAL: Module ipv6 not found. 
Sep  2 13:28:39 minimaverick /usr/sbin/cron[336]: (CRON) INFO (pidfile fd = 3)
Sep  2 13:28:39 minimaverick /usr/sbin/cron[337]: (CRON) STARTUP (fork ok)
Sep  2 13:28:39 minimaverick /usr/sbin/cron[337]: (CRON) INFO (Running @reboot jobs)


--------------070609040306010006020205--

