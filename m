Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTGKVZT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTGKVZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:25:19 -0400
Received: from zero.dsl.niluge.net ([80.65.224.59]:60808 "EHLO mx.niluge.net")
	by vger.kernel.org with ESMTP id S261741AbTGKVZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:25:06 -0400
Date: Fri, 11 Jul 2003 23:39:52 +0200
From: juan L <jcb@niluge.net>
To: linux-kernel@vger.kernel.org
Subject: Dell C600 broken bios ? -> hardware freeze
Message-ID: <20030711213952.GA531@zeus.niluge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i'm having lots and lots of hardware freezes, i've seen that c600's bios
is broken . what can i do ?


system freezes either when alsa modules load or when X11 starts and
sometimes a little while after x11 is started

here is the dmesg


BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
BIOS-e820: 0000000000100000 - 000000000ffdb000 (usable)
BIOS-e820: 000000000ffdb000 - 0000000010000000 (reserved)
BIOS-e820: 00000000100a0000 - 0000000010100000 (reserved)
BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
user-defined physical RAM map:
user: 0000000000000000 - 000000000009fc00 (usable)
user: 000000000009fc00 - 00000000000a0000 (reserved)
user: 0000000000100000 - 000000000ffdb000 (usable)
255MB LOWMEM available.
On node 0 totalpages: 65499
zone(0): 4096 pages.
zone(1): 61403 pages.
zone(2): 0 pages.
Dell Latitude C600 machine detected. Mousepad Resume Bug workaround enabled.
Kernel command line: root=/dev/hda6 vga=0x305 video=vesa:ywrap,mtrr idebus=33 noapic mem=261996K
ide_setup: idebus=33
Initializing CPU#0
Detected 701.569 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1396.08 BogoMIPS
Memory: 256804k/261996k available (1227k kernel code, 4804k reserved, 414k data, 108k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfc13e, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 08 [IRQ]
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd & kiswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
vesafb: framebuffer at 0xf8000000, mapped to 0xd0800000, size 6144k
vesafb: mode is 1024x768x8, linelength=1024, pages=9
vesafb: protected mode interface info at c000:6294
vesafb: pmi: set display start = c00c6302, set palette = c00c633c
vesafb: pmi: ports = ec10 ec16 ec54 ec38 ec3c ec5c ec00 ec04 ecb0 ecb2 ecb4 
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=6144
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
ide0: BM-DMA at 0x0860-0x0867, BIOS settings: hda:DMA, hdb:pio
hda: IC25N020ATDA04-0, ATA DISK drive
blk: queue c02ddac0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/1806KiB Cache, CHS=2432/255/63, UDMA(33)
Partition check:
/dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 > p3
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 11 for device 00:07.2
PCI: Sharing IRQ 11 with 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
PCI: Sharing IRQ 11 with 00:10.0
PCI: Sharing IRQ 11 with 00:10.1
host/uhci.c: USB UHCI at I/O 0xdce0, IRQ 11
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 108k freed
Adding Swap: 120448k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
i8k: unable to get SMM BIOS version
Dell laptop SMM driver v1.13 14/05/2002 Massimo Dal Zotto (dz@debian.org)
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with writeback data mode.
reiserfs: checking transaction log (device 03:08) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,9), internal journal
EXT3-fs: mounted filesystem with writeback data mode.
reiserfs: checking transaction log (device 03:0a) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
PCI: Found IRQ 11 for device 00:10.0
PCI: Sharing IRQ 11 with 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
PCI: Sharing IRQ 11 with 00:07.2
PCI: Sharing IRQ 11 with 00:10.1
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:10.0: 3Com PCI 3c556 Laptop Tornado at 0xd400. Vers LK1.1.16
00:00:86:4a:ff:b2, IRQ 11
product code 0000 rev 00.0 date 03-01-00
00:10.0: CardBus functions mapped f3ffd800->d0fb7800
Internal config register is 80600000, transceivers 0x40.
8K byte-wide RAM 5:3 Rx:Tx split, MII interface.
MII transceiver found at address 0, status 7809.
Enabling bus-master transmits and whole-frame receives.
00:10.0: scatter/gather enabled. h/w checksums enabled
PCI: Found IRQ 5 for device 00:08.0
Unknown interrupt
mtrr: 0xf8000000,0x800000 overlaps existing 0xf8000000,0x400000
