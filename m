Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbTIOXhj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 19:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbTIOXhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 19:37:37 -0400
Received: from ns.schottelius.org ([213.146.113.242]:13184 "HELO
	flapp.schottelius.org") by vger.kernel.org with SMTP
	id S261687AbTIOXec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 19:34:32 -0400
Date: Tue, 16 Sep 2003 01:32:01 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Nico Schottelius <nico-linux-admin-ml@schottelius.org>,
       Ross Clarke <encrypted@geekz.za.net>,
       Linux-Admin <linux-admin@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Crazy load average & unkillable processes
Message-ID: <20030915233201.GA289@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Nick Piggin <piggin@cyberone.com.au>,
	Nico Schottelius <nico-linux-admin-ml@schottelius.org>,
	Ross Clarke <encrypted@geekz.za.net>,
	Linux-Admin <linux-admin@vger.kernel.org>,
	linux-kernel@vger.kernel.org
References: <3F4D339A.8010907@geekz.za.net> <20030828085549.GB264@schottelius.org> <3F4DCC65.2010106@cyberone.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <3F4DCC65.2010106@cyberone.com.au>
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux flapp 2.6.0-test5
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Once again my system died.
first it gets slow.
then the cpu cooler starts to cool permanently.
then some processes die.
then the system becomes unusable.
i hit SAK, then sysrq+i. then reboot.
attached all available information.

anyone any idea?

Nico


Nick Piggin [Thu, Aug 28, 2003 at 07:33:25PM +1000]:
>=20
>=20
> Nico Schottelius wrote:
>=20
> >Very interesting..
> >with the test4 I experiene the same/similar problems on my laptop..
> >all of sudden yesterday several programs died -> Out of Memory.
> >I ran
> >  Xfree
> >  dhcpcd
> >  opera=20
> >  several xterms (about 6)
> >  qmail
> >  named
> >
> >first opera was Out of Memory, then died the whole X system with all
> >xterms and X beeing Out of Memory.
> >
> >MemTotal:       385600 kB
> >
> >which should be more than enough!
> >
>=20
> You might have a process with a memory leak. How much free memory do
> you have before everything dies? How much swapping activity is going
> on? What do /proc/meminfo and /proc/slabinfo say?
>=20
>=20
>=20

--=20
quote:   there are two time a day you should do nothing: before 12 and afte=
r 12
         (Nico Schottelius after writin' a very senseless email)
cmd:     echo God bless America | sed 's/.*\(A.*\)$/Why \1?/'
pgp:     new id: 0x8D0E27A4 | ftp.schottelius.org/pub/family/nico/pgp-key.n=
ew
url:     http://nerd-hosting.net - domains for nerds (from a nerd)

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="crazy-load.config"

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
CONFIG_BROKEN_ON_SMP=y

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

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
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
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_HPET_TIMER=y
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
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
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI_HT is not set
# CONFIG_ACPI is not set

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_PROC_INTF is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
# CONFIG_CPU_FREQ_24_API is not set
CONFIG_CPU_FREQ_TABLE=m

#
# CPUFreq processor drivers
#
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_ICH=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_SPEEDSTEP_LIB=m
# CONFIG_X86_P4_CLOCKMOD is not set
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
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_YENTA=m
CONFIG_CARDBUS=y
# CONFIG_I82092 is not set
# CONFIG_TCIC is not set

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
CONFIG_FW_LOADER=m

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
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_OTHER is not set
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
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
# CONFIG_PARIDE_PG is not set

#
# Parallel IDE protocol modules
#
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_BPCK6=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
# CONFIG_PARIDE_EPATC8 is not set
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
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
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
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
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
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
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
CONFIG_PCMCIA_AHA152X=m
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_PCMCIA_NINJA_SCSI=m
CONFIG_PCMCIA_QLOGIC=m

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
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=m
# CONFIG_IPV6_PRIVACY is not set
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_TUNNEL=m
# CONFIG_DECNET is not set
CONFIG_BRIDGE=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
# CONFIG_IP_NF_NAT_LOCAL is not set
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=m
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
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
# CONFIG_NET_CLS_POLICE is not set

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
CONFIG_EQUALIZER=m
CONFIG_TUN=m
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
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
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=m
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
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_AIRO is not set
CONFIG_HERMES=m
# CONFIG_PLX_HERMES is not set
# CONFIG_TMD_HERMES is not set
# CONFIG_PCI_HERMES is not set

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
CONFIG_PCMCIA_HERMES=m
CONFIG_AIRO_CS=m
CONFIG_PCMCIA_ATMEL=m
CONFIG_PCMCIA_WL3501=m
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
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_PCMCIA_AXNET=m

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
# CONFIG_IRDA_ULTRA is not set

#
# IrDA options
#
# CONFIG_IRDA_CACHE_LAST_LSAP is not set
# CONFIG_IRDA_FAST_RR is not set
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
# CONFIG_DONGLE is not set

#
# Old SIR device drivers
#
CONFIG_IRPORT_SIR=m

#
# Old Serial dongle support
#
# CONFIG_DONGLE_OLD is not set

#
# FIR device drivers
#
# CONFIG_USB_IRDA is not set
# CONFIG_TOSHIBA_OLD is not set
# CONFIG_TOSHIBA_FIR is not set
# CONFIG_VLSI_FIR is not set

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
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
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
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_SERIAL=m
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
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_CS=m
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
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
CONFIG_AGP_ALI=y
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
CONFIG_DRM_R128=y
# CONFIG_DRM_RADEON is not set
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
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=y
# CONFIG_XFS_RT is not set
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVFS_DEBUG=y
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
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_V4 is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=m
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
# CONFIG_SUNRPC_GSS is not set
# CONFIG_SMB_FS is not set
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
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
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
CONFIG_SND_INTEL8X0=m
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
CONFIG_USB=m
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
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m
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
# CONFIG_USB_AX8817X_STANDALONE is not set
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
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set

#
# Security options
#
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=m
CONFIG_SECURITY_ROOTPLUG=m
# CONFIG_SECURITY_SELINUX is not set

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
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="crazy-load.dmesg"

Linux version 2.6.0-test5 (root@flapp) (gcc version 3.3) #1 Wed Sep 10 01:06:13 CEST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ff0000 (usable)
 BIOS-e820: 0000000017ff0000 - 0000000017ff8000 (ACPI data)
 BIOS-e820: 0000000017ff8000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000f0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 0000000017ff0000 (usable)
 user: 0000000017ff0000 - 0000000017ff8000 (ACPI data)
 user: 0000000017ff8000 - 0000000018000000 (ACPI NVS)
 user: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98288
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 94192 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Building zonelist for node : 0
Kernel command line:  mem=393152K
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 647.031 MHz processor.
Console: colour VGA+ 80x25
Memory: 385496k/393152k available (2052k kernel code, 6900k reserved, 655k data, 112k init, 0k highmem)
Calibrating delay loop... 1273.85 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0387f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0387f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
apm: BIOS version 1.2 Flags 0x0f (Driver version 1.16ac)
ikconfig 0.6 with /proc/ikconfig
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x1
SGI XFS for Linux with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected ALi M???? chipset
agpgart: Maximum main memory to use for agp memory: 321M
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized r128 2.5.0 20030725 on minor 0
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:10.0
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x6050-0x6057, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x6058-0x605f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHR2020AT, ATA DISK drive
Using anticipatory scheduling io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITADVD-ROM SR-8175, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 112k freed
blk: queue d7d52a00, I/O limit 4095Mb (mask 0xffffffff)
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hda1, internal journal
Intel(R) PRO/100 Network Driver - version 2.3.18-k1
Copyright (c) 2003 Intel Corporation

PCI: Guessed IRQ 10 for device 0000:00:0a.0
e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Guessed IRQ 11 for device 0000:00:13.0
PCI: Sharing IRQ 11 with 0000:00:13.1
Yenta: CardBus bridge found at 0000:00:13.0 [1025:1010]
Yenta: ISA IRQ list 0638, PCI irq11
Socket status: 30000006
PCI: Guessed IRQ 11 for device 0000:00:13.1
PCI: Sharing IRQ 11 with 0000:00:13.0
Yenta: CardBus bridge found at 0000:00:13.1 [1025:1010]
Yenta: ISA IRQ list 0638, PCI irq11
Socket status: 30000006
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
e100: eth0 NIC Link is Up 100 Mbps Full duplex
PCI: Guessed IRQ 10 for device 0000:00:06.0
input: PS/2 Generic Mouse on isa0060/serio1
eth0: no IPv6 routers present
Process accounting paused
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
Out of Memory: Killed process 13793 (opera).
Out of Memory: Killed process 13792 (opera).

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="crazy-load.dmesg.afterKillAllTasks"
Content-Transfer-Encoding: quoted-printable

scall_call+0x7/0xb

bash          S 00000000 4010842336  1067   1066                     (NOTLB)
c5b1de80 00000086 c9ffc000 00000000 c5b1de68 00000037 6f63696e 616c6640=20
       7e3a7070 c5d166c0 7fffffff c5b1c000 bfffe95f c0124955 63656a6f 722f7=
374=20
       6e616d6c 72656761 322e302d c9202420 00000292 c0135775 c10aef10 00000=
246=20
Call Trace:
 [<c0124955>] schedule_timeout+0xb5/0xc0
 [<c0135775>] unlock_page+0x15/0x60
 [<c0245544>] read_chan+0x6d4/0x870
 [<c024584c>] write_chan+0x16c/0x230
 [<c0119030>] default_wake_function+0x0/0x30
 [<c0119030>] default_wake_function+0x0/0x30
 [<c023fdfd>] tty_write+0x17d/0x290
 [<c0244e70>] read_chan+0x0/0x870
 [<c023fc4d>] tty_read+0x11d/0x150
 [<c023fc80>] tty_write+0x0/0x290
 [<c0150e0c>] vfs_read+0xec/0x150
 [<c0127ccb>] sys_rt_sigprocmask+0xeb/0x170
 [<c01510c2>] sys_read+0x42/0x70
 [<c010937b>] syscall_call+0x7/0xb

xterm         S 00000000 3988309716  7236    219  7237    7321  1066 (NOTLB)
c472deb4 00000086 c034439c 00000000 000000d0 cd07a3a0 000000d0 d304f9c0=20
       00000246 00000000 7fffffff 00000005 00000005 c0124955 c0245a20 d53e0=
000=20
       d53e0920 c472df44 c5c0de60 00000010 00000004 00000004 c0241281 d53e0=
000=20
Call Trace:
 [<c0124955>] schedule_timeout+0xb5/0xc0
 [<c0245a20>] normal_poll+0x110/0x157
 [<c0241281>] tty_poll+0x61/0x80
 [<c016429f>] do_select+0x18f/0x2d0
 [<c0163f40>] __pollwait+0x0/0xd0
 [<c01646eb>] sys_select+0x2db/0x4e0
 [<c010937b>] syscall_call+0x7/0xb

bash          S 00000000 4269511568  7237   7236                     (NOTLB)
d64ede80 00000082 d5e7f000 00000000 d64ede68 00000029 6f63696e 616c6640=20
       7e3a7070 c5c0d660 7fffffff d64ec000 bfffe95f c0124955 372e332d 24203=
22e=20
       d64edf20 00000000 00000246 d5e7f000 00000292 c0135775 c120a918 00000=
246=20
Call Trace:
 [<c0124955>] schedule_timeout+0xb5/0xc0
 [<c0135775>] unlock_page+0x15/0x60
 [<c0245544>] read_chan+0x6d4/0x870
 [<c024584c>] write_chan+0x16c/0x230
 [<c0119030>] default_wake_function+0x0/0x30
 [<c0119030>] default_wake_function+0x0/0x30
 [<c023fdfd>] tty_write+0x17d/0x290
 [<c0244e70>] read_chan+0x0/0x870
 [<c023fc4d>] tty_read+0x11d/0x150
 [<c023fc80>] tty_write+0x0/0x290
 [<c0150e0c>] vfs_read+0xec/0x150
 [<c0127ccb>] sys_rt_sigprocmask+0xeb/0x170
 [<c01510c2>] sys_read+0x42/0x70
 [<c010937b>] syscall_call+0x7/0xb

xterm         S 00000000 4294153136  7321    219  7322    7419  7236 (NOTLB)
d42a3eb4 00000086 c034439c 00000000 000000d0 d42a3f2c 000000d0 d3346ba0=20
       00000246 00000000 7fffffff 00000005 00000005 c0124955 c0245a20 d33f1=
000=20
       d33f1920 d42a3f44 d33468a0 00000010 00000004 00000004 c0241281 d33f1=
000=20
Call Trace:
 [<c0124955>] schedule_timeout+0xb5/0xc0
 [<c0245a20>] normal_poll+0x110/0x157
 [<c0241281>] tty_poll+0x61/0x80
 [<c016429f>] do_select+0x18f/0x2d0
 [<c0163f40>] __pollwait+0x0/0xd0
 [<c01646eb>] sys_select+0x2db/0x4e0
 [<c010937b>] syscall_call+0x7/0xb

bash          S D4280000 4294012320  7322   7321 13300               (NOTLB)
d4281f50 00000086 d4281fc4 d4280000 00030002 00000001 00000001 d4281f58=20
       00000286 fffffe00 d4280000 d4368d1c d4368d1c c011f2e4 ffffffff 00000=
002=20
       c94a19c0 c011d6f6 d4280000 00000001 00000000 d4368c80 c0119030 00000=
000=20
Call Trace:
 [<c011f2e4>] sys_wait4+0x1e4/0x2c0
 [<c011d6f6>] session_of_pgrp+0x26/0xc0
 [<c0119030>] default_wake_function+0x0/0x30
 [<c0127ccb>] sys_rt_sigprocmask+0xeb/0x170
 [<c0119030>] default_wake_function+0x0/0x30
 [<c010937b>] syscall_call+0x7/0xb

xterm         R D7D0CA20 79096996  7419    219  7420   14378  7321 (NOTLB)
c7211dfc 00000082 c10f3548 d7d0ca20 c03443f0 00000001 c10f3548 c0344174=20
       0032687a c10f3548 c13c0b18 c7211e30 c7211e04 c0119fae c5c0d428 c0135=
8e5=20
       c10f3548 00000000 c26a0d80 c011a7c0 c7211e3c c7211e3c c784e220 00000=
001=20
Call Trace:
 [<c0119fae>] io_schedule+0xe/0x20
 [<c01358e5>] __lock_page+0xa5/0xd0
 [<c011a7c0>] autoremove_wake_function+0x0/0x50
 [<c011a7c0>] autoremove_wake_function+0x0/0x50
 [<c013593c>] find_get_page+0x2c/0x60
 [<c0136b41>] filemap_nopage+0x2d1/0x320
 [<c0143322>] do_no_page+0xd2/0x370
 [<c024679e>] pty_unthrottle+0x3e/0x60
 [<c01437c0>] handle_mm_fault+0xe0/0x180
 [<c01177ac>] do_page_fault+0x25c/0x479
 [<c01244d6>] update_process_times+0x46/0x60
 [<c0124346>] update_wall_time+0x16/0x40
 [<c01247b0>] do_timer+0xe0/0xf0
 [<c010b0ad>] do_IRQ+0xfd/0x130
 [<c0117550>] do_page_fault+0x0/0x479
 [<c0109525>] error_code+0x2d/0x38

bash          S 00000001 77198000  7420   7419 13279               (NOTLB)
c7041f50 00000086 c03a4b40 00000001 00030002 c7040000 cd889000 000033df=20
       ffffffe7 fffffe00 c7040000 c26a080c c26a080c c011f2e4 ffffffff 00000=
002=20
       c26a0160 c011d6f6 c7040000 00000001 00000000 c26a0770 c0119030 00000=
000=20
Call Trace:
 [<c011f2e4>] sys_wait4+0x1e4/0x2c0
 [<c011d6f6>] session_of_pgrp+0x26/0xc0
 [<c0119030>] default_wake_function+0x0/0x30
 [<c0127ccb>] sys_rt_sigprocmask+0xeb/0x170
 [<c0119030>] default_wake_function+0x0/0x30
 [<c010937b>] syscall_call+0x7/0xb

ssh           S C0139BDF 143726784 13279   7420                     (NOTLB)
cafb3eb4 00000082 c7172978 c0139bdf 00000000 c0163fcc 00000246 c6e47880=20
       00000246 00000000 7fffffff 00000005 00000005 c0124955 c0245a20 cd889=
000=20
       cd889920 cafb3f44 c68ae920 00000010 00000004 00000004 c0241281 cd889=
000=20
Call Trace:
 [<c0139bdf>] __get_free_pages+0x1f/0x50
 [<c0163fcc>] __pollwait+0x8c/0xd0
 [<c0124955>] schedule_timeout+0xb5/0xc0
 [<c0245a20>] normal_poll+0x110/0x157
 [<c0241281>] tty_poll+0x61/0x80
 [<c016429f>] do_select+0x18f/0x2d0
 [<c0163f40>] __pollwait+0x0/0xd0
 [<c01646eb>] sys_select+0x2db/0x4e0
 [<c0151035>] vfs_write+0x105/0x150
 [<c010937b>] syscall_call+0x7/0xb

mutt          S 00000000 206831712 13300   7322                     (NOTLB)
d59e3f08 00000082 00000fff 00000000 d59e3f1c 00000246 c03cb860 d59e3f1c=20
       00000000 05b2dac5 d59e3f1c d59e3f60 000927c1 c0124903 d59e3f1c 05b2d=
ac5=20
       d31c9000 c03d29b8 c03cc2c0 05b2dac5 4b87ad6e c0124890 c94a19c0 c03cb=
860=20
Call Trace:
 [<c0124903>] schedule_timeout+0x63/0xc0
 [<c0124890>] process_timeout+0x0/0x10
 [<c0164a3a>] do_poll+0xaa/0xd0
 [<c0164c09>] sys_poll+0x1a9/0x2c0
 [<c0163f40>] __pollwait+0x0/0xd0
 [<c010937b>] syscall_call+0x7/0xb

xterm         S 00000000 4022985104 14378    219 14379          7419 (NOTLB)
c4009eb4 00000082 c034439c 00000000 000000d0 c4009f2c 000000d0 c19a20c0=20
       00000246 00000000 7fffffff 00000005 00000005 c0124955 c0245a20 c1e04=
000=20
       c1e04920 c4009f44 c19a24c0 00000010 00000004 00000004 c0241281 c1e04=
000=20
Call Trace:
 [<c0124955>] schedule_timeout+0xb5/0xc0
 [<c0245a20>] normal_poll+0x110/0x157
 [<c0241281>] tty_poll+0x61/0x80
 [<c016429f>] do_select+0x18f/0x2d0
 [<c0163f40>] __pollwait+0x0/0xd0
 [<c01646eb>] sys_select+0x2db/0x4e0
 [<c010937b>] syscall_call+0x7/0xb

bash          S CF630000 4276240640 14379  14378 20147               (NOTLB)
cf631f50 00000086 cf631fc4 cf630000 00030002 00000001 00000001 cf631f58=20
       00000286 fffffe00 cf630000 d080b9bc d080b9bc c011f2e4 ffffffff 00000=
002=20
       c675e690 c011d6f6 cf630000 00000001 00000000 d080b920 c0119030 00000=
000=20
Call Trace:
 [<c011f2e4>] sys_wait4+0x1e4/0x2c0
 [<c011d6f6>] session_of_pgrp+0x26/0xc0
 [<c0119030>] default_wake_function+0x0/0x30
 [<c0127ccb>] sys_rt_sigprocmask+0xeb/0x170
 [<c0119030>] default_wake_function+0x0/0x30
 [<c010937b>] syscall_call+0x7/0xb

find          S D19CC000 139638944 14663      1  1488   21173   458 (NOTLB)
d19cdf50 00000086 d19cdfc4 d19cc000 00030002 00000001 00000001 d19cdf58=20
       00000286 fffffe00 d19cc000 c94a021c c94a021c c011f2e4 000005d0 00000=
000=20
       c26a1390 bfffe7f0 d19cc000 00000001 00000000 c94a0180 c0119030 00000=
000=20
Call Trace:
 [<c011f2e4>] sys_wait4+0x1e4/0x2c0
 [<c0119030>] default_wake_function+0x0/0x30
 [<c0118dae>] schedule+0x1ce/0x400
 [<c0119030>] default_wake_function+0x0/0x30
 [<c0107ad7>] sys_fork+0x37/0x40
 [<c010937b>] syscall_call+0x7/0xb

bash          S C0136AFE 4535188 20147  14379                     (NOTLB)
c6bb3e80 00000082 c1333678 c0136afe d7c37cdc 00000074 00000060 00000010=20
       00000000 d3346e20 7fffffff c6bb2000 bfffdbcf c0124955 00000025 00000=
000=20
       c01433fe 000000d0 00000074 00000000 c6bb3edc c6bb2000 c6bb2000 00000=
246=20
Call Trace:
 [<c0136afe>] filemap_nopage+0x28e/0x320
 [<c0124955>] schedule_timeout+0xb5/0xc0
 [<c01433fe>] do_no_page+0x1ae/0x370
 [<c0245544>] read_chan+0x6d4/0x870
 [<c01437c0>] handle_mm_fault+0xe0/0x180
 [<c0119030>] default_wake_function+0x0/0x30
 [<c0119030>] default_wake_function+0x0/0x30
 [<c023fdfd>] tty_write+0x17d/0x290
 [<c0244e70>] read_chan+0x0/0x870
 [<c023fc4d>] tty_read+0x11d/0x150
 [<c023fc80>] tty_write+0x0/0x290
 [<c0150e0c>] vfs_read+0xec/0x150
 [<c0127ccb>] sys_rt_sigprocmask+0xeb/0x170
 [<c01510c2>] sys_read+0x42/0x70
 [<c010937b>] syscall_call+0x7/0xb

login         S 00000003 272797816 21173      1 22891   25830 14663 (NOTLB)
d6b87f50 00000082 d6b87fc4 00000003 d6b87f88 d79bc000 0804d52f c015e557=20
       d79bc000 fffffe00 d6b86000 c675e11c c675e11c c011f2e4 ffffffff 00000=
000=20
       c26a19a0 d6b87f88 d6b86000 00000001 00000000 c675e080 c0119030 00000=
000=20
Call Trace:
 [<c015e557>] getname+0x97/0xd0
 [<c011f2e4>] sys_wait4+0x1e4/0x2c0
 [<c0119030>] default_wake_function+0x0/0x30
 [<c0119030>] default_wake_function+0x0/0x30
 [<c0107ad7>] sys_fork+0x37/0x40
 [<c010937b>] syscall_call+0x7/0xb

bash          S CE76A000 202145920 22891  21173 23753               (NOTLB)
ce76bf50 00000082 ce76bfc4 ce76a000 00030002 00000001 00000001 ce76bf58=20
       00000286 fffffe00 ce76a000 c26a1a3c c26a1a3c c011f2e4 ffffffff 00000=
002=20
       c675eca0 c011d6f6 ce76a000 00000001 00000000 c26a19a0 c0119030 00000=
000=20
Call Trace:
 [<c011f2e4>] sys_wait4+0x1e4/0x2c0
 [<c011d6f6>] session_of_pgrp+0x26/0xc0
 [<c0119030>] default_wake_function+0x0/0x30
 [<c0127ccb>] sys_rt_sigprocmask+0xeb/0x170
 [<c0119030>] default_wake_function+0x0/0x30
 [<c010937b>] syscall_call+0x7/0xb

mutt          R D7D0CA20 4224986496 23753  22891                     (NOTLB)
c24a3dfc 00000082 c11e4a38 d7d0ca20 c03443f0 00000001 c11e4a38 c0344174=20
       001e8fa3 c11e4a38 c13c0510 c24a3e30 c24a3e04 c0119fae c3f62f28 c0135=
8e5=20
       c11e4a38 00000000 c675eca0 c011a7c0 c24a3e3c c24a3e3c d7fc91a0 00000=
001=20
Call Trace:
 [<c0119fae>] io_schedule+0xe/0x20
 [<c01358e5>] __lock_page+0xa5/0xd0
 [<c011a7c0>] autoremove_wake_function+0x0/0x50
 [<c011a7c0>] autoremove_wake_function+0x0/0x50
 [<c013593c>] find_get_page+0x2c/0x60
 [<c0136b41>] filemap_nopage+0x2d1/0x320
 [<c0143322>] do_no_page+0xd2/0x370
 [<c01437c0>] handle_mm_fault+0xe0/0x180
 [<c01177ac>] do_page_fault+0x25c/0x479
 [<c01639ac>] vfs_readdir+0x9c/0xa0
 [<c0163cd0>] filldir64+0x0/0x110
 [<c0163e99>] sys_getdents64+0xb9/0xd1
 [<c0163cd0>] filldir64+0x0/0x110
 [<c0117550>] do_page_fault+0x0/0x479
 [<c0109525>] error_code+0x2d/0x38

agetty        S C0253055 4294957092 25830      1         26215 21173 (NOTLB)
d6a11e80 00000082 c03d29e8 c0253055 d7675c00 00000020 00000008 00000000=20
       00001000 c93734a0 7fffffff d6a10000 bffffd6b c0124955 d79218da 00000=
000=20
       00000286 ffffffff 00000008 00000008 d3e33000 d6a10000 d3e33000 00000=
246=20
Call Trace:
 [<c0253055>] do_con_write+0x295/0x760
 [<c0124955>] schedule_timeout+0xb5/0xc0
 [<c0245544>] read_chan+0x6d4/0x870
 [<c024584c>] write_chan+0x16c/0x230
 [<c0119030>] default_wake_function+0x0/0x30
 [<c0119030>] default_wake_function+0x0/0x30
 [<c023fdfd>] tty_write+0x17d/0x290
 [<c0244e70>] read_chan+0x0/0x870
 [<c023fc4d>] tty_read+0x11d/0x150
 [<c023fc80>] tty_write+0x0/0x290
 [<c0150e0c>] vfs_read+0xec/0x150
 [<c01510c2>] sys_read+0x42/0x70
 [<c010937b>] syscall_call+0x7/0xb

agetty        S C0253055 4294406276 26215      1               25830 (NOTLB)
d6b15e80 00000082 c03d29e8 c0253055 d7675800 00000020 00000008 00000000=20
       00001000 c9373aa0 7fffffff d6b14000 bffffd6b c0124955 d6b2fb5a 00000=
000=20
       00000286 ffffffff 00000008 00000008 d1b27000 d6b14000 d1b27000 00000=
246=20
Call Trace:
 [<c0253055>] do_con_write+0x295/0x760
 [<c0124955>] schedule_timeout+0xb5/0xc0
 [<c0245544>] read_chan+0x6d4/0x870
 [<c024584c>] write_chan+0x16c/0x230
 [<c0119030>] default_wake_function+0x0/0x30
 [<c0119030>] default_wake_function+0x0/0x30
 [<c023fdfd>] tty_write+0x17d/0x290
 [<c0244e70>] read_chan+0x0/0x870
 [<c023fc4d>] tty_read+0x11d/0x150
 [<c023fc80>] tty_write+0x0/0x290
 [<c0150e0c>] vfs_read+0xec/0x150
 [<c01510c2>] sys_read+0x42/0x70
 [<c010937b>] syscall_call+0x7/0xb

sh            R C0344174 4277855888  1488  14663                     (NOTLB)
c1651dfc 00000086 c13b1aa0 c0344174 000000f6 00000000 000000f5 c01399da=20
       c0344174 c11e4a10 c13c0988 c1651e30 c1651e04 c0119fae d3f70488 c0135=
8e5=20
       c11e4a10 00000000 c26a1390 c011a7c0 c1651e3c c1651e3c d7ab4b3c c013b=
a71=20
Call Trace:
 [<c01399da>] __alloc_pages+0x12a/0x310
 [<c0119fae>] io_schedule+0xe/0x20
 [<c01358e5>] __lock_page+0xa5/0xd0
 [<c011a7c0>] autoremove_wake_function+0x0/0x50
 [<c013ba71>] do_page_cache_readahead+0x101/0x180
 [<c011a7c0>] autoremove_wake_function+0x0/0x50
 [<c013593c>] find_get_page+0x2c/0x60
 [<c0136b41>] filemap_nopage+0x2d1/0x320
 [<c0143322>] do_no_page+0xd2/0x370
 [<c0289460>] dma_timer_expiry+0x0/0x80
 [<c01437c0>] handle_mm_fault+0xe0/0x180
 [<c01177ac>] do_page_fault+0x25c/0x479
 [<c01244d6>] update_process_times+0x46/0x60
 [<c0124346>] update_wall_time+0x16/0x40
 [<c01247b0>] do_timer+0xe0/0xf0
 [<c010b0ad>] do_IRQ+0xfd/0x130
 [<c0117550>] do_page_fault+0x0/0x479
 [<c0109525>] error_code+0x2d/0x38

cat           R C6158080 119445824  1489    148                     (NOTLB)
d79f5b60 00000086 c2ab28d0 c6158080 00000000 01728ae7 00000000 00000008=20
       00000008 cb11c250 c03cea88 d79f5b98 d79f5b68 c0119fae d7d23600 c0152=
52a=20
       cb11c250 c0153c13 00000000 d080a0e0 c011a7c0 d79f5ba4 d79f5ba4 00000=
010=20
Call Trace:
 [<c0119fae>] io_schedule+0xe/0x20
 [<c015252a>] __wait_on_buffer+0xda/0xe0
 [<c0153c13>] __find_get_block+0x73/0xf0
 [<c011a7c0>] autoremove_wake_function+0x0/0x50
 [<c0156397>] bio_alloc+0xd7/0x1c0
 [<c011a7c0>] autoremove_wake_function+0x0/0x50
 [<c0153a3d>] __bread_slow+0x4d/0xb0
 [<c0153d88>] __bread+0x38/0x40
 [<c018c6fc>] ext3_get_branch+0x6c/0xf0
 [<c018cdef>] ext3_get_block_handle+0x9f/0x320
 [<c026ea56>] generic_make_request+0x106/0x190
 [<c011a7c0>] autoremove_wake_function+0x0/0x50
 [<c02738df>] as_insert_request+0x8f/0x110
 [<c018d0c4>] ext3_get_block+0x54/0xa0
 [<c0172a35>] do_mpage_readpage+0x395/0x3b0
 [<c023032f>] radix_tree_node_alloc+0x1f/0x60
 [<c0230458>] radix_tree_extend+0x48/0x70
 [<c0230521>] radix_tree_insert+0xa1/0xc0
 [<c0135580>] add_to_page_cache+0x70/0x100
 [<c0172b9b>] mpage_readpages+0x14b/0x180
 [<c018d070>] ext3_get_block+0x0/0xa0
 [<c013b758>] read_pages+0x138/0x150
 [<c018d070>] ext3_get_block+0x0/0xa0
 [<c01399da>] __alloc_pages+0x12a/0x310
 [<c013ba71>] do_page_cache_readahead+0x101/0x180
 [<c0136990>] filemap_nopage+0x120/0x320
 [<c0143322>] do_no_page+0xd2/0x370
 [<c01437c0>] handle_mm_fault+0xe0/0x180
 [<c01177ac>] do_page_fault+0x25c/0x479
 [<c01244d6>] update_process_times+0x46/0x60
 [<c012461a>] run_timer_softirq+0x10a/0x1b0
 [<c01247b0>] do_timer+0xe0/0xf0
 [<c0118dae>] schedule+0x1ce/0x400
 [<c010b0ad>] do_IRQ+0xfd/0x130
 [<c0117550>] do_page_fault+0x0/0x479
 [<c0109525>] error_code+0x2d/0x38

SysRq : SAK
SAK: killed process 26215 (agetty): p->session=3D=3Dtty->session
SysRq : SAK
SysRq : Kill All Tasks

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="crazy-load.psax"
Content-Transfer-Encoding: quoted-printable

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1464  160 ?        S    Sep14   0:03 init
root         2  0.0  0.0     0    0 ?        SWN  Sep14   0:00 [ksoftirqd/0]
root         3  0.0  0.0     0    0 ?        SW<  Sep14   0:02 [events/0]
root         4  0.0  0.0     0    0 ?        SW<  Sep14   0:00 [kblockd/0]
root         5  0.0  0.0     0    0 ?        SW   Sep14   0:00 [kapmd]
root         6  0.0  0.0     0    0 ?        SW   Sep14   0:00 [pdflush]
root         7  0.0  0.0     0    0 ?        SW   Sep14   0:00 [pdflush]
root         8  0.0  0.0     0    0 ?        SW   Sep14   0:13 [kswapd0]
root         9  0.0  0.0     0    0 ?        SW<  Sep14   0:00 [aio/0]
root        10  0.0  0.0     0    0 ?        SW<  Sep14   0:00 [xfslogd/0]
root        11  0.0  0.0     0    0 ?        SW<  Sep14   0:00 [xfsdatad/0]
root        12  0.0  0.0     0    0 ?        SW   Sep14   0:00 [pagebufd]
root        13  0.0  0.0     0    0 ?        SW   Sep14   0:00 [kseriod]
root        14  0.0  0.0     0    0 ?        SW   Sep14   0:00 [kjournald]
root        35  0.0  0.0     0    0 ?        SW   Sep14   0:00 [pccardd]
root        37  0.0  0.0     0    0 ?        SW   Sep14   0:00 [pccardd]
root        56  0.0  0.0  1540  208 ?        S    Sep14   0:00 /sbin/syslogd
root        76  0.0  0.0  1528  164 ?        S    Sep14   0:00 /usr/sys/sbi=
n/gpm -m /dev/tts/0 -t mman -m /dev/misc/psaux -t ps2
root        94  0.0  0.3 10764 1412 ?        S    Sep14   0:00 /usr/net/sbi=
n/named
root        95  0.0  0.3 10764 1412 ?        S    Sep14   0:00 /usr/net/sbi=
n/named
root        97  0.0  0.3 10764 1412 ?        S    Sep14   0:00 /usr/net/sbi=
n/named
root        98  0.0  0.3 10764 1412 ?        S    Sep14   0:00 /usr/net/sbi=
n/named
root        99  0.0  0.3 10764 1412 ?        S    Sep14   0:00 /usr/net/sbi=
n/named
root       107  0.0  0.0  2608  136 ?        S    Sep14   0:00 /usr/openssh=
-3.6.1p1/sbin/sshd
root       113  0.0  0.1  4284  528 ?        S    Sep14   0:00 /usr/samba-3=
=2E0.0beta1/sbin/smbd
root       115  0.0  0.2  2904  832 ?        S    Sep14   0:00 /usr/samba-3=
=2E0.0beta1/sbin/nmbd
root       142  0.0  0.1  2088  444 vc/1     S    Sep14   0:00 login -- roo=
t    =20
root       146  0.0  0.0  1452   64 vc/5     S    Sep14   0:00 /sbin/agetty=
 vc/5 57600
root       147  0.0  0.0  1452   64 vc/6     S    Sep14   0:00 /sbin/agetty=
 vc/6 57600
root       148  0.0  0.2  2548  828 vc/1     S    Sep14   0:00 -bash
root       164  0.0  0.0  1460   60 ?        S    Sep14   0:00 dhcpcd
nico       204  0.0  0.0  2324  196 ?        S    Sep14   0:00 /bin/sh /usr=
/bin/startx
nico       216  0.0  0.0  2272   88 ?        S    Sep14   0:00 xinit /home/=
user/nico/.xinitrc --
root       217  0.9  5.4 32652 21204 ?       S    Sep14  15:11 X :0
nico       219  0.0  0.3  3648 1160 ?        S    Sep14   0:12 blackbox
nico       253  0.0  0.1  3132  428 ?        S    Sep14   0:07 aterm -trsb =
-tr -sh 100 -fg white -fade 50 -bw 0 +sb -sl 1000 -tint blue -ls -e ssh ns
root       256  0.0  0.2  5568  848 ?        S    Sep14   0:03 xterm -ls -e=
 ssh ns
nico       259  0.0  0.1  3104  680 pts/0    S    Sep14   0:13 ssh ns
nico       261  0.0  0.1  3104  644 pts/1    S    Sep14   0:02 ssh ns
nico       262  0.0  0.2  3316 1028 ?        S    Sep14   0:03 ssh -T -f -C=
 -N -L4242:mail.schottelius.org:110 ns.schottelius.org
nico       264  0.0  0.2  3132  880 ?        S    Sep14   0:03 ssh -T -f -C=
 -N -L2323:mail.folz.de:110 ns.schottelius.org
root       268  0.0  0.2  5544 1136 ?        S    Sep14   0:00 xterm -ls
nico       269  0.0  0.0  2572  336 pts/3    S    Sep14   0:00 -bash
qmails     458  0.0  0.0  1492   76 ?        S    Sep14   0:00 qmail-send
qmaill     459  0.0  0.0  1456   64 ?        S    Sep14   0:00 splogger qma=
il
root       460  0.0  0.0  1452   60 ?        S    Sep14   0:00 qmail-lspawn=
 ./Maildir/
qmailr     461  0.0  0.0  1448   60 ?        S    Sep14   0:00 qmail-rspawn
qmailq     462  0.0  0.0  1444   60 ?        S    Sep14   0:00 qmail-clean
nico       731  0.0  0.0  1520  328 pts/3    S    Sep15   0:01 pop3check
root      1066  0.0  0.3  5568 1168 ?        S    Sep15   0:04 xterm -ls
nico      1067  0.0  0.0  2588  352 pts/7    S    Sep15   0:00 -bash
root      7236  0.0  0.3  5572 1180 ?        S    Sep15   0:03 xterm -ls
nico      7237  0.0  0.0  2608  372 pts/6    S    Sep15   0:00 -bash
root      7321  0.0  0.1  5568  544 ?        S    Sep15   0:02 xterm -ls
nico      7322  0.0  0.0  2572  336 pts/2    S    Sep15   0:00 -bash
root      7419  0.0  0.3  5560 1360 ?        S    Sep15   0:01 xterm -ls
nico      7420  0.0  0.0  2600  364 pts/9    S    Sep15   0:00 -bash
nico     13279  0.0  0.1  3108  592 pts/9    S    Sep15   0:00 ssh l0g.de
nico     13300  0.0  0.5  5352 2020 pts/2    S    Sep15   0:03 mutt -f /hom=
e/user/nico/Maildir
root     14378  0.2  0.3  5560 1324 ?        S    00:53   0:02 xterm -ls
nico     14379  0.0  0.0  2572  336 pts/5    S    00:53   0:00 -bash
root     14663  4.6  0.0  2000  300 pts/5    S    00:58   0:45 find /usr/ -=
exec /root/scripts/remove.dead.links {} ;
root     20147  0.0  0.0  2540  304 pts/5    S    01:10   0:00 bash
root     21173  0.0  0.2  2088 1128 vc/2     S    01:13   0:00 login -- nic=
o    =20
nico     22891  0.2  0.3  2572 1432 vc/2     S    01:13   0:00 -bash
nico     23753  0.7  0.7  4732 2904 vc/2     S    01:14   0:00 mutt -f /hom=
e/user/nico/Maildir -f Maildir/computer/linux/kernel/
root     25830  0.0  0.1  1452  532 vc/4     S    01:14   0:00 /sbin/agetty=
 vc/4 57600
root     26215  0.0  0.1  1452  532 vc/3     S    01:14   0:00 /sbin/agetty=
 vc/3 57600
root     31572  0.0  0.2  2900  972 vc/1     R    01:15   0:00 ps axu
root     31606  0.0  0.1  2284  408 pts/5    R    01:15   0:00 /bin/sh /roo=
t/scripts/remove.dead.links /usr/share/games/quiz/greek

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="crazy-load.uname"

Linux flapp 2.6.0-test5 #1 Wed Sep 10 01:06:13 CEST 2003 i686 unknown unknown GNU/Linux

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="crazy-load.memory"

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-17feffff : System RAM
  00100000-0030103d : Kernel code
  0030103e-003a4f1f : Kernel data
17ff0000-17ff7fff : ACPI Tables
17ff8000-17ffffff : ACPI Non-volatile Storage
18000000-18000fff : 0000:00:13.0
  18000000-18000fff : yenta_socket
18001000-18001fff : 0000:00:13.1
  18001000-18001fff : yenta_socket
18400000-187fffff : PCI CardBus #02
18800000-18bfffff : PCI CardBus #02
18c00000-18ffffff : PCI CardBus #06
19000000-193fffff : PCI CardBus #06
80100000-80100fff : 0000:00:0a.0
  80100000-80100fff : e100
80200000-802fffff : 0000:00:0a.0
  80200000-802fffff : e100
80600000-820fffff : PCI Bus #01
  80600000-80600fff : 0000:01:00.0
  81000000-81ffffff : 0000:01:00.0
82200000-82200fff : 0000:00:06.0
82400000-82400fff : 0000:00:14.0
e0000000-e3ffffff : 0000:00:00.0
ffff0000-ffffffff : reserved
MemTotal:       385976 kB
MemFree:         49680 kB
Buffers:           404 kB
Cached:           4376 kB
SwapCached:          0 kB
Active:          44380 kB
Inactive:         1588 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       385976 kB
LowFree:         49680 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               8 kB
Writeback:           0 kB
Mapped:          43824 kB
Slab:             8108 kB
Committed_AS:    52744 kB
PageTables:        672 kB
VmallocTotal:   647148 kB
VmallocUsed:      1108 kB
VmallocChunk:   645924 kB

--vtzGhvizbBRQ85DL--

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ZkvxzGnTqo0OJ6QRAn4OAKC8Bkmqc3gu9Ourkflsw2Bh3VNwWACfUoJq
Ufhd8CGRYf8x/oRs6/IiDXo=
=kOmC
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
