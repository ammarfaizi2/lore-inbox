Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbWAISph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWAISph (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWAISph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:45:37 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:58346 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S1030241AbWAISpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:45:35 -0500
Date: Mon, 9 Jan 2006 10:45:29 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       dbrownell@users.sourceforge.net
Subject: Re: 2.6.15: usb storage device not detected
Message-ID: <20060109184529.GA3824@one-eyed-alien.net>
Mail-Followup-To: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net,
	dbrownell@users.sourceforge.net
References: <20060109130540.GB2035@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20060109130540.GB2035@zip.com.au>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2006 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Turn off CONFIG_BLK_DEV_UB

Matt

On Tue, Jan 10, 2006 at 12:05:50AM +1100, CaT wrote:
> Device works on two other linux boxes (an nvidia2 chipset and an intel
> bx laptop chipset) aswell as windows boxes without extra drivers.
>=20
> On this VIA based box:
>=20
> 0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.=
1 Controller (rev 80)
> 0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.=
1 Controller (rev 80)
> 0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.=
1 Controller (rev 80)
> 0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
>=20
> I get (from two inserts):
>=20
> kernel: [  111.330762] usb 1-5: new high speed USB device using ehci_hcd =
and address 3
> kernel: [  112.180267] ub(1.3): Stall at GetMaxLUN, using 1 LUN
> kernel: [  151.843141] usb 1-5: USB disconnect, address 3
> kernel: [  154.547011] usb 1-5: new high speed USB device using ehci_hcd =
and address 4
> kernel: [  155.395524] ub(1.4): Stall at GetMaxLUN, using 1 LUN
> kernel: [  177.073446] usb 1-5: USB disconnect, address 4
>=20
> and no device (I expect /dev/sda1).
>=20
> .config, dmesg and lspci -vv output for the usb bits attached.
>=20
> --=20
>     "To the extent that we overreact, we proffer the terrorists the
>     greatest tribute."
>     	- High Court Judge Michael Kirby

> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.15
> # Mon Jan  9 23:29:49 2006
> #
> CONFIG_X86_32=3Dy
> CONFIG_SEMAPHORE_SLEEPERS=3Dy
> CONFIG_X86=3Dy
> CONFIG_MMU=3Dy
> CONFIG_UID16=3Dy
> CONFIG_GENERIC_ISA_DMA=3Dy
> CONFIG_GENERIC_IOMAP=3Dy
> CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
>=20
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=3Dy
> CONFIG_CLEAN_COMPILE=3Dy
> CONFIG_BROKEN_ON_SMP=3Dy
> CONFIG_LOCK_KERNEL=3Dy
> CONFIG_INIT_ENV_ARG_LIMIT=3D32
>=20
> #
> # General setup
> #
> CONFIG_LOCALVERSION=3D""
> CONFIG_LOCALVERSION_AUTO=3Dy
> CONFIG_SWAP=3Dy
> CONFIG_SYSVIPC=3Dy
> CONFIG_POSIX_MQUEUE=3Dy
> # CONFIG_BSD_PROCESS_ACCT is not set
> CONFIG_SYSCTL=3Dy
> # CONFIG_AUDIT is not set
> CONFIG_HOTPLUG=3Dy
> CONFIG_KOBJECT_UEVENT=3Dy
> CONFIG_IKCONFIG=3Dy
> CONFIG_IKCONFIG_PROC=3Dy
> CONFIG_INITRAMFS_SOURCE=3D""
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=3Dy
> # CONFIG_KALLSYMS_ALL is not set
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> CONFIG_PRINTK=3Dy
> CONFIG_BUG=3Dy
> CONFIG_BASE_FULL=3Dy
> CONFIG_FUTEX=3Dy
> CONFIG_EPOLL=3Dy
> CONFIG_SHMEM=3Dy
> CONFIG_CC_ALIGN_FUNCTIONS=3D0
> CONFIG_CC_ALIGN_LABELS=3D0
> CONFIG_CC_ALIGN_LOOPS=3D0
> CONFIG_CC_ALIGN_JUMPS=3D0
> # CONFIG_TINY_SHMEM is not set
> CONFIG_BASE_SMALL=3D0
>=20
> #
> # Loadable module support
> #
> # CONFIG_MODULES is not set
>=20
> #
> # Block layer
> #
> CONFIG_LBD=3Dy
>=20
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=3Dy
> CONFIG_IOSCHED_AS=3Dy
> CONFIG_IOSCHED_DEADLINE=3Dy
> CONFIG_IOSCHED_CFQ=3Dy
> CONFIG_DEFAULT_AS=3Dy
> # CONFIG_DEFAULT_DEADLINE is not set
> # CONFIG_DEFAULT_CFQ is not set
> # CONFIG_DEFAULT_NOOP is not set
> CONFIG_DEFAULT_IOSCHED=3D"anticipatory"
>=20
> #
> # Processor type and features
> #
> CONFIG_X86_PC=3Dy
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
> CONFIG_MK7=3Dy
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MEFFICEON is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MGEODEGX1 is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_X86_GENERIC is not set
> CONFIG_X86_CMPXCHG=3Dy
> CONFIG_X86_XADD=3Dy
> CONFIG_X86_L1_CACHE_SHIFT=3D6
> CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
> CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> CONFIG_X86_WP_WORKS_OK=3Dy
> CONFIG_X86_INVLPG=3Dy
> CONFIG_X86_BSWAP=3Dy
> CONFIG_X86_POPAD_OK=3Dy
> CONFIG_X86_CMPXCHG64=3Dy
> CONFIG_X86_GOOD_APIC=3Dy
> CONFIG_X86_INTEL_USERCOPY=3Dy
> CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
> CONFIG_X86_USE_3DNOW=3Dy
> CONFIG_X86_TSC=3Dy
> CONFIG_HPET_TIMER=3Dy
> CONFIG_HPET_EMULATE_RTC=3Dy
> # CONFIG_SMP is not set
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=3Dy
> CONFIG_PREEMPT_BKL=3Dy
> CONFIG_X86_UP_APIC=3Dy
> CONFIG_X86_UP_IOAPIC=3Dy
> CONFIG_X86_LOCAL_APIC=3Dy
> CONFIG_X86_IO_APIC=3Dy
> CONFIG_X86_MCE=3Dy
> CONFIG_X86_MCE_NONFATAL=3Dy
> # CONFIG_X86_MCE_P4THERMAL is not set
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> # CONFIG_X86_REBOOTFIXUPS is not set
> # CONFIG_MICROCODE is not set
> # CONFIG_X86_MSR is not set
> # CONFIG_X86_CPUID is not set
>=20
> #
> # Firmware Drivers
> #
> # CONFIG_EDD is not set
> # CONFIG_DELL_RBU is not set
> # CONFIG_DCDBAS is not set
> CONFIG_NOHIGHMEM=3Dy
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> CONFIG_SELECT_MEMORY_MODEL=3Dy
> CONFIG_FLATMEM_MANUAL=3Dy
> # CONFIG_DISCONTIGMEM_MANUAL is not set
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=3Dy
> CONFIG_FLAT_NODE_MEM_MAP=3Dy
> # CONFIG_SPARSEMEM_STATIC is not set
> CONFIG_SPLIT_PTLOCK_CPUS=3D4
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=3Dy
> # CONFIG_EFI is not set
> # CONFIG_REGPARM is not set
> CONFIG_SECCOMP=3Dy
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> CONFIG_HZ_1000=3Dy
> CONFIG_HZ=3D1000
> CONFIG_PHYSICAL_START=3D0x100000
> # CONFIG_KEXEC is not set
>=20
> #
> # Power management options (ACPI, APM)
> #
> CONFIG_PM=3Dy
> CONFIG_PM_LEGACY=3Dy
> # CONFIG_PM_DEBUG is not set
> CONFIG_SOFTWARE_SUSPEND=3Dy
> CONFIG_PM_STD_PARTITION=3D"/dev/hda5"
> # CONFIG_SWSUSP_ENCRYPT is not set
>=20
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> CONFIG_ACPI=3Dy
> CONFIG_ACPI_SLEEP=3Dy
> CONFIG_ACPI_SLEEP_PROC_FS=3Dy
> # CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
> # CONFIG_ACPI_AC is not set
> # CONFIG_ACPI_BATTERY is not set
> CONFIG_ACPI_BUTTON=3Dy
> CONFIG_ACPI_VIDEO=3Dy
> # CONFIG_ACPI_HOTKEY is not set
> CONFIG_ACPI_FAN=3Dy
> CONFIG_ACPI_PROCESSOR=3Dy
> CONFIG_ACPI_THERMAL=3Dy
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_IBM is not set
> # CONFIG_ACPI_TOSHIBA is not set
> CONFIG_ACPI_BLACKLIST_YEAR=3D0
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_EC=3Dy
> CONFIG_ACPI_POWER=3Dy
> CONFIG_ACPI_SYSTEM=3Dy
> # CONFIG_X86_PM_TIMER is not set
> CONFIG_ACPI_CONTAINER=3Dy
>=20
> #
> # APM (Advanced Power Management) BIOS Support
> #
> # CONFIG_APM is not set
>=20
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
>=20
> #
> # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> #
> CONFIG_PCI=3Dy
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=3Dy
> CONFIG_PCI_BIOS=3Dy
> CONFIG_PCI_DIRECT=3Dy
> CONFIG_PCI_MMCONFIG=3Dy
> # CONFIG_PCIEPORTBUS is not set
> # CONFIG_PCI_MSI is not set
> CONFIG_PCI_LEGACY_PROC=3Dy
> # CONFIG_PCI_DEBUG is not set
> CONFIG_ISA_DMA_API=3Dy
> # CONFIG_ISA is not set
> # CONFIG_MCA is not set
> # CONFIG_SCx200 is not set
>=20
> #
> # PCCARD (PCMCIA/CardBus) support
> #
> # CONFIG_PCCARD is not set
>=20
> #
> # PCI Hotplug Support
> #
> # CONFIG_HOTPLUG_PCI is not set
>=20
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=3Dy
> # CONFIG_BINFMT_AOUT is not set
> # CONFIG_BINFMT_MISC is not set
>=20
> #
> # Networking
> #
> CONFIG_NET=3Dy
>=20
> #
> # Networking options
> #
> CONFIG_PACKET=3Dy
> CONFIG_PACKET_MMAP=3Dy
> CONFIG_UNIX=3Dy
> CONFIG_XFRM=3Dy
> # CONFIG_XFRM_USER is not set
> CONFIG_NET_KEY=3Dy
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> CONFIG_IP_ADVANCED_ROUTER=3Dy
> CONFIG_ASK_IP_FIB_HASH=3Dy
> # CONFIG_IP_FIB_TRIE is not set
> CONFIG_IP_FIB_HASH=3Dy
> CONFIG_IP_MULTIPLE_TABLES=3Dy
> CONFIG_IP_ROUTE_FWMARK=3Dy
> # CONFIG_IP_ROUTE_MULTIPATH is not set
> CONFIG_IP_ROUTE_VERBOSE=3Dy
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_ARPD is not set
> CONFIG_SYN_COOKIES=3Dy
> CONFIG_INET_AH=3Dy
> CONFIG_INET_ESP=3Dy
> CONFIG_INET_IPCOMP=3Dy
> CONFIG_INET_TUNNEL=3Dy
> CONFIG_INET_DIAG=3Dy
> CONFIG_INET_TCP_DIAG=3Dy
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_BIC=3Dy
>=20
> #
> # IP: Virtual Server Configuration
> #
> # CONFIG_IP_VS is not set
> # CONFIG_IPV6 is not set
> CONFIG_NETFILTER=3Dy
> # CONFIG_NETFILTER_DEBUG is not set
>=20
> #
> # Core Netfilter Configuration
> #
> # CONFIG_NETFILTER_NETLINK is not set
>=20
> #
> # IP: Netfilter Configuration
> #
> CONFIG_IP_NF_CONNTRACK=3Dy
> CONFIG_IP_NF_CT_ACCT=3Dy
> CONFIG_IP_NF_CONNTRACK_MARK=3Dy
> # CONFIG_IP_NF_CONNTRACK_EVENTS is not set
> # CONFIG_IP_NF_CT_PROTO_SCTP is not set
> CONFIG_IP_NF_FTP=3Dy
> CONFIG_IP_NF_IRC=3Dy
> # CONFIG_IP_NF_NETBIOS_NS is not set
> # CONFIG_IP_NF_TFTP is not set
> CONFIG_IP_NF_AMANDA=3Dy
> CONFIG_IP_NF_PPTP=3Dy
> CONFIG_IP_NF_QUEUE=3Dy
> CONFIG_IP_NF_IPTABLES=3Dy
> CONFIG_IP_NF_MATCH_LIMIT=3Dy
> CONFIG_IP_NF_MATCH_IPRANGE=3Dy
> CONFIG_IP_NF_MATCH_MAC=3Dy
> CONFIG_IP_NF_MATCH_PKTTYPE=3Dy
> CONFIG_IP_NF_MATCH_MARK=3Dy
> CONFIG_IP_NF_MATCH_MULTIPORT=3Dy
> CONFIG_IP_NF_MATCH_TOS=3Dy
> CONFIG_IP_NF_MATCH_RECENT=3Dy
> CONFIG_IP_NF_MATCH_ECN=3Dy
> CONFIG_IP_NF_MATCH_DSCP=3Dy
> CONFIG_IP_NF_MATCH_AH_ESP=3Dy
> CONFIG_IP_NF_MATCH_LENGTH=3Dy
> CONFIG_IP_NF_MATCH_TTL=3Dy
> CONFIG_IP_NF_MATCH_TCPMSS=3Dy
> CONFIG_IP_NF_MATCH_HELPER=3Dy
> CONFIG_IP_NF_MATCH_STATE=3Dy
> CONFIG_IP_NF_MATCH_CONNTRACK=3Dy
> CONFIG_IP_NF_MATCH_OWNER=3Dy
> CONFIG_IP_NF_MATCH_ADDRTYPE=3Dy
> CONFIG_IP_NF_MATCH_REALM=3Dy
> CONFIG_IP_NF_MATCH_SCTP=3Dy
> # CONFIG_IP_NF_MATCH_DCCP is not set
> CONFIG_IP_NF_MATCH_COMMENT=3Dy
> CONFIG_IP_NF_MATCH_CONNMARK=3Dy
> CONFIG_IP_NF_MATCH_CONNBYTES=3Dy
> CONFIG_IP_NF_MATCH_HASHLIMIT=3Dy
> CONFIG_IP_NF_MATCH_STRING=3Dy
> CONFIG_IP_NF_FILTER=3Dy
> CONFIG_IP_NF_TARGET_REJECT=3Dy
> CONFIG_IP_NF_TARGET_LOG=3Dy
> CONFIG_IP_NF_TARGET_ULOG=3Dy
> CONFIG_IP_NF_TARGET_TCPMSS=3Dy
> CONFIG_IP_NF_TARGET_NFQUEUE=3Dy
> CONFIG_IP_NF_NAT=3Dy
> CONFIG_IP_NF_NAT_NEEDED=3Dy
> CONFIG_IP_NF_TARGET_MASQUERADE=3Dy
> CONFIG_IP_NF_TARGET_REDIRECT=3Dy
> CONFIG_IP_NF_TARGET_NETMAP=3Dy
> CONFIG_IP_NF_TARGET_SAME=3Dy
> # CONFIG_IP_NF_NAT_SNMP_BASIC is not set
> CONFIG_IP_NF_NAT_IRC=3Dy
> CONFIG_IP_NF_NAT_FTP=3Dy
> CONFIG_IP_NF_NAT_AMANDA=3Dy
> CONFIG_IP_NF_NAT_PPTP=3Dy
> CONFIG_IP_NF_MANGLE=3Dy
> CONFIG_IP_NF_TARGET_TOS=3Dy
> CONFIG_IP_NF_TARGET_ECN=3Dy
> CONFIG_IP_NF_TARGET_DSCP=3Dy
> CONFIG_IP_NF_TARGET_MARK=3Dy
> CONFIG_IP_NF_TARGET_CLASSIFY=3Dy
> CONFIG_IP_NF_TARGET_TTL=3Dy
> CONFIG_IP_NF_TARGET_CONNMARK=3Dy
> # CONFIG_IP_NF_TARGET_CLUSTERIP is not set
> CONFIG_IP_NF_RAW=3Dy
> CONFIG_IP_NF_TARGET_NOTRACK=3Dy
> CONFIG_IP_NF_ARPTABLES=3Dy
> CONFIG_IP_NF_ARPFILTER=3Dy
> CONFIG_IP_NF_ARP_MANGLE=3Dy
>=20
> #
> # DCCP Configuration (EXPERIMENTAL)
> #
> # CONFIG_IP_DCCP is not set
>=20
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
>=20
> #
> # QoS and/or fair queueing
> #
> CONFIG_NET_SCHED=3Dy
> # CONFIG_NET_SCH_CLK_JIFFIES is not set
> # CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
> CONFIG_NET_SCH_CLK_CPU=3Dy
>=20
> #
> # Queueing/Scheduling
> #
> CONFIG_NET_SCH_CBQ=3Dy
> CONFIG_NET_SCH_HTB=3Dy
> CONFIG_NET_SCH_HFSC=3Dy
> CONFIG_NET_SCH_PRIO=3Dy
> CONFIG_NET_SCH_RED=3Dy
> CONFIG_NET_SCH_SFQ=3Dy
> CONFIG_NET_SCH_TEQL=3Dy
> CONFIG_NET_SCH_TBF=3Dy
> CONFIG_NET_SCH_GRED=3Dy
> CONFIG_NET_SCH_DSMARK=3Dy
> # CONFIG_NET_SCH_NETEM is not set
> CONFIG_NET_SCH_INGRESS=3Dy
>=20
> #
> # Classification
> #
> CONFIG_NET_CLS=3Dy
> # CONFIG_NET_CLS_BASIC is not set
> CONFIG_NET_CLS_TCINDEX=3Dy
> CONFIG_NET_CLS_ROUTE4=3Dy
> CONFIG_NET_CLS_ROUTE=3Dy
> CONFIG_NET_CLS_FW=3Dy
> CONFIG_NET_CLS_U32=3Dy
> CONFIG_CLS_U32_PERF=3Dy
> CONFIG_CLS_U32_MARK=3Dy
> CONFIG_NET_CLS_RSVP=3Dy
> # CONFIG_NET_CLS_RSVP6 is not set
> # CONFIG_NET_EMATCH is not set
> CONFIG_NET_CLS_ACT=3Dy
> CONFIG_NET_ACT_POLICE=3Dy
> CONFIG_NET_ACT_GACT=3Dy
> CONFIG_GACT_PROB=3Dy
> CONFIG_NET_ACT_MIRRED=3Dy
> CONFIG_NET_ACT_IPT=3Dy
> CONFIG_NET_ACT_PEDIT=3Dy
> # CONFIG_NET_ACT_SIMP is not set
> CONFIG_NET_CLS_IND=3Dy
> CONFIG_NET_ESTIMATOR=3Dy
>=20
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_HAMRADIO is not set
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> # CONFIG_IEEE80211 is not set
>=20
> #
> # Device Drivers
> #
>=20
> #
> # Generic Driver Options
> #
> CONFIG_STANDALONE=3Dy
> CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
> CONFIG_FW_LOADER=3Dy
> # CONFIG_DEBUG_DRIVER is not set
>=20
> #
> # Connector - unified userspace <-> kernelspace linker
> #
> # CONFIG_CONNECTOR is not set
>=20
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
>=20
> #
> # Parallel port support
> #
> CONFIG_PARPORT=3Dy
> CONFIG_PARPORT_PC=3Dy
> # CONFIG_PARPORT_SERIAL is not set
> CONFIG_PARPORT_PC_FIFO=3Dy
> CONFIG_PARPORT_PC_SUPERIO=3Dy
> # CONFIG_PARPORT_GSC is not set
> CONFIG_PARPORT_1284=3Dy
>=20
> #
> # Plug and Play support
> #
> CONFIG_PNP=3Dy
> # CONFIG_PNP_DEBUG is not set
>=20
> #
> # Protocols
> #
> CONFIG_PNPACPI=3Dy
>=20
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=3Dy
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_COW_COMMON is not set
> CONFIG_BLK_DEV_LOOP=3Dy
> CONFIG_BLK_DEV_CRYPTOLOOP=3Dy
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> CONFIG_BLK_DEV_UB=3Dy
> # CONFIG_BLK_DEV_RAM is not set
> CONFIG_BLK_DEV_RAM_COUNT=3D16
> CONFIG_CDROM_PKTCDVD=3Dy
> CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
> # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> # CONFIG_ATA_OVER_ETH is not set
>=20
> #
> # ATA/ATAPI/MFM/RLL support
> #
> CONFIG_IDE=3Dy
> CONFIG_BLK_DEV_IDE=3Dy
>=20
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_IDE_SATA is not set
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=3Dy
> CONFIG_IDEDISK_MULTI_MODE=3Dy
> CONFIG_BLK_DEV_IDECD=3Dy
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_BLK_DEV_IDESCSI is not set
> # CONFIG_IDE_TASK_IOCTL is not set
>=20
> #
> # IDE chipset support/bugfixes
> #
> # CONFIG_IDE_GENERIC is not set
> # CONFIG_BLK_DEV_CMD640 is not set
> # CONFIG_BLK_DEV_IDEPNP is not set
> CONFIG_BLK_DEV_IDEPCI=3Dy
> CONFIG_IDEPCI_SHARE_IRQ=3Dy
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_BLK_DEV_GENERIC is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=3Dy
> # CONFIG_IDEDMA_ONLYDISK is not set
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_ATIIXP is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_CS5535 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_SC1200 is not set
> # CONFIG_BLK_DEV_PIIX is not set
> # CONFIG_BLK_DEV_IT821X is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> CONFIG_BLK_DEV_VIA82CXXX=3Dy
> # CONFIG_IDE_ARM is not set
> CONFIG_BLK_DEV_IDEDMA=3Dy
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=3Dy
> # CONFIG_BLK_DEV_HD is not set
>=20
> #
> # SCSI device support
> #
> # CONFIG_RAID_ATTRS is not set
> CONFIG_SCSI=3Dy
> CONFIG_SCSI_PROC_FS=3Dy
>=20
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=3Dy
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_CHR_DEV_OSST is not set
> CONFIG_BLK_DEV_SR=3Dy
> # CONFIG_BLK_DEV_SR_VENDOR is not set
> CONFIG_CHR_DEV_SG=3Dy
> # CONFIG_CHR_DEV_SCH is not set
>=20
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> CONFIG_SCSI_MULTI_LUN=3Dy
> CONFIG_SCSI_CONSTANTS=3Dy
> # CONFIG_SCSI_LOGGING is not set
>=20
> #
> # SCSI Transport Attributes
> #
> # CONFIG_SCSI_SPI_ATTRS is not set
> # CONFIG_SCSI_FC_ATTRS is not set
> # CONFIG_SCSI_ISCSI_ATTRS is not set
> # CONFIG_SCSI_SAS_ATTRS is not set
>=20
> #
> # SCSI low-level drivers
> #
> # CONFIG_ISCSI_TCP is not set
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_MEGARAID_SAS is not set
> # CONFIG_SCSI_SATA is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_PPA is not set
> # CONFIG_SCSI_IMM is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> CONFIG_SCSI_QLA2XXX=3Dy
> # CONFIG_SCSI_QLA21XX is not set
> # CONFIG_SCSI_QLA22XX is not set
> # CONFIG_SCSI_QLA2300 is not set
> # CONFIG_SCSI_QLA2322 is not set
> # CONFIG_SCSI_QLA6312 is not set
> # CONFIG_SCSI_QLA24XX is not set
> # CONFIG_SCSI_LPFC is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
>=20
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
>=20
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
> # CONFIG_FUSION_SPI is not set
> # CONFIG_FUSION_FC is not set
> # CONFIG_FUSION_SAS is not set
>=20
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_IEEE1394 is not set
>=20
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
>=20
> #
> # Network device support
> #
> CONFIG_NETDEVICES=3Dy
> CONFIG_DUMMY=3Dy
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> # CONFIG_NET_SB1000 is not set
>=20
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
>=20
> #
> # PHY device support
> #
> # CONFIG_PHYLIB is not set
>=20
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=3Dy
> CONFIG_MII=3Dy
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NET_VENDOR_3COM is not set
>=20
> #
> # Tulip family network device support
> #
> CONFIG_NET_TULIP=3Dy
> # CONFIG_DE2104X is not set
> CONFIG_TULIP=3Dy
> # CONFIG_TULIP_MWI is not set
> # CONFIG_TULIP_MMIO is not set
> # CONFIG_TULIP_NAPI is not set
> # CONFIG_DE4X5 is not set
> # CONFIG_WINBOND_840 is not set
> # CONFIG_DM9102 is not set
> # CONFIG_ULI526X is not set
> # CONFIG_HP100 is not set
> CONFIG_NET_PCI=3Dy
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_B44 is not set
> # CONFIG_FORCEDETH is not set
> # CONFIG_DGRS is not set
> # CONFIG_EEPRO100 is not set
> CONFIG_E100=3Dy
> # CONFIG_FEALNX is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_8139CP is not set
> CONFIG_8139TOO=3Dy
> # CONFIG_8139TOO_PIO is not set
> # CONFIG_8139TOO_TUNE_TWISTER is not set
> # CONFIG_8139TOO_8129 is not set
> # CONFIG_8139_OLD_RX_RESET is not set
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_TLAN is not set
> CONFIG_VIA_RHINE=3Dy
> CONFIG_VIA_RHINE_MMIO=3Dy
> # CONFIG_NET_POCKET is not set
>=20
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
> # CONFIG_SIS190 is not set
> # CONFIG_SKGE is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_VIA_VELOCITY is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2 is not set
>=20
> #
> # Ethernet (10000 Mbit)
> #
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_IXGB is not set
> CONFIG_S2IO=3Dy
> # CONFIG_S2IO_NAPI is not set
>=20
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
>=20
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
>=20
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PLIP is not set
> CONFIG_PPP=3Dy
> # CONFIG_PPP_MULTILINK is not set
> CONFIG_PPP_FILTER=3Dy
> CONFIG_PPP_ASYNC=3Dy
> # CONFIG_PPP_SYNC_TTY is not set
> CONFIG_PPP_DEFLATE=3Dy
> CONFIG_PPP_BSDCOMP=3Dy
> CONFIG_PPP_MPPE=3Dy
> CONFIG_PPPOE=3Dy
> # CONFIG_SLIP is not set
> # CONFIG_NET_FC is not set
> # CONFIG_SHAPER is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_NETPOLL is not set
> # CONFIG_NET_POLL_CONTROLLER is not set
>=20
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
>=20
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
>=20
> #
> # Input device support
> #
> CONFIG_INPUT=3Dy
>=20
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=3Dy
> CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> CONFIG_INPUT_EVDEV=3Dy
> # CONFIG_INPUT_EVBUG is not set
>=20
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=3Dy
> CONFIG_KEYBOARD_ATKBD=3Dy
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=3Dy
> CONFIG_MOUSE_PS2=3Dy
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=3Dy
> CONFIG_INPUT_PCSPKR=3Dy
> # CONFIG_INPUT_WISTRON_BTNS is not set
> # CONFIG_INPUT_UINPUT is not set
>=20
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=3Dy
> CONFIG_SERIO_I8042=3Dy
> # CONFIG_SERIO_SERPORT is not set
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=3Dy
> # CONFIG_SERIO_RAW is not set
> # CONFIG_GAMEPORT is not set
>=20
> #
> # Character devices
> #
> CONFIG_VT=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_HW_CONSOLE=3Dy
> # CONFIG_SERIAL_NONSTANDARD is not set
>=20
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=3Dy
> # CONFIG_SERIAL_8250_CONSOLE is not set
> # CONFIG_SERIAL_8250_ACPI is not set
> CONFIG_SERIAL_8250_NR_UARTS=3D4
> # CONFIG_SERIAL_8250_EXTENDED is not set
>=20
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=3Dy
> # CONFIG_SERIAL_JSM is not set
> CONFIG_UNIX98_PTYS=3Dy
> CONFIG_LEGACY_PTYS=3Dy
> CONFIG_LEGACY_PTY_COUNT=3D256
> CONFIG_PRINTER=3Dy
> # CONFIG_LP_CONSOLE is not set
> # CONFIG_PPDEV is not set
> # CONFIG_TIPAR is not set
>=20
> #
> # IPMI
> #
> # CONFIG_IPMI_HANDLER is not set
>=20
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_HW_RANDOM is not set
> # CONFIG_NVRAM is not set
> CONFIG_RTC=3Dy
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
>=20
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> CONFIG_AGP=3Dy
> # CONFIG_AGP_ALI is not set
> # CONFIG_AGP_ATI is not set
> # CONFIG_AGP_AMD is not set
> # CONFIG_AGP_AMD64 is not set
> # CONFIG_AGP_INTEL is not set
> # CONFIG_AGP_NVIDIA is not set
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_SWORKS is not set
> CONFIG_AGP_VIA=3Dy
> # CONFIG_AGP_EFFICEON is not set
> CONFIG_DRM=3Dy
> # CONFIG_DRM_TDFX is not set
> # CONFIG_DRM_R128 is not set
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_MGA is not set
> # CONFIG_DRM_SIS is not set
> # CONFIG_DRM_VIA is not set
> # CONFIG_DRM_SAVAGE is not set
> # CONFIG_MWAVE is not set
> # CONFIG_RAW_DRIVER is not set
> # CONFIG_HPET is not set
> # CONFIG_HANGCHECK_TIMER is not set
>=20
> #
> # TPM devices
> #
> # CONFIG_TCG_TPM is not set
> # CONFIG_TELCLOCK is not set
>=20
> #
> # I2C support
> #
> # CONFIG_I2C is not set
>=20
> #
> # Dallas's 1-wire bus
> #
> # CONFIG_W1 is not set
>=20
> #
> # Hardware Monitoring support
> #
> # CONFIG_HWMON is not set
> # CONFIG_HWMON_VID is not set
>=20
> #
> # Misc devices
> #
> # CONFIG_IBM_ASM is not set
>=20
> #
> # Multimedia Capabilities Port drivers
> #
>=20
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
>=20
> #
> # Digital Video Broadcasting Devices
> #
> # CONFIG_DVB is not set
>=20
> #
> # Graphics support
> #
> # CONFIG_FB is not set
> # CONFIG_VIDEO_SELECT is not set
>=20
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=3Dy
> CONFIG_DUMMY_CONSOLE=3Dy
>=20
> #
> # Sound
> #
> CONFIG_SOUND=3Dy
>=20
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=3Dy
> CONFIG_SND_AC97_CODEC=3Dy
> CONFIG_SND_AC97_BUS=3Dy
> CONFIG_SND_TIMER=3Dy
> CONFIG_SND_PCM=3Dy
> CONFIG_SND_RAWMIDI=3Dy
> CONFIG_SND_SEQUENCER=3Dy
> # CONFIG_SND_SEQ_DUMMY is not set
> CONFIG_SND_OSSEMUL=3Dy
> CONFIG_SND_MIXER_OSS=3Dy
> CONFIG_SND_PCM_OSS=3Dy
> CONFIG_SND_SEQUENCER_OSS=3Dy
> CONFIG_SND_RTCTIMER=3Dy
> CONFIG_SND_SEQ_RTCTIMER_DEFAULT=3Dy
> # CONFIG_SND_VERBOSE_PRINTK is not set
> # CONFIG_SND_DEBUG is not set
>=20
> #
> # Generic devices
> #
> CONFIG_SND_MPU401_UART=3Dy
> # CONFIG_SND_DUMMY is not set
> # CONFIG_SND_VIRMIDI is not set
> # CONFIG_SND_MTPAV is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> # CONFIG_SND_MPU401 is not set
>=20
> #
> # PCI devices
> #
> # CONFIG_SND_ALI5451 is not set
> # CONFIG_SND_ATIIXP is not set
> # CONFIG_SND_ATIIXP_MODEM is not set
> # CONFIG_SND_AU8810 is not set
> # CONFIG_SND_AU8820 is not set
> # CONFIG_SND_AU8830 is not set
> # CONFIG_SND_AZT3328 is not set
> # CONFIG_SND_BT87X is not set
> # CONFIG_SND_CS46XX is not set
> # CONFIG_SND_CS4281 is not set
> # CONFIG_SND_EMU10K1 is not set
> # CONFIG_SND_EMU10K1X is not set
> # CONFIG_SND_CA0106 is not set
> # CONFIG_SND_KORG1212 is not set
> # CONFIG_SND_MIXART is not set
> # CONFIG_SND_NM256 is not set
> # CONFIG_SND_RME32 is not set
> # CONFIG_SND_RME96 is not set
> # CONFIG_SND_RME9652 is not set
> # CONFIG_SND_HDSP is not set
> # CONFIG_SND_HDSPM is not set
> # CONFIG_SND_TRIDENT is not set
> # CONFIG_SND_YMFPCI is not set
> # CONFIG_SND_AD1889 is not set
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
> CONFIG_SND_VIA82XX=3Dy
> # CONFIG_SND_VIA82XX_MODEM is not set
> # CONFIG_SND_VX222 is not set
> # CONFIG_SND_HDA_INTEL is not set
>=20
> #
> # USB devices
> #
> # CONFIG_SND_USB_AUDIO is not set
> # CONFIG_SND_USB_USX2Y is not set
>=20
> #
> # Open Sound System
> #
> # CONFIG_SOUND_PRIME is not set
>=20
> #
> # USB support
> #
> CONFIG_USB_ARCH_HAS_HCD=3Dy
> CONFIG_USB_ARCH_HAS_OHCI=3Dy
> CONFIG_USB=3Dy
> # CONFIG_USB_DEBUG is not set
>=20
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEVICEFS=3Dy
> # CONFIG_USB_BANDWIDTH is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> # CONFIG_USB_SUSPEND is not set
> # CONFIG_USB_OTG is not set
>=20
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_EHCI_HCD=3Dy
> # CONFIG_USB_EHCI_SPLIT_ISO is not set
> CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
> # CONFIG_USB_ISP116X_HCD is not set
> # CONFIG_USB_OHCI_HCD is not set
> CONFIG_USB_UHCI_HCD=3Dy
> # CONFIG_USB_SL811_HCD is not set
>=20
> #
> # USB Device Class drivers
> #
> # CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
> # CONFIG_USB_ACM is not set
> CONFIG_USB_PRINTER=3Dy
>=20
> #
> # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
> #
>=20
> #
> # may also be needed; see USB_STORAGE Help for more information
> #
> CONFIG_USB_STORAGE=3Dy
> # CONFIG_USB_STORAGE_DEBUG is not set
> CONFIG_USB_STORAGE_DATAFAB=3Dy
> CONFIG_USB_STORAGE_FREECOM=3Dy
> CONFIG_USB_STORAGE_ISD200=3Dy
> CONFIG_USB_STORAGE_DPCM=3Dy
> CONFIG_USB_STORAGE_USBAT=3Dy
> CONFIG_USB_STORAGE_SDDR09=3Dy
> CONFIG_USB_STORAGE_SDDR55=3Dy
> CONFIG_USB_STORAGE_JUMPSHOT=3Dy
>=20
> #
> # USB Input Devices
> #
> CONFIG_USB_HID=3Dy
> CONFIG_USB_HIDINPUT=3Dy
> # CONFIG_HID_FF is not set
> CONFIG_USB_HIDDEV=3Dy
> # CONFIG_USB_AIPTEK is not set
> # CONFIG_USB_WACOM is not set
> # CONFIG_USB_ACECAD is not set
> # CONFIG_USB_KBTAB is not set
> # CONFIG_USB_POWERMATE is not set
> # CONFIG_USB_MTOUCH is not set
> # CONFIG_USB_ITMTOUCH is not set
> # CONFIG_USB_EGALAX is not set
> # CONFIG_USB_YEALINK is not set
> # CONFIG_USB_XPAD is not set
> # CONFIG_USB_ATI_REMOTE is not set
> # CONFIG_USB_KEYSPAN_REMOTE is not set
> # CONFIG_USB_APPLETOUCH is not set
>=20
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_MICROTEK is not set
>=20
> #
> # USB Multimedia devices
> #
> # CONFIG_USB_DABUSB is not set
>=20
> #
> # Video4Linux support is needed for USB Multimedia device support
> #
>=20
> #
> # USB Network Adapters
> #
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> # CONFIG_USB_USBNET is not set
> CONFIG_USB_MON=3Dy
>=20
> #
> # USB port drivers
> #
> # CONFIG_USB_USS720 is not set
>=20
> #
> # USB Serial Converter support
> #
> # CONFIG_USB_SERIAL is not set
>=20
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI62 is not set
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_AUERSWALD is not set
> # CONFIG_USB_RIO500 is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_LED is not set
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_PHIDGETKIT is not set
> # CONFIG_USB_PHIDGETSERVO is not set
> # CONFIG_USB_IDMOUSE is not set
> # CONFIG_USB_SISUSBVGA is not set
> # CONFIG_USB_LD is not set
> # CONFIG_USB_TEST is not set
>=20
> #
> # USB DSL modem support
> #
>=20
> #
> # USB Gadget Support
> #
> # CONFIG_USB_GADGET is not set
>=20
> #
> # MMC/SD Card support
> #
> # CONFIG_MMC is not set
>=20
> #
> # InfiniBand support
> #
> # CONFIG_INFINIBAND is not set
>=20
> #
> # SN Devices
> #
>=20
> #
> # File systems
> #
> CONFIG_EXT2_FS=3Dy
> CONFIG_EXT2_FS_XATTR=3Dy
> CONFIG_EXT2_FS_POSIX_ACL=3Dy
> CONFIG_EXT2_FS_SECURITY=3Dy
> # CONFIG_EXT2_FS_XIP is not set
> CONFIG_EXT3_FS=3Dy
> CONFIG_EXT3_FS_XATTR=3Dy
> CONFIG_EXT3_FS_POSIX_ACL=3Dy
> CONFIG_EXT3_FS_SECURITY=3Dy
> CONFIG_JBD=3Dy
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FS_MBCACHE=3Dy
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> CONFIG_FS_POSIX_ACL=3Dy
> # CONFIG_XFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_INOTIFY=3Dy
> # CONFIG_QUOTA is not set
> CONFIG_DNOTIFY=3Dy
> # CONFIG_AUTOFS_FS is not set
> CONFIG_AUTOFS4_FS=3Dy
> # CONFIG_FUSE_FS is not set
>=20
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=3Dy
> CONFIG_JOLIET=3Dy
> CONFIG_ZISOFS=3Dy
> CONFIG_ZISOFS_FS=3Dy
> CONFIG_UDF_FS=3Dy
> CONFIG_UDF_NLS=3Dy
>=20
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=3Dy
> CONFIG_MSDOS_FS=3Dy
> CONFIG_VFAT_FS=3Dy
> CONFIG_FAT_DEFAULT_CODEPAGE=3D437
> CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
> # CONFIG_NTFS_FS is not set
>=20
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=3Dy
> CONFIG_PROC_KCORE=3Dy
> CONFIG_SYSFS=3Dy
> CONFIG_TMPFS=3Dy
> # CONFIG_HUGETLBFS is not set
> # CONFIG_HUGETLB_PAGE is not set
> CONFIG_RAMFS=3Dy
> # CONFIG_RELAYFS_FS is not set
>=20
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
> # CONFIG_UFS_FS is not set
>=20
> #
> # Network File Systems
> #
> # CONFIG_NFS_FS is not set
> # CONFIG_NFSD is not set
> CONFIG_SMB_FS=3Dy
> # CONFIG_SMB_NLS_DEFAULT is not set
> CONFIG_CIFS=3Dy
> CONFIG_CIFS_STATS=3Dy
> # CONFIG_CIFS_STATS2 is not set
> CONFIG_CIFS_XATTR=3Dy
> CONFIG_CIFS_POSIX=3Dy
> # CONFIG_CIFS_EXPERIMENTAL is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
>=20
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=3Dy
>=20
> #
> # Native Language Support
> #
> CONFIG_NLS=3Dy
> CONFIG_NLS_DEFAULT=3D"iso8859-1"
> CONFIG_NLS_CODEPAGE_437=3Dy
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> CONFIG_NLS_CODEPAGE_850=3Dy
> CONFIG_NLS_CODEPAGE_852=3Dy
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
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> # CONFIG_NLS_ASCII is not set
> CONFIG_NLS_ISO8859_1=3Dy
> CONFIG_NLS_ISO8859_2=3Dy
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> CONFIG_NLS_ISO8859_15=3Dy
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_UTF8 is not set
>=20
> #
> # Instrumentation Support
> #
> # CONFIG_PROFILING is not set
> # CONFIG_KPROBES is not set
>=20
> #
> # Kernel hacking
> #
> CONFIG_PRINTK_TIME=3Dy
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_MAGIC_SYSRQ=3Dy
> CONFIG_LOG_BUF_SHIFT=3D14
> # CONFIG_DETECT_SOFTLOCKUP is not set
> # CONFIG_SCHEDSTATS is not set
> # CONFIG_DEBUG_SLAB is not set
> CONFIG_DEBUG_PREEMPT=3Dy
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> # CONFIG_DEBUG_INFO is not set
> # CONFIG_DEBUG_FS is not set
> # CONFIG_DEBUG_VM is not set
> CONFIG_FRAME_POINTER=3Dy
> # CONFIG_RCU_TORTURE_TEST is not set
> CONFIG_EARLY_PRINTK=3Dy
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
>=20
> #
> # Page alloc debug is incompatible with Software Suspend on i386
> #
> CONFIG_4KSTACKS=3Dy
> CONFIG_X86_FIND_SMP_CONFIG=3Dy
> CONFIG_X86_MPPARSE=3Dy
>=20
> #
> # Security options
> #
> # CONFIG_KEYS is not set
> # CONFIG_SECURITY is not set
>=20
> #
> # Cryptographic options
> #
> CONFIG_CRYPTO=3Dy
> CONFIG_CRYPTO_HMAC=3Dy
> # CONFIG_CRYPTO_NULL is not set
> CONFIG_CRYPTO_MD4=3Dy
> CONFIG_CRYPTO_MD5=3Dy
> CONFIG_CRYPTO_SHA1=3Dy
> CONFIG_CRYPTO_SHA256=3Dy
> CONFIG_CRYPTO_SHA512=3Dy
> CONFIG_CRYPTO_WP512=3Dy
> CONFIG_CRYPTO_TGR192=3Dy
> CONFIG_CRYPTO_DES=3Dy
> CONFIG_CRYPTO_BLOWFISH=3Dy
> CONFIG_CRYPTO_TWOFISH=3Dy
> CONFIG_CRYPTO_SERPENT=3Dy
> CONFIG_CRYPTO_AES_586=3Dy
> CONFIG_CRYPTO_CAST5=3Dy
> CONFIG_CRYPTO_CAST6=3Dy
> CONFIG_CRYPTO_TEA=3Dy
> CONFIG_CRYPTO_ARC4=3Dy
> CONFIG_CRYPTO_KHAZAD=3Dy
> CONFIG_CRYPTO_ANUBIS=3Dy
> CONFIG_CRYPTO_DEFLATE=3Dy
> CONFIG_CRYPTO_MICHAEL_MIC=3Dy
> CONFIG_CRYPTO_CRC32C=3Dy
> # CONFIG_CRYPTO_TEST is not set
>=20
> #
> # Hardware crypto devices
> #
> # CONFIG_CRYPTO_DEV_PADLOCK is not set
>=20
> #
> # Library routines
> #
> CONFIG_CRC_CCITT=3Dy
> CONFIG_CRC16=3Dy
> CONFIG_CRC32=3Dy
> CONFIG_LIBCRC32C=3Dy
> CONFIG_ZLIB_INFLATE=3Dy
> CONFIG_ZLIB_DEFLATE=3Dy
> CONFIG_TEXTSEARCH=3Dy
> CONFIG_TEXTSEARCH_KMP=3Dy
> CONFIG_TEXTSEARCH_BM=3Dy
> CONFIG_TEXTSEARCH_FSM=3Dy
> CONFIG_GENERIC_HARDIRQS=3Dy
> CONFIG_GENERIC_IRQ_PROBE=3Dy
> CONFIG_X86_BIOS_REBOOT=3Dy

> 0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.=
1 Controller (rev 80) (prog-if 00 [UHCI])
> 	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
> 	Latency: 32, Cache Line Size: 0x08 (32 bytes)
> 	Interrupt: pin A routed to IRQ 19
> 	Region 4: I/O ports at d800 [size=3D32]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D=
3cold+)
> 		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.=
1 Controller (rev 80) (prog-if 00 [UHCI])
> 	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
> 	Latency: 32, Cache Line Size: 0x08 (32 bytes)
> 	Interrupt: pin B routed to IRQ 19
> 	Region 4: I/O ports at dc00 [size=3D32]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D=
3cold+)
> 		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.=
1 Controller (rev 80) (prog-if 00 [UHCI])
> 	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
> 	Latency: 32, Cache Line Size: 0x08 (32 bytes)
> 	Interrupt: pin C routed to IRQ 19
> 	Region 4: I/O ports at e000 [size=3D32]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D=
3cold+)
> 		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (pro=
g-if 20 [EHCI])
> 	Subsystem: VIA Technologies, Inc. USB 2.0
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
> 	Latency: 32, Cache Line Size: 0x10 (64 bytes)
> 	Interrupt: pin D routed to IRQ 19
> 	Region 0: Memory at eb002000 (32-bit, non-prefetchable) [size=3D256]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D=
3cold+)
> 		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

> [4294667.296000] CPU 0 irqstacks, hard=3Dc058b000 soft=3Dc058a000
> [4294667.296000] PID hash table entries: 1024 (order: 10, 16384 bytes)
> [    0.000000] Detected 1493.921 MHz processor.
> [   11.886345] Using tsc for high-res timesource
> [   11.887345] Console: colour VGA+ 80x25
> [   11.888932] Dentry cache hash table entries: 32768 (order: 5, 131072 b=
ytes)
> [   11.889189] Inode-cache hash table entries: 16384 (order: 4, 65536 byt=
es)
> [   11.897885] Memory: 238160k/245696k available (3326k kernel code, 7048=
k reserved, 1084k data, 212k init, 0k highmem)
> [   11.897944] Checking if this processor honours the WP bit even in supe=
rvisor mode... Ok.
> [   11.957330] Calibrating delay using timer specific routine.. 2991.85 B=
ogoMIPS (lpj=3D1495927)
> [   11.957462] Mount-cache hash table entries: 512
> [   11.957638] CPU: After generic identify, caps: 0383fbff c1cbfbff 00000=
000 00000000 00000000 00000000 00000000
> [   11.957648] CPU: After vendor identify, caps: 0383fbff c1cbfbff 000000=
00 00000000 00000000 00000000 00000000
> [   11.957658] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 byte=
s/line)
> [   11.957704] CPU: L2 Cache: 256K (64 bytes/line)
> [   11.957746] CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 000=
00020 00000000 00000000 00000000
> [   11.957754] Intel machine check architecture supported.
> [   11.957797] Intel machine check reporting enabled on CPU#0.
> [   11.957852] mtrr: v2.0 (20020519)
> [   11.957894] CPU: AMD Sempron(tm)   2200+ stepping 01
> [   11.957996] Enabling fast FPU save and restore... done.
> [   11.958067] Enabling unmasked SIMD FPU exception support... done.
> [   11.958141] Checking 'hlt' instruction... OK.
> [   11.989662] ENABLING IO-APIC IRQs
> [   11.990018] ..TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=
=3D-1
> [   12.101695] NET: Registered protocol family 16
> [   12.101766] ACPI: bus type pci registered
> [   12.105603] PCI: PCI BIOS revision 2.10 entry at 0xfb9e0, last bus=3D1
> [   12.105654] PCI: Using configuration type 1
> [   12.106235] ACPI: Subsystem revision 20050902
> [   12.118665] ACPI: Interpreter enabled
> [   12.118719] ACPI: Using IOAPIC for interrupt routing
> [   12.119641] ACPI: PCI Root Bridge [PCI0] (0000:00)
> [   12.119685] PCI: Probing PCI hardware (bus 00)
> [   12.119848] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
> [   12.123303] PCI quirk: region 0400-047f claimed by vt8235 PM
> [   12.123349] PCI quirk: region 5000-500f claimed by vt8235 SMB
> [   12.123571] Boot video device is 0000:01:00.0
> [   12.123618] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> [   12.163920] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 *10 11 12)
> [   12.164686] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 *11 12)
> [   12.165465] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 11 12) *5
> [   12.166265] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 10 *11 12)
> [   12.166960] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12) *0=
, disabled.
> [   12.167728] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12) *0=
, disabled.
> [   12.168494] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 6 7 10 11 12) *0=
, disabled.
> [   12.169264] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 6 7 10 11 12) *0=
, disabled.
> [   12.170222] ACPI: PCI Interrupt Link [ALKA] (IRQs *20), disabled.
> [   12.170988] ACPI: PCI Interrupt Link [ALKB] (IRQs *21)
> [   12.171583] ACPI: PCI Interrupt Link [ALKC] (IRQs *22)
> [   12.172259] ACPI: PCI Interrupt Link [ALKD] (IRQs *23), disabled.
> [   12.176275] Linux Plug and Play Support v0.97 (c) Adam Belay
> [   12.176330] pnp: PnP ACPI init
> [   12.182083] pnp: PnP ACPI: found 13 devices
> [   12.182331] SCSI subsystem initialized
> [   12.182418] usbcore: registered new driver usbfs
> [   12.182494] usbcore: registered new driver hub
> [   12.182611] PCI: Using ACPI for IRQ routing
> [   12.182656] PCI: If a device doesn't work, try "pci=3Drouteirq".  If i=
t helps, post a report
> [   12.303063] TC classifier action (bugs to netdev@vger.kernel.org cc ha=
di@cyberus.ca)
> [   12.303600] pnp: 00:01: ioport range 0x400-0x47f could not be reserved
> [   12.303647] pnp: 00:01: ioport range 0x5000-0x500f has been reserved
> [   12.303954] PCI: Bridge: 0000:00:01.0
> [   12.303995]   IO window: disabled.
> [   12.304039]   MEM window: e8000000-e9ffffff
> [   12.304097]   PREFETCH window: e4000000-e7ffffff
> [   12.304156] PCI: Setting latency timer of device 0000:00:01.0 to 64
> [   12.304237] Machine check exception polling timer started.
> [   12.306335] Initializing Cryptographic API
> [   12.306398] io scheduler noop registered
> [   12.306474] io scheduler anticipatory registered
> [   12.306548] io scheduler deadline registered
> [   12.306628] io scheduler cfq registered
> [   12.306818] ACPI: Power Button (FF) [PWRF]
> [   12.306871] ACPI: Power Button (CM) [PWRB]
> [   12.306921] ACPI: Sleep Button (CM) [SLPB]
> [   12.307002] ACPI: Fan [FAN] (on)
> [   12.307263] ACPI: CPU0 (power states: C1[C1] C2[C2])
> [   12.312592] ACPI: Thermal Zone [THRM] (55 C)
> [   12.328389] lp: driver loaded but no devices found
> [   12.328521] Real Time Clock Driver v1.12
> [   12.328564] Linux agpgart interface v0.101 (c) Dave Jones
> [   12.328649] agpgart: Detected VIA KM400/KM400A chipset
> [   12.333504] agpgart: AGP aperture is 64M @ 0xe0000000
> [   12.333596] [drm] Initialized drm 1.0.0 20040925
> [   12.333761] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
> [   12.333806] PNP: PS/2 controller doesn't have AUX irq; using default 12
> [   12.334057] serio: i8042 AUX port at 0x60,0x64 irq 12
> [   12.334151] serio: i8042 KBD port at 0x60,0x64 irq 1
> [   12.334235] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ s=
haring disabled
> [   12.334394] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
> [   12.334614] serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
> [   12.335156] 00:08: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
> [   12.335392] 00:09: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
> [   12.335838] parport: PnPBIOS parport detected.
> [   12.335970] parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,T=
RISTATE,COMPAT,EPP,ECP,DMA]
> [   12.419029] lp0: using parport0 (interrupt-driven).
> [   12.419221] Floppy drive(s): fd0 is 1.44M
> [   12.433753] FDC 0 is a post-1991 82077
> [   12.435014] loop: loaded (max 8 devices)
> [   12.435090] pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and=
 petero2@telia.com
> [   12.435169] usbcore: registered new driver ub
> [   12.435213] e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
> [   12.435256] e100: Copyright(c) 1999-2005 Intel Corporation
> [   12.435418] PPP generic driver version 2.4.2
> [   12.435491] PPP Deflate Compression module registered
> [   12.435535] PPP BSD Compression module registered
> [   12.435580] PPP MPPE Compression module registered
> [   12.435623] NET: Registered protocol family 24
> [   12.435807] Linux Tulip driver version 1.1.13 (May 11, 2002)
> [   12.435873] ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 16 (level, low)=
 -> IRQ 16
> [   12.436366] tulip0:  MII transceiver #1 config 1000 status 786d advert=
ising 05e1.
> [   12.436783] tulip0:  MII transceiver #2 config 1000 status 786d advert=
ising 05e1.
> [   12.437213] tulip0:  MII transceiver #3 config 1000 status 786d advert=
ising 05e1.
> [   12.437629] tulip0:  MII transceiver #4 config 1000 status 786d advert=
ising 05e1.
> [   12.437730] eth0: ADMtek Comet rev 17 at 0001d000, 00:04:E2:38:2F:1E, =
IRQ 16.
> [   12.438004] ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 17 (level, low)=
 -> IRQ 17
> [   12.455247] tulip1:  EEPROM default media type Autosense.
> [   12.455291] tulip1:  Index #0 - Media MII (#11) described by a 21140 M=
II PHY (1) block.
> [   12.457055] tulip1:  MII transceiver #3 config 3100 status 7809 advert=
ising 01e1.
> [   12.461376] eth1: Digital DS21140 Tulip rev 32 at 0001d400, 00:00:C0:8=
7:35:F8, IRQ 17.
> [   12.461640] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> [   12.461686] ide: Assuming 33MHz system bus speed for PIO modes; overri=
de with idebus=3Dxx
> [   12.461780] VP_IDE: IDE controller at PCI slot 0000:00:11.1
> [   12.462126] ACPI: PCI Interrupt Link [ALKA] disabled and referenced, B=
IOS bug.
> [   12.462314] ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
> [   12.462359] ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [ALKA] -> GSI =
20 (level, low) -> IRQ 18
> [   12.462478] PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 2
> [   12.462543] VP_IDE: chipset revision 6
> [   12.462584] VP_IDE: not 100% native mode: will probe irqs later
> [   12.462636] VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0=
000:00:11.1
> [   12.462693]     ide0: BM-DMA at 0xe400-0xe407, BIOS settings: hda:DMA,=
 hdb:pio
> [   12.462815]     ide1: BM-DMA at 0xe408-0xe40f, BIOS settings: hdc:pio,=
 hdd:DMA
> [   12.462948] Probing IDE interface ide0...
> [   12.848726] hda: ST380011A, ATA DISK drive
> [   13.460828] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> [   13.461551] Probing IDE interface ide1...
> [   14.509428] hdd: LITE-ON COMBO SOHC-5232K, ATAPI CD/DVD-ROM drive
> [   14.560789] ide1 at 0x170-0x177,0x376 on irq 15
> [   14.561025] hda: max request size: 1024KiB
> [   14.561521] hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=3D1=
6383/255/63, UDMA(100)
> [   14.561835] hda: cache flushes supported
> [   14.561936]  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
> [   14.594923] hdd: ATAPI 52X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(3=
3)
> [   14.595177] Uniform CD-ROM driver Revision: 3.20
> [   14.598779] usbmon: debugfs is not available
> [   14.599367] ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 21
> [   14.599417] ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [ALKB] -> GSI =
21 (level, low) -> IRQ 19
> [   14.599537] PCI: Via IRQ fixup for 0000:00:10.3, from 11 to 3
> [   14.599611] ehci_hcd 0000:00:10.3: EHCI Host Controller
> [   14.599784] ehci_hcd 0000:00:10.3: new USB bus registered, assigned bu=
s number 1
> [   14.599849] ehci_hcd 0000:00:10.3: irq 19, io mem 0xeb002000
> [   14.599898] ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver =
10 Dec 2004
> [   14.600085] hub 1-0:1.0: USB hub found
> [   14.600141] hub 1-0:1.0: 6 ports detected
> [   14.700254] USB Universal Host Controller Interface driver v2.3
> [   14.700363] ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [ALKB] -> GSI =
21 (level, low) -> IRQ 19
> [   14.700477] PCI: Via IRQ fixup for 0000:00:10.0, from 10 to 3
> [   14.700543] uhci_hcd 0000:00:10.0: UHCI Host Controller
> [   14.700634] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bu=
s number 2
> [   14.700688] uhci_hcd 0000:00:10.0: irq 19, io base 0x0000d800
> [   14.700888] hub 2-0:1.0: USB hub found
> [   14.700941] hub 2-0:1.0: 2 ports detected
> [   14.801177] ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [ALKB] -> GSI =
21 (level, low) -> IRQ 19
> [   14.801291] PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 3
> [   14.801353] uhci_hcd 0000:00:10.1: UHCI Host Controller
> [   14.801447] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bu=
s number 3
> [   14.801501] uhci_hcd 0000:00:10.1: irq 19, io base 0x0000dc00
> [   14.801703] hub 3-0:1.0: USB hub found
> [   14.801754] hub 3-0:1.0: 2 ports detected
> [   14.902099] ACPI: PCI Interrupt 0000:00:10.2[C] -> Link [ALKB] -> GSI =
21 (level, low) -> IRQ 19
> [   14.902213] PCI: Via IRQ fixup for 0000:00:10.2, from 5 to 3
> [   14.902276] uhci_hcd 0000:00:10.2: UHCI Host Controller
> [   14.902365] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bu=
s number 4
> [   14.902419] uhci_hcd 0000:00:10.2: irq 19, io base 0x0000e000
> [   14.902618] hub 4-0:1.0: USB hub found
> [   14.902669] hub 4-0:1.0: 2 ports detected
> [   15.164833] usb 2-2: new low speed USB device using uhci_hcd and addre=
ss 2
> [   15.328567] usbcore: registered new driver usblp
> [   15.328611] drivers/usb/class/usblp.c: v0.13: USB Printer Device Class=
 driver
> [   15.328656] Initializing USB Mass Storage driver...
> [   15.535590] usbcore: registered new driver usb-storage
> [   15.535633] USB Mass Storage support registered.
> [   15.743411] usbcore: registered new driver hiddev
> [   15.764226] input: Logitech USB Optical Mouse as /class/input/input0
> [   15.764277] input: USB HID v1.10 Mouse [Logitech USB Optical Mouse] on=
 usb-0000:00:10.0-2
> [   15.764405] usbcore: registered new driver usbhid
> [   15.764448] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
> [   15.764581] mice: PS/2 mouse device common for all mice
> [   15.764780] input: PC Speaker as /class/input/input1
> [   15.764886] Advanced Linux Sound Architecture Driver Version 1.0.10rc3=
 (Mon Nov 07 13:30:21 2005 UTC).
> [   15.765619] ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
> [   15.765670] ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [ALKC] -> GSI =
22 (level, low) -> IRQ 20
> [   15.765789] PCI: Via IRQ fixup for 0000:00:11.5, from 5 to 4
> [   15.765983] PCI: Setting latency timer of device 0000:00:11.5 to 64
> [   15.822292] input: AT Translated Set 2 keyboard as /class/input/input2
> [   16.276395] codec_read: codec 0 is not valid [0xfe0000]
> [   16.282640] codec_read: codec 0 is not valid [0xfe0000]
> [   16.288929] codec_read: codec 0 is not valid [0xfe0000]
> [   16.295217] codec_read: codec 0 is not valid [0xfe0000]
> [   16.307943] ALSA device list:
> [   16.307990]   #0: VIA 8235 with AD1980 at 0xe800, irq 20
> [   16.308082] GACT probability on
> [   16.308122] Mirror/redirect action on
> [   16.308238] u32 classifier
> [   16.308277]     Perfomance counters on
> [   16.308317]     input device check on=20
> [   16.308357]     Actions configured=20
> [   16.308421] NET: Registered protocol family 2
> [   16.318009] IP route cache hash table entries: 2048 (order: 1, 8192 by=
tes)
> [   16.318236] TCP established hash table entries: 8192 (order: 3, 32768 =
bytes)
> [   16.318359] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
> [   16.318476] TCP: Hash tables configured (established 8192 bind 8192)
> [   16.318520] TCP reno registered
> [   16.318631] ip_conntrack version 2.4 (1919 buckets, 15352 max) - 232 b=
ytes per conntrack
> [   16.341978] ip_conntrack_pptp version 3.1 loaded
> [   16.342030] ip_nat_pptp version 3.0 loaded
> [   16.342075] ip_tables: (C) 2000-2002 Netfilter core team
> [   16.389884] ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  ht=
tp://snowman.net/projects/ipt_recent/
> [   16.389953] arp_tables: (C) 2002 David S. Miller
> [   16.398879] TCP bic registered
> [   16.398923] NET: Registered protocol family 1
> [   16.398969] NET: Registered protocol family 17
> [   16.399013] NET: Registered protocol family 15
> [   16.399064] Using IPI Shortcut mode
> [   16.408861] ACPI wakeup devices:=20
> [   16.408903] SLPB PCI0 USB0 USB1 USB2 USB6 USB7 USB8 USB9 LAN0 MC97 UAR=
1 ECP1=20
> [   16.409330] ACPI: (supports S0 S1 S3 S4 S5)
> [   16.421504] EXT3-fs: mounted filesystem with ordered data mode.
> [   16.421563] VFS: Mounted root (ext3 filesystem) readonly.
> [   16.421964] Freeing unused kernel memory: 212k freed
> [   16.422076] kjournald starting.  Commit interval 5 seconds
> [   17.416834] Adding 530104k swap on /dev/hda5.  Priority:-1 extents:1 a=
cross:530104k
> [   17.482462] EXT3 FS on hda2, internal journal
> [   18.044180] kjournald starting.  Commit interval 5 seconds
> [   18.044363] EXT3 FS on hda1, internal journal
> [   18.044438] EXT3-fs: mounted filesystem with ordered data mode.
> [   18.055177] kjournald starting.  Commit interval 5 seconds
> [   18.055342] EXT3 FS on hda3, internal journal
> [   18.055415] EXT3-fs: mounted filesystem with ordered data mode.
> [   18.083220] kjournald starting.  Commit interval 5 seconds
> [   18.083395] EXT3 FS on hda6, internal journal
> [   18.083468] EXT3-fs: mounted filesystem with ordered data mode.
> [   18.093175] kjournald starting.  Commit interval 5 seconds
> [   18.093354] EXT3 FS on hda7, internal journal
> [   18.093426] EXT3-fs: mounted filesystem with ordered data mode.
> [   22.328840] 0000:00:08.0: tulip_stop_rxtx() failed
> [   22.328854] eth0: Setting full-duplex based on MII#1 link partner capa=
bility of 45e1.


--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

G:  Let me guess, you started on the 'net with AOL, right?
C:  WOW! d00d! U r leet!
					-- Greg and Customer=20
User Friendly, 2/12/1999

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDwq9JHL9iwnUZqnkRAn3YAJsFjvZkMIlzEUj2RfuNQ35d0fwWywCdEVp4
h07X+bZ2I7GZkYgX4asAZ8Y=
=9jdQ
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
