Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSILMez>; Thu, 12 Sep 2002 08:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315437AbSILMez>; Thu, 12 Sep 2002 08:34:55 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:20896 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S315427AbSILMex>; Thu, 12 Sep 2002 08:34:53 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: 34-mm2 ide problems - unexpected interrupt
Date: Thu, 12 Sep 2002 08:38:44 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209120838.44092.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Got this booting 34-mm2.  Think the are problems with the ide updates...
UP no preempth.  Everything look ok up to the int loop.

Ed Tomlinson

Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages
  Normal zone: 126960 pages
  HighMem zone: 0 pages
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=Linux ro root=2103 console=tty0 console=ttyS0,38400 video=matrox:mem:32 idebus=33 profile=1
ide_setup: idebus=33
Initializing CPU#0
Detected 401.003 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 790.52 BogoMIPS
Memory: 514708k/524224k available (1053k kernel code, 9132k reserved, 517k data, 76k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Enabling new style K6 write allocation for 511 Mb
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: L2 Cache: 256K (32 bytes/line)
CPU: AMD-K6(tm) 3D+ Processor stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfb520, last bus=1
PCI: Using configuration type 1
usb.c: registered new driver usbfs
usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
aio_setup: sizeof(struct page) = 40
Capability LSM initialized
Activating ISA DMA hang workarounds.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
pty: 256 Unix98 ptys configured
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLP KA13.6, ATA DISK drive
hda: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CD-ROM 50X, ATAPI CD/DVD-ROM drive
hdd: HP COLORADO 20GB, ATAPI TAPE drive
hdc: DMA disabled
hdd: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
PDC20267: IDE controller at PCI slot 00:09.0
PCI: Found IRQ 12 for device 00:09.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xeb000000
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:DMA, hdh:pio
hde: QUANTUM FIREBALLP AS40.0, ATA DISK drive
ide2 at 0xac00-0xac07,0xb002 on irq 12
ide_intr: unexpected interrupt!
ide_intr: unexpected interrupt!
ide_intr: unexpected interrupt!
ide_intr: unexpected interrupt!
ide_intr: unexpected interrupt!
ide_intr: unexpected interrupt!
ide_intr: unexpected interrupt!
ide_intr: unexpected interrupt!
ide_intr: unexpected interrupt!
ide_intr: unexpected interrupt!
ide_intr: unexpected interrupt!
ide_intr: unexpected interrupt!
ide_intr: unexpected interrupt!
ide_intr: unexpected interrupt!
ide_intr: unexpected interrupt!

