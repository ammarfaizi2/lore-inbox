Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262728AbSJCDxN>; Wed, 2 Oct 2002 23:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262730AbSJCDxN>; Wed, 2 Oct 2002 23:53:13 -0400
Received: from melchi.fuller.edu ([65.118.138.13]:39684 "EHLO
	melchi.fuller.edu") by vger.kernel.org with ESMTP
	id <S262728AbSJCDxK>; Wed, 2 Oct 2002 23:53:10 -0400
Date: Wed, 2 Oct 2002 20:58:35 -0700 (PDT)
From: <christoph@lameter.com>
X-X-Sender: <christoph@melchi.fuller.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.40 Oops in IDE driver on bootup
Message-ID: <Pine.LNX.4.33.0210022051110.15968-100000@melchi.fuller.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got a oops on bootup with 2.5.40.... This is 2.5.40 with a patch for S3
Linear Framebuffer support for 2.4.18

It plays mp3s just fine even after the oops. S3 Linear Framebuffer does
not work though.

Linux version 2.5.40 (christoph@) (gcc version 3.2)
Video mode to be used for restore is 318
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff0800 (ACPI NVS)
 BIOS-e820: 000000000fff0800 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages
  Normal zone: 61424 pages
  HighMem zone: 0 pages
Building zonelist for node : 0
Kernel command line: root=/dev/hda3 vga=0x318 video=vesa:mtrr,ypan
Initializing CPU#0
Detected 400.989 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 790.52 BogoMIPS
Memory: 255268k/262080k available (1978k kernel code, 6428k reserved, 724k
data, 108k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU:             Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfb360, last bus=2
PCI: Using configuration type 1
adding '' to cpu class interfaces
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: 00:07.3: class 604 doesn't match header type 00. Ignoring class.
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
PCI: IRQ 0 for device 00:08.0 doesn't match PIRQ mask - try
pci=usepirqmask
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
devfs: v1.21 (20020820) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Capability LSM initialized
Activating ISA DMA hang workarounds.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
tts/%d0 at I/O 0x3f8 (irq = 4) is a 16550A
tts/%d1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
vesafb: enabling S3 linear frame buffer
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Via MVP3 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
hda: C/H/S=28733/16/255 from BIOS ignored
hda: ST360021A, ATA DISK drive
hdc: Memorex CRW-1622, ATAPI CD/DVD-ROM drive
Debug: sleeping function called from illegal context at slab.c:1374
c12b5ec8 c013232f c02ff601 0000055e c040dd9c c040ddd4 c040dd9c 00000000
       c01318cd cfee9650 000001d0 c01f7a70 cfee9650 000001d0 00000046
c010ac82
       0000000e 00000000 c040dd9c c040dd8c c040dce0 00000000 c01f7aed
c040dd9c
Call Trace:
 [<c013232f>]__kmem_cache_alloc+0xaf/0xc0
 [<c01318cd>]kmem_cache_alloc+0xd/0x20
 [<c01f7a70>]blk_init_free_list+0x70/0xe0
 [<c010ac82>]setup_irq+0xa2/0xe0
 [<c01f7aed>]blk_init_queue+0xd/0x100
 [<c020c688>]ide_init_queue+0x28/0x80
 [<c0213680>]do_ide_request+0x0/0x20
 [<c020c890>]init_irq+0x1b0/0x360
 [<c020ccc6>]hwif_init+0xc6/0x280
 [<c020cfa7>]ideprobe_init+0xe7/0x100
 [<c0105075>]init+0x35/0x160
 [<c0105040>]init+0x0/0x160
 [<c0107081>]kernel_thread_helper+0x5/0x24

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
hdc: ATAPI 6X CD-ROM CD-R/RW drive, 1024kB Cache
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00


