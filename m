Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAaEZr>; Tue, 30 Jan 2001 23:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129729AbRAaEZh>; Tue, 30 Jan 2001 23:25:37 -0500
Received: from river.it.gvsu.edu ([148.61.1.16]:31480 "EHLO river.it.gvsu.edu")
	by vger.kernel.org with ESMTP id <S129562AbRAaEZe>;
	Tue, 30 Jan 2001 23:25:34 -0500
Message-ID: <3A7793B2.2020502@lycosmail.com>
Date: Tue, 30 Jan 2001 23:25:22 -0500
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4.1 Detects 64 MB RAM, actual 192MB
Content-Type: multipart/mixed;
 boundary="------------080005050400080108000102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080005050400080108000102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

2.4.1 detects 64 MB, but 2.4.0 detects 192 (Maybe 191, not sure).

dmesg attached.

--------------080005050400080108000102
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.4.1 (root@tabriel) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #9 Tue Jan 30 15:35:21 EST 2001
BIOS-provided physical RAM map:
 BIOS-88: 000000000009f000 @ 0000000000000000 (usable)
 BIOS-88: 0000000003ff0000 @ 0000000000100000 (usable)
On node 0 totalpages: 16624
zone(0): 4096 pages.
zone(1): 12528 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=k241 ro root=341
Initializing CPU#0
Detected 598.848 MHz processor.
Console: colour VGA+ 132x43
Calibrating delay loop... 1196.03 BogoMIPS
Memory: 63276k/66496k available (961k kernel code, 2832k reserved, 321k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0081f9ff c0c1f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After vendor init, caps: 0081f9ff c0c1f9ff 00000000 00000000
CPU: After generic, caps: 0081f9ff c0c1f9ff 00000000 00000000
CPU: Common caps: 0081f9ff c0c1f9ff 00000000 00000000
CPU: AMD-K7(tm) Processor stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb470, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.2 present.
39 structures occupying 1001 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 6.0 PG
BIOS Release: 11/23/99
Board Vendor: MICRO-STAR INTERNATIONAL CO., LTD.
Board Name: MS-6167 (AMD751).
Board Version: 1.X.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 16
0x378: readIntrThreshold is 16
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x48
0x378: ECP settings irq=7 dma=<none or set by other means>
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,EPP,ECP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
block: queued sectors max/low 41821kB/13940kB, 128 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7409: IDE controller on PCI bus 00 dev 39
AMD7409: chipset revision 3
AMD7409: not 100% native mode: will probe irqs later
AMD7409: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC AC28400R, ATA DISK drive
hdb: IBM-DHEA-38451, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-M1202, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=1027/255/63, UDMA(33)
hdb: 16514064 sectors (8455 MB) w/472KiB Cache, CHS=1027/255/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1
 /dev/ide/host0/bus0/target1/lun0: p1 p2 < p5 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Real Time Clock Driver v1.10d
ppdev: user-space parallel port driver
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 28M
agpgart: Detected AMD Irongate chipset
agpgart: AGP aperture is 32M @ 0xd8000000
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 15:34:20 Jan 30 2001
usb-uhci.c: High bandwidth mode enabled
usb.c: registered new driver usbscanner
scanner.c: USB Scanner support registered.
usb.c: registered new driver usblp
usb.c: registered new driver rio500
rio500.c: USB Rio support registered.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 204k freed
Adding Swap: 136512k swap-space (priority -1)

--------------080005050400080108000102--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
