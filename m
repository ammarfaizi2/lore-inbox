Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWAUVsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWAUVsq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWAUVsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:48:46 -0500
Received: from usmimesweeper.bluearc.com ([63.203.197.133]:64007 "EHLO
	us-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S932397AbWAUVsp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:48:45 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Out of Memory: Killed process 16498 (java).
Date: Sat, 21 Jan 2006 21:47:40 -0000
Message-ID: <89E85E0168AD994693B574C80EDB9C270128C324@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Out of Memory: Killed process 16498 (java).
Thread-Index: AcYd6DUwLxt0jImtRE6uw8sSTg0uTgA7BhC9
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: "Andrew Morton" <akpm@osdl.org>, <davej@redhat.com>,
       <linux-kernel@vger.kernel.org>, <lwoodman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok - here is the complete dmesg as of today:

ksize
usbmon: debugfs is not available
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI wakeup devices: 
PCI0 PS2K PS2M UAR2 UAR1 AC97 USB1 USB2 USB3 USB4 EHCI PWRB SLPB 
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 148k freed
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
input: AT Translated Set 2 keyboard as /class/input/input0
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HDS722525VLAT80, ATA DISK drive
hdb: Maxtor 6Y200P0, ATA DISK drive
bounce: queue ffff81013fa312d8, setting pfn 1310720, max_low 1310720
bounce: queue ffff81013fa312d8, setting pfn 1048575, max_low 1310720
isa bounce pool size: 16 pages
bounce: queue ffff81013fa31048, setting pfn 1310720, max_low 1310720
bounce: queue ffff81013fa31048, setting pfn 1048575, max_low 1310720
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-3500AG, ATAPI CD/DVD-ROM drive
bounce: queue ffff81013f51fd18, setting pfn 1310720, max_low 1310720
bounce: queue ffff81013f51fd18, setting pfn 1310720, max_low 1310720
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 390721968 sectors (200049 MB) w/7938KiB Cache, CHS=24321/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 >
hdb: max request size: 1024KiB
hdb: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(133)
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 >
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 18
skge 1.2 addr 0xfa900000 irq 18 chip Yukon-Lite rev 7
skge eth0: addr 00:11:2f:a7:fb:ef
USB Universal Host Controller Interface driver v2.3
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 3
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 19, io base 0x0000d400
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
SCSI subsystem initialized
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
libata version 1.20 loaded.
sata_promise 0000:00:08.0: version 1.03
GSI 20 sharing vector 0xC9 and IRQ 20
ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 3
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 19, io base 0x0000d800
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ata1: SATA max UDMA/133 cmd 0xFFFFC20000004200 ctl 0xFFFFC20000004238 bmdma 0x0 irq 20
ata2: SATA max UDMA/133 cmd 0xFFFFC20000004280 ctl 0xFFFFC200000042B8 bmdma 0x0 irq 20
input: PC Speaker as /class/input/input1
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 3
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 19, io base 0x0000e000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 3
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.3: irq 19, io base 0x0000e400
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ata1: no device found (phy stat 00000000)
scsi0 : sata_promise
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ata2: no device found (phy stat 00000000)
scsi1 : sata_promise
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.4, from 5 to 3
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:10.4: irq 19, io mem 0xfae00000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 1
sata_via 0000:00:0f.0: routed to hard irq line 1
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 20
e100: eth1: e100_probe: addr 0xfac00000, irq 20, MAC addr 00:D0:B7:BF:92:C8
ata3: SATA max UDMA/133 cmd 0xD000 ctl 0xC802 bmdma 0xB800 irq 17
ata4: SATA max UDMA/133 cmd 0xC400 ctl 0xC002 bmdma 0xB808 irq 17
input: ImExPS/2 Generic Explorer Mouse as /class/input/input2
ata3: dev 0 cfg 49:2f00 82:3069 83:7c01 84:4003 85:3069 86:3c01 87:4003 88:203f
ata3: dev 0 ATA-6, max UDMA/100, 390721968 sectors: LBA48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_via
ata4: no device found (phy stat 00000000)
scsi3 : sata_via
bounce: queue ffff81013f51fa88, setting pfn 1310720, max_low 1310720
bounce: queue ffff81013f51fa88, setting pfn 1048575, max_low 1310720
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
bounce: queue ffff81013f51f7f8, setting pfn 1310720, max_low 1310720
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
GSI 21 sharing vector 0xD1 and IRQ 21
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:11.5 to 64
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 > sda3
sd 2:0:0:0: Attached scsi disk sda
Adding 1951856k swap on /dev/hda5.  Priority:-1 extents:1 across:1951856k
Adding 1951856k swap on /dev/hda6.  Priority:-2 extents:1 across:1951856k
Adding 1951856k swap on /dev/hda7.  Priority:-3 extents:1 across:1951856k
Adding 996020k swap on /dev/hdb2.  Priority:-4 extents:1 across:996020k
Adding 996020k swap on /dev/hdb3.  Priority:-5 extents:1 across:996020k
Adding 995988k swap on /dev/hdb5.  Priority:-6 extents:1 across:995988k
Adding 843372k swap on /dev/hdb6.  Priority:-7 extents:1 across:843372k
EXT3 FS on hda1, internal journal
ieee1394: Initialized config rom entry `ip1394'
sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem hdb1
Ending clean XFS mount for filesystem: hdb1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
XFS mounting filesystem sda5
Ending clean XFS mount for filesystem: sda5
e100: intel: e100_watchdog: link up, 100Mbps, half-duplex
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
pnp: the driver 'parport_pc' has been registered
lp: driver loaded but no devices found
intel: no IPv6 routers present
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
NFSD: starting 90-second grace period
mtrr: type mismatch for f0000000,8000000 old: write-back new: write-combining
mtrr: type mismatch for f0000000,8000000 old: write-back new: write-combining
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:35
cpu 0 cold: low 0, high 62, batch 15 used:57
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:31
cpu 0 cold: low 0, high 62, batch 15 used:60
HighMem per-cpu: empty
Free pages:       20120kB (0kB HighMem)
Active:49696 inactive:905346 dirty:401104 writeback:10576 unstable:0 free:5030 slab:40994 mapped:49180 pagetables:1655
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:12 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:17032kB min:6052kB low:7564kB high:9076kB active:176kB inactive:2854812kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:3068kB min:2036kB low:2544kB high:3052kB active:198608kB inactive:766572kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 48*4kB 77*8kB 68*16kB 55*32kB 29*64kB 14*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 17032kB
Normal: 17*4kB 19*8kB 8*16kB 9*32kB 2*64kB 6*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 3068kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
955800 pages shared
38 pages swap cached
Out of Memory: Killed process 7054 (java).
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:49
cpu 0 cold: low 0, high 62, batch 15 used:57
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:171
cpu 0 cold: low 0, high 62, batch 15 used:60
HighMem per-cpu: empty
Free pages:       48660kB (0kB HighMem)
Active:42535 inactive:905346 dirty:401112 writeback:10064 unstable:0 free:12165 slab:40987 mapped:38361 pagetables:1578
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:14 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:17032kB min:6052kB low:7564kB high:9076kB active:176kB inactive:2854812kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:31608kB min:2036kB low:2544kB high:3052kB active:169964kB inactive:766572kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 48*4kB 77*8kB 68*16kB 55*32kB 29*64kB 14*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 17032kB
Normal: 454*4kB 328*8kB 222*16kB 148*32kB 99*64kB 40*128kB 13*256kB 4*512kB 2*1024kB 0*2048kB 0*4096kB = 31608kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
951709 pages shared
38 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:56
cpu 0 cold: low 0, high 62, batch 15 used:57
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:171
cpu 0 cold: low 0, high 62, batch 15 used:60
HighMem per-cpu: empty
Free pages:       48660kB (0kB HighMem)
Active:42535 inactive:905346 dirty:401112 writeback:9808 unstable:0 free:12165 slab:40980 mapped:38361 pagetables:1578
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:14 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:17032kB min:6052kB low:7564kB high:9076kB active:176kB inactive:2854812kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:31608kB min:2036kB low:2544kB high:3052kB active:169964kB inactive:766572kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 48*4kB 77*8kB 68*16kB 55*32kB 29*64kB 14*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 17032kB
Normal: 454*4kB 328*8kB 222*16kB 148*32kB 99*64kB 40*128kB 13*256kB 4*512kB 2*1024kB 0*2048kB 0*4096kB = 31608kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
951709 pages shared
38 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:64
cpu 0 cold: low 0, high 62, batch 15 used:57
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:171
cpu 0 cold: low 0, high 62, batch 15 used:60
HighMem per-cpu: empty
Free pages:       48660kB (0kB HighMem)
Active:42535 inactive:905346 dirty:401112 writeback:9552 unstable:0 free:12165 slab:40972 mapped:38361 pagetables:1578
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:14 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:17032kB min:6052kB low:7564kB high:9076kB active:176kB inactive:2854812kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:31608kB min:2036kB low:2544kB high:3052kB active:169964kB inactive:766572kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 48*4kB 77*8kB 68*16kB 55*32kB 29*64kB 14*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 17032kB
Normal: 454*4kB 328*8kB 222*16kB 148*32kB 99*64kB 40*128kB 13*256kB 4*512kB 2*1024kB 0*2048kB 0*4096kB = 31608kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
951709 pages shared
38 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:74
cpu 0 cold: low 0, high 62, batch 15 used:57
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:180
cpu 0 cold: low 0, high 62, batch 15 used:60
HighMem per-cpu: empty
Free pages:       48660kB (0kB HighMem)
Active:42535 inactive:905346 dirty:401112 writeback:9040 unstable:0 free:12165 slab:40953 mapped:38361 pagetables:1578
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:14 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:17032kB min:6052kB low:7564kB high:9076kB active:176kB inactive:2854812kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:31608kB min:2036kB low:2544kB high:3052kB active:169964kB inactive:766572kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 48*4kB 77*8kB 68*16kB 55*32kB 29*64kB 14*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 17032kB
Normal: 454*4kB 328*8kB 222*16kB 148*32kB 99*64kB 40*128kB 13*256kB 4*512kB 2*1024kB 0*2048kB 0*4096kB = 31608kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
951709 pages shared
38 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:74
cpu 0 cold: low 0, high 62, batch 15 used:57
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:159
cpu 0 cold: low 0, high 62, batch 15 used:60
HighMem per-cpu: empty
Free pages:       48784kB (0kB HighMem)
Active:42535 inactive:905346 dirty:401112 writeback:8784 unstable:0 free:12196 slab:40943 mapped:38361 pagetables:1578
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:14 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:17032kB min:6052kB low:7564kB high:9076kB active:176kB inactive:2854812kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:31732kB min:2036kB low:2544kB high:3052kB active:169964kB inactive:766572kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 48*4kB 77*8kB 68*16kB 55*32kB 29*64kB 14*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 17032kB
Normal: 453*4kB 328*8kB 222*16kB 148*32kB 99*64kB 41*128kB 13*256kB 4*512kB 2*1024kB 0*2048kB 0*4096kB = 31732kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
951709 pages shared
38 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:74
cpu 0 cold: low 0, high 62, batch 15 used:57
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:170
cpu 0 cold: low 0, high 62, batch 15 used:60
HighMem per-cpu: empty
Free pages:       48784kB (0kB HighMem)
Active:42535 inactive:905346 dirty:401112 writeback:8528 unstable:0 free:12196 slab:40932 mapped:38361 pagetables:1578
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:14 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:17032kB min:6052kB low:7564kB high:9076kB active:176kB inactive:2854812kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:31732kB min:2036kB low:2544kB high:3052kB active:169964kB inactive:766572kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 48*4kB 77*8kB 68*16kB 55*32kB 29*64kB 14*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 17032kB
Normal: 453*4kB 328*8kB 222*16kB 148*32kB 99*64kB 41*128kB 13*256kB 4*512kB 2*1024kB 0*2048kB 0*4096kB = 31732kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
951709 pages shared
38 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:74
cpu 0 cold: low 0, high 62, batch 15 used:57
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:179
cpu 0 cold: low 0, high 62, batch 15 used:60
HighMem per-cpu: empty
Free pages:       48784kB (0kB HighMem)
Active:42536 inactive:905349 dirty:401112 writeback:8272 unstable:0 free:12196 slab:40923 mapped:38361 pagetables:1578
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:16 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:17032kB min:6052kB low:7564kB high:9076kB active:176kB inactive:2854812kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:31732kB min:2036kB low:2544kB high:3052kB active:169968kB inactive:766584kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 48*4kB 77*8kB 68*16kB 55*32kB 29*64kB 14*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 17032kB
Normal: 453*4kB 328*8kB 222*16kB 148*32kB 99*64kB 41*128kB 13*256kB 4*512kB 2*1024kB 0*2048kB 0*4096kB = 31732kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
951705 pages shared
38 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:74
cpu 0 cold: low 0, high 62, batch 15 used:57
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:157
cpu 0 cold: low 0, high 62, batch 15 used:60
HighMem per-cpu: empty
Free pages:       48908kB (0kB HighMem)
Active:42536 inactive:905349 dirty:401112 writeback:8016 unstable:0 free:12227 slab:40914 mapped:38361 pagetables:1578
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:16 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:17032kB min:6052kB low:7564kB high:9076kB active:176kB inactive:2854812kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:31856kB min:2036kB low:2544kB high:3052kB active:169968kB inactive:766584kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 48*4kB 77*8kB 68*16kB 55*32kB 29*64kB 14*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 17032kB
Normal: 452*4kB 324*8kB 218*16kB 143*32kB 97*64kB 39*128kB 14*256kB 5*512kB 2*1024kB 0*2048kB 0*4096kB = 31856kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
951705 pages shared
38 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:74
cpu 0 cold: low 0, high 62, batch 15 used:57
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:178
cpu 0 cold: low 0, high 62, batch 15 used:60
HighMem per-cpu: empty
Free pages:       48908kB (0kB HighMem)
Active:42536 inactive:905349 dirty:401112 writeback:7504 unstable:0 free:12227 slab:40893 mapped:38361 pagetables:1578
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:16 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:17032kB min:6052kB low:7564kB high:9076kB active:176kB inactive:2854812kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:31856kB min:2036kB low:2544kB high:3052kB active:169968kB inactive:766584kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 48*4kB 77*8kB 68*16kB 55*32kB 29*64kB 14*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 17032kB
Normal: 452*4kB 324*8kB 218*16kB 143*32kB 97*64kB 39*128kB 14*256kB 5*512kB 2*1024kB 0*2048kB 0*4096kB = 31856kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
951705 pages shared
38 pages swap cached
printk: 116 messages suppressed.
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:176
cpu 0 cold: low 0, high 62, batch 15 used:9
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:169
cpu 0 cold: low 0, high 62, batch 15 used:10
HighMem per-cpu: empty
Free pages:     2937644kB (0kB HighMem)
Active:234053 inactive:21105 dirty:85603 writeback:3267 unstable:0 free:734411 slab:11180 mapped:40545 pagetables:1672
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:2474820kB min:6052kB low:7564kB high:9076kB active:491432kB inactive:920kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:462804kB min:2036kB low:2544kB high:3052kB active:444780kB inactive:83500kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 5617*4kB 5710*8kB 5539*16kB 5003*32kB 3444*64kB 943*128kB 1009*256kB 594*512kB 409*1024kB 242*2048kB 83*4096kB = 2474820kB
Normal: 4939*4kB 111*8kB 1539*16kB 5268*32kB 2514*64kB 556*128kB 58*256kB 2*512kB 1*1024kB 0*2048kB 0*4096kB = 462804kB
HighMem: empty
Swap cache: add 38, delete 38, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
238615 pages shared
0 pages swap cached
Out of Memory: Killed process 6451 (nautilus).
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:176
cpu 0 cold: low 0, high 62, batch 15 used:9
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:155
cpu 0 cold: low 0, high 62, batch 15 used:10
HighMem per-cpu: empty
Free pages:     2944280kB (0kB HighMem)
Active:232520 inactive:21107 dirty:84963 writeback:3267 unstable:0 free:736070 slab:11173 mapped:38188 pagetables:1599
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:2474820kB min:6052kB low:7564kB high:9076kB active:491432kB inactive:920kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:469440kB min:2036kB low:2544kB high:3052kB active:438648kB inactive:83508kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 5617*4kB 5710*8kB 5539*16kB 5003*32kB 3444*64kB 943*128kB 1009*256kB 594*512kB 409*1024kB 242*2048kB 83*4096kB = 2474820kB
Normal: 5176*4kB 246*8kB 1593*16kB 5305*32kB 2528*64kB 561*128kB 60*256kB 3*512kB 1*1024kB 0*2048kB 0*4096kB = 469440kB
HighMem: empty
Swap cache: add 38, delete 38, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
235419 pages shared
0 pages swap cached
Out of Memory: Killed process 6475 (clock-applet).
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:185
cpu 0 cold: low 0, high 62, batch 15 used:9
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:58
cpu 0 cold: low 0, high 62, batch 15 used:10
HighMem per-cpu: empty
Free pages:     2947628kB (0kB HighMem)
Active:231721 inactive:21107 dirty:84451 writeback:3267 unstable:0 free:736907 slab:11167 mapped:37179 pagetables:1633
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:2474820kB min:6052kB low:7564kB high:9076kB active:491432kB inactive:920kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:472788kB min:2036kB low:2544kB high:3052kB active:435452kB inactive:83508kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 5617*4kB 5710*8kB 5539*16kB 5003*32kB 3444*64kB 943*128kB 1009*256kB 594*512kB 409*1024kB 242*2048kB 83*4096kB = 2474820kB
Normal: 5275*4kB 297*8kB 1616*16kB 5317*32kB 2536*64kB 567*128kB 62*256kB 3*512kB 1*1024kB 0*2048kB 0*4096kB = 472788kB
HighMem: empty
Swap cache: add 38, delete 38, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
235131 pages shared
0 pages swap cached
Out of Memory: Killed process 6413 (ssh-agent).
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:155
cpu 0 cold: low 0, high 62, batch 15 used:9
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:157
cpu 0 cold: low 0, high 62, batch 15 used:10
HighMem per-cpu: empty
Free pages:     2999552kB (0kB HighMem)
Active:218989 inactive:21102 dirty:81156 writeback:3259 unstable:0 free:749888 slab:10888 mapped:37088 pagetables:1621
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:2474944kB min:6052kB low:7564kB high:9076kB active:491432kB inactive:920kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:524588kB min:2036kB low:2544kB high:3052kB active:384524kB inactive:83488kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 5600*4kB 5702*8kB 5533*16kB 5000*32kB 3441*64kB 944*128kB 1007*256kB 596*512kB 409*1024kB 242*2048kB 83*4096kB = 2474944kB
Normal: 5403*4kB 3298*8kB 3305*16kB 5317*32kB 2536*64kB 567*128kB 63*256kB 3*512kB 1*1024kB 0*2048kB 0*4096kB = 524588kB
HighMem: empty
Swap cache: add 38, delete 38, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
222355 pages shared
0 pages swap cached
Out of Memory: Killed process 24590 (gnome-session).
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:155
cpu 0 cold: low 0, high 62, batch 15 used:9
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:131
cpu 0 cold: low 0, high 62, batch 15 used:10
HighMem per-cpu: empty
Free pages:     2999808kB (0kB HighMem)
Active:219006 inactive:21102 dirty:81148 writeback:3267 unstable:0 free:749952 slab:10888 mapped:37105 pagetables:1575
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:2474944kB min:6052kB low:7564kB high:9076kB active:491432kB inactive:920kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:524844kB min:2036kB low:2544kB high:3052kB active:384592kB inactive:83488kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 5600*4kB 5702*8kB 5533*16kB 5000*32kB 3441*64kB 944*128kB 1007*256kB 596*512kB 409*1024kB 242*2048kB 83*4096kB = 2474944kB
Normal: 5405*4kB 3297*8kB 3319*16kB 5316*32kB 2535*64kB 568*128kB 63*256kB 3*512kB 1*1024kB 0*2048kB 0*4096kB = 524844kB
HighMem: empty
Swap cache: add 38, delete 38, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
221469 pages shared
0 pages swap cached
Out of Memory: Killed process 6430 (gnome-settings-).
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:155
cpu 0 cold: low 0, high 62, batch 15 used:9
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:132
cpu 0 cold: low 0, high 62, batch 15 used:10
HighMem per-cpu: empty
Free pages:     2999808kB (0kB HighMem)
Active:219006 inactive:21102 dirty:80636 writeback:3267 unstable:0 free:749952 slab:10888 mapped:37105 pagetables:1575
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:2474944kB min:6052kB low:7564kB high:9076kB active:491432kB inactive:920kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:524844kB min:2036kB low:2544kB high:3052kB active:384592kB inactive:83488kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 5600*4kB 5702*8kB 5533*16kB 5000*32kB 3441*64kB 944*128kB 1007*256kB 596*512kB 409*1024kB 242*2048kB 83*4096kB = 2474944kB
Normal: 5405*4kB 3297*8kB 3319*16kB 5316*32kB 2535*64kB 568*128kB 63*256kB 3*512kB 1*1024kB 0*2048kB 0*4096kB = 524844kB
HighMem: empty
Swap cache: add 38, delete 38, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
221469 pages shared
0 pages swap cached
Out of Memory: Killed process 6438 (gnome-settings-).
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:155
cpu 0 cold: low 0, high 62, batch 15 used:9
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:132
cpu 0 cold: low 0, high 62, batch 15 used:10
HighMem per-cpu: empty
Free pages:     2999808kB (0kB HighMem)
Active:219006 inactive:21102 dirty:80252 writeback:3267 unstable:0 free:749952 slab:10888 mapped:37105 pagetables:1575
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:2 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:2474944kB min:6052kB low:7564kB high:9076kB active:491432kB inactive:920kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:524844kB min:2036kB low:2544kB high:3052kB active:384592kB inactive:83488kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 5600*4kB 5702*8kB 5533*16kB 5000*32kB 3441*64kB 944*128kB 1007*256kB 596*512kB 409*1024kB 242*2048kB 83*4096kB = 2474944kB
Normal: 5405*4kB 3297*8kB 3319*16kB 5316*32kB 2535*64kB 568*128kB 63*256kB 3*512kB 1*1024kB 0*2048kB 0*4096kB = 524844kB
HighMem: empty
Swap cache: add 38, delete 38, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
221469 pages shared
0 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:155
cpu 0 cold: low 0, high 62, batch 15 used:9
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:132
cpu 0 cold: low 0, high 62, batch 15 used:10
HighMem per-cpu: empty
Free pages:     2999808kB (0kB HighMem)
Active:219006 inactive:21102 dirty:79868 writeback:3267 unstable:0 free:749952 slab:10888 mapped:37105 pagetables:1575
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:2474944kB min:6052kB low:7564kB high:9076kB active:491432kB inactive:920kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:524844kB min:2036kB low:2544kB high:3052kB active:384592kB inactive:83488kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 5600*4kB 5702*8kB 5533*16kB 5000*32kB 3441*64kB 944*128kB 1007*256kB 596*512kB 409*1024kB 242*2048kB 83*4096kB = 2474944kB
Normal: 5405*4kB 3297*8kB 3319*16kB 5316*32kB 2535*64kB 568*128kB 63*256kB 3*512kB 1*1024kB 0*2048kB 0*4096kB = 524844kB
HighMem: empty
Swap cache: add 38, delete 38, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
221469 pages shared
0 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:155
cpu 0 cold: low 0, high 62, batch 15 used:9
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:132
cpu 0 cold: low 0, high 62, batch 15 used:10
HighMem per-cpu: empty
Free pages:     2999808kB (0kB HighMem)
Active:219006 inactive:21102 dirty:79484 writeback:3267 unstable:0 free:749952 slab:10888 mapped:37105 pagetables:1575
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:2474944kB min:6052kB low:7564kB high:9076kB active:491432kB inactive:920kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:524844kB min:2036kB low:2544kB high:3052kB active:384592kB inactive:83488kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 5600*4kB 5702*8kB 5533*16kB 5000*32kB 3441*64kB 944*128kB 1007*256kB 596*512kB 409*1024kB 242*2048kB 83*4096kB = 2474944kB
Normal: 5405*4kB 3297*8kB 3319*16kB 5316*32kB 2535*64kB 568*128kB 63*256kB 3*512kB 1*1024kB 0*2048kB 0*4096kB = 524844kB
HighMem: empty
Swap cache: add 38, delete 38, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
221469 pages shared
0 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:155
cpu 0 cold: low 0, high 62, batch 15 used:9
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:132
cpu 0 cold: low 0, high 62, batch 15 used:10
HighMem per-cpu: empty
Free pages:     2999808kB (0kB HighMem)
Active:219006 inactive:21102 dirty:79100 writeback:3267 unstable:0 free:749952 slab:10888 mapped:37105 pagetables:1575
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:2474944kB min:6052kB low:7564kB high:9076kB active:491432kB inactive:920kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:524844kB min:2036kB low:2544kB high:3052kB active:384592kB inactive:83488kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 5600*4kB 5702*8kB 5533*16kB 5000*32kB 3441*64kB 944*128kB 1007*256kB 596*512kB 409*1024kB 242*2048kB 83*4096kB = 2474944kB
Normal: 5405*4kB 3297*8kB 3319*16kB 5316*32kB 2535*64kB 568*128kB 63*256kB 3*512kB 1*1024kB 0*2048kB 0*4096kB = 524844kB
HighMem: empty
Swap cache: add 38, delete 38, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
221469 pages shared
0 pages swap cached
Out of Memory: Killed process 6477 (mixer_applet2).
printk: 90 messages suppressed.
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48} <ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232} <ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd674>{blk_rq_map_user+136} <ffffffff801c0024>{sg_io+328}
       <ffffffff801c0498>{scsi_cmd_ioctl+491} <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88206d0c>{:sd_mod:sd_ioctl+371} <ffffffff802a6dd6>{schedule_timeout+158}
       <ffffffff801bf181>{blkdev_ioctl+1365} <ffffffff80243cd2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0} <ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89} <ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:177
cpu 0 cold: low 0, high 62, batch 15 used:53
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:178
cpu 0 cold: low 0, high 62, batch 15 used:0
HighMem per-cpu: empty
Free pages:     3169120kB (0kB HighMem)
Active:169664 inactive:27316 dirty:25704 writeback:3254 unstable:0 free:792280 slab:11571 mapped:39271 pagetables:1562
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB present:12740kB pages_scanned:2 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:2816320kB min:6052kB low:7564kB high:9076kB active:139680kB inactive:11112kB present:3071904kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1010 1010
Normal free:352780kB min:2036kB low:2544kB high:3052kB active:538976kB inactive:98152kB present:1034240kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 20kB
DMA32: 11666*4kB 10505*8kB 10673*16kB 9309*32kB 7290*64kB 5039*128kB 2420*256kB 711*512kB 107*1024kB 2*2048kB 2*4096kB = 2816320kB
Normal: 10207*4kB 6816*8kB 5839*16kB 939*32kB 867*64kB 513*128kB 44*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 352780kB
HighMem: empty
Swap cache: add 38, delete 38, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
106408 pages shared
0 pages swap cached
Out of Memory: Killed process 24591 (nautilus).




-----Original Message-----
From: Jens Axboe [mailto:axboe@suse.de]
Sent: Fri 2006-01-20 17:39
To: Andy Chittenden
Cc: Andrew Morton; davej@redhat.com; linux-kernel@vger.kernel.org; lwoodman@redhat.com
Subject: Re: Out of Memory: Killed process 16498 (java).
 
On Fri, Jan 20 2006, Andy Chittenden wrote:
> > Andy, can you try and boot with this applied?
> 
> At boot,
> 
> # dmesg | grep bounce:
> bounce: queue ffff81013fa5cd18, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa5ca88, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa5c7f8, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa5c568, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa5c2d8, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa5c048, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013f93bd18, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013f93ba88, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013f93b7f8, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013f93b568, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013f93b2d8, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013f93b048, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa31d18, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa31a88, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa317f8, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa31568, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa312d8, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa312d8, setting pfn 1048575, max_low 1310720
> bounce: queue ffff81013fa31048, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013fa31048, setting pfn 1048575, max_low 1310720
> bounce: queue ffff81013f51fd18, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013f51fd18, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013f51fa88, setting pfn 1310720, max_low 1310720
> bounce: queue ffff81013f51fa88, setting pfn 1048575, max_low 1310720
> bounce: queue ffff81013f51f7f8, setting pfn 1310720, max_low 1310720
> 
> No change when I ran the test.

Please include the full dmesg, so I can see which queue is what. Most of
them look ok (1310720 is BLK_BOUNCE_HIGH), 1048575 is a little weird
though. So full dmesg please!

Perhaps this is a wrapping problem of some sort.

-- 
Jens Axboe


