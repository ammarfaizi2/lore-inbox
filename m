Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVDUOZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVDUOZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 10:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVDUOZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 10:25:28 -0400
Received: from hermes.domdv.de ([193.102.202.1]:43015 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261389AbVDUOYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 10:24:15 -0400
Message-ID: <4267B78D.9000408@domdv.de>
Date: Thu, 21 Apr 2005 16:24:13 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: Linux 2.6.12-rc3: Oops on IDE flash disk eject
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030002050006050109020302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030002050006050109020302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

As already reported to lkml and IDE maintainer for 2.6.12-rc2:

Oops on 'cardctl eject' of an IDE flash disk (Pretec ATA Flash 16MB).
2.6.11.2 works fine.

System:
Linux (none) 2.6.12-rc3-gringo #1 Thu Apr 21 15:45:08 CEST 2005 x86_64
unknown unknown GNU/Linux

Kernel messages from startup to and including Oops as well as config are
attached.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------030002050006050109020302
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

Bootdata ok (command line is BOOT_IMAGE=2.6.12rc2 ro root=301 hdb=none hdc=cdrom hdd=none elevator=cfq psmouse.rate=20 report_lost_ticks iommu=off init=/bin/bash)
Linux version 2.6.12-rc3-gringo (root@gringo) (gcc version 3.4.3) #1 Thu Apr 21 15:45:08 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff70000 (usable)
 BIOS-e820: 000000003ff70000 - 000000003ff7a000 (ACPI data)
 BIOS-e820: 000000003ff7a000 - 000000003ff80000 (ACPI NVS)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 PTLTD                                 ) @ 0x00000000000f6a60
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x000000003ff73fde
ACPI: FADT (v002 AMDK8  PTLTW    0x06040000 PTL_ 0x000f4240) @ 0x000000003ff79e56
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x000000003ff79eda
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x000000003ff79fb0
ACPI: DSDT (v001  VIA   PTL_ACPI 0x06040000 MSFT 0x0100000e) @ 0x0000000000000000
On node 0 totalpages: 262000
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 257904 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 40000000:bffe0000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6.12rc2 ro root=301 hdb=none hdc=cdrom hdd=none elevator=cfq psmouse.rate=20 report_lost_ticks iommu=off init=/bin/bash console=tty0
ide_setup: hdb=none
ide_setup: hdc=cdrom
ide_setup: hdd=none
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1801.076 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x50
time.c: Lost 3 timer tick(s)! rip vfs_caches_init_early+0x0/0xa0)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1024468k/1048000k available (2958k kernel code, 22832k reserved, 1639k data, 164k init)
Calibrating delay loop... 3547.13 BogoMIPS (lpj=1773568)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 0a
time.c: Lost 86 timer tick(s)! rip acpi_os_write_port+0x1a/0x36)
Using local APIC NMI watchdog using perfctr0
Using local APIC timer interrupts.
Detected 12.507 MHz APIC timer.
time.c: Lost 55 timer tick(s)! rip setup_boot_APIC_clock+0x112/0x120)
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [ALKA] (IRQs 16 17 18 19 20 21 22 23) *10, disabled.
ACPI: PCI Interrupt Link [ALKB] (IRQs 16 17 18 19 20 21 22 23) *10, disabled.
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *11, disabled.
ACPI: PCI Interrupt Link [ALKD] (IRQs 21) *11, disabled.
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 12 14 15) *10
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: Embedded Controller [EC] (gpe 11)
time.c: Lost 8 timer tick(s)! rip acpi_os_write_port+0x1a/0x36)
time.c: Lost 8 timer tick(s)! rip acpi_os_write_port+0x1a/0x36)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
time.c: Lost 8 timer tick(s)! rip acpi_os_write_port+0x1a/0x36)
pnp: PnP ACPI: found 10 devices
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NET: Registered protocol family 23
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
pnp: 00:05: ioport range 0x600-0x60f has been reserved
pnp: 00:05: ioport range 0x1c0-0x1cf has been reserved
pnp: 00:05: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:05: ioport range 0xfe10-0xfe11 could not be reserved
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
time.c: Lost 7 timer tick(s)! rip acpi_os_write_port+0x1a/0x36)
ACPI: AC Adapter [AC] (on-line)
time.c: Lost 8 timer tick(s)! rip acpi_os_write_port+0x1a/0x36)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
time.c: Lost 17 timer tick(s)! rip acpi_os_write_port+0x1a/0x36)
time.c: Lost 17 timer tick(s)! rip acpi_os_write_port+0x1a/0x36)
time.c: Lost 17 timer tick(s)! rip acpi_os_write_port+0x1a/0x36)
time.c: Lost 18 timer tick(s)! rip acpi_os_write_port+0x1a/0x36)
time.c: Lost 17 timer tick(s)! rip acpi_os_write_port+0x1a/0x36)
ACPI: Thermal Zone [THRS] (47 C)
time.c: Lost 17 timer tick(s)! rip acpi_os_write_port+0x1a/0x36)
time.c: Lost 17 timer tick(s)! rip acpi_os_write_port+0x1a/0x36)
time.c: Lost 17 timer tick(s)! rip acpi_os_write_port+0x1a/0x36)
time.c: Lost 17 timer tick(s)! rip acpi_os_write_port+0x1a/0x36)
time.c: Lost 17 timer tick(s)! rip acpi_os_write_port+0x1a/0x36)
ACPI: Thermal Zone [THRC] (56 C)
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 256M @ 0xd0000000
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
CSLIP: code copyright 1989 Regents of the University of California.
r8169 Gigabit Ethernet driver 2.2LK loaded
ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 22 (level, low) -> IRQ 22
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: RTL8169 at 0xffffc20000022400, 00:0a:e4:a2:b0:49, IRQ 22
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI - using IRQ 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x1c80-0x1c87, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c88-0x1c8f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: WDC WD800VE-00HDT0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TSSTcorpCD/DVDW TS-L532A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:00:0b.2[C] -> GSI 19 (level, low) -> IRQ 19
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[c0005800-c0005fff]  Max Packet=[2048]
ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 17 (level, low) -> IRQ 17
Yenta: CardBus bridge found at 0000:00:0b.0 [1025:006e]
Yenta: ISA IRQ mask 0x0cf8, PCI irq 17
Socket status: 30000811
PCI: Enabling device 0000:00:0b.1 (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:0b.1[B] -> GSI 18 (level, low) -> IRQ 18
Yenta: CardBus bridge found at 0000:00:0b.1 [1025:006e]
Yenta: ISA IRQ mask 0x0cf8, PCI irq 18
Socket status: 30000810
usbmon: debugs is not available
mice: PS/2 mouse device common for all mice
time.c: Lost 1 timer tick(s)! rip release_console_sem+0x13d/0x1c0)
i2c /dev entries driver
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Bluetooth: HCI UART driver ver 2.1
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
IrCOMM protocol (Dag Brattli)
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.4
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09e)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0xa, vid 0x2
swsusp: Suspend partition has wrong signature?
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 164k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000ae4045210338d]
Synaptics Touchpad, model: 1
 Firmware: 5.8
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
EXT3 FS on hda1, internal journal
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xd3fff 0xd8000-0xdffff 0xe4000-0xfffff
ttyS16: detected caps 00000700 should be 00000100
ttyS16 at I/O 0x100 (irq = 17) is a 16C950/954
ttyS17 at I/O 0x108 (irq = 17) is a 8250
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xd3fff 0xd8000-0xdffff 0xe4000-0xfffff
Probing IDE interface ide2...
hde: 16MB CTS, CFA DISK drive
ide2 at 0x110-0x117,0x11e on irq 18
hde: max request size: 128KiB
hde: 32000 sectors (16 MB) w/4KiB Cache, CHS=500/2/32
hde: cache flushes not supported
 hde: hde1
ide-cs: hde: Vcc = 3.3, Vpp = 0.0
Unable to handle kernel NULL pointer dereference at 0000000000000020 RIP: 
<ffffffff802dc3a5>{ide_drive_remove+21}
PGD 3f5c1067 PUD 3f63d067 PMD 0 
Oops: 0000 [1] 
CPU 0 
Modules linked in:
Pid: 981, comm: cardctl Not tainted 2.6.12-rc3-gringo
RIP: 0010:[<ffffffff802dc3a5>] <ffffffff802dc3a5>{ide_drive_remove+21}
RSP: 0000:ffff81003f07da28  EFLAGS: 00010296
RAX: ffffffff805d3050 RBX: ffffffff805d31c0 RCX: ffffffff805d3198
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff805d3050
RBP: ffffffff805d3178 R08: 0000000000000117 R09: 0000000000000001
R10: 00000000ffffffff R11: ffffffff80184cd0 R12: ffffffff80510470
R13: 0000000000000001 R14: 0000000000000002 R15: ffffffff8050fd20
FS:  00002aaaaae0aae0(0000) GS:ffffffff805ec340(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000020 CR3: 000000003f647000 CR4: 00000000000006e0
Process cardctl (pid: 981, threadinfo ffff81003f07c000, task ffff81000237ced0)
Stack: 0000000000000001 ffffffff802b57c7 ffffffff805d3178 ffffffff8050fb20 
       ffff810002335000 ffffffff802b59f4 ffffffff805d3178 ffffffff805d3738 
       ffff810002335000 ffffffff802b4818 
Call Trace:<ffffffff802b57c7>{device_release_driver+119} <ffffffff802b59f4>{bus_remove_device+180}
       <ffffffff802b4818>{device_del+88} <ffffffff802b4869>{device_unregister+9}
       <ffffffff802da8c2>{ide_unregister+546} <ffffffff80310d70>{send_event_callback+0}
       <ffffffff802ed585>{ide_release+37} <ffffffff802ed80e>{ide_event+174}
       <ffffffff8021cd28>{avc_alloc_node+56} <ffffffff80310d70>{send_event_callback+0}
       <ffffffff802b535d>{__bus_for_each_dev+109} <ffffffff80310d70>{send_event_callback+0}
       <ffffffff802b53e8>{bus_for_each_dev+72} <ffffffff80310e0d>{send_event+93}
       <ffffffff803112c7>{ds_event+103} <ffffffff8030b6d5>{send_event+69}
       <ffffffff8030b83d>{socket_shutdown+13} <ffffffff8030b6d5>{send_event+69}
       <ffffffff8030bdc9>{socket_remove+9} <ffffffff8030d90d>{pcmcia_eject_card+93}
       <ffffffff80311dde>{ds_ioctl+1278} <ffffffff8021e11a>{inode_has_perm+106}
       <ffffffff80220b1a>{selinux_file_ioctl+762} <ffffffff801dc3ed>{__ext3_journal_stop+45}
       <ffffffff8021d3af>{avc_has_perm+15} <ffffffff8021e071>{task_has_capability+97}
       <ffffffff8017d6ee>{do_ioctl+78} <ffffffff8017d97d>{vfs_ioctl+637}
       <ffffffff8017da0a>{sys_ioctl+106} <ffffffff8010d696>{system_call+126}
       

Code: ff 52 20 31 c0 48 83 c4 08 c3 90 41 54 48 8d 87 38 01 00 00 
RIP <ffffffff802dc3a5>{ide_drive_remove+21} RSP <ffff81003f07da28>
CR2: 0000000000000020
 <4>time.c: Lost 1 timer tick(s)! rip __down_read+0x75/0x7b)

--------------030002050006050109020302
Content-Type: application/x-gunzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
VScGE6F1W/wfBchGjsGRAAA=
--------------030002050006050109020302--
