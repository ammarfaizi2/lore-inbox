Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263499AbTDWV0u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbTDWV0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:26:50 -0400
Received: from lakemtao02.cox.net ([68.1.17.243]:45230 "EHLO
	lakemtao02.cox.net") by vger.kernel.org with ESMTP id S263499AbTDWV0e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:26:34 -0400
Message-ID: <3EA707D2.1000507@cox.net>
Date: Wed, 23 Apr 2003 16:38:26 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Nils Holland <nils@ravishing.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-rc1] USB Trackball broken
References: <3EA6C558.5040004@cox.net> <200304232134.42349.nils@ravishing.de> <3EA6EE47.4000801@cox.net> <20030423201619.GB12889@kroah.com>
In-Reply-To: <20030423201619.GB12889@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------040701020600060602050504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040701020600060602050504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Wed, Apr 23, 2003 at 02:49:27PM -0500, David van Hoose wrote:
> 
>>Nils Holland wrote:
>>
>>>On Wednesday 23 April 2003 18:54, David van Hoose wrote:
>>>
>>>
>>>
>>>>I am running RedHat 9. Trackball is detected and works when using the
>>>>stock 2.4.20-9 kernel that RedHat provided.
>>>>
>>>>With 2.4.21-rc1, I have included the USB and input devices in the
>>>>kernel, as modules, and as various combinations in between. My USB
>>>>Logitech Trackball shows up as being detected and setup, but it doesn't
>>>>work.
>>>
>>>
>>>I'm using a Logitech Cordless TrackMan here, and this works fine with 
>>>2.4.21-rc1. I don't know which trackball you have, but the Logitech input 
>>>devices all seem to be using more or less the same receiver, and this is 
>>>what the problem would be about.
>>>
>>>Anyway, if not done already, I would suggest that you plug the trackball 
>>>right into one of the computer's USB ports and not into an external hub to 
>>>see if that makes a difference.
>>
>>I have a Logitech Cordless Optical Trackman. It detects as a Logitech 
>>Cordless Receiver. My motherboard is an Asus P4S8X. It has the 
>>SiS648/SiS963 chipsets. I'm not using an external hub. I'm using the 
>>ports on my motherboard. I've tried using all 6 USB ports I have, but I 
>>get the same thing; detection and no input.
> 
> 
> If you do not build in the CONFIG_USB_EHCI driver, does it work ok?

Nope. Same deal. Tried all 6 ports too. Attached is the dmesg and config.

Regards,
David

--------------040701020600060602050504
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

--------------040701020600060602050504
Content-Type: text/plain;
 name="dmesg-2.4.21-rc1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.4.21-rc1"

Linux version 2.4.21-rc1 (root@aeon) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Wed Apr 23 16:18:31 CDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131068
zone(0): 4096 pages.
zone(1): 126972 pages.
zone(2): 0 pages.
Kernel command line: ro root=LABEL=/ parport=auto
Found and enabled local APIC!
Initializing CPU#0
Detected 2533.091 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 5059.37 BogoMIPS
Memory: 514892k/524272k available (1712k kernel code, 8992k reserved, 588k data, 104k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.53GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2532.9929 MHz.
..... host bus clock speed is 133.3153 MHz.
cpu: 0, clocks: 1333153, slice: 666576
CPU0<T0:1333152,T1:666576,D:0,S:666576,C:1333153>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf11b0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1039/0963] at 00:02.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,EPP,ECP]
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (interrupt-driven).
lp0: console ready
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
divert: not allocating divert_blk for non-ethernet device dummy0
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SiS648    ATA 133 controller
    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 6Y080P0, ATA DISK drive
hdb: Maxtor 53073H6, ATA DISK drive
blk: queue c039d6a0, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c039d7dc, I/O limit 4095Mb (mask 0xffffffff)
hdc: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=9964/255/63, UDMA(133)
hdb: attached ide-disk driver.
hdb: host protected area => 1
hdb: 60030432 sectors (30736 MB) w/2048KiB Cache, CHS=3736/255/63, UDMA(100)
hdc: attached ide-cdrom driver.
hdc: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
 hdb: hdb1
ide-floppy driver 0.99.newide
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
ppa: Version 2.07 (for Linux 2.4.x)
ppa: Found device at ID 6, Attempting to use EPP 32 bit
ppa: Communication established with ID 6 using EPP 32 bit
scsi1 : Iomega VPI0 (ppa) interface
  Vendor: IOMEGA    Model: ZIP 100           Rev: D.09
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi1, channel 0, id 6, lun 0
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sns = 70  2
ASC=3a ASCQ= 0
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x00 0x00 0x11 0x00 0x00 0x00 0x00 0x3a 0x00 0x00 0x00 0x00 0x00 0xff 0xfe 0x01 0x00 0x00 0x00 0x00 
sda : block size assumed to be 512 bytes, disk size 1GB.  
 sda: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
 unable to read partition table
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/usb-uhci.c: $Revision: 1.275 $ time 16:21:04 Apr 23 2003
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
host/usb-ohci.c: USB OHCI at membase 0xe080d000, IRQ 9
host/usb-ohci.c: usb-00:03.0, Silicon Integrated Systems [SiS] 7001
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF c1657940, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: e080d000
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
usb.c: hub driver claimed interface c1657940
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
host/usb-ohci.c: USB OHCI at membase 0xe080f000, IRQ 9
host/usb-ohci.c: usb-00:03.1, Silicon Integrated Systems [SiS] 7001 (#2)
usb.c: new USB bus registered, assigned bus number 2
usb.c: kmalloc IF c1657bc0, numif 1
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
usb.c: hub driver claimed interface c1657bc0
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
host/usb-ohci.c: USB OHCI at membase 0xe0811000, IRQ 9
host/usb-ohci.c: usb-00:03.2, Silicon Integrated Systems [SiS] 7001 (#3)
usb.c: new USB bus registered, assigned bus number 3
usb.c: kmalloc IF c1657e40, numif 1
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
usb.c: hub driver claimed interface c1657e40
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
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 104k freed
hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 303, change 10, 1.5 Mb/s
hub.c: new USB device 00:03.0-1, assigned address 2
usb.c: kmalloc IF dfef4a00, numif 1
usb.c: skipped 1 class/vendor specific interface descriptors
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 2 default language ID 0x409
Manufacturer: Logitech
Product: USB Receiver
: USB HID v1.10 Mouse [Logitech USB Receiver] on usb1:2.0
usb.c: hid driver claimed interface dfef4a00
usb.c: kusbd: /sbin/hotplug add 2
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
Adding Swap: 1004020k swap-space (priority -1)
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sns = 70  2
ASC=3a ASCQ= 0
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x00 0x00 0x11 0x00 0x00 0x00 0x00 0x3a 0x00 0x00 0x00 0x00 0x00 0xff 0xfe 0x01 0x00 0x00 0x00 0x00 
sda : block size assumed to be 512 bytes, disk size 1GB.  
sda: Write Protect is off
 sda: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
 unable to read partition table
Device not ready.  Make sure there is a disc in the drive.
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sns = 70  2
ASC=3a ASCQ= 0
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x00 0x00 0x11 0x00 0x00 0x00 0x00 0x3a 0x00 0x00 0x00 0x00 0x00 0xff 0xfe 0x01 0x00 0x00 0x00 0x00 
sda : block size assumed to be 512 bytes, disk size 1GB.  
sda: Write Protect is off
 sda: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
 unable to read partition table
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
eth1: ADMtek Comet rev 17 at 0xe081c000, 00:20:78:04:68:6F, IRQ 9.
eth0: no IPv6 routers present

--------------040701020600060602050504--

