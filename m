Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161248AbWJRRwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161248AbWJRRwK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWJRRwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:52:09 -0400
Received: from dxv00.wellsfargo.com ([151.151.5.40]:5525 "EHLO
	dxv00.wellsfargo.com") by vger.kernel.org with ESMTP
	id S1751508AbWJRRwG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:52:06 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: kernel oops with extended serial stuff turned on...
Date: Wed, 18 Oct 2006 12:51:58 -0500
Message-ID: <E8C008223DD5F64485DFBDF6D4B7F71D020C5FE0@msgswbmnmsp25.wellsfargo.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel oops with extended serial stuff turned on...
Thread-Index: Acby3iLx2GtF9mX3SLKt/1ML33gBNw==
From: <Greg.Chandler@wellsfargo.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Oct 2006 17:51:58.0778 (UTC) FILETIME=[1BAF69A0:01C6F2DE]
X-WFMX: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Or maybe it's not exactly an oops.....

Unfortunately I do not have the .config for this....
I do know that I had EVERY serial option turned on since I was trying to
find a specific device....
See below:


Linux version 2.6.18.1 (root@blackhole) (gcc version 3.3.6) #3 Tue Oct
17 22:02:19 PDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b800 (usable)
 BIOS-e820: 000000000009b800 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eef0000 (usable)
 BIOS-e820: 000000000eef0000 - 000000000eeff000 (ACPI data)
 BIOS-e820: 000000000eeff000 - 000000000ef00000 (ACPI NVS)
 BIOS-e820: 000000000ef00000 - 000000000f000000 (usable)
 BIOS-e820: 00000000ffff8000 - 0000000100000000 (reserved)
240MB LOWMEM available.
On node 0 totalpages: 61440
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 57344 pages, LIFO batch:15
DMI 2.3 present.
ACPI: RSDP (v000 HTCLTD                                ) @ 0x000f80f0
ACPI: RSDT (v001 HTCLTD HTC20F1  0x06040005  LTP 0x00000000) @
0x0eefc451
ACPI: FADT (v001 HTCLTD HTC20F1  0x06040005 PTL  0x00000001) @
0x0eefef64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040005  LTP 0x00000001) @
0x0eefefd8
ACPI: DSDT (v001 HTCLTD HTC20F1  0x06040005 MSFT 0x0100000d) @
0x00000000
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 10000000 (gap: 0f000000:f0ff8000)
Detected 398.205 MHz processor.
Built 1 zonelists.  Total pages: 61440
Kernel command line: auto BOOT_IMAGE=cris-2.6.18.1-1 ro root=301
log_buf_len=4M
log_buf_len: 4194304
No local APIC present or hardware disabled
mapped APIC to ffffd000 (015e1000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 4096 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 233332k/245760k available (3179k kernel code, 11856k reserved,
1649k data, 248k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay using timer specific routine.. 803.09 BogoMIPS
(lpj=4015461)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0084893f 0081813f 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0084893f 0081813f 0000000e 00000000
00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 256K (128 bytes/line)
CPU: Processor revision 1.3.1.3, 400 MHz
CPU: Code Morphing Software revision 4.2.7-8-278
CPU: 20011004 02:04 official release 4.2.7#7
CPU serial number disabled.
CPU: After all inits, caps: 0080893f 0081813f 0000000e 00000000 00000000
00000000 00000000
Compat vDSO mapped to ffffe000.
CPU: Transmeta(tm) Crusoe(tm) Processor TM5400 stepping 03
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 08a0)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd8b9, last bus=0
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:06.0
PCI quirk: region 8000-803f claimed by ali7101 ACPI
PCI quirk: region 8040-805f claimed by ali7101 SMB
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 6 7 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 6 *7 11)
ACPI: PCI Interrupt Link [LNK3] (IRQs *5 6 7 11)
ACPI: PCI Interrupt Link [LNK4] (IRQs 5 6 7 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 6 7 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK6] (IRQs 5 6 7 *11)
ACPI: PCI Interrupt Link [LNK7] (IRQs 5 6 7 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK8] (IRQs 5 6 7 *11)
ACPI: PCI Interrupt Link [LNKU] (IRQs 5 6 7 *11)
ACPI: Power Resource [PUSB] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
pnp: 00:07: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:07: ioport range 0x40b-0x40b has been reserved
pnp: 00:07: ioport range 0x480-0x48f has been reserved
pnp: 00:07: ioport range 0x4d6-0x4d6 has been reserved
pnp: 00:07: ioport range 0x8000-0x803f could not be reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:00:06.0
PCI: Bus 1, cardbus bridge: 0000:00:05.0
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 10000000-11ffffff
  MEM window: 12000000-13ffffff
PCI: Bus 5, cardbus bridge: 0000:00:05.1
  IO window: 00002000-000020ff
  IO window: 00002400-000024ff
  PREFETCH window: 14000000-15ffffff
  MEM window: 16000000-17ffffff
PCI: Bus 9, cardbus bridge: 0000:00:0b.0
  IO window: 00002800-000028ff
  IO window: 00002c00-00002cff
  PREFETCH window: 18000000-19ffffff
  MEM window: 1a000000-1bffffff
PCI: Enabling device 0000:00:05.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [LNK3] -> GSI 5 (level, low)
-> IRQ 5
PCI: Setting latency timer of device 0000:00:05.0 to 64
ACPI: PCI Interrupt 0000:00:05.1[A] -> Link [LNK3] -> GSI 5 (level, low)
-> IRQ 5
PCI: Setting latency timer of device 0000:00:05.1 to 64
PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNK6] -> GSI 11 (level,
low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:0b.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
Total HugeTLB memory allocated, 0
NTFS driver 2.1.27 [Flags: R/W].
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
Activating ISA DMA hang workarounds.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
cpcihp_generic: Generic port I/O CompactPCI Hot Plug Driver version: 0.1
cpcihp_generic: not configured, disabling.
vesafb: framebuffer at 0xfd000000, mapped to 0xcf880000, using 937k,
total 2048k
vesafb: mode is 800x600x8, linelength=800, pages=3
vesafb: protected mode interface info at c9cf:000e
vesafb: pmi: set display start = c00c9d33, set palette = c00c9d87
vesafb: pmi: ports = 
vesafb: scrolling: redraw
vesafb: Pseudocolor: size=6:6:6:6, shift=0:0:0:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
RocketPort device driver module, version 2.09, 12-June-2003
No rocketport ports found; unloading driver.
Cyclades driver 2.3.2.20 2004/02/25 18:14:16
        built Oct 15 2006 02:35:46
Stallion Multiport Serial Driver: version 5.6.0
Stallion Intelligent Multiport Serial Driver: version 5.6.0
STALLION: failed to register serial memory device
kobject_add failed for staliomem with -EEXIST, don't try to register
things with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c01f533f>] subsystem_register+0xf/0x20
 [<c02a47b3>] class_register+0x63/0x90
 [<c02a4870>] class_create+0x40/0x60
 [<c05d0a29>] stli_init+0x99/0x180
 [<c05d08c5>] istallion_module_init+0x5/0x10
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
STALLION: failed to register serial driver
DIGI epca driver version 1.3.0.1-LK2.6 loaded.
sx: Specialix IO8+ driver v1.11, (c) R.E.Wolff 1997/1998.
sx: derived from work (c) D.Gorodchanin 1994-1996.
sx: DTR/RTS pin is RTS when CRTSCTS is on.
sx0: specialix IO8+ Board at 0x100 not found.
sx1: specialix IO8+ Board at 0x180 not found.
sx2: specialix IO8+ Board at 0x250 not found.
sx3: specialix IO8+ Board at 0x260 not found.
sx: No specialix IO8+ boards detected.
MOXA Intellio family driver version 5.1k
Tty devices major number = 172
MOXA Smartio/Industio family driver version 1.8
Computone IntelliPort Plus multiport driver version 1.2.14
rc: SDL RISCom/8 card driver v1.1, (c) D.Gorodchanin 1994-1996.
rc0: RISCom/8 Board at 0x220 not found.
rc1: RISCom/8 Board at 0x240 not found.
rc2: RISCom/8 Board at 0x250 not found.
rc3: RISCom/8 Board at 0x260 not found.
rc: No RISCom/8 boards detected.
kobject_add failed for ttyM0 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM1 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM2 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM3 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM4 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM5 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM6 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM7 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM8 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM9 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM10 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM11 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM12 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM13 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM14 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM15 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM16 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM17 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM18 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM19 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM20 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM21 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM22 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM23 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM24 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM25 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM26 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM27 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM28 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM29 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM30 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM31 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
kobject_add failed for ttyM32 with -EEXIST, don't try to register things
with the same name in the same directory.
 [<c01f4fe2>] kobject_add+0xd2/0xe0
 [<c02a4e8f>] class_device_add+0x9f/0x2a0
 [<c02a5117>] class_device_create+0x77/0x90
 [<c02423ff>] tty_register_device+0x5f/0x70
 [<c02a5c9c>] kobj_map+0xec/0x100
 [<c015493d>] cdev_add+0x1d/0x30
 [<c02426ea>] tty_register_driver+0x19a/0x1b0
 [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
 [<c02738ae>] isicom_setup+0x13e/0x1d0
 [<c05d1b62>] riscom8_init+0x222/0x230
 [<c05ba723>] do_initcalls+0x53/0xf0
 [<c01331a2>] register_irq_proc+0x52/0x70
 [<c0170000>] bm_status_read+0x50/0xd0
 [<c0100290>] init+0x0/0x120
 [<c01002c2>] init+0x32/0x120
 [<c010132d>] kernel_thread_helper+0x5/0x18
SyncLink serial driver $Revision: 4.38 $
SyncLink serial driver $Revision: 4.38 $, tty major#253
SyncLink MultiPort driver $Revision: 4.38 $
SyncLink MultiPort driver $Revision: 4.38 $, tty major#252
SyncLink GT $Revision: 4.25 $
SyncLink GT no devices found
HDLC line discipline: version $Revision: 4.8 $, maxframe=4096
N_HDLC line discipline registered.
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
loop: loaded (max 8 devices)
nbd: registered device at major 43
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, git-1.2.2
ipw2100: Copyright(c) 2003-2006 Intel Corporation
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.2k
ipw2200: Copyright(c) 2003-2006 Intel Corporation
orinoco 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin
<proski@gnu.org>, et al)
orinoco_cs 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel
Roskin <proski@gnu.org>, et al)
orinoco_plx 0.15 (Pavel Roskin <proski@gnu.org>, David Gibson
<hermes@gibson.dropbear.id.au>, Daniel Barlow <dan@telent.net>)
orinoco_pci 0.15 (Pavel Roskin <proski@gnu.org>, David Gibson
<hermes@gibson.dropbear.id.au> & Jean Tourrilhes <jt@hpl.hp.com>)
orinoco_tmd 0.15 (Joerg Dorchain <joerg@dorchain.net>)
orinoco_nortel 0.15 (Tobias Hoffmann & Christoph Jungegger
<disdos@traum404.de>)
spectrum_cs 0.15 (Pavel Roskin <proski@gnu.org>, David Gibson
<hermes@gibson.dropbear.id.au>, et al)
airo(): Probing for PCI adapters
airo(): Finished probing for PCI adapters
Loaded prism54 driver, version 1.2
hostap_cs: 0.4.4-kernel (Jouni Malinen <jkmaline@cc.hut.fi>)
hostap_plx: 0.4.4-kernel (Jouni Malinen <jkmaline@cc.hut.fi>)
hostap_pci: 0.4.4-kernel (Jouni Malinen <jkmaline@cc.hut.fi>)
usbcore: registered new driver zd1201
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:10.0
ACPI: Unable to derive IRQ for device 0000:00:10.0
ACPI: PCI Interrupt 0000:00:10.0[A]: no GSI
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1400-0x1407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1408-0x140f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HMS360404D5CF00, CFA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 7999488 sectors (4095 MB) w/128KiB Cache, CHS=7936/16/63, UDMA(33)
hda: cache flushes supported
 hda: hda1
Yenta: CardBus bridge found at 0000:00:05.0 [1054:0110]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:05.0, mfunc 0x012c1222, devctl 0x64
Yenta: ISA IRQ mask 0x0cd8, PCI irq 5
Socket status: 30000010
Yenta: CardBus bridge found at 0000:00:05.1 [1054:0110]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:05.1, mfunc 0x012c1222, devctl 0x64
Yenta: ISA IRQ mask 0x0cd8, PCI irq 5
Socket status: 30000006
Yenta: CardBus bridge found at 0000:00:0b.0 [12a3:ab01]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0b.0, mfunc 0x01000002, devctl 0x60
Yenta: ISA IRQ mask 0x0000, PCI irq 11
Socket status: 30000010
pccard: PCMCIA card inserted into slot 0
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver
(PCI)
ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [LNKU] -> GSI 11 (level,
low) -> IRQ 11
ohci_hcd 0000:00:14.0: OHCI Host Controller
ohci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:14.0: irq 11, io mem 0x000e0000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
Initializing USB Mass Storage driver...
usb 1-1: new full speed USB device using ohci_hcd and address 2
pccard: PCMCIA card inserted into slot 2
usb 1-1: configuration #1 chosen from 1 choice
usb 1-4: new full speed USB device using ohci_hcd and address 3
usb 1-4: configuration #1 chosen from 1 choice
hub 1-4:1.0: USB hub found
hub 1-4:1.0: 4 ports detected
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
usb 1-4.1: new full speed USB device using ohci_hcd and address 4
usb 1-4.1: configuration #1 chosen from 1 choice
hub 1-4.1:1.0: USB hub found
hub 1-4.1:1.0: 3 ports detected
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver aiptek
drivers/usb/input/aiptek.c: v1.5 (May-15-2004): Bryan W. Headley/Chris
Atenasio
drivers/usb/input/aiptek.c: Aiptek HyperPen USB Tablet Driver (Linux
2.6.x)
usb 1-4.1.3: new full speed USB device using ohci_hcd and address 5
usb 1-4.1.3: configuration #1 chosen from 1 choice
usbcore: registered new driver hiddev
input: ORTEK USB Keyboard Hub as /class/input/input0
input: USB HID v1.10 Keyboard [ORTEK USB Keyboard Hub] on
usb-0000:00:14.0-4.1.3
input: ORTEK USB Keyboard Hub as /class/input/input1
input: USB HID v1.10 Device [ORTEK USB Keyboard Hub] on
usb-0000:00:14.0-4.1.3
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver kbtab
drivers/usb/input/kbtab.c: v0.0.2:USB KB Gear JamStudio Tablet driver
usbcore: registered new driver usbtouchscreen
usbcore: registered new driver powermate
usbcore: registered new driver wacom
drivers/usb/input/wacom.c: v1.45:USB Wacom Graphire and Wacom Intuos
tablet driver
usbcore: registered new driver usb_acecad
drivers/usb/input/acecad.c: v3.2:USB Acecad Flair tablet driver
usbcore: registered new driver appletouch
usbcore: registered new driver catc
drivers/usb/net/catc.c: v2.8 CATC EL1210A NetMate USB Ethernet driver
usbcore: registered new driver kaweth
pegasus: v0.6.13 (2005/11/13), Pegasus/Pegasus II USB Ethernet driver
usbcore: registered new driver pegasus
drivers/usb/net/rtl8150.c: rtl8150 based usb-ethernet driver v0.6.2
(2004/08/27)
usbcore: registered new driver rtl8150
usbcore: registered new driver asix
usbcore: registered new driver cdc_ether
usbcore: registered new driver gl620a
usbcore: registered new driver net1080
usbcore: registered new driver plusb
usbcore: registered new driver rndis_host
usbcore: registered new driver cdc_subset
usbcore: registered new driver zaurus
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for
generic
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for
ark3116
usbcore: registered new driver ark3116
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Belkin / Peracom / GoHubs USB Serial Adapter
usbcore: registered new driver belkin
drivers/usb/serial/belkin_sa.c: USB Belkin Serial converter driver v1.2
drivers/usb/serial/usb-serial.c: USB Serial support registered for
cp2101
usbcore: registered new driver cp2101
drivers/usb/serial/cp2101.c: Silicon Labs CP2101/CP2102 RS232 serial
adaptor driver v0.07
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Reiner SCT Cyberjack USB card reader
usbcore: registered new driver cyberjack
drivers/usb/serial/cyberjack.c: v1.01 Matthias Bruestle
drivers/usb/serial/cyberjack.c: REINER SCT cyberJack pinpad/e-com USB
Chipcard Reader Driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for
DeLorme Earthmate USB
drivers/usb/serial/usb-serial.c: USB Serial support registered for
HID->COM RS232 Adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Nokia
CA-42 V2 Adapter
usbcore: registered new driver cypress
drivers/usb/serial/cypress_m8.c: Cypress USB to Serial Driver v1.09
drivers/usb/serial/usb-serial.c: USB Serial support registered for Digi
2 port USB adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Digi
4 port USB adapter
usbcore: registered new driver digi_acceleport
drivers/usb/serial/digi_acceleport.c: v1.80.1.2:Digi AccelePort
USB-2/USB-4 Serial Converter driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Edgeport 2 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Edgeport 4 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Edgeport 8 port adapter
usbcore: registered new driver io_edgeport
drivers/usb/serial/io_edgeport.c: Edgeport USB Serial Driver v2.7
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Edgeport TI 1 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Edgeport TI 2 port adapter
usbcore: registered new driver io_ti
drivers/usb/serial/io_ti.c: Edgeport USB Serial Driver v0.7
drivers/usb/serial/usb-serial.c: USB Serial support registered for FTDI
USB Serial Device
usbcore: registered new driver ftdi_sio
drivers/usb/serial/ftdi_sio.c: v1.4.3:USB FTDI Serial Converters Driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for
funsoft
usbcore: registered new driver funsoft
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Garmin GPS usb/tty
usbcore: registered new driver garmin_gps
drivers/usb/serial/garmin_gps.c: garmin gps driver v0.23
drivers/usb/serial/usb-serial.c: USB Serial support registered for hp4X
usbcore: registered new driver hp4X
drivers/usb/serial/hp4x.c: HP4x (48/49) Generic Serial driver v1.00
drivers/usb/serial/usb-serial.c: USB Serial support registered for
PocketPC PDA
drivers/usb/serial/ipaq.c: USB PocketPC PDA driver v0.5
usbcore: registered new driver ipaq
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Keyspan - (without firmware)
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Keyspan 1 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Keyspan 2 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Keyspan 4 port adapter
usbcore: registered new driver keyspan
drivers/usb/serial/keyspan.c: v1.1.4:Keyspan USB to Serial Converter
Driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Keyspan PDA
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Keyspan PDA - (prerenumeration)
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Xircom / Entregra PGS - (prerenumeration)
usbcore: registered new driver keyspan_pda
drivers/usb/serial/keyspan_pda.c: USB Keyspan PDA Converter driver v1.1
drivers/usb/serial/usb-serial.c: USB Serial support registered for
KL5KUSB105D / PalmConnect
usbcore: registered new driver kl5kusb105d
drivers/usb/serial/kl5kusb105.c: KLSI KL5KUSB105 chipset USB->Serial
Converter driver v0.3a
drivers/usb/serial/usb-serial.c: USB Serial support registered for KOBIL
USB smart card terminal
usbcore: registered new driver kobil
drivers/usb/serial/kobil_sct.c: 21/05/2004 KOBIL Systems GmbH -
http://www.kobil.com
drivers/usb/serial/kobil_sct.c: KOBIL USB Smart Card Terminal Driver
(experimental)
drivers/usb/serial/usb-serial.c: USB Serial support registered for MCT
U232
usbcore: registered new driver mct_u232
drivers/usb/serial/mct_u232.c: Magic Control Technology USB-RS232
converter driver z2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for
navman
usbcore: registered new driver navman
drivers/usb/serial/usb-serial.c: USB Serial support registered for ZyXEL
- omni.net lcd plus usb
usbcore: registered new driver omninet
drivers/usb/serial/omninet.c: v1.1:USB ZyXEL omni.net LCD PLUS Driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for
pl2303
usbcore: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor
driver
drivers/usb/serial/safe_serial.c: v0.0b sl@lineo.com, tbr@lineo.com
drivers/usb/serial/safe_serial.c: USB Safe Encapsulated Serial
drivers/usb/serial/safe_serial.c: vendor: 0 product: 0 safe: 1 padded: 0

drivers/usb/serial/usb-serial.c: USB Serial support registered for
safe_serial
usbcore: registered new driver safe_serial
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Sierra_Wireless
usbcore: registered new driver sierra_wireless
drivers/usb/serial/usb-serial.c: USB Serial support registered for TI
USB 3410 1 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for TI
USB 5052 2 port adapter
usbcore: registered new driver ti_usb_3410_5052
drivers/usb/serial/ti_usb_3410_5052.c: TI USB 3410/5052 Serial Driver
v0.9
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Handspring Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony
Clie 3.5
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony
Clie 5.0
usbcore: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Connect Tech - WhiteHEAT - (prerenumeration)
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Connect Tech - WhiteHEAT
usbcore: registered new driver whiteheat
drivers/usb/serial/whiteheat.c: USB ConnectTech WhiteHEAT driver v2.0
gs_module_init: cannot register gadget driver, ret=-22
pnp: Device 00:09 activated.
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
ts: Compaq touchscreen protocol output
mk712: device not present
input: PC Speaker as /class/input/input2
input: LBPS/2 Fujitsu Lifebook TouchScreen as /class/input/input3
i2c /dev entries driver
i2c-pca-isa: i/o base 0x000330. irq 10
  Vendor: LEXAR     Model: JUMPDRIVE         Rev: 1000
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 2030592 512-byte hdwr sectors (1040 MB)
sda: Write Protect is off
sda: Mode Sense: 43 00 00 00
sda: assuming drive cache: write through
SCSI device sda: 2030592 512-byte hdwr sectors (1040 MB)
sda: Write Protect is off
sda: Mode Sense: 43 00 00 00
sda: assuming drive cache: write through
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi removable disk sda
usb-storage: device scan complete
sdhci: Secure Digital Host Controller Interface driver, 0.12
sdhci: Copyright(c) Pierre Ossman
wbsd: Winbond W83L51xD SD/MMC card interface driver, 1.6
wbsd: Copyright(c) Pierre Ossman
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22
13:55:50 2006 UTC).
ACPI: PCI Interrupt Link [LNK8] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNK8] -> GSI 11 (level,
low) -> IRQ 11
ALSA device list:
  #0: ALI 5451 at 0x1000, irq 11
ip_conntrack version 2.4 (1920 buckets, 15360 max) - 172 bytes per
conntrack
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation
<jketreno@linux.intel.com>
ieee80211_crypt: registered algorithm 'NULL'
ieee80211_crypt: registered algorithm 'WEP'
ieee80211_crypt: registered algorithm 'CCMP'
ieee80211_crypt: registered algorithm 'TKIP'
Using IPI Shortcut mode
ACPI: (supports S0 S1 S3 S4<6>Time: tsc clocksource has been installed.
 S5)
Time: acpi_pm clocksource has been installed.
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 248k freed
EXT3 FS on hda1, internal journal
pcmcia: Detected deprecated PCMCIA ioctl usage from process: cardmgr.
pcmcia: This interface will soon be removed from the kernel; please
expect breakage unless you upgrade to new tools.
pcmcia: see
http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for
details.
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff
0xdc000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
pcmcia: registering new device pcmcia0.0
pcmcia: request for exclusive IRQ could not be fulfilled.
pcmcia: the driver needs updating to supported shared IRQ lines.
airo(eth0): cmd= 111

airo(eth0): status= 7f11

airo(eth0): Rsp0= 2

airo(eth0): Rsp1= 0

airo(eth0): Rsp2= 0

airo(eth0): Doing fast bap_reads
airo(eth0): WPA unsupported (only firmware versions 5.30.17 and greater
support WPA.  Detected 4.25.30)
airo(eth0): MAC enabled 0:d:bc:98:c5:4
eth0: index 0x05: , Vpp 5.0, irq 5, io 0x0100-0x013f
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff
0xdc000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: excluding 0x60000000-0x600fffff
cs: memory probe 0xa0000000-0xa0ffffff: clean.
pcmcia: registering new device pcmcia2.0
pcmcia: request for exclusive IRQ could not be fulfilled.
pcmcia: the driver needs updating to supported shared IRQ lines.
hermes @ 00010140: BAP0 offset timeout: reg=0x8000 id=0xfd0b offset=0x0
eth1: Cannot read hardware identity: error -110
eth1: Incompatible firmware, aborting
orinoco_cs: register_netdev() failed
pcmcia: request for exclusive IRQ could not be fulfilled.
pcmcia: the driver needs updating to supported shared IRQ lines.
hermes @ 00010140: BAP0 offset error: reg=0x4000 id=0xfd0b offset=0x0
eth1: Cannot read hardware identity: error -5
eth1: Incompatible firmware, aborting
orinoco_cs: register_netdev() failed
airo(eth0): cmd= 1

airo(eth0): status= 7f01

airo(eth0): Rsp0= 88

airo(eth0): Rsp1= ff10

airo(eth0): Rsp2= a0

airo(eth0): cmd= 2

airo(eth0): status= 7f02

airo(eth0): Rsp0= 0

airo(eth0): Rsp1= ff10

airo(eth0): Rsp2= a0

airo(eth0): cmd= 1

airo(eth0): status= 7f01

airo(eth0): Rsp0= 88

airo(eth0): Rsp1= ff10

airo(eth0): Rsp2= a0

airo(eth0): cmd= 2

airo(eth0): status= 7f02

airo(eth0): Rsp0= 0

airo(eth0): Rsp1= ff10

airo(eth0): Rsp2= a0

