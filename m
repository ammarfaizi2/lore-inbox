Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUGAUew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUGAUew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 16:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266277AbUGAUew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 16:34:52 -0400
Received: from web52902.mail.yahoo.com ([206.190.39.179]:44223 "HELO
	web52902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266273AbUGAUcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 16:32:54 -0400
Message-ID: <20040701203252.58144.qmail@web52902.mail.yahoo.com>
Date: Thu, 1 Jul 2004 22:32:52 +0200 (CEST)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Re: 2.6.7-mm[3-4] doesn't boot (alsa or pnp related)
To: Calin Szonyi <caszonyi@rdslink.ro>, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
In-Reply-To: <Pine.LNX.4.53.0406300333020.216@grinch.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- caszonyi@rdslink.ro a écrit : > Hi all
> I just tried today 2.6.7-mm3 and 2.6.7-mm4.
> They both stop booting at:
> Advanced Linux Sound Architecture Driver Version 1.0.5 (Sun
> May 30
> 10:49:40 2004 UTC)
> pnp: Device 01:01.00 activated
> pnp: Device 01:01.02 activated
> pnp: Device 01:01.03 activated
> 

The same happens on 2.6.7-mm5 ;-(
Programs:
Linux grinch 2.6.7 #1 Thu Jun 17 00:09:27 EEST 2004 i686 unknown
 
Gnu C                  3.3.3
Gnu make               3.80
binutils               2.13.90.0.18
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.9
e2fsprogs              1.35
jfsutils               1.1.6
reiserfsprogs          3.6.4
xfsprogs               2.3.5
quota-tools            3.08.
PPP                    2.4.1
nfs-utils              1.0.4
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.3
Procps                 3.1.8
Net-tools              1.60
Kbd                    1.08
Sh-utils               2.0
Modules Loaded         bttv tvaudio tuner video_buf btcx_risc



> 
> on a normal boot it is (vanila 2.6.7):
> 
> Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon
> May 17
> 14:31:44 2004 U
> TC).
> pnp: the driver 'cs423x' has been registered
> pnp: match found with the PnP device '01:01.00' and the driver
> 'cs423x'
> pnp: match found with the PnP device '01:01.02' and the driver
> 'cs423x'
> pnp: match found with the PnP device '01:01.03' and the driver
> 'cs423x'
> pnp: Device 01:01.00 activated.
> pnp: Device 01:01.02 activated.
> pnp: Device 01:01.03 activated.
> ALSA device list:
>   #0: CS4239 at 0x534, irq 5, dma 1&0
>   #1: Brooktree Bt878 at 0xe2002000, irq 10
> 
> config is attached
> 
> Bye
> Calin
> 
> --
> "A mouse is a device used to point at
> the xterm you want to type in".
> Kim Alm on a.s.r.> #
> # Automatically generated make config: don't edit
> #
> CONFIG_X86=y
> CONFIG_MMU=y
> CONFIG_UID16=y
> CONFIG_GENERIC_ISA_DMA=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> # CONFIG_CLEAN_COMPILE is not set
> # CONFIG_STANDALONE is not set
> CONFIG_BROKEN=y
> CONFIG_BROKEN_ON_SMP=y
> 
> #
> # General setup
> #
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> # CONFIG_POSIX_MQUEUE is not set
> # CONFIG_BSD_PROCESS_ACCT is not set
> CONFIG_SYSCTL=y
> # CONFIG_AUDIT is not set
> CONFIG_LOG_BUF_SHIFT=17
> # CONFIG_HOTPLUG is not set
> # CONFIG_IKCONFIG is not set
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_ALL is not set
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> CONFIG_MODULE_FORCE_UNLOAD=y
> CONFIG_OBSOLETE_MODPARM=y
> # CONFIG_MODVERSIONS is not set
> CONFIG_KMOD=y
> 
> #
> # Processor type and features
> #
> CONFIG_X86_PC=y
> # CONFIG_X86_ELAN is not set
> # CONFIG_X86_VOYAGER is not set
> # CONFIG_X86_NUMAQ is not set
> # CONFIG_X86_SUMMIT is not set
> # CONFIG_X86_BIGSMP is not set
> # CONFIG_X86_VISWS is not set
> # CONFIG_X86_GENERICARCH is not set
> # CONFIG_X86_ES7000 is not set
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUMM is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> CONFIG_MK7=y
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_X86_GENERIC is not set
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_USE_3DNOW=y
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> # CONFIG_SMP is not set
> CONFIG_PREEMPT=y
> # CONFIG_X86_UP_APIC is not set
> CONFIG_X86_TSC=y
> # CONFIG_X86_MCE is not set
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> # CONFIG_MICROCODE is not set
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
> 
> #
> # Firmware Drivers
> #
> # CONFIG_EDD is not set
> CONFIG_NOHIGHMEM=y
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> # CONFIG_EFI is not set
> CONFIG_HAVE_DEC_LOCK=y
> CONFIG_REGPARM=y
> 
> #
> # Performance-monitoring counters support
> #
> # CONFIG_PERFCTR is not set
> 
> #
> # Power management options (ACPI, APM)
> #
> CONFIG_PM=y
> # CONFIG_SOFTWARE_SUSPEND is not set
> # CONFIG_PM_DISK is not set
> 
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> CONFIG_ACPI=y
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_INTERPRETER=y
> # CONFIG_ACPI_SLEEP is not set
> # CONFIG_ACPI_AC is not set
> # CONFIG_ACPI_BATTERY is not set
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_THERMAL=y
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_TOSHIBA is not set
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_BUS=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_PCI=y
> CONFIG_ACPI_SYSTEM=y
> # CONFIG_X86_PM_TIMER is not set
> 
> #
> # APM (Advanced Power Management) BIOS Support
> #
> # CONFIG_APM is not set
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> 
> #
> # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> #
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> CONFIG_PCI_GODIRECT=y
> # CONFIG_PCI_GOANY is not set
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_LEGACY_PROC=y
> CONFIG_PCI_NAMES=y
> CONFIG_ISA=y
> # CONFIG_EISA is not set
> # CONFIG_MCA is not set
> # CONFIG_SCx200 is not set
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> # CONFIG_BINFMT_AOUT is not set
> # CONFIG_BINFMT_MISC is not set
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> # CONFIG_DEBUG_DRIVER is not set
> 
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
> 
> #
> # Parallel port support
> #
> CONFIG_PARPORT=y
> CONFIG_PARPORT_PC=y
> CONFIG_PARPORT_PC_CML1=y
> # CONFIG_PARPORT_SERIAL is not set
> CONFIG_PARPORT_PC_FIFO=y
> CONFIG_PARPORT_PC_SUPERIO=y
> # CONFIG_PARPORT_OTHER is not set
> CONFIG_PARPORT_1284=y
> 
> #
> # Plug and Play support
> #
> CONFIG_PNP=y
> CONFIG_PNP_DEBUG=y
> 
> #
> # Protocols
> #
> CONFIG_ISAPNP=y
> CONFIG_PNPBIOS=y
> CONFIG_PNPBIOS_PROC_FS=y
> 
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=y
> # CONFIG_BLK_DEV_XD is not set
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> CONFIG_BLK_DEV_LOOP=y
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_LBD is not set
> 
> #
> # ATA/ATAPI/MFM/RLL support
> #
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> 
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_IDE_SATA is not set
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECD=y
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_IDE_TASK_IOCTL is not set
> CONFIG_IDE_TASKFILE_IO=y
> 
> #
> # IDE chipset support/bugfixes
> #
> # CONFIG_IDE_GENERIC is not set
> # CONFIG_BLK_DEV_CMD640 is not set
> # CONFIG_BLK_DEV_IDEPNP is not set
> CONFIG_BLK_DEV_IDEPCI=y
> # CONFIG_IDEPCI_SHARE_IRQ is not set
> # CONFIG_BLK_DEV_OFFBOARD is not set
> CONFIG_BLK_DEV_GENERIC=y
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> CONFIG_BLK_DEV_ADMA=y
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_ATIIXP is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_SC1200 is not set
> # CONFIG_BLK_DEV_PIIX is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> CONFIG_BLK_DEV_VIA82CXXX=y
> # CONFIG_IDE_ARM is not set
> # CONFIG_IDE_CHIPSETS is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_BLK_DEV_HD is not set
> 
> #
> # SCSI device support
> #
> # CONFIG_SCSI is not set
> 
> #
> # Old CD-ROM drivers (not SCSI, not IDE)
> #
> # CONFIG_CD_NO_IDESCSI is not set
> 
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
> 
> #
> # Fusion MPT device support
> #
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_IEEE1394 is not set
> 
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
> 
> #
> # Networking support
> #
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> CONFIG_NETLINK_DEV=y
> CONFIG_UNIX=y
> # CONFIG_NET_KEY is not set
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> CONFIG_IP_ADVANCED_ROUTER=y
> # CONFIG_IP_MULTIPLE_TABLES is not set
> # CONFIG_IP_ROUTE_MULTIPATH is not set
> CONFIG_IP_ROUTE_TOS=y
> # CONFIG_IP_ROUTE_VERBOSE is not set
> # CONFIG_IP_PNP is not set
> CONFIG_NET_IPIP=y
> # CONFIG_NET_IPGRE is not set
> # CONFIG_ARPD is not set
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> 
> #
> # IP: Virtual Server Configuration
> #
> # CONFIG_IP_VS is not set
> # CONFIG_IPV6 is not set
> CONFIG_NETFILTER=y
> # CONFIG_NETFILTER_DEBUG is not set
> 
> #
> # IP: Netfilter Configuration
> #
> CONFIG_IP_NF_CONNTRACK=y
> CONFIG_IP_NF_FTP=y
> CONFIG_IP_NF_IRC=y
> CONFIG_IP_NF_TFTP=y
> # CONFIG_IP_NF_AMANDA is not set
> # CONFIG_IP_NF_QUEUE is not set
> CONFIG_IP_NF_IPTABLES=y
> CONFIG_IP_NF_MATCH_LIMIT=y
> CONFIG_IP_NF_MATCH_IPRANGE=y
> CONFIG_IP_NF_MATCH_MAC=y
> CONFIG_IP_NF_MATCH_PKTTYPE=y
> CONFIG_IP_NF_MATCH_MARK=y
> CONFIG_IP_NF_MATCH_MULTIPORT=y
> CONFIG_IP_NF_MATCH_TOS=y
> CONFIG_IP_NF_MATCH_RECENT=y
> CONFIG_IP_NF_MATCH_ECN=y
> CONFIG_IP_NF_MATCH_DSCP=y
> CONFIG_IP_NF_MATCH_AH_ESP=y
> CONFIG_IP_NF_MATCH_LENGTH=y
> CONFIG_IP_NF_MATCH_TTL=y
> CONFIG_IP_NF_MATCH_TCPMSS=y
> CONFIG_IP_NF_MATCH_HELPER=y
> CONFIG_IP_NF_MATCH_STATE=y
> CONFIG_IP_NF_MATCH_CONNTRACK=y
> CONFIG_IP_NF_MATCH_OWNER=y
> CONFIG_IP_NF_FILTER=y
> CONFIG_IP_NF_TARGET_REJECT=y
> CONFIG_IP_NF_NAT=y
> CONFIG_IP_NF_NAT_NEEDED=y
> CONFIG_IP_NF_TARGET_MASQUERADE=y
> CONFIG_IP_NF_TARGET_REDIRECT=y
> CONFIG_IP_NF_TARGET_NETMAP=y
> CONFIG_IP_NF_TARGET_SAME=y
> CONFIG_IP_NF_NAT_LOCAL=y
> CONFIG_IP_NF_NAT_SNMP_BASIC=y
> CONFIG_IP_NF_NAT_IRC=y
> CONFIG_IP_NF_NAT_FTP=y
> CONFIG_IP_NF_NAT_TFTP=y
> CONFIG_IP_NF_MANGLE=y
> CONFIG_IP_NF_TARGET_TOS=y
> CONFIG_IP_NF_TARGET_ECN=y
> CONFIG_IP_NF_TARGET_DSCP=y
> CONFIG_IP_NF_TARGET_MARK=y
> CONFIG_IP_NF_TARGET_CLASSIFY=y
> CONFIG_IP_NF_TARGET_LOG=y
> CONFIG_IP_NF_TARGET_ULOG=y
> CONFIG_IP_NF_TARGET_TCPMSS=y
> CONFIG_IP_NF_ARPTABLES=y
> CONFIG_IP_NF_ARPFILTER=y
> # CONFIG_IP_NF_ARP_MANGLE is not set
> # CONFIG_IP_NF_RAW is not set
> # CONFIG_IP_NF_MATCH_ADDRTYPE is not set
> # CONFIG_IP_NF_MATCH_REALM is not set
> CONFIG_XFRM=y
> # CONFIG_XFRM_USER is not set
> 
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> # CONFIG_IP_SCTP is not set
> # CONFIG_ATM is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
> 
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
> # CONFIG_NET_CLS_ROUTE is not set
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_KGDBOE is not set
> # CONFIG_NETPOLL is not set
> # CONFIG_NETPOLL_RX is not set
> # CONFIG_NETPOLL_TRAP is not set
> # CONFIG_NET_POLL_CONTROLLER is not set
> # CONFIG_HAMRADIO is not set
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> CONFIG_NETDEVICES=y
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> # CONFIG_ETHERTAP is not set
> # CONFIG_NET_SB1000 is not set
> 
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> CONFIG_MII=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_LANCE is not set
> # CONFIG_NET_VENDOR_SMC is not set
> # CONFIG_NET_VENDOR_RACAL is not set
> 
> #
> # Tulip family network device support
> #
> # CONFIG_NET_TULIP is not set
> # CONFIG_AT1700 is not set
> # CONFIG_DEPCA is not set
> # CONFIG_HP100 is not set
> # CONFIG_NET_ISA is not set
> CONFIG_NET_PCI=y
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_AC3200 is not set
> # CONFIG_APRICOT is not set
> # CONFIG_B44 is not set
> # CONFIG_FORCEDETH is not set
> # CONFIG_CS89x0 is not set
> # CONFIG_DGRS is not set
> # CONFIG_EEPRO100 is not set
> # CONFIG_E100 is not set
> # CONFIG_FEALNX is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_8139CP is not set
> CONFIG_8139TOO=y
> # CONFIG_8139TOO_PIO is not set
> # CONFIG_8139TOO_TUNE_TWISTER is not set
> # CONFIG_8139TOO_8129 is not set
> # CONFIG_8139_OLD_RX_RESET is not set
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_TLAN is not set
> # CONFIG_VIA_RHINE is not set
> # CONFIG_VIA_VELOCITY is not set
> # CONFIG_NET_POCKET is not set
> 
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> # CONFIG_E1000 is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_R8169 is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_TIGON3 is not set
> 
> #
> # Ethernet (10000 Mbit)
> #
> # CONFIG_IXGB is not set
> # CONFIG_S2IO is not set
> 
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
> 
> #
> # Wireless LAN (non-hamradio)
> #
> CONFIG_NET_RADIO=y
> 
> #
> # Obsolete Wireless cards support (pre-802.11)
> #
> # CONFIG_STRIP is not set
> # CONFIG_ARLAN is not set
> # CONFIG_WAVELAN is not set
> 
> #
> # Wireless 802.11b ISA/PCI cards support
> #
> # CONFIG_AIRO is not set
> # CONFIG_HERMES is not set
> # CONFIG_ATMEL is not set
> 
> #
> # Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
> #
> CONFIG_NET_WIRELESS=y
> 
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PLIP is not set
> CONFIG_PPP=y
> # CONFIG_PPP_MULTILINK is not set
> CONFIG_PPP_FILTER=y
> CONFIG_PPP_ASYNC=y
> # CONFIG_PPP_SYNC_TTY is not set
> CONFIG_PPP_DEFLATE=y
> CONFIG_PPP_BSDCOMP=y
> # CONFIG_PPPOE is not set
> # CONFIG_SLIP is not set
> # CONFIG_SHAPER is not set
> # CONFIG_NETCONSOLE is not set
> 
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
> 
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input I/O drivers
> #
> # CONFIG_GAMEPORT is not set
> CONFIG_SOUND_GAMEPORT=y
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> # CONFIG_SERIO_PCIPS2 is not set
> # CONFIG_SERIO_RAW is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_INPORT is not set
> # CONFIG_MOUSE_LOGIBM is not set
> # CONFIG_MOUSE_PC110PAD is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_PCSPKR=y
> # CONFIG_INPUT_UINPUT is not set
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=y
> # CONFIG_SERIAL_8250_CONSOLE is not set
> # CONFIG_SERIAL_8250_ACPI is not set
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> # CONFIG_SERIAL_8250_MANY_PORTS is not set
> # CONFIG_SERIAL_8250_SHARE_IRQ is not set
> CONFIG_SERIAL_8250_DETECT_IRQ=y
> # CONFIG_SERIAL_8250_MULTIPORT is not set
> CONFIG_SERIAL_8250_RSA=y
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=512
> CONFIG_PRINTER=y
> CONFIG_LP_CONSOLE=y
> CONFIG_PPDEV=y
> # CONFIG_TIPAR is not set
> # CONFIG_QIC02_TAPE is not set
> 
> #
> # IPMI
> #
> # CONFIG_IPMI_HANDLER is not set
> 
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_HW_RANDOM is not set
> CONFIG_NVRAM=y
> CONFIG_RTC=y
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> CONFIG_AGP=y
> # CONFIG_AGP_ALI is not set
> # CONFIG_AGP_ATI is not set
> # CONFIG_AGP_AMD is not set
> # CONFIG_AGP_AMD64 is not set
> # CONFIG_AGP_INTEL is not set
> # CONFIG_AGP_INTEL_MCH is not set
> # CONFIG_AGP_NVIDIA is not set
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_SWORKS is not set
> CONFIG_AGP_VIA=y
> # CONFIG_AGP_EFFICEON is not set
> CONFIG_DRM=y
> # CONFIG_DRM_TDFX is not set
> # CONFIG_DRM_GAMMA is not set
> # CONFIG_DRM_R128 is not set
> CONFIG_DRM_RADEON=y
> # CONFIG_DRM_MGA is not set
> # CONFIG_DRM_SIS is not set
> # CONFIG_MWAVE is not set
> # CONFIG_RAW_DRIVER is not set
> CONFIG_HPET=y
> # CONFIG_HPET_RTC_IRQ is not set
> CONFIG_HPET_NOMMAP=y
> # CONFIG_HANGCHECK_TIMER is not set
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_I2C_CHARDEV=y
> 
> #
> # I2C Algorithms
> #
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ALGOPCF=y
> 
> #
> # I2C Hardware Bus support
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_ELEKTOR is not set
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_I810 is not set
> CONFIG_I2C_ISA=y
> # CONFIG_I2C_NFORCE2 is not set
> # CONFIG_I2C_PARPORT is not set
> # CONFIG_I2C_PARPORT_LIGHT is not set
> # CONFIG_I2C_PIIX4 is not set
> # CONFIG_I2C_PROSAVAGE is not set
> # CONFIG_I2C_SAVAGE4 is not set
> # CONFIG_SCx200_ACB is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> CONFIG_I2C_VIA=y
> CONFIG_I2C_VIAPRO=y
> # CONFIG_I2C_VOODOO3 is not set
> 
> #
> # Hardware Sensors Chip support
> #
> CONFIG_I2C_SENSOR=y
> # CONFIG_SENSORS_ADM1021 is not set
> # CONFIG_SENSORS_ASB100 is not set
> # CONFIG_SENSORS_DS1621 is not set
> # CONFIG_SENSORS_FSCHER is not set
> # CONFIG_SENSORS_GL518SM is not set
> # CONFIG_SENSORS_IT87 is not set
> # CONFIG_SENSORS_LM75 is not set
> # CONFIG_SENSORS_LM78 is not set
> # CONFIG_SENSORS_LM80 is not set
> # CONFIG_SENSORS_LM83 is not set
> # CONFIG_SENSORS_LM85 is not set
> # CONFIG_SENSORS_LM90 is not set
> # CONFIG_SENSORS_MAX1619 is not set
> CONFIG_SENSORS_VIA686A=y
> # CONFIG_SENSORS_W83781D is not set
> # CONFIG_SENSORS_W83L785TS is not set
> # CONFIG_SENSORS_W83627HF is not set
> 
> #
> # Other I2C Chip support
> #
> # CONFIG_SENSORS_EEPROM is not set
> # CONFIG_SENSORS_PCF8574 is not set
> # CONFIG_SENSORS_PCF8591 is not set
> # CONFIG_SENSORS_RTC8564 is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # CONFIG_I2C_DEBUG_CHIP is not set
> 
> #
> # Misc devices
> #
> # CONFIG_IBM_ASM is not set
> 
> #
> # Multimedia devices
> #
> CONFIG_VIDEO_DEV=y
> 
> #
> # Video For Linux
> #
> 
> #
> # Video Adapters
> #
> CONFIG_VIDEO_BT848=m
> # CONFIG_VIDEO_PMS is not set
> # CONFIG_VIDEO_BWQCAM is not set
> # CONFIG_VIDEO_CQCAM is not set
> # CONFIG_VIDEO_W9966 is not set
> # CONFIG_VIDEO_CPIA is not set
> # CONFIG_VIDEO_SAA5246A is not set
> # CONFIG_VIDEO_SAA5249 is not set
> # CONFIG_TUNER_3036 is not set
> # CONFIG_VIDEO_STRADIS is not set
> # CONFIG_VIDEO_ZORAN is not set
> # CONFIG_VIDEO_ZR36120 is not set
> # CONFIG_VIDEO_SAA7134 is not set
> # CONFIG_VIDEO_MXB is not set
> # CONFIG_VIDEO_DPC is not set
> # CONFIG_VIDEO_HEXIUM_ORION is not set
> # CONFIG_VIDEO_HEXIUM_GEMINI is not set
> # CONFIG_VIDEO_CX88 is not set
> # CONFIG_VIDEO_OVCAMCHIP is not set
> 
> #
> # Radio Adapters
> #
> # CONFIG_RADIO_CADET is not set
> # CONFIG_RADIO_RTRACK is not set
> # CONFIG_RADIO_RTRACK2 is not set
> # CONFIG_RADIO_AZTECH is not set
> # CONFIG_RADIO_GEMTEK is not set
> # CONFIG_RADIO_GEMTEK_PCI is not set
> # CONFIG_RADIO_MAXIRADIO is not set
> # CONFIG_RADIO_MAESTRO is not set
> # CONFIG_RADIO_SF16FMI is not set
> # CONFIG_RADIO_SF16FMR2 is not set
> # CONFIG_RADIO_TERRATEC is not set
> # CONFIG_RADIO_TRUST is not set
> # CONFIG_RADIO_TYPHOON is not set
> # CONFIG_RADIO_ZOLTRIX is not set
> 
> #
> # Digital Video Broadcasting Devices
> #
> # CONFIG_DVB is not set
> CONFIG_VIDEO_TUNER=m
> CONFIG_VIDEO_BUF=m
> CONFIG_VIDEO_BTCX=m
> CONFIG_VIDEO_IR=m
> 
> #
> # Graphics support
> #
> # CONFIG_FB is not set
> CONFIG_VIDEO_SELECT=y
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y
> 
> #
> # Sound
> #
> CONFIG_SOUND=y
> 
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=y
> CONFIG_SND_TIMER=y
> CONFIG_SND_PCM=y
> CONFIG_SND_HWDEP=y
> CONFIG_SND_RAWMIDI=y
> CONFIG_SND_SEQUENCER=y
> # CONFIG_SND_SEQ_DUMMY is not set
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=y
> CONFIG_SND_PCM_OSS=y
> CONFIG_SND_SEQUENCER_OSS=y
> CONFIG_SND_RTCTIMER=y
> CONFIG_SND_VERBOSE_PRINTK=y
> # CONFIG_SND_DEBUG is not set
> 
> #
> # Generic devices
> #
> CONFIG_SND_MPU401_UART=y
> CONFIG_SND_OPL3_LIB=y
> # CONFIG_SND_DUMMY is not set
> # CONFIG_SND_VIRMIDI is not set
> # CONFIG_SND_MTPAV is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> CONFIG_SND_MPU401=y
> 
> #
> # ISA devices
> #
> # CONFIG_SND_AD1816A is not set
> # CONFIG_SND_AD1848 is not set
> # CONFIG_SND_CS4231 is not set
> # CONFIG_SND_CS4232 is not set
> CONFIG_SND_CS4236=y
> # CONFIG_SND_ES968 is not set
> # CONFIG_SND_ES1688 is not set
> # CONFIG_SND_ES18XX is not set
> # CONFIG_SND_GUSCLASSIC is not set
> # CONFIG_SND_GUSEXTREME is not set
> # CONFIG_SND_GUSMAX is not set
> # CONFIG_SND_INTERWAVE is not set
> # CONFIG_SND_INTERWAVE_STB is not set
> # CONFIG_SND_OPTI92X_AD1848 is not set
> # CONFIG_SND_OPTI92X_CS4231 is not set
> # CONFIG_SND_OPTI93X is not set
> # CONFIG_SND_SB8 is not set
> # CONFIG_SND_SB16 is not set
> # CONFIG_SND_SBAWE is not set
> # CONFIG_SND_WAVEFRONT is not set
> # CONFIG_SND_ALS100 is not set
> # CONFIG_SND_AZT2320 is not set
> # CONFIG_SND_CMI8330 is not set
> # CONFIG_SND_DT019X is not set
> # CONFIG_SND_OPL3SA2 is not set
> # CONFIG_SND_SGALAXY is not set
> # CONFIG_SND_SSCAPE is not set
> 
> #
> # PCI devices
> #
> # CONFIG_SND_ALI5451 is not set
> # CONFIG_SND_ATIIXP is not set
> # CONFIG_SND_AU8810 is not set
> # CONFIG_SND_AU8820 is not set
> # CONFIG_SND_AU8830 is not set
> # CONFIG_SND_AZT3328 is not set
> CONFIG_SND_BT87X=y
> # CONFIG_SND_CS46XX is not set
> # CONFIG_SND_CS4281 is not set
> # CONFIG_SND_EMU10K1 is not set
> # CONFIG_SND_KORG1212 is not set
> # CONFIG_SND_MIXART is not set
> # CONFIG_SND_NM256 is not set
> # CONFIG_SND_RME32 is not set
> # CONFIG_SND_RME96 is not set
> # CONFIG_SND_RME9652 is not set
> # CONFIG_SND_HDSP is not set
> # CONFIG_SND_TRIDENT is not set
> # CONFIG_SND_YMFPCI is not set
> # CONFIG_SND_ALS4000 is not set
> # CONFIG_SND_CMIPCI is not set
> # CONFIG_SND_ENS1370 is not set
> # CONFIG_SND_ENS1371 is not set
> # CONFIG_SND_ES1938 is not set
> # CONFIG_SND_ES1968 is not set
> # CONFIG_SND_MAESTRO3 is not set
> # CONFIG_SND_FM801 is not set
> # CONFIG_SND_ICE1712 is not set
> # CONFIG_SND_ICE1724 is not set
> # CONFIG_SND_INTEL8X0 is not set
> # CONFIG_SND_INTEL8X0M is not set
> # CONFIG_SND_SONICVIBES is not set
> # CONFIG_SND_VIA82XX is not set
> # CONFIG_SND_VX222 is not set
> 
> #
> # Open Sound System
> #
> # CONFIG_SOUND_PRIME is not set
> 
> #
> # USB support
> #
> # CONFIG_USB is not set
> 
> #
> # USB Gadget Support
> #
> # CONFIG_USB_GADGET is not set
> 
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> # CONFIG_EXT2_FS_SECURITY is not set
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_XATTR=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> # CONFIG_EXT3_FS_SECURITY is not set
> CONFIG_JBD=y
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> # CONFIG_REISERFS_FS is not set
> CONFIG_JFS_FS=y
> CONFIG_JFS_POSIX_ACL=y
> # CONFIG_JFS_DEBUG is not set
> # CONFIG_JFS_STATISTICS is not set
> CONFIG_FS_POSIX_ACL=y
> CONFIG_XFS_FS=y
> # CONFIG_XFS_RT is not set
> # CONFIG_XFS_QUOTA is not set
> # CONFIG_XFS_SECURITY is not set
> CONFIG_XFS_POSIX_ACL=y
> # CONFIG_MINIX_FS is not set
> # CONFIG_ROMFS_FS is not set
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_ZISOFS_FS=y
> CONFIG_UDF_FS=y
> 
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> # CONFIG_NTFS_FS is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_SYSFS=y
> # CONFIG_DEVFS_FS is not set
> # CONFIG_DEVPTS_FS_XATTR is not set
> CONFIG_TMPFS=y
> # CONFIG_HUGETLBFS is not set
> # CONFIG_HUGETLB_PAGE is not set
> CONFIG_RAMFS=y
> 
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_SYSV_FS is not set
> CONFIG_UFS_FS=y
> # CONFIG_UFS_FS_WRITE is not set
> 
> #
> # Network File Systems
> #
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V4 is not set
> # CONFIG_NFS_DIRECTIO is not set
> CONFIG_NFSD=y
> CONFIG_NFSD_V3=y
> # CONFIG_NFSD_V4 is not set
> CONFIG_NFSD_TCP=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_EXPORTFS=y
> CONFIG_SUNRPC=y
> # CONFIG_RPCSEC_GSS_KRB5 is not set
> CONFIG_SMB_FS=y
> # CONFIG_SMB_NLS_DEFAULT is not set
> # CONFIG_CIFS is not set
> # CONFIG_NCP_FS is not set
> CONFIG_CODA_FS=y
> CONFIG_CODA_FS_OLD_API=y
> # CONFIG_AFS_FS is not set
> 
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> # CONFIG_ACORN_PARTITION is not set
> # CONFIG_OSF_PARTITION is not set
> # CONFIG_AMIGA_PARTITION is not set
> # CONFIG_ATARI_PARTITION is not set
> # CONFIG_MAC_PARTITION is not set
> CONFIG_MSDOS_PARTITION=y
> CONFIG_BSD_DISKLABEL=y
> # CONFIG_MINIX_SUBPARTITION is not set
> CONFIG_SOLARIS_X86_PARTITION=y
> # CONFIG_UNIXWARE_DISKLABEL is not set
> # CONFIG_LDM_PARTITION is not set
> # CONFIG_SGI_PARTITION is not set
> # CONFIG_ULTRIX_PARTITION is not set
> # CONFIG_SUN_PARTITION is not set
> # CONFIG_EFI_PARTITION is not set
> 
> #
> # Native Language Support
> #
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-2"
> CONFIG_NLS_CODEPAGE_437=y
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> CONFIG_NLS_CODEPAGE_850=y
> CONFIG_NLS_CODEPAGE_852=y
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> CONFIG_NLS_CODEPAGE_1250=y
> # CONFIG_NLS_CODEPAGE_1251 is not set
> CONFIG_NLS_ASCII=y
> CONFIG_NLS_ISO8859_1=y
> CONFIG_NLS_ISO8859_2=y
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> CONFIG_NLS_ISO8859_15=y
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_UTF8=y
> 
> #
> # Profiling support
> #
> # CONFIG_PROFILING is not set
> 
> #
> # Kernel hacking
> #
> CONFIG_DEBUG_KERNEL=y
> CONFIG_EARLY_PRINTK=y
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_DEBUG_SLAB is not set
> CONFIG_MAGIC_SYSRQ=y
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_DEBUG_INFO is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_KGDB is not set
> # CONFIG_FRAME_POINTER is not set
> # CONFIG_4KSTACKS is not set
> 
> #
> # Security options
> #
> # CONFIG_SECURITY is not set
> 
> #
> # Cryptographic options
> #
> # CONFIG_CRYPTO is not set
> 
> #
> # Library routines
> #
> CONFIG_CRC16=y
> CONFIG_CRC32=y
> # CONFIG_LIBCRC32C is not set
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_X86_BIOS_REBOOT=y
> CONFIG_PC=y
>  

=====
--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.


	

	
		
Créez gratuitement votre Yahoo! Mail avec 100 Mo de stockage !
Créez votre Yahoo! Mail sur http://fr.benefits.yahoo.com/

Dialoguez en direct avec vos amis grâce à Yahoo! Messenger !Téléchargez Yahoo! Messenger sur http://fr.messenger.yahoo.com
