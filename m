Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTDWWWd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 18:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbTDWWWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 18:22:33 -0400
Received: from marshall.modwest.com ([216.129.251.30]:64430 "EHLO
	mail.modwest.com") by vger.kernel.org with ESMTP id S264266AbTDWWWX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 18:22:23 -0400
From: Nils Holland <nils@ravishing.de>
Organization: Ravishing Enterprises
To: David van Hoose <davidvh@cox.net>
Subject: Re: [2.4.21-rc1] USB Trackball broken
Date: Thu, 24 Apr 2003 00:34:20 +0200
User-Agent: KMail/1.5.1
References: <3EA6C558.5040004@cox.net> <20030423201619.GB12889@kroah.com> <3EA707D2.1000507@cox.net>
In-Reply-To: <3EA707D2.1000507@cox.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304240034.20872.nils@ravishing.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 April 2003 23:38, you wrote:

> >
> > If you do not build in the CONFIG_USB_EHCI driver, does it work ok?
>
> Nope. Same deal. Tried all 6 ports too. Attached is the dmesg and config.

Strange. My trackball actually seems to be the very same as yours (Logitech 
Cordless Trackman Optical). I'm also using a Logitech cordless keyboard, but 
that's a different issue.

Anyway, here's my .config and dmesg with which this stuff is working just 
fine:

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
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
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_1284=y
CONFIG_PNP=m
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_STATS=y
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_INET_ECN=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_IPTABLES=m
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
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
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
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_IDEDMA_IVB=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=3
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_TUN=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_VIA_RHINE=m
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_PPDEV=m
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
CONFIG_INPUT_SERIO=m
CONFIG_INPUT_SERPORT=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_AGP=m
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_R128=m
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_PROC_FS=y
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=m
CONFIG_JBD=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_JFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=m
CONFIG_UDF_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_ZISOFS_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=m
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=m
CONFIG_USB_OHCI=m
CONFIG_USB_PRINTER=m
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_SCANNER=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

Linux version 2.4.21-rc1 (root@lisa) (gcc version 3.2) #5 Tue Apr 22 13:12:21 
CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff3000 (ACPI NVS)
 BIOS-e820: 000000002fff3000 - 0000000030000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
767MB LOWMEM available.
On node 0 totalpages: 196592
zone(0): 4096 pages.
zone(1): 192496 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda7 hdb=ide-scsi hdc=ide-scsi hdd=ide-scsi 
vga=4 
ide_setup: hdb=ide-scsi
ide_setup: hdc=ide-scsi
ide_setup: hdd=ide-scsi
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1536.866 MHz processor.
Console: colour VGA+ 80x30
Calibrating delay loop... 3067.08 BogoMIPS
Memory: 775812k/786368k available (1026k kernel code, 10168k reserved, 361k 
data, 80k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD Athlon(tm) XP 1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1536.8875 MHz.
..... host bus clock speed is 267.2846 MHz.
cpu: 0, clocks: 2672846, slice: 1336423
CPU0<T0:2672832,T1:1336400,D:9,S:1336423,C:2672846>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb470, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/3074] at 00:11.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
spurious 8259A interrupt: IRQ7.
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD800BB-60CJA0, ATA DISK drive
hdb: IDE DVD-ROM 16X, ATAPI CD/DVD-ROM drive
blk: queue c029af20, I/O limit 4095Mb (mask 0xffffffff)
hdc: CD-ROM 52X/AKH, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG CD-R/RW SW-240B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(100)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 03:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 80k freed
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Adding Swap: 1052216k swap-space (priority 42)
SCSI subsystem driver Revision: 1.00
hdb: attached ide-scsi driver.
hdc: attached ide-scsi driver.
hdd: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: IDE       Model: DVD-ROM 16X       Rev: 2.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: E-IDE     Model: CD-ROM 52X/AKH    Rev: A60 
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: SAMSUNG   Model: CD-R/RW SW-240B   Rev: R403
  Type:   CD-ROM                             ANSI SCSI revision: 02
PCI: Found IRQ 5 for device 00:0b.0
PCI: Sharing IRQ 5 with 00:11.2
PCI: Sharing IRQ 5 with 00:11.3
PCI: Sharing IRQ 5 with 00:11.4
mice: PS/2 mouse device common for all mice
Linux video capture interface: v1.00
i2c-core.o: i2c core module
DVB: registering new adapter (TT-Budget/WinTV-NOVA-CI PCI).
PCI: Found IRQ 11 for device 00:09.0
stv0299.c: setup for tuner BSRU6, TDQB-S00x
DVB: registering frontend 0:0 (STV0299/TSA5059/SL1935 based)...
via-rhine.c:v1.10-LK1.1.17  March-1-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
PCI: Found IRQ 10 for device 00:0c.0
eth0: VIA VT6102 Rhine-II at 0xd400, 00:05:5d:08:ca:a2, IRQ 10.
eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 0021.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 13:16:06 Apr 22 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 5 for device 00:11.2
PCI: Sharing IRQ 5 with 00:0b.0
PCI: Sharing IRQ 5 with 00:11.3
PCI: Sharing IRQ 5 with 00:11.4
usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 5 for device 00:11.3
PCI: Sharing IRQ 5 with 00:0b.0
PCI: Sharing IRQ 5 with 00:11.2
PCI: Sharing IRQ 5 with 00:11.4
usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 5 for device 00:11.4
PCI: Sharing IRQ 5 with 00:0b.0
PCI: Sharing IRQ 5 with 00:11.2
PCI: Sharing IRQ 5 with 00:11.3
usb-uhci.c: USB UHCI at I/O 0xe400, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: new USB device 00:11.2-2, assigned address 2
usb.c: USB device 2 (vend/prod 0x46d/0xc505) is not claimed by any active 
driver.
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 2, lun 0
sr0: scsi3-mmc drive: 1x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 8x/52x cd/rw xa/form2 cdda tray
sr2: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
usb.c: registered new driver hiddev
usb.c: registered new driver hid
input1: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb1:2.0
input2: USB HID v1.10 Mouse [Logitech USB Receiver] on usb1:2.1
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb-uhci.c: ENXIO 84000280, flags 0, urb ee03b0c0, burb ee4b1f40
usb-uhci.c: ENXIO 84000280, flags 0, urb ee03b0c0, burb ee4b1f40
usb-uhci.c: ENXIO 84000280, flags 0, urb ee03b0c0, burb ee4b1f40
usb-uhci.c: ENXIO 84000280, flags 0, urb ee03b0c0, burb ee4b1f40
usb-uhci.c: ENXIO 84000280, flags 0, urb ee03b0c0, burb ee4b1f40
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 9 ret -6
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: Printer, HEWLETT-PACKARD DESKJET 930C
lp0: using parport0 (polling).
keyboard: Timeout - AT keyboard not present?(f4)

Bye,
Nils<nils@ravishing.de>

-- 
celine.ravishing.de
Linux 2.4.21-rc1 #5 Tue Apr 22 13:12:21 CEST 2003 i686
 12:26am  up 3 min,  2 users,  load average: 0.33, 0.26, 0.11

