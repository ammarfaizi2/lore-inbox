Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264130AbTDWQnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbTDWQnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:43:13 -0400
Received: from lakemtao03.cox.net ([68.1.17.242]:17806 "EHLO
	lakemtao03.cox.net") by vger.kernel.org with ESMTP id S264130AbTDWQm5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:42:57 -0400
Message-ID: <3EA6C558.5040004@cox.net>
Date: Wed, 23 Apr 2003 11:54:48 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.4.21-rc1] USB Trackball broken
Content-Type: multipart/mixed;
 boundary="------------090405070209080809060006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090405070209080809060006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I am running RedHat 9. Trackball is detected and works when using the 
stock 2.4.20-9 kernel that RedHat provided.

With 2.4.21-rc1, I have included the USB and input devices in the 
kernel, as modules, and as various combinations in between. My USB 
Logitech Trackball shows up as being detected and setup, but it doesn't 
work. Attached is my config and a trimmed down dmesg. (ppa is messed up 
and floods me with messages)
I have USB vebose debugging turned on. That may help. Please let me know 
what information you might need in addition.


Thanks,
David

--------------090405070209080809060006
Content-Type: text/plain;
 name="config-2.4.21-rc1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-2.4.21-rc1"

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MPENTIUM4=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HIGHIO=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_CPU_IDLE=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_TFTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_NAT_LOCAL=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_NAT_TFTP=y
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IPV6=y
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=y
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
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_ATM=y
CONFIG_ATM_CLIP=y
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_ATM_BR2684=m
CONFIG_ATM_BR2684_IPFILTER=y
CONFIG_VLAN_8021Q=m
CONFIG_IPX=m
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=y
CONFIG_COPS_DAYNA=y
CONFIG_COPS_TANGENT=y
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
CONFIG_DECNET=m
CONFIG_DECNET_SIOCGIFCONF=y
CONFIG_DECNET_ROUTER=y
CONFIG_DECNET_ROUTE_FWMARK=y
CONFIG_BRIDGE=m
CONFIG_NET_DIVERT=y
CONFIG_WAN_ROUTER=m
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
CONFIG_NET_CLS_POLICE=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_PPA=y
CONFIG_SCSI_IMM=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_BONDING=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_TULIP=m
CONFIG_TULIP_MMIO=y
CONFIG_SIS900=m
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=2048
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
CONFIG_BUSMOUSE=y
CONFIG_ATIXL_BUSMOUSE=m
CONFIG_LOGIBUSMOUSE=m
CONFIG_MS_BUSMOUSE=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_82C710_MOUSE=m
CONFIG_PC110_PAD=m
CONFIG_MK712_MOUSE=m
CONFIG_INPUT_GAMEPORT=y
CONFIG_INPUT_NS558=y
CONFIG_INPUT_EMU10K1=m
CONFIG_INPUT_SERIO=m
CONFIG_INPUT_SERPORT=m
CONFIG_INPUT_ANALOG=y
CONFIG_INTEL_RNG=m
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_FTAPE=m
CONFIG_ZFTAPE=m
CONFIG_ZFT_DFLT_BLK_SZ=10240
CONFIG_ZFT_COMPRESSOR=m
CONFIG_FT_NR_BUFFERS=3
CONFIG_FT_NORMAL_DEBUG=y
CONFIG_FT_STD_FDC=y
CONFIG_FT_FDC_THR=8
CONFIG_FT_FDC_MAX_RATE=2000
CONFIG_FT_ALPHA_CLOCK=0
CONFIG_AGP=m
CONFIG_AGP_SIS=y
CONFIG_QUOTA=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_HFS_FS=m
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_NTFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_ZISOFS_FS=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_SGI_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=m
CONFIG_SOUND_EMU10K1=m
CONFIG_SOUND_ICH=m
CONFIG_USB=y
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI=y
CONFIG_USB_OHCI=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=m
CONFIG_USB_HIDDEV=m
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m

--------------090405070209080809060006
Content-Type: text/plain;
 name="dmesg-2.4.21-rc1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.4.21-rc1"

hub.c: power on to power good time: 0ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RRRRRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c1657980
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
host/usb-uhci.c: $Revision: 1.275 $ time 11:27:52 Apr 23 2003
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
host/usb-ohci.c: USB OHCI at membase 0xe080f000, IRQ 9
host/usb-ohci.c: usb-00:03.0, Silicon Integrated Systems [SiS] 7001
usb.c: new USB bus registered, assigned bus number 2
usb.c: kmalloc IF c1657c00, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: e080f000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c1657c00
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
host/usb-ohci.c: USB OHCI at membase 0xe0811000, IRQ 9
host/usb-ohci.c: usb-00:03.1, Silicon Integrated Systems [SiS] 7001 (#2)
usb.c: new USB bus registered, assigned bus number 3
usb.c: kmalloc IF c1657e80, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: e0811000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c1657e80
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
host/usb-ohci.c: USB OHCI at membase 0xe0813000, IRQ 9
host/usb-ohci.c: usb-00:03.2, Silicon Integrated Systems [SiS] 7001 (#3)
usb.c: new USB bus registered, assigned bus number 4
usb.c: kmalloc IF dfef4280, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: e0813000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dfef4280
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
ip6_tables: (C) 2000-2002 Netfilter core team
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 83k freed
VFS: Mounted root (ext2 filesystem).
ehci-hcd 00:03.3: GetStatus port 1 status 001403 POWER sig=k  CSC CONNECT
hub.c: port 1, portstatus 501, change 1, 480 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 501, change 1, 480 Mb/s
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 104k freed
hub.c: port 1, portstatus 501, change 0, 480 Mb/s
hub.c: port 1, portstatus 501, change 0, 480 Mb/s
hub.c: port 1, portstatus 501, change 0, 480 Mb/s
hub.c: port 1, portstatus 501, change 0, 480 Mb/s
ehci-hcd 00:03.3: port 1 low speed --> companion
ehci-hcd 00:03.3: GetStatus port 1 status 003002 POWER OWNER sig=se0  CSC
hub.c: port 1, portstatus 0, change 1, 12 Mb/s
ehci-hcd 00:03.3: free_config  devnum 0
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
hub.c: port 3, portstatus 100, change 0, 12 Mb/s
hub.c: port 4, portstatus 100, change 0, 12 Mb/s
hub.c: port 5, portstatus 100, change 0, 12 Mb/s
hub.c: port 6, portstatus 100, change 0, 12 Mb/s
hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 303, change 10, 1.5 Mb/s
hub.c: new USB device 00:03.0-1, assigned address 2
usb.c: kmalloc IF dfef4c40, numif 1
usb.c: skipped 1 class/vendor specific interface descriptors
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 2 default language ID 0x409
Manufacturer: Logitech
Product: USB Receiver
: USB HID v1.10 Mouse [Logitech USB Receiver] on usb2:2.0
usb.c: hid driver claimed interface dfef4c40
usb.c: kusbd: /sbin/hotplug add 2
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
Adding Swap: 1004020k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,65), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
microcode: CPU0 no microcode found! (sig=f24, pflags=4)
sis900.c: v1.08.06 9/24/2002
divert: allocating divert_blk for eth0
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0x9800, IRQ 9, 00:e0:18:9d:4f:d0.
eth0: Media Link On 100mbps full-duplex 
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
divert: allocating divert_blk for eth1
eth1: ADMtek Comet rev 17 at 0xe081e000, 00:20:78:04:68:6F, IRQ 9.
eth0: no IPv6 routers present
ehci-hcd 00:03.3: GetStatus port 1 status 001002 POWER sig=se0  CSC
hub.c: port 1, portstatus 100, change 1, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 1, 12 Mb/s
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
hub.c: port 3, portstatus 100, change 0, 12 Mb/s
hub.c: port 4, portstatus 100, change 0, 12 Mb/s
hub.c: port 5, portstatus 100, change 0, 12 Mb/s
hub.c: port 6, portstatus 100, change 0, 12 Mb/s
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
usb.c: USB disconnect on device 00:03.0-1 address 2
usb.c: kusbd: /sbin/hotplug remove 2
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
hub.c: port 1, portstatus 300, change 2, 1.5 Mb/s
hub.c: port 1 enable change, status 300
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
ehci-hcd 00:03.3: GetStatus port 1 status 001403 POWER sig=k  CSC CONNECT
hub.c: port 1, portstatus 501, change 1, 480 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 501, change 1, 480 Mb/s
hub.c: port 1, portstatus 501, change 0, 480 Mb/s
hub.c: port 1, portstatus 501, change 0, 480 Mb/s
hub.c: port 1, portstatus 501, change 0, 480 Mb/s
hub.c: port 1, portstatus 501, change 0, 480 Mb/s
ehci-hcd 00:03.3: port 1 low speed --> companion
ehci-hcd 00:03.3: GetStatus port 1 status 003002 POWER OWNER sig=se0  CSC
hub.c: port 1, portstatus 0, change 1, 12 Mb/s
ehci-hcd 00:03.3: free_config  devnum 0
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
hub.c: port 3, portstatus 100, change 0, 12 Mb/s
hub.c: port 4, portstatus 100, change 0, 12 Mb/s
hub.c: port 5, portstatus 100, change 0, 12 Mb/s
hub.c: port 6, portstatus 100, change 0, 12 Mb/s
hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 303, change 10, 1.5 Mb/s
hub.c: new USB device 00:03.0-1, assigned address 3
usb.c: kmalloc IF dfef4c40, numif 1
usb.c: skipped 1 class/vendor specific interface descriptors
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 3 default language ID 0x409
Manufacturer: Logitech
Product: USB Receiver
: USB HID v1.10 Mouse [Logitech USB Receiver] on usb2:3.0
usb.c: hid driver claimed interface dfef4c40
usb.c: kusbd: /sbin/hotplug add 3
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
ehci-hcd 00:03.3: GetStatus port 1 status 001002 POWER sig=se0  CSC
hub.c: port 1, portstatus 100, change 1, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 1, 12 Mb/s
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
hub.c: port 3, portstatus 100, change 0, 12 Mb/s
hub.c: port 4, portstatus 100, change 0, 12 Mb/s
hub.c: port 5, portstatus 100, change 0, 12 Mb/s
hub.c: port 6, portstatus 100, change 0, 12 Mb/s
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
usb.c: USB disconnect on device 00:03.0-1 address 3
usb.c: kusbd: /sbin/hotplug remove 3
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
hub.c: port 1, portstatus 300, change 2, 1.5 Mb/s
hub.c: port 1 enable change, status 300
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
ehci-hcd 00:03.3: GetStatus port 1 status 001403 POWER sig=k  CSC CONNECT
hub.c: port 1, portstatus 501, change 1, 480 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 501, change 1, 480 Mb/s
hub.c: port 1, portstatus 501, change 0, 480 Mb/s
hub.c: port 1, portstatus 501, change 0, 480 Mb/s
hub.c: port 1, portstatus 501, change 0, 480 Mb/s
hub.c: port 1, portstatus 501, change 0, 480 Mb/s
ehci-hcd 00:03.3: port 1 low speed --> companion
ehci-hcd 00:03.3: GetStatus port 1 status 003002 POWER OWNER sig=se0  CSC
hub.c: port 1, portstatus 0, change 1, 12 Mb/s
ehci-hcd 00:03.3: free_config  devnum 0
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
hub.c: port 3, portstatus 100, change 0, 12 Mb/s
hub.c: port 4, portstatus 100, change 0, 12 Mb/s
hub.c: port 5, portstatus 100, change 0, 12 Mb/s
hub.c: port 6, portstatus 100, change 0, 12 Mb/s
hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 303, change 10, 1.5 Mb/s
hub.c: new USB device 00:03.0-1, assigned address 4
usb.c: kmalloc IF dfef4c40, numif 1
usb.c: skipped 1 class/vendor specific interface descriptors
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 4 default language ID 0x409
Manufacturer: Logitech
Product: USB Receiver
: USB HID v1.10 Mouse [Logitech USB Receiver] on usb2:4.0
usb.c: hid driver claimed interface dfef4c40
usb.c: kusbd: /sbin/hotplug add 4
hub.c: port 2, portstatus 100, change 0, 12 Mb/s

--------------090405070209080809060006--

