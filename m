Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTJJGqh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 02:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTJJGqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 02:46:37 -0400
Received: from pop.gmx.net ([213.165.64.20]:13734 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262540AbTJJGqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 02:46:24 -0400
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20031010084231.01e44c28@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Fri, 10 Oct 2003 08:50:20 +0200
To: linux-kernel@vger.kernel.org
From: Mike Galbraith <efault@gmx.de>
Subject: 2.6.0-test7 DEBUG_PAGEALLOC oops
In-Reply-To: <200310092204.h99M4Ro28540@mail.osdl.org>
References: <20031009130409.GA740@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_15888250==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_15888250==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

Greetings,

Enabling page allocation debugging produced the attached repeatable oops.

	-Mike
--=====================_15888250==_
Content-Type: text/plain; charset="us-ascii"

Linux version 2.6.0-test7 (root@mikeg) (gcc version gcc-2.95.3 20010315 (release)) #118 Fri Oct 10 08:20:35 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI NVS)
 BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32752
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 28656 pages, LIFO batch:6
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Building zonelist for node : 0
Kernel command line: root=/dev/hda6 ro console=ttyS0,115200n8 console=tty0 apm=power-off elevator=as sb=220,5,0,6 mpu401=0x BOOT_IMAGE=260t7vir
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 512 (order 9: 4096 bytes)
Detected 499.509 MHz processor.
Console: colour VGA+ 80x25
Memory: 125276k/131008k available (1668k kernel code, 5196k reserved, 663k data, 296k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 985.08 BogoMIPS
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Katmai) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 499.0050 MHz.
..... host bus clock speed is 99.0809 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb1a0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0596] at 0000:00:07.0
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
VFS: Disk quotas dquot_6.5.1
Activating ISA DMA hang workarounds.
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: Maximum main memory to use for agp memory: 94M
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized r128 2.5.0 20030725 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Found IRQ 9 for device 0000:00:0f.0
PCI: Sharing IRQ 9 with 0000:00:0c.0
eth0: ADMtek Comet rev 17 at 0xc8823000, 00:04:5A:64:94:34, IRQ 9.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c596b (rev 11) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJNA-352030, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITADVD-ROM SR-8583A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39876480 sectors (20416 MB) w/1966KiB Cache, CHS=39560/16/63
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 >
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 32X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
PCI: Found IRQ 9 for device 0000:00:0c.0
PCI: Sharing IRQ 9 with 0000:00:0f.0
ALSA device list:
  #0: Yamaha DS-XG PCI (YMF740C) at 0xec000000, irq 9
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 296k freed
Adding 265064k swap on /dev/hda2.  Priority:2 extents:1
blk: queue c7af4df8, I/O limit 4095Mb (mask 0xffffffff)
EXT3 FS on hda6, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Unable to handle kernel paging request at virtual address c034a000
 printing eip:
c0134d5a
*pde = 00102027
*pte = 0034a000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0134d5a>]    Not tainted
EFLAGS: 00010002
EIP is at store_stackinfo+0x4e/0x80
eax: 00000000   ebx: c7802f98   ecx: c0301390   edx: c030138c
esi: c0349ffe   edi: 017e0008   ebp: c0349da6   esp: c0349d96
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0348000 task=c02fcbe0)
Stack: c78371dc c11731d8 c7802000 00000060 c0349dd6 c0136aa8 c11731d8 c7802000 
       0000006b c7802f58 c7af4df8 c7fec428 00001000 c0131b6c c7d2ef78 00000086 
       c0349de6 c0131b6c c11731d8 c7802f58 c0349e02 c0131b3e c7802f58 c11731d8 
Call Trace:
 [<c0136aa8>] kmem_cache_free+0x218/0x294
 [<c0131b6c>] mempool_free_slab+0x10/0x14
 [<c0131b6c>] mempool_free_slab+0x10/0x14
 [<c0131b3e>] mempool_free+0x7a/0x84
 [<c01e3984>] __blk_put_request+0x74/0x88
 [<c01e4716>] end_that_request_last+0x62/0x7c
 [<c01f0be3>] ide_end_request+0xf3/0x124
 [<c01f9f68>] default_end_request+0x14/0x18
 [<c0201df8>] ide_dma_intr+0x60/0x98
 [<c01f2024>] ide_intr+0x108/0x17c
 [<c0201d98>] ide_dma_intr+0x0/0x98
 [<c010a423>] handle_IRQ_event+0x2b/0x58
 [<c010a70e>] do_IRQ+0x92/0x130
 [<c0109014>] common_interrupt+0x18/0x20
 [<c010a423>] 
--=====================_15888250==_--

