Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271697AbRIMNwT>; Thu, 13 Sep 2001 09:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271705AbRIMNwG>; Thu, 13 Sep 2001 09:52:06 -0400
Received: from ms1.adiis.net ([207.177.36.3]:61887 "EHLO ms1.adiis.net")
	by vger.kernel.org with ESMTP id <S271697AbRIMNvw>;
	Thu, 13 Sep 2001 09:51:52 -0400
Subject: Re: 2.4.9-ac9 APM w/Compaq 16xx laptop...
From: Ryan Butler <rbutler@adiis.net>
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
Cc: chris@boojiboy.eorbit.net, linux-kernel@vger.kernel.org,
        bmacy@macykids.net
In-Reply-To: <20010913091748.A21626@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010913011606.H20118@arthur.ubicom.tudelft.nl>
	<200109130124.SAA22845@boojiboy.eorbit.net> 
	<20010913091748.A21626@arthur.ubicom.tudelft.nl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-QqOCP62N8SsnrlrmLchR"
X-Mailer: Evolution/0.13.99+cvs.2001.09.12.07.08 (Preview Release)
Date: 13 Sep 2001 08:52:04 -0500
Message-Id: <1000389126.13173.7.camel@dialupoffice.adiis.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QqOCP62N8SsnrlrmLchR
Content-Type: multipart/mixed; boundary="=-myEBTG10K44i8vEzXmSd"


--=-myEBTG10K44i8vEzXmSd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Just as another datapoint, I'll attach a copy of my dmesg and .config,

Compaq Presario 1600S K6-2-450, 192 meg of ram.  Exhibits the same
problem, hangs on shutdown -r, halts and powers off gracefully with
shutdown -h.

The last time I remember reboot working properly under linux was when I
had rh 6.2 and a 2.2.x kernel.

Ryan Butler
rbutler@adiis.net




--=-myEBTG10K44i8vEzXmSd
Content-Type: text/plain
Content-Disposition: attachment; filename=dmesg.out
Content-ID: <1000389024.13124.4.camel@dialupoffice.adiis.net>
Content-Transfer-Encoding: quoted-printable

Linux version 2.4.8-xfs (root@localhost.localdomain) (gcc version egcs-2.91=
.66 19990314/Linux (egcs-1.1.2 release)) #6 Wed Aug 22 14:01:14 CDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ecc00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000bff0000 (usable)
 BIOS-e820: 000000000bff0000 - 000000000bfffc00 (ACPI data)
 BIOS-e820: 000000000bfffc00 - 000000000c000000 (ACPI NVS)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009f800 for 4096 bytes.
On node 0 totalpages: 49136
zone(0): 4096 pages.
zone(1): 45040 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (fee00000)
Kernel command line: auto BOOT_IMAGE=3Dlinux-2.4.8 ro root=3D303 BOOT_FILE=
=3D/boot/vmlinuz-2.4.8
Initializing CPU#0
Detected 451.040 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 901.12 BogoMIPS
Memory: 189872k/196544k available (1582k kernel code, 6284k reserved, 992k =
data, 204k init, 0k highmem)
kdb version 1.8 by Scott Lurndal, Keith Owens. Copyright SGI, All Rights Re=
served
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor =3D 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU:             Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Can't find local APIC: non-existent or disabledin hardware
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfd8be, last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
PCI: Found IRQ 10 for device 00:0a.0
PCI: Sharing IRQ 10 with 00:0f.0
  got res[10000000:10000fff] for resource 0 of Texas Instruments PCI1211
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
SGI XFS with ACLs, EAs, DMAPI, quota, no debug enabled
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI ISAPNP enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
block: 128 slots per queue, batch=3D16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ALI15X3: IDE controller on PCI bus 00 dev 80
PCI: No IRQ known for interrupt pin A of device 00:10.0. Please try using p=
ci=3Dbiosirq.
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc90-0xfc97, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc98-0xfc9f, BIOS settings: hdc:pio, hdd:pio
hda: FUJITSU MHK2048AT, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
hdc: TOSHIBA CD-ROM XM-7002B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 9514260 sectors (4871 MB) w/512KiB Cache, CHS=3D629/240/63, (U)DMA
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 149M
agpgart: Detected Ali M1541 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] AGP 0.99 on ALi M1541 @ 0xe0000000 64MB
[drm] Initialized r128 2.1.6 20010405 on minor 0
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 10 for device 00:0a.0
PCI: Sharing IRQ 10 with 00:0f.0
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Yenta IRQ list 0ab8, PCI irq10
Socket status: 30000020
PCI: Found IRQ 5 for device 00:14.0
usb-ohci.c: USB OHCI at membase 0xcc81c000, IRQ 5
usb-ohci.c: usb-00:14.0, Acer Laboratories Inc. [ALi] M5237 USB
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
cs: cb_alloc(bus 2): vendor 0x10b7, device 0x5157
  got res[1800:187f] for resource 0 of PCI device 10b7:5157
  got res[10800000:1080007f] for resource 1 of PCI device 10b7:5157
  got res[10800080:108000ff] for resource 2 of PCI device 10b7:5157
  got res[10400000:1041ffff] for resource 6 of PCI device 10b7:5157
PCI: Enabling device 02:00.0 (0000 -> 0003)
Start mounting filesystem: ide0(3,3)
Ending clean XFS mount for filesystem: ide0(3,3)
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 204k freed
Adding Swap: 136072k swap-space (priority -1)
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
SMSC chip at EFER=3D0x370 key=3D0x55 devid=3D28 devrev=3D01
SMSC unknown chip type
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
ip_conntrack (1535 buckets, 12280 max)
3c59x.c:LK1.1.15 6 June 2001  Donald Becker and others. http://www.scyld.co=
m/network/vortex.html
See Documentation/networking/vortex.txt
02:00.0: 3Com PCI 3CCFE575BT Cyclone CardBus at 0x1800, PCI: Setting latenc=
y timer of device 02:00.0 to 64
 00:50:da:9a:a3:d5, IRQ 10
  product code 5a48 rev 07.1 date 12-04-99
02:00.0: CardBus functions mapped 10800080->cc863080
  8K byte-wide RAM 5:3 Rx:Tx split, MII interface.
  MII transceiver found at address 0, status 282d.
  Enabling bus-master transmits and whole-frame receives.
02:00.0: scatter/gather enabled. h/w checksums enabled
eth0: using default media MII
eth0: using default media MII
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x408-0x40f 0x480-0x=
48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.

--=-myEBTG10K44i8vEzXmSd
Content-ID: <1000389034.13124.5.camel@dialupoffice.adiis.net>
Content-Description: 
Content-Type: text/plain
Content-Disposition: attachment; filename=.config
Content-Transfer-Encoding: quoted-printable

#
# Automatically generated make config: don't edit
#
CONFIG_X86=3Dy
CONFIG_ISA=3Dy
# CONFIG_SBUS is not set
CONFIG_UID16=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_KMOD=3Dy

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
CONFIG_MK6=3Dy
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D5
CONFIG_X86_ALIGNMENT_16=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=3Dm
CONFIG_X86_CPUID=3Dm
CONFIG_NOHIGHMEM=3Dy
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=3Dy
# CONFIG_SMP is not set
CONFIG_X86_UP_IOAPIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
# CONFIG_UP_NMI_WATCHDOG is not set

#
# General setup
#
CONFIG_NET=3Dy
# CONFIG_VISWS is not set
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_NAMES=3Dy
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=3Dy

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=3Dy
CONFIG_CARDBUS=3Dy
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set
CONFIG_SYSVIPC=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=3Dy
CONFIG_KCORE_ELF=3Dy
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=3Dm
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dm
CONFIG_PM=3Dy
# CONFIG_ACPI is not set
CONFIG_APM=3Dy
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_PC_CML1=3Dm
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=3Dy
CONFIG_PARPORT_PC_SUPERIO=3Dy
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play configuration
#
CONFIG_PNP=3Dy
CONFIG_ISAPNP=3Dy
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dy
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=3Dm
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=3Dm
CONFIG_BLK_DEV_RAM_SIZE=3D4096

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK=3Dy
CONFIG_RTNETLINK=3Dy
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE=3Dm
# CONFIG_NET_IPGRE_BROADCAST is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dm
CONFIG_IP_NF_FTP=3Dm
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
CONFIG_IP_NF_MATCH_MARK=3Dm
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
CONFIG_IP_NF_MATCH_TCPMSS=3Dm
CONFIG_IP_NF_MATCH_STATE=3Dm
CONFIG_IP_NF_MATCH_UNCLEAN=3Dm
CONFIG_IP_NF_MATCH_OWNER=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_MIRROR=3Dm
CONFIG_IP_NF_NAT=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_IP_NF_NAT_FTP=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_TOS=3Dm
CONFIG_IP_NF_TARGET_MARK=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
CONFIG_IP_NF_COMPAT_IPCHAINS=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_IPV6=3Dm

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_IPTABLES=3Dm
CONFIG_IP6_NF_MATCH_LIMIT=3Dm
CONFIG_IP6_NF_MATCH_MARK=3Dm
CONFIG_IP6_NF_FILTER=3Dm
CONFIG_IP6_NF_MANGLE=3Dm
CONFIG_IP6_NF_TARGET_MARK=3Dm
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set

#
# =20
#
# CONFIG_IPX is not set
CONFIG_ATALK=3Dm
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
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
# Telephony Support
#
# CONFIG_PHONE is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=3Dy

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=3Dy
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=3Dm

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=3Dy
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_RZ1000=3Dy
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_AEC62XX is not set
CONFIG_BLK_DEV_ALI15X3=3Dy
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=3Dy

#
# SCSI support
#
CONFIG_SCSI=3Dm

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=3Dm
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=3D2
CONFIG_CHR_DEV_SG=3Dm

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_DEBUG_QUEUES=3Dy
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
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
# CONFIG_SCSI_NCR53C8XX is not set
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
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_SCSI_PCMCIA is not set

#
# Fusion MPT device support
#
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

#
# Network device support
#
CONFIG_NETDEVICES=3Dy

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Appletalk devices
#
# CONFIG_APPLETALK is not set
CONFIG_DUMMY=3Dm
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
# CONFIG_ARM_AM79C961A is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=3Dy
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
CONFIG_VORTEX=3Dm
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
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=3Dm
CONFIG_PPP_MULTILINK=3Dy
CONFIG_PPP_FILTER=3Dy
CONFIG_PPP_ASYNC=3Dm
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_PPPOE=3Dm
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=3Dy
# CONFIG_STRIP is not set
# CONFIG_WAVELAN is not set
# CONFIG_ARLAN is not set
CONFIG_AIRONET4500=3Dm
CONFIG_AIRONET4500_NONCS=3Dm
# CONFIG_AIRONET4500_PNP is not set
# CONFIG_AIRONET4500_PCI is not set
# CONFIG_AIRONET4500_ISA is not set
# CONFIG_AIRONET4500_I365 is not set
CONFIG_AIRONET4500_PROC=3Dm
# CONFIG_AIRO is not set

#
# Wireless Pcmcia cards support
#
# CONFIG_PCMCIA_HERMES is not set
CONFIG_AIRO_CS=3Dm
CONFIG_NET_WIRELESS=3Dy

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
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=3Dy
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
CONFIG_PCMCIA_XIRTULIP=3Dm
CONFIG_NET_PCMCIA_RADIO=3Dy
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_PCMCIA_NETWAVE is not set
# CONFIG_PCMCIA_WAVELAN is not set
CONFIG_AIRONET4500_CS=3Dm

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
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=3Dm
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=3Dm
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_SERIAL=3Dy
CONFIG_SERIAL_CONSOLE=3Dy
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
CONFIG_PRINTER=3Dm
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
CONFIG_MOUSE=3Dy
CONFIG_PSMOUSE=3Dy
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
CONFIG_JOYSTICK=3Dy

#
# Game port support
#
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set

#
# Gameport joysticks
#
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set

#
# Serial port support
#
# CONFIG_INPUT_SERPORT is not set

#
# Serial port joysticks
#
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_IFORCE_USB is not set

#
# Parallel port joysticks
#
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
CONFIG_NVRAM=3Dm
CONFIG_RTC=3Dm
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=3Dy
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
CONFIG_AGP_ALI=3Dy
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=3Dy
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
CONFIG_DRM_R128=3Dy
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_MGA is not set

#
# PCMCIA character devices
#
# CONFIG_PCMCIA_SERIAL_CS is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=3Dm

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=3Dy

#
# Video Adapters
#
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_STRADIS is not set

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
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# File systems
#
CONFIG_QUOTA=3Dy
CONFIG_FS_POSIX_ACL=3Dy
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=3Dm
# CONFIG_REISERFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=3Dm
CONFIG_EFS_FS=3Dm
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=3Dy
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=3Dy
CONFIG_JOLIET=3Dy
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=3Dy
CONFIG_DEVFS_FS=3Dy
CONFIG_DEVFS_MOUNT=3Dy
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=3Dy
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=3Dy
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_PAGE_BUF=3Dy
CONFIG_XFS_FS=3Dy
# CONFIG_XFS_RT is not set
CONFIG_HAVE_ATTRCTL=3Dy
CONFIG_XFS_DMAPI=3Dy
CONFIG_XFS_QUOTA=3Dy

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V3=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
CONFIG_SUNRPC=3Dm
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_SMB_FS=3Dm
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_SMB_NLS=3Dy
CONFIG_NLS=3Dy

#
# Native Language Support
#
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dm
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
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=3Dm
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
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=3Dy
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
CONFIG_SOUND_ESSSOLO1=3Dm
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set

#
# USB support
#
CONFIG_USB=3Dy
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
# CONFIG_USB_BANDWIDTH is not set

#
# USB Controllers
#
# CONFIG_USB_UHCI is not set
# CONFIG_USB_UHCI_ALT is not set
CONFIG_USB_OHCI=3Dy

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=3Dm
# CONFIG_USB_BLUETOOTH is not set
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_DPCM is not set
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_WACOM is not set

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=3Dm
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_IBMCAM is not set
CONFIG_USB_OV511=3Dm
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_DABUSB is not set

#
# USB Network adaptors
#
# CONFIG_USB_PLUSB is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_NET1080 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB misc drivers
#
# CONFIG_USB_RIO500 is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_KDB=3Dy
CONFIG_KDB_OFF=3Dy

#
# Load all symbols for debugging is required for KDB
#
CONFIG_KALLSYMS=3Dy
# CONFIG_FRAME_POINTER is not set

--=-myEBTG10K44i8vEzXmSd--

--=-QqOCP62N8SsnrlrmLchR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA7oLoEHcn7/7W9zdERAjwwAJ9+N2W0bludytWqQPCgnpML8sNDkQCeK7Xv
k2vM7HOepFrLmjOooOmb6mE=
=HEHl
-----END PGP SIGNATURE-----

--=-QqOCP62N8SsnrlrmLchR--

