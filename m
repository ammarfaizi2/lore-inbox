Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbTIYI07 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 04:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTIYI07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 04:26:59 -0400
Received: from eu40.st74-net74.ip.superonlinecorporate.com ([213.74.74.40]:52752
	"HELO viruswall.solmaz.com.tr") by vger.kernel.org with SMTP
	id S261665AbTIYI0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 04:26:30 -0400
Message-ID: <EA16D384EF89C942B5948FEB8E5D2FF3061C59@mailserver>
From: Tarkan Erimer <TARKANE@solmaz.com.tr>
To: "lkml (linux-kernel@vger.kernel.org)" <linux-kernel@vger.kernel.org>
Subject: [BUG] Hard lock up exiting X on linux-2.6.0-test5/test5-mm4
Date: Thu, 25 Sep 2003 11:27:00 +0300
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C3833E.CA74D050"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C3833E.CA74D050
Content-Type: text/plain;
	charset="iso-8859-1"


Hi,

I compile and run linux-2.6.0-test5-mm4. It works wonderful, but when I
switch to X windows it's OK. But, when I tried to exit X, it completely
freezes the box. I tried this with open source nvidia (nv) driver and
proprietary nvidia (nvidia)driver. Results are always same. My hardware is:
P-II 350, 384 RAM, BX board and Riva TNT gfx card. The same thing also
happened with vanilla linux-2.6.0-test5. I attached my .config and
version_linux outputs. Any idea ?

Regards,

Tarkan Erimer


------_=_NextPart_000_01C3833E.CA74D050
Content-Type: application/octet-stream;
	name="version_linux.out"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="version_linux.out"

If some fields are empty or look unusual you may have an old =
version.=0A=
Compare to the current minimal requirements in =
Documentation/Changes.=0A=
 =0A=
Linux hightemple 2.6.0-test5-mm4 #1 Wed Sep 24 00:29:18 EEST 2003 i686 =
unknown unknown GNU/Linux=0A=
 =0A=
Gnu C                  3.2.2=0A=
Gnu make               3.80=0A=
util-linux             2.12=0A=
mount                  2.12=0A=
e2fsprogs              1.34=0A=
jfsutils               1.1.1=0A=
reiserfsprogs          3.6.4=0A=
xfsprogs               2.3.5=0A=
pcmcia-cs              3.2.4=0A=
quota-tools            3.09.=0A=
PPP                    2.4.1=0A=
nfs-utils              1.0.1=0A=
Linux C Library        2.3.2=0A=
Dynamic linker (ldd)   2.3.2=0A=
Linux C++ Library      5.0.2=0A=
Procps                 3.1.6=0A=
Net-tools              1.60=0A=
Kbd                    1.08=0A=
Sh-utils               5.0=0A=
Modules Loaded         nvidia ntfs dummy sb sb_lib uart401 sound =
soundcore agpgart apm vfat fat=0A=

------_=_NextPart_000_01C3833E.CA74D050
Content-Type: application/octet-stream;
	name=".config"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename=".config"

#=0A=
# Automatically generated make config: don't edit=0A=
#=0A=
CONFIG_X86=3Dy=0A=
CONFIG_MMU=3Dy=0A=
CONFIG_UID16=3Dy=0A=
CONFIG_GENERIC_ISA_DMA=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
# CONFIG_CLEAN_COMPILE is not set=0A=
CONFIG_STANDALONE=3Dy=0A=
CONFIG_BROKEN=3Dy=0A=
CONFIG_BROKEN_ON_SMP=3Dy=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_SWAP=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
CONFIG_BSD_PROCESS_ACCT=3Dy=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_LOG_BUF_SHIFT=3D14=0A=
CONFIG_IKCONFIG=3Dy=0A=
CONFIG_IKCONFIG_PROC=3Dy=0A=
# CONFIG_EMBEDDED is not set=0A=
CONFIG_KALLSYMS=3Dy=0A=
CONFIG_FUTEX=3Dy=0A=
CONFIG_EPOLL=3Dy=0A=
CONFIG_IOSCHED_NOOP=3Dy=0A=
CONFIG_IOSCHED_AS=3Dy=0A=
CONFIG_IOSCHED_DEADLINE=3Dy=0A=
CONFIG_IOSCHED_CFQ=3Dy=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODULE_UNLOAD=3Dy=0A=
CONFIG_MODULE_FORCE_UNLOAD=3Dy=0A=
CONFIG_OBSOLETE_MODPARM=3Dy=0A=
# CONFIG_MODVERSIONS is not set=0A=
CONFIG_KMOD=3Dy=0A=
=0A=
#=0A=
# Processor type and features=0A=
#=0A=
CONFIG_X86_PC=3Dy=0A=
# CONFIG_X86_VOYAGER is not set=0A=
# CONFIG_X86_NUMAQ is not set=0A=
# CONFIG_X86_SUMMIT is not set=0A=
# CONFIG_X86_BIGSMP is not set=0A=
# CONFIG_X86_VISWS is not set=0A=
# CONFIG_X86_GENERICARCH is not set=0A=
# CONFIG_X86_ES7000 is not set=0A=
# CONFIG_M386 is not set=0A=
# CONFIG_M486 is not set=0A=
# CONFIG_M586 is not set=0A=
# CONFIG_M586TSC is not set=0A=
# CONFIG_M586MMX is not set=0A=
# CONFIG_M686 is not set=0A=
CONFIG_MPENTIUMII=3Dy=0A=
# CONFIG_MPENTIUMIII is not set=0A=
# CONFIG_MPENTIUM4 is not set=0A=
# CONFIG_MK6 is not set=0A=
# CONFIG_MK7 is not set=0A=
# CONFIG_MK8 is not set=0A=
# CONFIG_MELAN is not set=0A=
# CONFIG_MCRUSOE is not set=0A=
# CONFIG_MWINCHIPC6 is not set=0A=
# CONFIG_MWINCHIP2 is not set=0A=
# CONFIG_MWINCHIP3D is not set=0A=
# CONFIG_MCYRIXIII is not set=0A=
# CONFIG_MVIAC3_2 is not set=0A=
CONFIG_X86_GENERIC=3Dy=0A=
CONFIG_X86_CMPXCHG=3Dy=0A=
CONFIG_X86_XADD=3Dy=0A=
CONFIG_X86_L1_CACHE_SHIFT=3D7=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
CONFIG_X86_WP_WORKS_OK=3Dy=0A=
CONFIG_X86_INVLPG=3Dy=0A=
CONFIG_X86_BSWAP=3Dy=0A=
CONFIG_X86_POPAD_OK=3Dy=0A=
CONFIG_X86_GOOD_APIC=3Dy=0A=
CONFIG_X86_INTEL_USERCOPY=3Dy=0A=
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy=0A=
# CONFIG_X86_4G is not set=0A=
# CONFIG_X86_SWITCH_PAGETABLES is not set=0A=
# CONFIG_X86_4G_VM_LAYOUT is not set=0A=
# CONFIG_X86_UACCESS_INDIRECT is not set=0A=
# CONFIG_X86_HIGH_ENTRY is not set=0A=
CONFIG_HPET_TIMER=3Dy=0A=
# CONFIG_HPET_EMULATE_RTC is not set=0A=
# CONFIG_SMP is not set=0A=
CONFIG_PREEMPT=3Dy=0A=
CONFIG_X86_UP_APIC=3Dy=0A=
CONFIG_X86_UP_IOAPIC=3Dy=0A=
CONFIG_X86_LOCAL_APIC=3Dy=0A=
CONFIG_X86_IO_APIC=3Dy=0A=
CONFIG_X86_TSC=3Dy=0A=
CONFIG_X86_MCE=3Dy=0A=
# CONFIG_X86_MCE_NONFATAL is not set=0A=
# CONFIG_X86_MCE_P4THERMAL is not set=0A=
# CONFIG_TOSHIBA is not set=0A=
# CONFIG_I8K is not set=0A=
CONFIG_MICROCODE=3Dy=0A=
# CONFIG_X86_MSR is not set=0A=
# CONFIG_X86_CPUID is not set=0A=
# CONFIG_EDD is not set=0A=
CONFIG_NOHIGHMEM=3Dy=0A=
# CONFIG_HIGHMEM4G is not set=0A=
# CONFIG_HIGHMEM64G is not set=0A=
# CONFIG_MATH_EMULATION is not set=0A=
CONFIG_MTRR=3Dy=0A=
CONFIG_HAVE_DEC_LOCK=3Dy=0A=
=0A=
#=0A=
# Power management options (ACPI, APM)=0A=
#=0A=
CONFIG_PM=3Dy=0A=
CONFIG_SOFTWARE_SUSPEND=3Dy=0A=
# CONFIG_PM_DISK is not set=0A=
CONFIG_PM_DISK_PARTITION=3D""=0A=
=0A=
#=0A=
# ACPI (Advanced Configuration and Power Interface) Support=0A=
#=0A=
CONFIG_ACPI=3Dy=0A=
CONFIG_ACPI_BOOT=3Dy=0A=
CONFIG_ACPI_INTERPRETER=3Dy=0A=
CONFIG_ACPI_SLEEP=3Dy=0A=
CONFIG_ACPI_SLEEP_PROC_FS=3Dy=0A=
# CONFIG_ACPI_AC is not set=0A=
# CONFIG_ACPI_BATTERY is not set=0A=
# CONFIG_ACPI_BUTTON is not set=0A=
CONFIG_ACPI_FAN=3Dy=0A=
CONFIG_ACPI_PROCESSOR=3Dy=0A=
CONFIG_ACPI_THERMAL=3Dy=0A=
# CONFIG_ACPI_ASUS is not set=0A=
# CONFIG_ACPI_TOSHIBA is not set=0A=
# CONFIG_ACPI_DEBUG is not set=0A=
CONFIG_ACPI_BUS=3Dy=0A=
CONFIG_ACPI_EC=3Dy=0A=
CONFIG_ACPI_POWER=3Dy=0A=
CONFIG_ACPI_PCI=3Dy=0A=
CONFIG_ACPI_SYSTEM=3Dy=0A=
=0A=
#=0A=
# APM (Advanced Power Management) BIOS Support=0A=
#=0A=
CONFIG_APM=3Dm=0A=
# CONFIG_APM_IGNORE_USER_SUSPEND is not set=0A=
CONFIG_APM_DO_ENABLE=3Dy=0A=
# CONFIG_APM_CPU_IDLE is not set=0A=
CONFIG_APM_DISPLAY_BLANK=3Dy=0A=
# CONFIG_APM_RTC_IS_GMT is not set=0A=
# CONFIG_APM_ALLOW_INTS is not set=0A=
# CONFIG_APM_REAL_MODE_POWER_OFF is not set=0A=
=0A=
#=0A=
# CPU Frequency scaling=0A=
#=0A=
# CONFIG_CPU_FREQ is not set=0A=
=0A=
#=0A=
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)=0A=
#=0A=
CONFIG_PCI=3Dy=0A=
# CONFIG_PCI_GOBIOS is not set=0A=
# CONFIG_PCI_GODIRECT is not set=0A=
CONFIG_PCI_GOANY=3Dy=0A=
CONFIG_PCI_BIOS=3Dy=0A=
CONFIG_PCI_DIRECT=3Dy=0A=
CONFIG_PCI_LEGACY_PROC=3Dy=0A=
CONFIG_PCI_NAMES=3Dy=0A=
CONFIG_ISA=3Dy=0A=
# CONFIG_EISA is not set=0A=
# CONFIG_MCA is not set=0A=
# CONFIG_SCx200 is not set=0A=
# CONFIG_HOTPLUG is not set=0A=
=0A=
#=0A=
# Executable file formats=0A=
#=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
# CONFIG_BINFMT_AOUT is not set=0A=
CONFIG_BINFMT_MISC=3Dy=0A=
=0A=
#=0A=
# Generic Driver Options=0A=
#=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
# CONFIG_MTD is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
# CONFIG_PARPORT is not set=0A=
=0A=
#=0A=
# Plug and Play support=0A=
#=0A=
CONFIG_PNP=3Dy=0A=
# CONFIG_PNP_DEBUG is not set=0A=
=0A=
#=0A=
# Protocols=0A=
#=0A=
CONFIG_ISAPNP=3Dy=0A=
CONFIG_PNPBIOS=3Dy=0A=
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
# CONFIG_BLK_DEV_CRYPTOLOOP is not set=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
CONFIG_BLK_DEV_RAM=3Dy=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D8192=0A=
CONFIG_BLK_DEV_INITRD=3Dy=0A=
CONFIG_LBD=3Dy=0A=
=0A=
#=0A=
# ATA/ATAPI/MFM/RLL support=0A=
#=0A=
CONFIG_IDE=3Dy=0A=
CONFIG_BLK_DEV_IDE=3Dy=0A=
=0A=
#=0A=
# Please see Documentation/ide.txt for help/info on IDE drives=0A=
#=0A=
# CONFIG_BLK_DEV_HD_IDE is not set=0A=
CONFIG_BLK_DEV_IDEDISK=3Dy=0A=
CONFIG_IDEDISK_MULTI_MODE=3Dy=0A=
# CONFIG_IDEDISK_STROKE is not set=0A=
CONFIG_BLK_DEV_IDECD=3Dy=0A=
# CONFIG_BLK_DEV_IDETAPE is not set=0A=
# CONFIG_BLK_DEV_IDEFLOPPY is not set=0A=
# CONFIG_IDE_TASK_IOCTL is not set=0A=
CONFIG_IDE_TASKFILE_IO=3Dy=0A=
=0A=
#=0A=
# IDE chipset support/bugfixes=0A=
#=0A=
# CONFIG_BLK_DEV_CMD640 is not set=0A=
# CONFIG_BLK_DEV_IDEPNP is not set=0A=
CONFIG_BLK_DEV_IDEPCI=3Dy=0A=
CONFIG_IDEPCI_SHARE_IRQ=3Dy=0A=
# CONFIG_BLK_DEV_OFFBOARD is not set=0A=
CONFIG_BLK_DEV_GENERIC=3Dy=0A=
# CONFIG_BLK_DEV_OPTI621 is not set=0A=
# CONFIG_BLK_DEV_RZ1000 is not set=0A=
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy=0A=
# CONFIG_BLK_DEV_IDE_TCQ is not set=0A=
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set=0A=
CONFIG_IDEDMA_PCI_AUTO=3Dy=0A=
# CONFIG_IDEDMA_ONLYDISK is not set=0A=
# CONFIG_IDEDMA_PCI_WIP is not set=0A=
CONFIG_BLK_DEV_ADMA=3Dy=0A=
# CONFIG_BLK_DEV_AEC62XX is not set=0A=
# CONFIG_BLK_DEV_ALI15X3 is not set=0A=
# CONFIG_BLK_DEV_AMD74XX is not set=0A=
# CONFIG_BLK_DEV_CMD64X is not set=0A=
# CONFIG_BLK_DEV_TRIFLEX is not set=0A=
# CONFIG_BLK_DEV_CY82C693 is not set=0A=
# CONFIG_BLK_DEV_CS5520 is not set=0A=
# CONFIG_BLK_DEV_CS5530 is not set=0A=
# CONFIG_BLK_DEV_HPT34X is not set=0A=
# CONFIG_BLK_DEV_HPT366 is not set=0A=
# CONFIG_BLK_DEV_SC1200 is not set=0A=
CONFIG_BLK_DEV_PIIX=3Dy=0A=
# CONFIG_BLK_DEV_NS87415 is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_OLD is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_NEW is not set=0A=
# CONFIG_BLK_DEV_SVWKS is not set=0A=
# CONFIG_BLK_DEV_SIIMAGE is not set=0A=
# CONFIG_BLK_DEV_SIS5513 is not set=0A=
# CONFIG_BLK_DEV_SLC90E66 is not set=0A=
# CONFIG_BLK_DEV_TRM290 is not set=0A=
# CONFIG_BLK_DEV_VIA82CXXX is not set=0A=
# CONFIG_IDE_CHIPSETS is not set=0A=
CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
# CONFIG_IDEDMA_IVB is not set=0A=
CONFIG_IDEDMA_AUTO=3Dy=0A=
# CONFIG_DMA_NONPCI is not set=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
=0A=
#=0A=
# SCSI device support=0A=
#=0A=
# CONFIG_SCSI is not set=0A=
=0A=
#=0A=
# Old CD-ROM drivers (not SCSI, not IDE)=0A=
#=0A=
# CONFIG_CD_NO_IDESCSI is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
=0A=
#=0A=
# Fusion MPT device support=0A=
#=0A=
=0A=
#=0A=
# IEEE 1394 (FireWire) support (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IEEE1394 is not set=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
# CONFIG_I2O is not set=0A=
=0A=
#=0A=
# Networking support=0A=
#=0A=
CONFIG_NET=3Dy=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
# CONFIG_PACKET_MMAP is not set=0A=
# CONFIG_NETLINK_DEV is not set=0A=
CONFIG_UNIX=3Dy=0A=
# CONFIG_NET_KEY is not set=0A=
CONFIG_INET=3Dy=0A=
# CONFIG_IP_MULTICAST is not set=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
# CONFIG_IP_PNP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_ARPD is not set=0A=
# CONFIG_INET_ECN is not set=0A=
CONFIG_SYN_COOKIES=3Dy=0A=
# CONFIG_INET_AH is not set=0A=
# CONFIG_INET_ESP is not set=0A=
# CONFIG_INET_IPCOMP is not set=0A=
=0A=
#=0A=
# IP: Virtual Server Configuration=0A=
#=0A=
# CONFIG_IP_VS is not set=0A=
# CONFIG_IPV6 is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_BRIDGE is not set=0A=
CONFIG_NETFILTER=3Dy=0A=
# CONFIG_NETFILTER_DEBUG is not set=0A=
=0A=
#=0A=
# IP: Netfilter Configuration=0A=
#=0A=
CONFIG_IP_NF_CONNTRACK=3Dy=0A=
CONFIG_IP_NF_FTP=3Dy=0A=
CONFIG_IP_NF_IRC=3Dy=0A=
CONFIG_IP_NF_TFTP=3Dy=0A=
CONFIG_IP_NF_AMANDA=3Dy=0A=
CONFIG_IP_NF_QUEUE=3Dy=0A=
CONFIG_IP_NF_IPTABLES=3Dy=0A=
CONFIG_IP_NF_MATCH_LIMIT=3Dy=0A=
CONFIG_IP_NF_MATCH_IPRANGE=3Dy=0A=
CONFIG_IP_NF_MATCH_MAC=3Dy=0A=
CONFIG_IP_NF_MATCH_PKTTYPE=3Dy=0A=
CONFIG_IP_NF_MATCH_MARK=3Dy=0A=
CONFIG_IP_NF_MATCH_MULTIPORT=3Dy=0A=
CONFIG_IP_NF_MATCH_TOS=3Dy=0A=
CONFIG_IP_NF_MATCH_RECENT=3Dy=0A=
CONFIG_IP_NF_MATCH_ECN=3Dy=0A=
CONFIG_IP_NF_MATCH_DSCP=3Dy=0A=
CONFIG_IP_NF_MATCH_AH_ESP=3Dy=0A=
CONFIG_IP_NF_MATCH_LENGTH=3Dy=0A=
CONFIG_IP_NF_MATCH_TTL=3Dy=0A=
CONFIG_IP_NF_MATCH_TCPMSS=3Dy=0A=
CONFIG_IP_NF_MATCH_HELPER=3Dy=0A=
CONFIG_IP_NF_MATCH_STATE=3Dy=0A=
CONFIG_IP_NF_MATCH_CONNTRACK=3Dy=0A=
CONFIG_IP_NF_MATCH_OWNER=3Dy=0A=
CONFIG_IP_NF_FILTER=3Dy=0A=
CONFIG_IP_NF_TARGET_REJECT=3Dy=0A=
CONFIG_IP_NF_NAT=3Dy=0A=
CONFIG_IP_NF_NAT_NEEDED=3Dy=0A=
CONFIG_IP_NF_TARGET_MASQUERADE=3Dy=0A=
CONFIG_IP_NF_TARGET_REDIRECT=3Dy=0A=
CONFIG_IP_NF_TARGET_NETMAP=3Dy=0A=
CONFIG_IP_NF_TARGET_SAME=3Dy=0A=
CONFIG_IP_NF_NAT_LOCAL=3Dy=0A=
CONFIG_IP_NF_NAT_SNMP_BASIC=3Dy=0A=
CONFIG_IP_NF_NAT_IRC=3Dy=0A=
CONFIG_IP_NF_NAT_FTP=3Dy=0A=
CONFIG_IP_NF_NAT_TFTP=3Dy=0A=
CONFIG_IP_NF_NAT_AMANDA=3Dy=0A=
CONFIG_IP_NF_MANGLE=3Dy=0A=
CONFIG_IP_NF_TARGET_TOS=3Dy=0A=
CONFIG_IP_NF_TARGET_ECN=3Dy=0A=
CONFIG_IP_NF_TARGET_DSCP=3Dy=0A=
CONFIG_IP_NF_TARGET_MARK=3Dy=0A=
CONFIG_IP_NF_TARGET_CLASSIFY=3Dy=0A=
CONFIG_IP_NF_TARGET_LOG=3Dy=0A=
CONFIG_IP_NF_TARGET_ULOG=3Dy=0A=
CONFIG_IP_NF_TARGET_TCPMSS=3Dy=0A=
CONFIG_IP_NF_ARPTABLES=3Dy=0A=
CONFIG_IP_NF_ARPFILTER=3Dy=0A=
CONFIG_IP_NF_ARP_MANGLE=3Dy=0A=
=0A=
#=0A=
# SCTP Configuration (EXPERIMENTAL)=0A=
#=0A=
CONFIG_IPV6_SCTP__=3Dy=0A=
# CONFIG_IP_SCTP is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_LLC2 is not set=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
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
# CONFIG_NET_SB1000 is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
# CONFIG_NET_ETHERNET is not set=0A=
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
# CONFIG_R8169 is not set=0A=
# CONFIG_SIS190 is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_TIGON3 is not set=0A=
=0A=
#=0A=
# Ethernet (10000 Mbit)=0A=
#=0A=
# CONFIG_IXGB is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
CONFIG_PPP=3Dy=0A=
CONFIG_PPP_MULTILINK=3Dy=0A=
CONFIG_PPP_FILTER=3Dy=0A=
CONFIG_PPP_ASYNC=3Dy=0A=
# CONFIG_PPP_SYNC_TTY is not set=0A=
# CONFIG_PPP_DEFLATE is not set=0A=
CONFIG_PPP_BSDCOMP=3Dy=0A=
# CONFIG_PPPOE is not set=0A=
# CONFIG_SLIP is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
# CONFIG_RCPCI is not set=0A=
# CONFIG_SHAPER is not set=0A=
# CONFIG_NET_POLL_CONTROLLER is not set=0A=
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
# IrDA (infrared) support=0A=
#=0A=
# CONFIG_IRDA is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN_BOOL is not set=0A=
=0A=
#=0A=
# Telephony Support=0A=
#=0A=
# CONFIG_PHONE is not set=0A=
=0A=
#=0A=
# Input device support=0A=
#=0A=
CONFIG_INPUT=3Dy=0A=
=0A=
#=0A=
# Userland interfaces=0A=
#=0A=
CONFIG_INPUT_MOUSEDEV=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768=0A=
# CONFIG_INPUT_JOYDEV is not set=0A=
# CONFIG_INPUT_TSDEV is not set=0A=
# CONFIG_INPUT_EVDEV is not set=0A=
# CONFIG_INPUT_EVBUG is not set=0A=
=0A=
#=0A=
# Input I/O drivers=0A=
#=0A=
# CONFIG_GAMEPORT is not set=0A=
CONFIG_SOUND_GAMEPORT=3Dy=0A=
CONFIG_SERIO=3Dy=0A=
CONFIG_SERIO_I8042=3Dy=0A=
# CONFIG_SERIO_SERPORT is not set=0A=
# CONFIG_SERIO_CT82C710 is not set=0A=
# CONFIG_SERIO_PCIPS2 is not set=0A=
=0A=
#=0A=
# Input Device Drivers=0A=
#=0A=
CONFIG_INPUT_KEYBOARD=3Dy=0A=
CONFIG_KEYBOARD_ATKBD=3Dy=0A=
# CONFIG_KEYBOARD_SUNKBD is not set=0A=
# CONFIG_KEYBOARD_XTKBD is not set=0A=
# CONFIG_KEYBOARD_NEWTON is not set=0A=
CONFIG_INPUT_MOUSE=3Dy=0A=
CONFIG_MOUSE_PS2=3Dy=0A=
# CONFIG_MOUSE_PS2_SYNAPTICS is not set=0A=
# CONFIG_MOUSE_SERIAL is not set=0A=
# CONFIG_MOUSE_INPORT is not set=0A=
# CONFIG_MOUSE_LOGIBM is not set=0A=
# CONFIG_MOUSE_PC110PAD is not set=0A=
# CONFIG_INPUT_JOYSTICK is not set=0A=
# CONFIG_INPUT_TOUCHSCREEN is not set=0A=
# CONFIG_INPUT_MISC is not set=0A=
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
CONFIG_SERIAL_8250=3Dy=0A=
# CONFIG_SERIAL_8250_CONSOLE is not set=0A=
# CONFIG_SERIAL_8250_ACPI is not set=0A=
# CONFIG_SERIAL_8250_EXTENDED is not set=0A=
=0A=
#=0A=
# Non-8250 serial port support=0A=
#=0A=
CONFIG_SERIAL_CORE=3Dy=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_UNIX98_PTY_COUNT=3D256=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# I2C Hardware Sensors Mainboard support=0A=
#=0A=
=0A=
#=0A=
# I2C Hardware Sensors Chip support=0A=
#=0A=
# CONFIG_I2C_SENSOR is not set=0A=
=0A=
#=0A=
# Mice=0A=
#=0A=
# CONFIG_BUSMOUSE is not set=0A=
# CONFIG_QIC02_TAPE is not set=0A=
=0A=
#=0A=
# IPMI=0A=
#=0A=
# CONFIG_IPMI_HANDLER is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
# CONFIG_HW_RANDOM is not set=0A=
# CONFIG_NVRAM is not set=0A=
# CONFIG_RTC is not set=0A=
# CONFIG_GEN_RTC is not set=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
# CONFIG_SONYPI is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_FTAPE is not set=0A=
CONFIG_AGP=3Dm=0A=
# CONFIG_AGP_ALI is not set=0A=
# CONFIG_AGP_ATI is not set=0A=
# CONFIG_AGP_AMD is not set=0A=
# CONFIG_AGP_AMD64 is not set=0A=
CONFIG_AGP_INTEL=3Dm=0A=
# CONFIG_AGP_NVIDIA is not set=0A=
# CONFIG_AGP_SIS is not set=0A=
# CONFIG_AGP_SWORKS is not set=0A=
# CONFIG_AGP_VIA is not set=0A=
CONFIG_DRM=3Dy=0A=
# CONFIG_DRM_TDFX is not set=0A=
# CONFIG_DRM_GAMMA is not set=0A=
# CONFIG_DRM_R128 is not set=0A=
# CONFIG_DRM_RADEON is not set=0A=
# CONFIG_DRM_I810 is not set=0A=
# CONFIG_DRM_I830 is not set=0A=
# CONFIG_DRM_MGA is not set=0A=
# CONFIG_MWAVE is not set=0A=
CONFIG_RAW_DRIVER=3Dy=0A=
CONFIG_HANGCHECK_TIMER=3Dy=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# Digital Video Broadcasting Devices=0A=
#=0A=
# CONFIG_DVB is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
CONFIG_EXT2_FS=3Dy=0A=
CONFIG_EXT2_FS_XATTR=3Dy=0A=
CONFIG_EXT2_FS_POSIX_ACL=3Dy=0A=
CONFIG_EXT2_FS_SECURITY=3Dy=0A=
CONFIG_EXT3_FS=3Dy=0A=
CONFIG_EXT3_FS_XATTR=3Dy=0A=
CONFIG_EXT3_FS_POSIX_ACL=3Dy=0A=
CONFIG_EXT3_FS_SECURITY=3Dy=0A=
CONFIG_JBD=3Dy=0A=
# CONFIG_JBD_DEBUG is not set=0A=
CONFIG_FS_MBCACHE=3Dy=0A=
# CONFIG_REISERFS_FS is not set=0A=
# CONFIG_JFS_FS is not set=0A=
CONFIG_FS_POSIX_ACL=3Dy=0A=
# CONFIG_XFS_FS is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
CONFIG_QUOTA=3Dy=0A=
# CONFIG_QFMT_V1 is not set=0A=
CONFIG_QFMT_V2=3Dy=0A=
CONFIG_QUOTACTL=3Dy=0A=
# CONFIG_AUTOFS_FS is not set=0A=
CONFIG_AUTOFS4_FS=3Dy=0A=
=0A=
#=0A=
# CD-ROM/DVD Filesystems=0A=
#=0A=
CONFIG_ISO9660_FS=3Dy=0A=
CONFIG_JOLIET=3Dy=0A=
# CONFIG_ZISOFS is not set=0A=
# CONFIG_UDF_FS is not set=0A=
=0A=
#=0A=
# DOS/FAT/NT Filesystems=0A=
#=0A=
CONFIG_FAT_FS=3Dm=0A=
CONFIG_MSDOS_FS=3Dm=0A=
CONFIG_VFAT_FS=3Dm=0A=
CONFIG_NTFS_FS=3Dm=0A=
# CONFIG_NTFS_DEBUG is not set=0A=
# CONFIG_NTFS_RW is not set=0A=
=0A=
#=0A=
# Pseudo filesystems=0A=
#=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_PROC_KCORE=3Dy=0A=
# CONFIG_DEVFS_FS is not set=0A=
CONFIG_DEVPTS_FS=3Dy=0A=
# CONFIG_DEVPTS_FS_XATTR is not set=0A=
CONFIG_TMPFS=3Dy=0A=
CONFIG_HUGETLBFS=3Dy=0A=
CONFIG_HUGETLB_PAGE=3Dy=0A=
CONFIG_RAMFS=3Dy=0A=
=0A=
#=0A=
# Miscellaneous filesystems=0A=
#=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_CRAMFS is not set=0A=
# CONFIG_VXFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
CONFIG_NFS_FS=3Dy=0A=
# CONFIG_NFS_V3 is not set=0A=
CONFIG_NFS_V4=3Dy=0A=
CONFIG_NFS_DIRECTIO=3Dy=0A=
CONFIG_NFSD=3Dy=0A=
CONFIG_NFSD_V3=3Dy=0A=
CONFIG_NFSD_V4=3Dy=0A=
CONFIG_NFSD_TCP=3Dy=0A=
CONFIG_LOCKD=3Dy=0A=
CONFIG_LOCKD_V4=3Dy=0A=
CONFIG_EXPORTFS=3Dy=0A=
CONFIG_SUNRPC=3Dy=0A=
CONFIG_SUNRPC_GSS=3Dy=0A=
CONFIG_SMB_FS=3Dy=0A=
# CONFIG_SMB_NLS_DEFAULT is not set=0A=
# CONFIG_CIFS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_INTERMEZZO_FS is not set=0A=
# CONFIG_AFS_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
# CONFIG_PARTITION_ADVANCED is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
CONFIG_SMB_NLS=3Dy=0A=
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
CONFIG_NLS_CODEPAGE_857=3Dy=0A=
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
CONFIG_NLS_CODEPAGE_1250=3Dy=0A=
# CONFIG_NLS_CODEPAGE_1251 is not set=0A=
CONFIG_NLS_ISO8859_1=3Dy=0A=
# CONFIG_NLS_ISO8859_2 is not set=0A=
CONFIG_NLS_ISO8859_3=3Dy=0A=
# CONFIG_NLS_ISO8859_4 is not set=0A=
# CONFIG_NLS_ISO8859_5 is not set=0A=
# CONFIG_NLS_ISO8859_6 is not set=0A=
# CONFIG_NLS_ISO8859_7 is not set=0A=
CONFIG_NLS_ISO8859_9=3Dy=0A=
# CONFIG_NLS_ISO8859_13 is not set=0A=
# CONFIG_NLS_ISO8859_14 is not set=0A=
CONFIG_NLS_ISO8859_15=3Dy=0A=
# CONFIG_NLS_KOI8_R is not set=0A=
# CONFIG_NLS_KOI8_U is not set=0A=
CONFIG_NLS_UTF8=3Dy=0A=
=0A=
#=0A=
# Graphics support=0A=
#=0A=
CONFIG_FB=3Dy=0A=
# CONFIG_FB_CIRRUS is not set=0A=
# CONFIG_FB_PM2 is not set=0A=
# CONFIG_FB_CYBER2000 is not set=0A=
# CONFIG_FB_ASILIANT is not set=0A=
# CONFIG_FB_IMSTT is not set=0A=
# CONFIG_FB_VGA16 is not set=0A=
CONFIG_FB_VESA=3Dy=0A=
CONFIG_VIDEO_SELECT=3Dy=0A=
# CONFIG_FB_HGA is not set=0A=
CONFIG_FB_RIVA=3Dm=0A=
# CONFIG_FB_I810 is not set=0A=
# CONFIG_FB_MATROX is not set=0A=
# CONFIG_FB_RADEON is not set=0A=
# CONFIG_FB_ATY128 is not set=0A=
# CONFIG_FB_ATY is not set=0A=
# CONFIG_FB_SIS is not set=0A=
# CONFIG_FB_NEOMAGIC is not set=0A=
# CONFIG_FB_3DFX is not set=0A=
# CONFIG_FB_VOODOO1 is not set=0A=
# CONFIG_FB_TRIDENT is not set=0A=
# CONFIG_FB_PM3 is not set=0A=
# CONFIG_FB_VIRTUAL is not set=0A=
=0A=
#=0A=
# Console display driver support=0A=
#=0A=
CONFIG_VGA_CONSOLE=3Dy=0A=
# CONFIG_MDA_CONSOLE is not set=0A=
CONFIG_DUMMY_CONSOLE=3Dy=0A=
CONFIG_FRAMEBUFFER_CONSOLE=3Dm=0A=
CONFIG_PCI_CONSOLE=3Dy=0A=
# CONFIG_FONTS is not set=0A=
CONFIG_FONT_8x8=3Dy=0A=
CONFIG_FONT_8x16=3Dy=0A=
=0A=
#=0A=
# Logo configuration=0A=
#=0A=
CONFIG_LOGO=3Dy=0A=
# CONFIG_LOGO_LINUX_MONO is not set=0A=
# CONFIG_LOGO_LINUX_VGA16 is not set=0A=
CONFIG_LOGO_LINUX_CLUT224=3Dy=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
CONFIG_SOUND=3Dm=0A=
=0A=
#=0A=
# Advanced Linux Sound Architecture=0A=
#=0A=
CONFIG_SND=3Dm=0A=
CONFIG_SND_SEQUENCER=3Dm=0A=
# CONFIG_SND_SEQ_DUMMY is not set=0A=
CONFIG_SND_OSSEMUL=3Dy=0A=
CONFIG_SND_MIXER_OSS=3Dm=0A=
CONFIG_SND_PCM_OSS=3Dm=0A=
CONFIG_SND_SEQUENCER_OSS=3Dy=0A=
# CONFIG_SND_VERBOSE_PRINTK is not set=0A=
# CONFIG_SND_DEBUG is not set=0A=
=0A=
#=0A=
# Generic devices=0A=
#=0A=
# CONFIG_SND_DUMMY is not set=0A=
# CONFIG_SND_VIRMIDI is not set=0A=
# CONFIG_SND_MTPAV is not set=0A=
# CONFIG_SND_SERIAL_U16550 is not set=0A=
# CONFIG_SND_MPU401 is not set=0A=
=0A=
#=0A=
# ISA devices=0A=
#=0A=
# CONFIG_SND_AD1816A is not set=0A=
# CONFIG_SND_AD1848 is not set=0A=
# CONFIG_SND_CS4231 is not set=0A=
# CONFIG_SND_CS4232 is not set=0A=
# CONFIG_SND_CS4236 is not set=0A=
# CONFIG_SND_ES968 is not set=0A=
# CONFIG_SND_ES1688 is not set=0A=
# CONFIG_SND_ES18XX is not set=0A=
# CONFIG_SND_GUSCLASSIC is not set=0A=
# CONFIG_SND_GUSEXTREME is not set=0A=
# CONFIG_SND_GUSMAX is not set=0A=
# CONFIG_SND_INTERWAVE is not set=0A=
# CONFIG_SND_INTERWAVE_STB is not set=0A=
# CONFIG_SND_OPTI92X_AD1848 is not set=0A=
# CONFIG_SND_OPTI92X_CS4231 is not set=0A=
# CONFIG_SND_OPTI93X is not set=0A=
# CONFIG_SND_SB8 is not set=0A=
# CONFIG_SND_SB16 is not set=0A=
# CONFIG_SND_SBAWE is not set=0A=
# CONFIG_SND_WAVEFRONT is not set=0A=
# CONFIG_SND_ALS100 is not set=0A=
# CONFIG_SND_AZT2320 is not set=0A=
# CONFIG_SND_CMI8330 is not set=0A=
# CONFIG_SND_DT019X is not set=0A=
# CONFIG_SND_OPL3SA2 is not set=0A=
# CONFIG_SND_SGALAXY is not set=0A=
# CONFIG_SND_SSCAPE is not set=0A=
=0A=
#=0A=
# PCI devices=0A=
#=0A=
# CONFIG_SND_ALI5451 is not set=0A=
# CONFIG_SND_AZT3328 is not set=0A=
# CONFIG_SND_CS46XX is not set=0A=
# CONFIG_SND_CS4281 is not set=0A=
# CONFIG_SND_EMU10K1 is not set=0A=
# CONFIG_SND_KORG1212 is not set=0A=
# CONFIG_SND_NM256 is not set=0A=
# CONFIG_SND_RME32 is not set=0A=
# CONFIG_SND_RME96 is not set=0A=
# CONFIG_SND_RME9652 is not set=0A=
# CONFIG_SND_HDSP is not set=0A=
# CONFIG_SND_TRIDENT is not set=0A=
# CONFIG_SND_YMFPCI is not set=0A=
# CONFIG_SND_ALS4000 is not set=0A=
# CONFIG_SND_CMIPCI is not set=0A=
# CONFIG_SND_ENS1370 is not set=0A=
# CONFIG_SND_ENS1371 is not set=0A=
# CONFIG_SND_ES1938 is not set=0A=
# CONFIG_SND_ES1968 is not set=0A=
# CONFIG_SND_MAESTRO3 is not set=0A=
# CONFIG_SND_FM801 is not set=0A=
# CONFIG_SND_ICE1712 is not set=0A=
# CONFIG_SND_ICE1724 is not set=0A=
CONFIG_SND_INTEL8X0=3Dm=0A=
# CONFIG_SND_SONICVIBES is not set=0A=
# CONFIG_SND_VIA82XX is not set=0A=
# CONFIG_SND_VX222 is not set=0A=
=0A=
#=0A=
# ALSA USB devices=0A=
#=0A=
# CONFIG_SND_USB_AUDIO is not set=0A=
=0A=
#=0A=
# Open Sound System=0A=
#=0A=
CONFIG_SOUND_PRIME=3Dm=0A=
# CONFIG_SOUND_BT878 is not set=0A=
# CONFIG_SOUND_CMPCI is not set=0A=
# CONFIG_SOUND_EMU10K1 is not set=0A=
# CONFIG_SOUND_FUSION is not set=0A=
# CONFIG_SOUND_CS4281 is not set=0A=
# CONFIG_SOUND_ES1370 is not set=0A=
# CONFIG_SOUND_ES1371 is not set=0A=
# CONFIG_SOUND_ESSSOLO1 is not set=0A=
# CONFIG_SOUND_MAESTRO is not set=0A=
# CONFIG_SOUND_MAESTRO3 is not set=0A=
# CONFIG_SOUND_ICH is not set=0A=
# CONFIG_SOUND_SONICVIBES is not set=0A=
# CONFIG_SOUND_TRIDENT is not set=0A=
# CONFIG_SOUND_VIA82CXXX is not set=0A=
CONFIG_SOUND_OSS=3Dm=0A=
# CONFIG_SOUND_TRACEINIT is not set=0A=
# CONFIG_SOUND_DMAP is not set=0A=
# CONFIG_SOUND_AD1816 is not set=0A=
# CONFIG_SOUND_AD1889 is not set=0A=
# CONFIG_SOUND_SGALAXY is not set=0A=
# CONFIG_SOUND_ADLIB is not set=0A=
# CONFIG_SOUND_ACI_MIXER is not set=0A=
# CONFIG_SOUND_CS4232 is not set=0A=
# CONFIG_SOUND_SSCAPE is not set=0A=
# CONFIG_SOUND_GUS is not set=0A=
CONFIG_SOUND_VMIDI=3Dm=0A=
# CONFIG_SOUND_TRIX is not set=0A=
# CONFIG_SOUND_MSS is not set=0A=
# CONFIG_SOUND_MPU401 is not set=0A=
# CONFIG_SOUND_NM256 is not set=0A=
# CONFIG_SOUND_MAD16 is not set=0A=
# CONFIG_SOUND_PAS is not set=0A=
# CONFIG_SOUND_PSS is not set=0A=
CONFIG_SOUND_SB=3Dm=0A=
# CONFIG_SOUND_AWE32_SYNTH is not set=0A=
# CONFIG_SOUND_WAVEFRONT is not set=0A=
# CONFIG_SOUND_MAUI is not set=0A=
# CONFIG_SOUND_YM3812 is not set=0A=
# CONFIG_SOUND_OPL3SA1 is not set=0A=
# CONFIG_SOUND_OPL3SA2 is not set=0A=
# CONFIG_SOUND_YMFPCI is not set=0A=
CONFIG_SOUND_UART6850=3Dm=0A=
# CONFIG_SOUND_AEDSP16 is not set=0A=
# CONFIG_SOUND_KAHLUA is not set=0A=
# CONFIG_SOUND_ALI5455 is not set=0A=
# CONFIG_SOUND_FORTE is not set=0A=
# CONFIG_SOUND_RME96XX is not set=0A=
# CONFIG_SOUND_AD1980 is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
CONFIG_USB=3Dy=0A=
# CONFIG_USB_DEBUG is not set=0A=
=0A=
#=0A=
# Miscellaneous USB options=0A=
#=0A=
CONFIG_USB_DEVICEFS=3Dy=0A=
# CONFIG_USB_BANDWIDTH is not set=0A=
# CONFIG_USB_DYNAMIC_MINORS is not set=0A=
=0A=
#=0A=
# USB Host Controller Drivers=0A=
#=0A=
# CONFIG_USB_EHCI_HCD is not set=0A=
# CONFIG_USB_OHCI_HCD is not set=0A=
CONFIG_USB_UHCI_HCD=3Dy=0A=
=0A=
#=0A=
# USB Device Class drivers=0A=
#=0A=
# CONFIG_USB_AUDIO is not set=0A=
# CONFIG_USB_BLUETOOTH_TTY is not set=0A=
# CONFIG_USB_MIDI is not set=0A=
# CONFIG_USB_ACM is not set=0A=
# CONFIG_USB_PRINTER is not set=0A=
=0A=
#=0A=
# SCSI support is needed for USB Storage=0A=
#=0A=
# CONFIG_USB_STORAGE is not set=0A=
=0A=
#=0A=
# USB Human Interface Devices (HID)=0A=
#=0A=
CONFIG_USB_HID=3Dy=0A=
CONFIG_USB_HIDINPUT=3Dy=0A=
# CONFIG_HID_FF is not set=0A=
# CONFIG_USB_HIDDEV is not set=0A=
# CONFIG_USB_AIPTEK is not set=0A=
# CONFIG_USB_WACOM is not set=0A=
# CONFIG_USB_KBTAB is not set=0A=
# CONFIG_USB_POWERMATE is not set=0A=
# CONFIG_USB_XPAD is not set=0A=
=0A=
#=0A=
# USB Imaging devices=0A=
#=0A=
# CONFIG_USB_MDC800 is not set=0A=
# CONFIG_USB_SCANNER is not set=0A=
=0A=
#=0A=
# USB Multimedia devices=0A=
#=0A=
# CONFIG_USB_DABUSB is not set=0A=
=0A=
#=0A=
# Video4Linux support is needed for USB Multimedia device support=0A=
#=0A=
=0A=
#=0A=
# USB Network adaptors=0A=
#=0A=
# CONFIG_USB_AX8817X_STANDALONE is not set=0A=
# CONFIG_USB_CATC is not set=0A=
# CONFIG_USB_KAWETH is not set=0A=
# CONFIG_USB_PEGASUS is not set=0A=
# CONFIG_USB_RTL8150 is not set=0A=
# CONFIG_USB_USBNET is not set=0A=
=0A=
#=0A=
# USB port drivers=0A=
#=0A=
=0A=
#=0A=
# USB Serial Converter support=0A=
#=0A=
# CONFIG_USB_SERIAL is not set=0A=
=0A=
#=0A=
# USB Miscellaneous drivers=0A=
#=0A=
# CONFIG_USB_TIGL is not set=0A=
# CONFIG_USB_AUERSWALD is not set=0A=
# CONFIG_USB_RIO500 is not set=0A=
# CONFIG_USB_BRLVGER is not set=0A=
# CONFIG_USB_LCD is not set=0A=
# CONFIG_USB_TEST is not set=0A=
# CONFIG_USB_GADGET is not set=0A=
=0A=
#=0A=
# Bluetooth support=0A=
#=0A=
# CONFIG_BT is not set=0A=
=0A=
#=0A=
# Profiling support=0A=
#=0A=
CONFIG_PROFILING=3Dy=0A=
CONFIG_OPROFILE=3Dy=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
# CONFIG_DEBUG_KERNEL is not set=0A=
CONFIG_DEBUG_SPINLOCK_SLEEP=3Dy=0A=
CONFIG_FRAME_POINTER=3Dy=0A=
CONFIG_X86_EXTRA_IRQS=3Dy=0A=
CONFIG_X86_FIND_SMP_CONFIG=3Dy=0A=
CONFIG_X86_MPPARSE=3Dy=0A=
=0A=
#=0A=
# Security options=0A=
#=0A=
CONFIG_SECURITY=3Dy=0A=
CONFIG_SECURITY_NETWORK=3Dy=0A=
CONFIG_SECURITY_CAPABILITIES=3Dy=0A=
CONFIG_SECURITY_ROOTPLUG=3Dy=0A=
CONFIG_SECURITY_SELINUX=3Dy=0A=
# CONFIG_SECURITY_SELINUX_BOOTPARAM is not set=0A=
# CONFIG_SECURITY_SELINUX_DEVELOP is not set=0A=
CONFIG_SECURITY_SELINUX_MLS=3Dy=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
# CONFIG_CRYPTO is not set=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
# CONFIG_CRC32 is not set=0A=
CONFIG_X86_BIOS_REBOOT=3Dy=0A=

------_=_NextPart_000_01C3833E.CA74D050--
