Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbSLBV3H>; Mon, 2 Dec 2002 16:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265255AbSLBV3H>; Mon, 2 Dec 2002 16:29:07 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:14566 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S265275AbSLBV1e>; Mon, 2 Dec 2002 16:27:34 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "'Ivan Kokshaysky'" <ink@jurassic.park.msu.ru>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: kernel build of 2.5.50 fails on Alpha
Date: Mon, 2 Dec 2002 22:34:57 +0100
Message-ID: <004101c29a4a$a9875030$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0042_01C29A53.0B4BB830"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20021202231624.A1571@jurassic.park.msu.ru>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0042_01C29A53.0B4BB830
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> arch/alpha/kernel/pci.c: In function `pcibios_fixup_final':
> arch/alpha/kernel/pci.c:128: `ALPHA_ALCOR_MAX_DMA_ISA_ADDRESS' undeclared
I> My fault. Please try this.

To no avail:

drivers/built-in.o: In function `kd_nosound':
drivers/built-in.o(.text+0x21354): undefined reference to `input_event'
drivers/built-in.o(.text+0x21358): undefined reference to `input_event'
drivers/built-in.o(.text+0x21384): undefined reference to `input_event'
drivers/built-in.o(.text+0x21388): undefined reference to `input_event'
drivers/built-in.o: In function `kd_mksound':
drivers/built-in.o(.text+0x214cc): undefined reference to `input_event'
drivers/built-in.o(.text+0x214d0): more undefined references to
`input_event' follow
drivers/built-in.o: In function `kbd_connect':
drivers/built-in.o(.text+0x236b4): undefined reference to
`input_open_device'
drivers/built-in.o(.text+0x236b8): undefined reference to
`input_open_device'
drivers/built-in.o: In function `kbd_disconnect':
drivers/built-in.o(.text+0x23718): undefined reference to
`input_close_device'
drivers/built-in.o(.text+0x2371c): undefined reference to
`input_close_device'
drivers/built-in.o: In function `kbd_init':
drivers/built-in.o(.init.text+0x4e8c): undefined reference to
`input_register_handler'
drivers/built-in.o(.init.text+0x4e90): undefined reference to
`input_register_handler'
net/built-in.o: In function `ip_conntrack_helper_register':
net/built-in.o(.text+0x69040): undefined reference to `__this_module'
net/built-in.o(.text+0x69080): undefined reference to `__this_module'
net/built-in.o: In function `ip_conntrack_helper_unregister':
net/built-in.o(.text+0x6916c): undefined reference to `__this_module'
net/built-in.o: In function `ip_nat_helper_register':
net/built-in.o(.text+0x6d314): undefined reference to `__this_module'
net/built-in.o(.text+0x6d350): undefined reference to `__this_module'
net/built-in.o(.text+0x6d640): more undefined references to `__this_module'
follow
make: *** [vmlinux] Error 1


------=_NextPart_000_0042_01C29A53.0B4BB830
Content-Type: application/octet-stream;
	name="config_beta_2.5"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="config_beta_2.5"

#=0A=
# Automatically generated make config: don't edit=0A=
#=0A=
CONFIG_ALPHA=3Dy=0A=
CONFIG_MMU=3Dy=0A=
CONFIG_SWAP=3Dy=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
CONFIG_GENERIC_ISA_DMA=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_NET=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
CONFIG_BSD_PROCESS_ACCT=3Dy=0A=
CONFIG_SYSCTL=3Dy=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODULE_UNLOAD=3Dy=0A=
# CONFIG_MODULE_FORCE_UNLOAD is not set=0A=
CONFIG_KMOD=3Dy=0A=
=0A=
#=0A=
# System setup=0A=
#=0A=
# CONFIG_ALPHA_GENERIC is not set=0A=
CONFIG_ALPHA_ALCOR=3Dy=0A=
# CONFIG_ALPHA_XL is not set=0A=
# CONFIG_ALPHA_BOOK1 is not set=0A=
# CONFIG_ALPHA_AVANTI_CH is not set=0A=
# CONFIG_ALPHA_CABRIOLET is not set=0A=
# CONFIG_ALPHA_DP264 is not set=0A=
# CONFIG_ALPHA_EB164 is not set=0A=
# CONFIG_ALPHA_EB64P_CH is not set=0A=
# CONFIG_ALPHA_EB66 is not set=0A=
# CONFIG_ALPHA_EB66P is not set=0A=
# CONFIG_ALPHA_EIGER is not set=0A=
# CONFIG_ALPHA_JENSEN is not set=0A=
# CONFIG_ALPHA_LX164 is not set=0A=
# CONFIG_ALPHA_MIATA is not set=0A=
# CONFIG_ALPHA_MIKASA is not set=0A=
# CONFIG_ALPHA_NAUTILUS is not set=0A=
# CONFIG_ALPHA_NONAME_CH is not set=0A=
# CONFIG_ALPHA_NORITAKE is not set=0A=
# CONFIG_ALPHA_PC164 is not set=0A=
# CONFIG_ALPHA_P2K is not set=0A=
# CONFIG_ALPHA_RAWHIDE is not set=0A=
# CONFIG_ALPHA_RUFFIAN is not set=0A=
# CONFIG_ALPHA_RX164 is not set=0A=
# CONFIG_ALPHA_SX164 is not set=0A=
# CONFIG_ALPHA_SABLE is not set=0A=
# CONFIG_ALPHA_SHARK is not set=0A=
# CONFIG_ALPHA_TAKARA is not set=0A=
# CONFIG_ALPHA_TITAN is not set=0A=
# CONFIG_ALPHA_WILDFIRE is not set=0A=
CONFIG_ISA=3Dy=0A=
CONFIG_EISA=3Dy=0A=
CONFIG_PCI=3Dy=0A=
CONFIG_ALPHA_EV5=3Dy=0A=
CONFIG_ALPHA_CIA=3Dy=0A=
# CONFIG_ALPHA_EV56 is not set=0A=
# CONFIG_ALPHA_SRM is not set=0A=
CONFIG_ALPHA_EISA=3Dy=0A=
# CONFIG_DISCONTIGMEM is not set=0A=
CONFIG_VERBOSE_MCHECK=3Dy=0A=
CONFIG_PCI_NAMES=3Dy=0A=
# CONFIG_HOTPLUG is not set=0A=
CONFIG_KCORE_ELF=3Dy=0A=
# CONFIG_KCORE_AOUT is not set=0A=
CONFIG_SRM_ENV=3Dm=0A=
CONFIG_BINFMT_AOUT=3Dm=0A=
# CONFIG_OSF4_COMPAT is not set=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_BINFMT_MISC=3Dm=0A=
CONFIG_BINFMT_EM86=3Dm=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
# CONFIG_PARPORT is not set=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
# CONFIG_MTD is not set=0A=
=0A=
#=0A=
# Plug and Play configuration=0A=
#=0A=
CONFIG_PNP=3Dy=0A=
# CONFIG_PNP_NAMES is not set=0A=
# CONFIG_PNP_DEBUG is not set=0A=
=0A=
#=0A=
# Protocols=0A=
#=0A=
# CONFIG_ISAPNP is not set=0A=
# CONFIG_PNPBIOS is not set=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
CONFIG_BLK_DEV_FD=3Dy=0A=
# CONFIG_BLK_DEV_XD is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_UMEM is not set=0A=
CONFIG_BLK_DEV_LOOP=3Dm=0A=
CONFIG_BLK_DEV_NBD=3Dm=0A=
# CONFIG_BLK_DEV_RAM is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
=0A=
#=0A=
# ATA/ATAPI/MFM/RLL support=0A=
#=0A=
# CONFIG_IDE is not set=0A=
=0A=
#=0A=
# SCSI support=0A=
#=0A=
CONFIG_SCSI=3Dy=0A=
=0A=
#=0A=
# SCSI support type (disk, tape, CD-ROM)=0A=
#=0A=
CONFIG_BLK_DEV_SD=3Dy=0A=
# CONFIG_CHR_DEV_ST is not set=0A=
# CONFIG_CHR_DEV_OSST is not set=0A=
CONFIG_BLK_DEV_SR=3Dm=0A=
CONFIG_BLK_DEV_SR_VENDOR=3Dy=0A=
CONFIG_CHR_DEV_SG=3Dm=0A=
=0A=
#=0A=
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs=0A=
#=0A=
# CONFIG_SCSI_MULTI_LUN is not set=0A=
# CONFIG_SCSI_REPORT_LUNS is not set=0A=
CONFIG_SCSI_CONSTANTS=3Dy=0A=
# CONFIG_SCSI_LOGGING is not set=0A=
=0A=
#=0A=
# SCSI low-level drivers=0A=
#=0A=
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set=0A=
# CONFIG_SCSI_7000FASST is not set=0A=
# CONFIG_SCSI_ACARD is not set=0A=
# CONFIG_SCSI_AHA152X is not set=0A=
# CONFIG_SCSI_AHA1542 is not set=0A=
# CONFIG_SCSI_AHA1740 is not set=0A=
# CONFIG_SCSI_AACRAID is not set=0A=
# CONFIG_SCSI_AIC7XXX is not set=0A=
# CONFIG_SCSI_AIC7XXX_OLD is not set=0A=
# CONFIG_SCSI_DPT_I2O is not set=0A=
# CONFIG_SCSI_ADVANSYS is not set=0A=
# CONFIG_SCSI_IN2000 is not set=0A=
# CONFIG_SCSI_AM53C974 is not set=0A=
# CONFIG_SCSI_MEGARAID is not set=0A=
# CONFIG_SCSI_BUSLOGIC is not set=0A=
# CONFIG_SCSI_CPQFCTS is not set=0A=
# CONFIG_SCSI_DMX3191D is not set=0A=
# CONFIG_SCSI_DTC3280 is not set=0A=
# CONFIG_SCSI_EATA is not set=0A=
# CONFIG_SCSI_EATA_DMA is not set=0A=
# CONFIG_SCSI_EATA_PIO is not set=0A=
# CONFIG_SCSI_FUTURE_DOMAIN is not set=0A=
# CONFIG_SCSI_GDTH is not set=0A=
# CONFIG_SCSI_GENERIC_NCR5380 is not set=0A=
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set=0A=
# CONFIG_SCSI_INITIO is not set=0A=
# CONFIG_SCSI_INIA100 is not set=0A=
# CONFIG_SCSI_NCR53C406A is not set=0A=
# CONFIG_SCSI_NCR53C7xx is not set=0A=
# CONFIG_SCSI_SYM53C8XX_2 is not set=0A=
CONFIG_SCSI_NCR53C8XX=3Dy=0A=
CONFIG_SCSI_SYM53C8XX=3Dy=0A=
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=3D8=0A=
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=3D32=0A=
CONFIG_SCSI_NCR53C8XX_SYNC=3D20=0A=
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set=0A=
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set=0A=
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set=0A=
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set=0A=
# CONFIG_SCSI_PAS16 is not set=0A=
# CONFIG_SCSI_PCI2000 is not set=0A=
# CONFIG_SCSI_PCI2220I is not set=0A=
# CONFIG_SCSI_PSI240I is not set=0A=
# CONFIG_SCSI_QLOGIC_FAS is not set=0A=
# CONFIG_SCSI_QLOGIC_ISP is not set=0A=
# CONFIG_SCSI_QLOGIC_FC is not set=0A=
# CONFIG_SCSI_QLOGIC_1280 is not set=0A=
# CONFIG_SCSI_SIM710 is not set=0A=
# CONFIG_SCSI_SYM53C416 is not set=0A=
# CONFIG_SCSI_DC390T is not set=0A=
# CONFIG_SCSI_T128 is not set=0A=
# CONFIG_SCSI_U14_34F is not set=0A=
# CONFIG_SCSI_NSP32 is not set=0A=
# CONFIG_SCSI_DEBUG is not set=0A=
=0A=
#=0A=
# Fusion MPT device support=0A=
#=0A=
# CONFIG_FUSION is not set=0A=
=0A=
#=0A=
# IEEE 1394 (FireWire) support (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IEEE1394 is not set=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
# CONFIG_PACKET_MMAP is not set=0A=
CONFIG_NETLINK_DEV=3Dy=0A=
CONFIG_NETFILTER=3Dy=0A=
# CONFIG_NETFILTER_DEBUG is not set=0A=
# CONFIG_FILTER is not set=0A=
CONFIG_UNIX=3Dy=0A=
CONFIG_NET_KEY=3Dm=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
# CONFIG_IP_PNP is not set=0A=
CONFIG_NET_IPIP=3Dm=0A=
CONFIG_NET_IPGRE=3Dm=0A=
# CONFIG_NET_IPGRE_BROADCAST is not set=0A=
# CONFIG_IP_MROUTE is not set=0A=
# CONFIG_ARPD is not set=0A=
CONFIG_INET_ECN=3Dy=0A=
# CONFIG_SYN_COOKIES is not set=0A=
CONFIG_INET_AH=3Dm=0A=
CONFIG_INET_ESP=3Dm=0A=
CONFIG_XFRM_USER=3Dm=0A=
=0A=
#=0A=
# IP: Netfilter Configuration=0A=
#=0A=
CONFIG_IP_NF_CONNTRACK=3Dm=0A=
CONFIG_IP_NF_FTP=3Dm=0A=
CONFIG_IP_NF_IRC=3Dm=0A=
CONFIG_IP_NF_QUEUE=3Dm=0A=
CONFIG_IP_NF_IPTABLES=3Dm=0A=
# CONFIG_IP_NF_MATCH_LIMIT is not set=0A=
# CONFIG_IP_NF_MATCH_MAC is not set=0A=
# CONFIG_IP_NF_MATCH_PKTTYPE is not set=0A=
# CONFIG_IP_NF_MATCH_MARK is not set=0A=
# CONFIG_IP_NF_MATCH_MULTIPORT is not set=0A=
# CONFIG_IP_NF_MATCH_TOS is not set=0A=
# CONFIG_IP_NF_MATCH_ECN is not set=0A=
# CONFIG_IP_NF_MATCH_DSCP is not set=0A=
# CONFIG_IP_NF_MATCH_AH_ESP is not set=0A=
# CONFIG_IP_NF_MATCH_LENGTH is not set=0A=
# CONFIG_IP_NF_MATCH_TTL is not set=0A=
# CONFIG_IP_NF_MATCH_TCPMSS is not set=0A=
# CONFIG_IP_NF_MATCH_HELPER is not set=0A=
# CONFIG_IP_NF_MATCH_STATE is not set=0A=
# CONFIG_IP_NF_MATCH_CONNTRACK is not set=0A=
# CONFIG_IP_NF_MATCH_UNCLEAN is not set=0A=
# CONFIG_IP_NF_MATCH_OWNER is not set=0A=
CONFIG_IP_NF_FILTER=3Dm=0A=
# CONFIG_IP_NF_TARGET_REJECT is not set=0A=
# CONFIG_IP_NF_TARGET_MIRROR is not set=0A=
CONFIG_IP_NF_NAT=3Dm=0A=
CONFIG_IP_NF_NAT_NEEDED=3Dy=0A=
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm=0A=
# CONFIG_IP_NF_TARGET_REDIRECT is not set=0A=
# CONFIG_IP_NF_NAT_LOCAL is not set=0A=
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set=0A=
CONFIG_IP_NF_NAT_IRC=3Dm=0A=
CONFIG_IP_NF_NAT_FTP=3Dm=0A=
# CONFIG_IP_NF_MANGLE is not set=0A=
# CONFIG_IP_NF_TARGET_LOG is not set=0A=
# CONFIG_IP_NF_TARGET_ULOG is not set=0A=
# CONFIG_IP_NF_TARGET_TCPMSS is not set=0A=
# CONFIG_IP_NF_ARPTABLES is not set=0A=
CONFIG_IP_NF_COMPAT_IPCHAINS=3Dy=0A=
CONFIG_IPV6=3Dm=0A=
=0A=
#=0A=
# IPv6: Netfilter Configuration=0A=
#=0A=
# CONFIG_IP6_NF_QUEUE is not set=0A=
# CONFIG_IP6_NF_IPTABLES is not set=0A=
=0A=
#=0A=
# SCTP Configuration (EXPERIMENTAL)=0A=
#=0A=
CONFIG_IPV6_SCTP__=3Dy=0A=
# CONFIG_IP_SCTP is not set=0A=
# CONFIG_ATM is not set=0A=
CONFIG_VLAN_8021Q=3Dm=0A=
# CONFIG_LLC is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_BRIDGE is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
# CONFIG_NET_FASTROUTE is not set=0A=
# CONFIG_NET_HW_FLOWCONTROL is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
=0A=
#=0A=
# Network device support=0A=
#=0A=
CONFIG_NETDEVICES=3Dy=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
CONFIG_DUMMY=3Dm=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
CONFIG_ETHERTAP=3Dm=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
# CONFIG_HAPPYMEAL is not set=0A=
# CONFIG_SUNGEM is not set=0A=
CONFIG_NET_VENDOR_3COM=3Dy=0A=
# CONFIG_EL1 is not set=0A=
# CONFIG_EL2 is not set=0A=
# CONFIG_ELPLUS is not set=0A=
# CONFIG_EL16 is not set=0A=
CONFIG_EL3=3Dm=0A=
# CONFIG_3C515 is not set=0A=
CONFIG_VORTEX=3Dm=0A=
# CONFIG_LANCE is not set=0A=
# CONFIG_NET_VENDOR_SMC is not set=0A=
# CONFIG_NET_VENDOR_RACAL is not set=0A=
=0A=
#=0A=
# Tulip family network device support=0A=
#=0A=
CONFIG_NET_TULIP=3Dy=0A=
CONFIG_DE2104X=3Dm=0A=
# CONFIG_TULIP is not set=0A=
# CONFIG_DE4X5 is not set=0A=
# CONFIG_WINBOND_840 is not set=0A=
# CONFIG_DM9102 is not set=0A=
# CONFIG_AT1700 is not set=0A=
# CONFIG_DEPCA is not set=0A=
# CONFIG_HP100 is not set=0A=
# CONFIG_NET_ISA is not set=0A=
# CONFIG_NET_PCI is not set=0A=
# CONFIG_NET_POCKET is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_DL2K is not set=0A=
# CONFIG_E1000 is not set=0A=
# CONFIG_NS83820 is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_TIGON3 is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
CONFIG_PPP=3Dm=0A=
# CONFIG_PPP_MULTILINK is not set=0A=
# CONFIG_PPP_ASYNC is not set=0A=
# CONFIG_PPP_SYNC_TTY is not set=0A=
# CONFIG_PPP_DEFLATE is not set=0A=
# CONFIG_PPP_BSDCOMP is not set=0A=
# CONFIG_PPPOE is not set=0A=
CONFIG_SLIP=3Dm=0A=
# CONFIG_SLIP_COMPRESSED is not set=0A=
# CONFIG_SLIP_SMART is not set=0A=
# CONFIG_SLIP_MODE_SLIP6 is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token Ring devices (depends on LLC=3Dy)=0A=
#=0A=
# CONFIG_NET_FC is not set=0A=
# CONFIG_RCPCI is not set=0A=
# CONFIG_SHAPER is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
=0A=
#=0A=
# Amateur Radio support=0A=
#=0A=
# CONFIG_HAMRADIO is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN_BOOL is not set=0A=
=0A=
#=0A=
# Old CD-ROM drivers (not SCSI, not IDE)=0A=
#=0A=
# CONFIG_CD_NO_IDESCSI is not set=0A=
=0A=
#=0A=
# Input device support=0A=
#=0A=
# CONFIG_INPUT is not set=0A=
=0A=
#=0A=
# Userland interfaces=0A=
#=0A=
=0A=
#=0A=
# Input I/O drivers=0A=
#=0A=
# CONFIG_GAMEPORT is not set=0A=
CONFIG_SOUND_GAMEPORT=3Dy=0A=
# CONFIG_SERIO is not set=0A=
=0A=
#=0A=
# Input Device Drivers=0A=
#=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
CONFIG_VT=3Dy=0A=
CONFIG_VT_CONSOLE=3Dy=0A=
CONFIG_HW_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
=0A=
#=0A=
# Serial drivers=0A=
#=0A=
CONFIG_SERIAL_8250=3Dm=0A=
# CONFIG_SERIAL_8250_EXTENDED is not set=0A=
=0A=
#=0A=
# Non-8250 serial port support=0A=
#=0A=
CONFIG_SERIAL_CORE=3Dm=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_UNIX98_PTY_COUNT=3D256=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# Mice=0A=
#=0A=
CONFIG_BUSMOUSE=3Dm=0A=
# CONFIG_QIC02_TAPE is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
# CONFIG_NVRAM is not set=0A=
CONFIG_RTC=3Dy=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_FTAPE is not set=0A=
# CONFIG_AGP is not set=0A=
# CONFIG_DRM is not set=0A=
# CONFIG_RAW_DRIVER is not set=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
# CONFIG_QUOTA is not set=0A=
CONFIG_AUTOFS_FS=3Dm=0A=
# CONFIG_AUTOFS4_FS is not set=0A=
# CONFIG_REISERFS_FS is not set=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
CONFIG_EXT3_FS=3Dm=0A=
CONFIG_EXT3_FS_XATTR=3Dy=0A=
# CONFIG_EXT3_FS_POSIX_ACL is not set=0A=
CONFIG_JBD=3Dy=0A=
# CONFIG_JBD_DEBUG is not set=0A=
CONFIG_FAT_FS=3Dm=0A=
CONFIG_MSDOS_FS=3Dm=0A=
CONFIG_VFAT_FS=3Dm=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_CRAMFS is not set=0A=
CONFIG_TMPFS=3Dy=0A=
CONFIG_RAMFS=3Dy=0A=
CONFIG_ISO9660_FS=3Dm=0A=
CONFIG_JOLIET=3Dy=0A=
CONFIG_ZISOFS=3Dy=0A=
# CONFIG_JFS_FS is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_VXFS_FS is not set=0A=
# CONFIG_NTFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
CONFIG_PROC_FS=3Dy=0A=
# CONFIG_DEVFS_FS is not set=0A=
CONFIG_DEVPTS_FS=3Dy=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
CONFIG_EXT2_FS=3Dy=0A=
# CONFIG_EXT2_FS_XATTR is not set=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UDF_FS is not set=0A=
# CONFIG_UFS_FS is not set=0A=
# CONFIG_XFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_INTERMEZZO_FS is not set=0A=
CONFIG_NFS_FS=3Dm=0A=
CONFIG_NFS_V3=3Dy=0A=
# CONFIG_NFS_V4 is not set=0A=
CONFIG_NFSD=3Dm=0A=
CONFIG_NFSD_V3=3Dy=0A=
# CONFIG_NFSD_V4 is not set=0A=
# CONFIG_NFSD_TCP is not set=0A=
CONFIG_SUNRPC=3Dm=0A=
CONFIG_LOCKD=3Dm=0A=
CONFIG_LOCKD_V4=3Dy=0A=
CONFIG_EXPORTFS=3Dm=0A=
# CONFIG_CIFS is not set=0A=
# CONFIG_SMB_FS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_AFS_FS is not set=0A=
CONFIG_ZISOFS_FS=3Dm=0A=
CONFIG_FS_MBCACHE=3Dy=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
# CONFIG_PARTITION_ADVANCED is not set=0A=
CONFIG_OSF_PARTITION=3Dy=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
CONFIG_NLS=3Dy=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
CONFIG_NLS_DEFAULT=3D"iso8859-1"=0A=
CONFIG_NLS_CODEPAGE_437=3Dy=0A=
# CONFIG_NLS_CODEPAGE_737 is not set=0A=
# CONFIG_NLS_CODEPAGE_775 is not set=0A=
# CONFIG_NLS_CODEPAGE_850 is not set=0A=
# CONFIG_NLS_CODEPAGE_852 is not set=0A=
# CONFIG_NLS_CODEPAGE_855 is not set=0A=
# CONFIG_NLS_CODEPAGE_857 is not set=0A=
# CONFIG_NLS_CODEPAGE_860 is not set=0A=
# CONFIG_NLS_CODEPAGE_861 is not set=0A=
# CONFIG_NLS_CODEPAGE_862 is not set=0A=
# CONFIG_NLS_CODEPAGE_863 is not set=0A=
# CONFIG_NLS_CODEPAGE_864 is not set=0A=
# CONFIG_NLS_CODEPAGE_865 is not set=0A=
# CONFIG_NLS_CODEPAGE_866 is not set=0A=
# CONFIG_NLS_CODEPAGE_869 is not set=0A=
# CONFIG_NLS_CODEPAGE_936 is not set=0A=
# CONFIG_NLS_CODEPAGE_950 is not set=0A=
# CONFIG_NLS_CODEPAGE_932 is not set=0A=
# CONFIG_NLS_CODEPAGE_949 is not set=0A=
# CONFIG_NLS_CODEPAGE_874 is not set=0A=
# CONFIG_NLS_ISO8859_8 is not set=0A=
# CONFIG_NLS_CODEPAGE_1250 is not set=0A=
# CONFIG_NLS_CODEPAGE_1251 is not set=0A=
# CONFIG_NLS_ISO8859_1 is not set=0A=
# CONFIG_NLS_ISO8859_2 is not set=0A=
# CONFIG_NLS_ISO8859_3 is not set=0A=
# CONFIG_NLS_ISO8859_4 is not set=0A=
# CONFIG_NLS_ISO8859_5 is not set=0A=
# CONFIG_NLS_ISO8859_6 is not set=0A=
# CONFIG_NLS_ISO8859_7 is not set=0A=
# CONFIG_NLS_ISO8859_9 is not set=0A=
# CONFIG_NLS_ISO8859_13 is not set=0A=
# CONFIG_NLS_ISO8859_14 is not set=0A=
# CONFIG_NLS_ISO8859_15 is not set=0A=
# CONFIG_NLS_KOI8_R is not set=0A=
# CONFIG_NLS_KOI8_U is not set=0A=
# CONFIG_NLS_UTF8 is not set=0A=
=0A=
#=0A=
# Console drivers=0A=
#=0A=
CONFIG_VGA_CONSOLE=3Dy=0A=
=0A=
#=0A=
# Frame-buffer support=0A=
#=0A=
# CONFIG_FB is not set=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
# CONFIG_SOUND is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
# CONFIG_USB is not set=0A=
=0A=
#=0A=
# Bluetooth support=0A=
#=0A=
# CONFIG_BT is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
CONFIG_ALPHA_LEGACY_START_ADDRESS=3Dy=0A=
CONFIG_DEBUG_KERNEL=3Dy=0A=
CONFIG_MATHEMU=3Dy=0A=
# CONFIG_DEBUG_SLAB is not set=0A=
CONFIG_MAGIC_SYSRQ=3Dy=0A=
# CONFIG_DEBUG_SPINLOCK is not set=0A=
# CONFIG_DEBUG_RWLOCK is not set=0A=
# CONFIG_DEBUG_SEMAPHORE is not set=0A=
=0A=
#=0A=
# Security options=0A=
#=0A=
CONFIG_SECURITY=3Dy=0A=
CONFIG_SECURITY_CAPABILITIES=3Dm=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
CONFIG_CRYPTO=3Dy=0A=
# CONFIG_CRYPTO_HMAC is not set=0A=
# CONFIG_CRYPTO_NULL is not set=0A=
# CONFIG_CRYPTO_MD4 is not set=0A=
# CONFIG_CRYPTO_MD5 is not set=0A=
# CONFIG_CRYPTO_SHA1 is not set=0A=
# CONFIG_CRYPTO_SHA256 is not set=0A=
# CONFIG_CRYPTO_DES is not set=0A=
# CONFIG_CRYPTO_BLOWFISH is not set=0A=
# CONFIG_CRYPTO_TEST is not set=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
CONFIG_CRC32=3Dm=0A=
CONFIG_ZLIB_INFLATE=3Dm=0A=

------=_NextPart_000_0042_01C29A53.0B4BB830--

