Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVFOKGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVFOKGf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 06:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVFOKGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 06:06:35 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:26134 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261377AbVFOKEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 06:04:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=QLHX7ID3zPo04IVk/1a+oaHFh2uYfHh8Y6ZlS7k3JtyLwH3C3czbDtHldFNNni8QUSPuK7AJpTBWuvOhLHmcuzsR+LMmMZTBz5uqZeo+bAamNv3mMHqNk87xn8aJoWrvZ0kDolQqNVfbx1vY/RvILVdO7dPbkNGNj7Cu9anHh9E=
Message-ID: <243922d60506150304348bb817@mail.gmail.com>
Date: Wed, 15 Jun 2005 10:04:07 +0000
From: thibault dory <dory.thibault@gmail.com>
Reply-To: thibault dory <dory.thibault@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel BUG using iptable
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_904_12255298.1118829847271"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_904_12255298.1118829847271
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Since I try to use iptable with kernel 2.6.11.X serie I get the same
bug with iptable. It didn't work at all and I experience problems with
my connection. I give you my kernel config file in attachement.
For the moment I'm using 2.6.11.12 kernel on a 1.4Ghz Centrino.

Here's the dmesg output that show the bug :

Linux version 2.6.11.12 (root@inflames) (gcc version 3.3.5) #1 SMP Wed
Jun 15 11:25:20 Local time zone must be set--see zic
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001eff0000 (usable)
 BIOS-e820: 000000001eff0000 - 000000001effffc0 (ACPI data)
 BIOS-e820: 000000001effffc0 - 000000001f000000 (ACPI NVS)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
495MB LOWMEM available.
On node 0 totalpages: 126960
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 122864 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 OID_00                                ) @ 0x000e6010
ACPI: RSDT (v001 INSYDE RSDT_000 0x00000001 _CSI 0x00010101) @ 0x1effa5b0
ACPI: FADT (v001 COMPAL DCL51_00 0x00000100 _CSI 0x00010101) @ 0x1efffb00
ACPI: BOOT (v001 INSYDE BOOT_000 0x00000001 _CSI 0x00010101) @ 0x1efffb90
ACPI: DBGP (v001 INSYDE DBGP_000 0x00000001 _CSI 0x00010101) @ 0x1efffbc0
ACPI: SSDT (v001 INSYDE   GV3Ref 0x00002000 INTL 0x20021002) @ 0x1effa5f0
ACPI: DSDT (v001 ACER   TM290    0x00000006 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 1f000000 (gap: 1f000000:e0b80000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=3D2.6.11.12 ro root=3D302 hdc=3Dide-scsi
ide_setup: hdc=3Dide-scsi
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01423000)
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1399.233 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 497672k/507840k available (3243k kernel code, 9620k reserved,
1232k data, 216k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok=
.
Calibrating delay loop... 2777.08 BogoMIPS (lpj=3D1388544)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000
00000180 00000000 00000000
CPU: After vendor identify, caps: a7e9f9bf 00000000 00000000 00000000
00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps: a7e9f9bf 00000000 00000000 00000040
00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquire=
d
Parsing all Control
Methods:...................................................................=
...........................................................................=
..............................................
Table [DSDT](id F005) - 618 Objects with 53 Devices 188 Methods 20 Regions
Parsing all Control Methods:....
Table [SSDT](id F003) - 7 Objects with 0 Devices 4 Methods 0 Regions
ACPI Namespace successfully loaded at root c05b9940
ACPI: setting ELCR to 0200 (from 0c20)
evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successf=
ul
CPU0: Intel(R) Pentium(R) M processor 1400MHz stepping 05
per-CPU timeslice cutoff: 2925.26 usecs.
task migration cache decay timeout: 3 msecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
CPU0 attaching sched-domain:
 domain 0: span 01
  groups: 01
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xe9824, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on in=
t 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 6 Wake, Enabled 2
Runtime GPEs in this block
Completing Region/Field/Buffer/Package
initialization:............................................................=
....
Initialized 20/20 Regions 0/0 Fields 34/34 Buffers 10/16 Packages (634 node=
s)
Executing all Device _STA and_INI
methods:........................................................
56 Devices found containing: 56 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Via IRQ fixup
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
[ACPI Debug] Buffer: [0x06]ACPI: PCI Interrupt Link [LNKA] (IRQs 10) *11
ACPI: PCI Interrupt Link [LNKB] (IRQs 10) *5
ACPI: PCI Interrupt Link [LNKC] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 10) *0, disabled.
[ACPI Debug] Buffer: [0x06]ACPI: PCI Interrupt Link [LNKE] (IRQs 10) *11
[ACPI Debug] Buffer: [0x06]ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *11
[ACPI Debug] Buffer: [0x06]ACPI: PCI Interrupt Link [LNKG] (IRQs 10) *11
[ACPI Debug] Buffer: [0x06]ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
ACPI: Embedded Controller [EC0] (gpe 28)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=3Drouteirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
NET: Registered protocol family 23
Simple Boot Flag at 0x37 set to 0x80
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1118834961.891:0): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.22 [Flags: R/O].
Initializing Cryptographic API
ACPI: AC Adapter [ACAD] (off-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [GFX0] (multi-head: yes  rom: yes  post: no)
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Maximum main memory to use for agp memory: 424M
agpgart: Detected 16252K stolen memory.
agpgart: AGP aperture is 128M @ 0xb0000000
[drm] Initialized drm 1.0.0 20040925
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
lp0: using parport0 (polling).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
nbd: registered device at major 43
8139too Fast Ethernet driver 0.9.27
[ACPI Debug] Buffer: [0x06][ACPI Debug] Buffer: [0x06]ACPI: PCI
Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI interrupt 0000:01:01.0[A] -> GSI 10 (level, low) -> IRQ 10
eth0: RealTek RTL8139 at 0xc000, 00:02:3f:13:96:a3, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8101'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1108-0x110f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK4025GAS, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-R6112, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB), CHS=3D65535/16/63, UDMA(33)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 > hda4
ide-scsi is deprecated for cd burning! Use ide-cd and give
dev=3D/dev/hdX as device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: DVD-ROM SD-R6112  Rev: 1031
  Type:   CD-ROM                             ANSI SCSI revision: 02
libata version 1.10 loaded.
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
[ACPI Debug] Buffer: [0x06][ACPI Debug] Buffer: [0x06]ACPI: PCI
Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=3D[10]=20
MMIO=3D[e0001800-e0001fff]  Max Packet=3D[2048]
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
eth1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
[ACPI Debug] Buffer: [0x06][ACPI Debug] Buffer: [0x06]ACPI: PCI
Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0
EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 10, pci mem 0xf0080000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v2.2
[ACPI Debug] Buffer: [0x06][ACPI Debug] Buffer: [0x06]ACPI: PCI
Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 10, io base 0x1200
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 10, io base 0x1600
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 10, io base 0x1700
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 2-1: new low speed USB device using uhci_hcd and address 2
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: USB HID v1.10 Mouse [Wireless Mouse Wireless Mouse] on usb-0000:00:1=
d.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
ALPS Touchpad (Glidepoint) detected
  Disabling hardware tapping
input: AlpsPS/2 ALPS TouchPad on isa0060/serio4
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13
09:39:32 2005 UTC).
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023f4244004245]
intel8x0_measure_ac97_clock: measured 49446 usecs
intel8x0: clocking to 48000
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ALSA device list:
  #0: Intel 82801DB-ICH4 with ALC202 at 0xf0080400, irq 10
  #1: Intel 82801DB-ICH4 Modem at 0xe300, irq 10
oprofile: using timer interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 16384 (order: 5, 196608 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack version 2.1 (3967 buckets, 31736 max) - 220 bytes per conntrac=
k
NET: Registered protocol family 1
PM: Reading swsusp image.
PM: Resume from disk failed.
ACPI wakeup devices:
ELAN USB1 USB2 USB3 EUSB MODM
ACPI: (supports S0 S1 S3 S4 S5)
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 216k freed
kjournald starting.  Commit interval 5 seconds
Adding 512024k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 10 (level, low) -> IRQ 10
[drm] Initialized i915 1.1.0 20040405 on minor 0: Intel Corp.
82852/855GM Integrated Graphics Device
PCI: Enabling device 0000:00:02.1 (0000 -> 0002)
[drm] Initialized i915 1.1.0 20040405 on minor 1: Intel Corp.
82852/855GM Integrated Graphics Device (#2)
ip_tables: (C) 2000-2002 Netfilter core team
BUG: using smp_processor_id() in preemptible [00000001] code: modprobe/1529
caller is ip_conntrack_helper_register+0x18/0x170
 [<c022b8b8>] smp_processor_id+0xa8/0xc0
 [<c03fbc68>] ip_conntrack_helper_register+0x18/0x170
 [<c03fbc68>] ip_conntrack_helper_register+0x18/0x170
 [<c022a7ff>] sprintf+0x1f/0x30
 [<df9550d5>] init+0xd5/0x114 [ip_conntrack_ftp]
 [<c013a1c2>] sys_init_module+0x182/0x240
 [<c01032af>] syscall_call+0x7/0xb
BUG: using smp_processor_id() in preemptible [00000001] code: modprobe/1529
caller is ip_conntrack_helper_register+0x125/0x170
 [<c022b8b8>] smp_processor_id+0xa8/0xc0
 [<c03fbd75>] ip_conntrack_helper_register+0x125/0x170
 [<c03fbd75>] ip_conntrack_helper_register+0x125/0x170
 [<c022a7ff>] sprintf+0x1f/0x30
 [<df9550d5>] init+0xd5/0x114 [ip_conntrack_ftp]
 [<c013a1c2>] sys_init_module+0x182/0x240
 [<c01032af>] syscall_call+0x7/0xb
BUG: using smp_processor_id() in preemptible [00000001] code: modprobe/1529
caller is ip_nat_init+0x30/0x1da [iptable_nat]
 [<c022b8b8>] smp_processor_id+0xa8/0xc0
 [<df9830c0>] ip_nat_init+0x30/0x1da [iptable_nat]
 [<df9830c0>] ip_nat_init+0x30/0x1da [iptable_nat]
 [<df983066>] ip_nat_rule_init+0x46/0x70 [iptable_nat]
 [<df95151b>] init_or_cleanup+0x2b/0x1a0 [iptable_nat]
 [<df98300f>] init+0xf/0x20 [iptable_nat]
 [<c013a1c2>] sys_init_module+0x182/0x240
 [<c01032af>] syscall_call+0x7/0xb
BUG: using smp_processor_id() in preemptible [00000001] code: modprobe/1529
caller is ip_nat_init+0x1a6/0x1da [iptable_nat]
 [<c022b8b8>] smp_processor_id+0xa8/0xc0
 [<df983236>] ip_nat_init+0x1a6/0x1da [iptable_nat]
 [<df983236>] ip_nat_init+0x1a6/0x1da [iptable_nat]
 [<df983066>] ip_nat_rule_init+0x46/0x70 [iptable_nat]
 [<df95151b>] init_or_cleanup+0x2b/0x1a0 [iptable_nat]
 [<df98300f>] init+0xf/0x20 [iptable_nat]
 [<c013a1c2>] sys_init_module+0x182/0x240
 [<c01032af>] syscall_call+0x7/0xb
BUG: using smp_processor_id() in preemptible [00000001] code: modprobe/1551
caller is ip_conntrack_helper_register+0x18/0x170
 [<c022b8b8>] smp_processor_id+0xa8/0xc0
 [<c03fbc68>] ip_conntrack_helper_register+0x18/0x170
 [<c03fbc68>] ip_conntrack_helper_register+0x18/0x170
 [<c022a7ff>] sprintf+0x1f/0x30
 [<df9610d3>] init+0xd3/0x141 [ip_conntrack_irc]
 [<c013a1c2>] sys_init_module+0x182/0x240
 [<c01032af>] syscall_call+0x7/0xb
BUG: using smp_processor_id() in preemptible [00000001] code: modprobe/1551
caller is ip_conntrack_helper_register+0x125/0x170
 [<c022b8b8>] smp_processor_id+0xa8/0xc0
 [<c03fbd75>] ip_conntrack_helper_register+0x125/0x170
 [<c03fbd75>] ip_conntrack_helper_register+0x125/0x170
 [<c022a7ff>] sprintf+0x1f/0x30
 [<df9610d3>] init+0xd3/0x141 [ip_conntrack_irc]
 [<c013a1c2>] sys_init_module+0x182/0x240
 [<c01032af>] syscall_call+0x7/0xb
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
acpi-cpufreq: CPU0 - ACPI performance management activated.
NET: Registered protocol family 17
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
apm: BIOS not found.
mtrr: base(0xb0020000) is not aligned on a size(0x300000) boundary
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
BUG: using smp_processor_id() in preemptible [00000001] code: dhcpcd/4015
caller is get_next_corpse+0x14/0x280
 [<c022b8b8>] smp_processor_id+0xa8/0xc0
 [<c03fc454>] get_next_corpse+0x14/0x280
 [<c03fc454>] get_next_corpse+0x14/0x280
 [<c04294af>] _spin_unlock_irqrestore+0xf/0x30
 [<c03ac09d>] skb_dequeue+0x4d/0x60
 [<c03fc6f4>] ip_ct_iterate_cleanup+0x34/0xd0
 [<df9c0360>] device_cmp+0x0/0x110 [ipt_MASQUERADE]
 [<df9c0328>] masq_inet_event+0x38/0x70 [ipt_MASQUERADE]
 [<df9c0360>] device_cmp+0x0/0x110 [ipt_MASQUERADE]
 [<c012db4d>] notifier_call_chain+0x2d/0x50
 [<c03eca5c>] inet_del_ifa+0x8c/0x150
 [<c03ed6dd>] devinet_ioctl+0x48d/0x5b0
 [<c03ef9e6>] inet_ioctl+0x66/0xb0
 [<df9c51d1>] packet_ioctl+0x141/0x170 [af_packet]
 [<c03a6c79>] sock_ioctl+0xd9/0x260
 [<c01746be>] do_ioctl+0x8e/0xa0
 [<c01748e5>] vfs_ioctl+0x65/0x1f0
 [<c0174ad7>] sys_ioctl+0x67/0x90
 [<c01032af>] syscall_call+0x7/0xb
BUG: using smp_processor_id() in preemptible [00000001] code: dhcpcd/4015
caller is get_next_corpse+0x240/0x280
 [<c022b8b8>] smp_processor_id+0xa8/0xc0
 [<c03fc680>] get_next_corpse+0x240/0x280
 [<c03fc680>] get_next_corpse+0x240/0x280
 [<c04294af>] _spin_unlock_irqrestore+0xf/0x30
 [<c03ac09d>] skb_dequeue+0x4d/0x60
 [<c03fc6f4>] ip_ct_iterate_cleanup+0x34/0xd0
 [<df9c0360>] device_cmp+0x0/0x110 [ipt_MASQUERADE]
 [<df9c0328>] masq_inet_event+0x38/0x70 [ipt_MASQUERADE]
 [<df9c0360>] device_cmp+0x0/0x110 [ipt_MASQUERADE]
 [<c012db4d>] notifier_call_chain+0x2d/0x50
 [<c03eca5c>] inet_del_ifa+0x8c/0x150
 [<c03ed6dd>] devinet_ioctl+0x48d/0x5b0
 [<c03ef9e6>] inet_ioctl+0x66/0xb0
 [<df9c51d1>] packet_ioctl+0x141/0x170 [af_packet]
 [<c03a6c79>] sock_ioctl+0xd9/0x260
 [<c01746be>] do_ioctl+0x8e/0xa0
 [<c01748e5>] vfs_ioctl+0x65/0x1f0
 [<c0174ad7>] sys_ioctl+0x67/0x90
 [<c01032af>] syscall_call+0x7/0xb
spurious 8259A interrupt: IRQ7.





The output of /proc/modules :

root:# cat /proc/modules
ipt_MASQUERADE 4864 1 - Live 0xdf9c0000
ipt_state 2560 2 - Live 0xdf9be000
af_packet 18568 2 - Live 0xdf9c3000
acpi_cpufreq 7712 1 - Live 0xdf9ab000
processor 32424 1 acpi_cpufreq, Live 0xdf9b3000
iptable_mangle 3328 0 - Live 0xdf9a5000
iptable_filter 3328 1 - Live 0xdf983000
ip_nat_irc 2816 0 - Live 0xdf966000
ip_conntrack_irc 72080 1 ip_nat_irc, Live 0xdf992000
ip_nat_ftp 3584 0 - Live 0xdf964000
iptable_nat 23868 4 ipt_MASQUERADE,ip_nat_irc,ip_nat_ftp, Live 0xdf951000
ip_conntrack_ftp 72976 1 ip_nat_ftp, Live 0xdf970000
ip_tables 24960 5
ipt_MASQUERADE,ipt_state,iptable_mangle,iptable_filter,iptable_nat,
Live 0xdf968000
i915 18944 1 - Live 0xdf958000



the output of /proc/ioports

root:# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
  1000-107f : motherboard
    1000-1003 : PM1a_EVT_BLK
    1004-1005 : PM1a_CNT_BLK
    1008-100b : PM_TMR
    1010-1015 : ACPI CPU throttle
    1020-1020 : PM2_CNT_BLK
    1028-102f : GPE0_BLK
1100-110f : 0000:00:1f.1
  1100-1107 : ide0
  1108-110f : ide1
1200-121f : 0000:00:1d.0
  1200-121f : uhci_hcd
1300-133f : 0000:00:1f.0
  1300-133f : motherboard
1400-141f : 0000:00:1f.3
1600-161f : 0000:00:1d.1
  1600-161f : uhci_hcd
1700-171f : 0000:00:1d.2
  1700-171f : uhci_hcd
c000-c0ff : 0000:01:01.0
  c000-c0ff : 8139too
c100-c17f : 0000:01:00.0
e000-e007 : 0000:00:02.0
e100-e1ff : 0000:00:1f.5
  e100-e1ff : Intel 82801DB-ICH4
e200-e23f : 0000:00:1f.5
  e200-e23f : Intel 82801DB-ICH4
e300-e3ff : 0000:00:1f.6
  e300-e3ff : Intel 82801DB-ICH4 Modem
e400-e47f : 0000:00:1f.6
  e400-e47f : Intel 82801DB-ICH4 Modem
fe00-fe00 : motherboard


The output of /proc/iomem

root:# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ccdff : Video ROM
000e0000-000e17ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1efeffff : System RAM
  00100000-0042ae04 : Kernel code
  0042ae05-0055f17f : Kernel data
1eff0000-1effffbf : ACPI Tables
1effffc0-1effffff : ACPI Non-volatile Storage
1f000000-1f07ffff : 0000:00:02.1
1f080000-1f0803ff : 0000:00:1f.1
1f081000-1f081fff : 0000:01:04.0
20000000-27ffffff : 0000:00:02.1
b0000000-b7ffffff : 0000:00:02.0
e0000000-e0000fff : 0000:01:02.0
e0001000-e00010ff : 0000:01:01.0
  e0001000-e00010ff : 8139too
e0001800-e0001fff : 0000:01:00.0
  e0001800-e0001fff : ohci1394
f0000000-f007ffff : 0000:00:02.0
f0080000-f00803ff : 0000:00:1d.7
  f0080000-f00803ff : ehci_hcd
f0080400-f00805ff : 0000:00:1f.5
  f0080400-f00805ff : Intel 82801DB-ICH4
f0080600-f00806ff : 0000:00:1f.5
  f0080600-f00806ff : Intel 82801DB-ICH4
ffb80000-ffbfffff : reserved
fff80000-ffffffff : reserved


I hope there's enough information to find the bug, if it misses
something I can send it.
Thx for all the good job you're doing!!

------=_Part_904_12255298.1118829847271
Content-Type: application/octet-stream; name="config"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config"

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMgTGlu
dXgga2VybmVsIHZlcnNpb246IDIuNi4xMS4xMgojIFdlZCBKdW4gMTUgMTE6MTU6MTcgMjAwNQoj
CkNPTkZJR19YODY9eQpDT05GSUdfTU1VPXkKQ09ORklHX1VJRDE2PXkKQ09ORklHX0dFTkVSSUNf
SVNBX0RNQT15CkNPTkZJR19HRU5FUklDX0lPTUFQPXkKCiMKIyBDb2RlIG1hdHVyaXR5IGxldmVs
IG9wdGlvbnMKIwpDT05GSUdfRVhQRVJJTUVOVEFMPXkKQ09ORklHX0NMRUFOX0NPTVBJTEU9eQpD
T05GSUdfTE9DS19LRVJORUw9eQoKIwojIEdlbmVyYWwgc2V0dXAKIwpDT05GSUdfTE9DQUxWRVJT
SU9OPSIiCkNPTkZJR19TV0FQPXkKQ09ORklHX1NZU1ZJUEM9eQpDT05GSUdfUE9TSVhfTVFVRVVF
PXkKIyBDT05GSUdfQlNEX1BST0NFU1NfQUNDVCBpcyBub3Qgc2V0CkNPTkZJR19TWVNDVEw9eQpD
T05GSUdfQVVESVQ9eQpDT05GSUdfQVVESVRTWVNDQUxMPXkKQ09ORklHX0xPR19CVUZfU0hJRlQ9
MTUKQ09ORklHX0hPVFBMVUc9eQpDT05GSUdfS09CSkVDVF9VRVZFTlQ9eQpDT05GSUdfSUtDT05G
SUc9eQojIENPTkZJR19JS0NPTkZJR19QUk9DIGlzIG5vdCBzZXQKIyBDT05GSUdfRU1CRURERUQg
aXMgbm90IHNldApDT05GSUdfS0FMTFNZTVM9eQojIENPTkZJR19LQUxMU1lNU19FWFRSQV9QQVNT
IGlzIG5vdCBzZXQKQ09ORklHX0ZVVEVYPXkKQ09ORklHX0VQT0xMPXkKIyBDT05GSUdfQ0NfT1BU
SU1JWkVfRk9SX1NJWkUgaXMgbm90IHNldApDT05GSUdfU0hNRU09eQpDT05GSUdfQ0NfQUxJR05f
RlVOQ1RJT05TPTAKQ09ORklHX0NDX0FMSUdOX0xBQkVMUz0wCkNPTkZJR19DQ19BTElHTl9MT09Q
Uz0wCkNPTkZJR19DQ19BTElHTl9KVU1QUz0wCiMgQ09ORklHX1RJTllfU0hNRU0gaXMgbm90IHNl
dAoKIwojIExvYWRhYmxlIG1vZHVsZSBzdXBwb3J0CiMKQ09ORklHX01PRFVMRVM9eQpDT05GSUdf
TU9EVUxFX1VOTE9BRD15CiMgQ09ORklHX01PRFVMRV9GT1JDRV9VTkxPQUQgaXMgbm90IHNldApD
T05GSUdfT0JTT0xFVEVfTU9EUEFSTT15CiMgQ09ORklHX01PRFZFUlNJT05TIGlzIG5vdCBzZXQK
IyBDT05GSUdfTU9EVUxFX1NSQ1ZFUlNJT05fQUxMIGlzIG5vdCBzZXQKQ09ORklHX0tNT0Q9eQpD
T05GSUdfU1RPUF9NQUNISU5FPXkKCiMKIyBQcm9jZXNzb3IgdHlwZSBhbmQgZmVhdHVyZXMKIwpD
T05GSUdfWDg2X1BDPXkKIyBDT05GSUdfWDg2X0VMQU4gaXMgbm90IHNldAojIENPTkZJR19YODZf
Vk9ZQUdFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9OVU1BUSBpcyBub3Qgc2V0CiMgQ09ORklH
X1g4Nl9TVU1NSVQgaXMgbm90IHNldAojIENPTkZJR19YODZfQklHU01QIGlzIG5vdCBzZXQKIyBD
T05GSUdfWDg2X1ZJU1dTIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0dFTkVSSUNBUkNIIGlzIG5v
dCBzZXQKIyBDT05GSUdfWDg2X0VTNzAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX00zODYgaXMgbm90
IHNldAojIENPTkZJR19NNDg2IGlzIG5vdCBzZXQKIyBDT05GSUdfTTU4NiBpcyBub3Qgc2V0CiMg
Q09ORklHX001ODZUU0MgaXMgbm90IHNldAojIENPTkZJR19NNTg2TU1YIGlzIG5vdCBzZXQKIyBD
T05GSUdfTTY4NiBpcyBub3Qgc2V0CiMgQ09ORklHX01QRU5USVVNSUkgaXMgbm90IHNldAojIENP
TkZJR19NUEVOVElVTUlJSSBpcyBub3Qgc2V0CkNPTkZJR19NUEVOVElVTU09eQojIENPTkZJR19N
UEVOVElVTTQgaXMgbm90IHNldAojIENPTkZJR19NSzYgaXMgbm90IHNldAojIENPTkZJR19NSzcg
aXMgbm90IHNldAojIENPTkZJR19NSzggaXMgbm90IHNldAojIENPTkZJR19NQ1JVU09FIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUVGRklDRU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfTVdJTkNISVBDNiBp
cyBub3Qgc2V0CiMgQ09ORklHX01XSU5DSElQMiBpcyBub3Qgc2V0CiMgQ09ORklHX01XSU5DSElQ
M0QgaXMgbm90IHNldAojIENPTkZJR19NQ1lSSVhJSUkgaXMgbm90IHNldAojIENPTkZJR19NVklB
QzNfMiBpcyBub3Qgc2V0CkNPTkZJR19YODZfR0VORVJJQz15CkNPTkZJR19YODZfQ01QWENIRz15
CkNPTkZJR19YODZfWEFERD15CkNPTkZJR19YODZfTDFfQ0FDSEVfU0hJRlQ9NwpDT05GSUdfUldT
RU1fWENIR0FERF9BTEdPUklUSE09eQpDT05GSUdfR0VORVJJQ19DQUxJQlJBVEVfREVMQVk9eQpD
T05GSUdfWDg2X1dQX1dPUktTX09LPXkKQ09ORklHX1g4Nl9JTlZMUEc9eQpDT05GSUdfWDg2X0JT
V0FQPXkKQ09ORklHX1g4Nl9QT1BBRF9PSz15CkNPTkZJR19YODZfR09PRF9BUElDPXkKQ09ORklH
X1g4Nl9JTlRFTF9VU0VSQ09QWT15CkNPTkZJR19YODZfVVNFX1BQUk9fQ0hFQ0tTVU09eQojIENP
TkZJR19IUEVUX1RJTUVSIGlzIG5vdCBzZXQKQ09ORklHX1NNUD15CkNPTkZJR19OUl9DUFVTPTgK
IyBDT05GSUdfU0NIRURfU01UIGlzIG5vdCBzZXQKQ09ORklHX1BSRUVNUFQ9eQpDT05GSUdfUFJF
RU1QVF9CS0w9eQpDT05GSUdfWDg2X0xPQ0FMX0FQSUM9eQpDT05GSUdfWDg2X0lPX0FQSUM9eQpD
T05GSUdfWDg2X1RTQz15CkNPTkZJR19YODZfTUNFPXkKQ09ORklHX1g4Nl9NQ0VfTk9ORkFUQUw9
eQpDT05GSUdfWDg2X01DRV9QNFRIRVJNQUw9eQojIENPTkZJR19UT1NISUJBIGlzIG5vdCBzZXQK
IyBDT05GSUdfSThLIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlDUk9DT0RFIGlzIG5vdCBzZXQKIyBD
T05GSUdfWDg2X01TUiBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9DUFVJRCBpcyBub3Qgc2V0Cgoj
CiMgRmlybXdhcmUgRHJpdmVycwojCiMgQ09ORklHX0VERCBpcyBub3Qgc2V0CkNPTkZJR19OT0hJ
R0hNRU09eQojIENPTkZJR19ISUdITUVNNEcgaXMgbm90IHNldAojIENPTkZJR19ISUdITUVNNjRH
IGlzIG5vdCBzZXQKQ09ORklHX01BVEhfRU1VTEFUSU9OPXkKQ09ORklHX01UUlI9eQojIENPTkZJ
R19FRkkgaXMgbm90IHNldApDT05GSUdfSVJRQkFMQU5DRT15CkNPTkZJR19IQVZFX0RFQ19MT0NL
PXkKIyBDT05GSUdfUkVHUEFSTSBpcyBub3Qgc2V0CgojCiMgUG93ZXIgbWFuYWdlbWVudCBvcHRp
b25zIChBQ1BJLCBBUE0pCiMKQ09ORklHX1BNPXkKQ09ORklHX1BNX0RFQlVHPXkKQ09ORklHX1NP
RlRXQVJFX1NVU1BFTkQ9eQpDT05GSUdfUE1fU1REX1BBUlRJVElPTj0iIgoKIwojIEFDUEkgKEFk
dmFuY2VkIENvbmZpZ3VyYXRpb24gYW5kIFBvd2VyIEludGVyZmFjZSkgU3VwcG9ydAojCkNPTkZJ
R19BQ1BJPXkKQ09ORklHX0FDUElfQk9PVD15CkNPTkZJR19BQ1BJX0lOVEVSUFJFVEVSPXkKQ09O
RklHX0FDUElfU0xFRVA9eQpDT05GSUdfQUNQSV9TTEVFUF9QUk9DX0ZTPXkKQ09ORklHX0FDUElf
QUM9eQpDT05GSUdfQUNQSV9CQVRURVJZPXkKQ09ORklHX0FDUElfQlVUVE9OPXkKQ09ORklHX0FD
UElfVklERU89eQpDT05GSUdfQUNQSV9GQU49eQpDT05GSUdfQUNQSV9QUk9DRVNTT1I9bQpDT05G
SUdfQUNQSV9USEVSTUFMPW0KIyBDT05GSUdfQUNQSV9BU1VTIGlzIG5vdCBzZXQKIyBDT05GSUdf
QUNQSV9JQk0gaXMgbm90IHNldAojIENPTkZJR19BQ1BJX1RPU0hJQkEgaXMgbm90IHNldApDT05G
SUdfQUNQSV9CTEFDS0xJU1RfWUVBUj0wCkNPTkZJR19BQ1BJX0RFQlVHPXkKQ09ORklHX0FDUElf
QlVTPXkKQ09ORklHX0FDUElfRUM9eQpDT05GSUdfQUNQSV9QT1dFUj15CkNPTkZJR19BQ1BJX1BD
ST15CkNPTkZJR19BQ1BJX1NZU1RFTT15CkNPTkZJR19YODZfUE1fVElNRVI9eQojIENPTkZJR19B
Q1BJX0NPTlRBSU5FUiBpcyBub3Qgc2V0CgojCiMgQVBNIChBZHZhbmNlZCBQb3dlciBNYW5hZ2Vt
ZW50KSBCSU9TIFN1cHBvcnQKIwpDT05GSUdfQVBNPW0KIyBDT05GSUdfQVBNX0lHTk9SRV9VU0VS
X1NVU1BFTkQgaXMgbm90IHNldAojIENPTkZJR19BUE1fRE9fRU5BQkxFIGlzIG5vdCBzZXQKIyBD
T05GSUdfQVBNX0NQVV9JRExFIGlzIG5vdCBzZXQKIyBDT05GSUdfQVBNX0RJU1BMQVlfQkxBTksg
aXMgbm90IHNldAojIENPTkZJR19BUE1fUlRDX0lTX0dNVCBpcyBub3Qgc2V0CiMgQ09ORklHX0FQ
TV9BTExPV19JTlRTIGlzIG5vdCBzZXQKIyBDT05GSUdfQVBNX1JFQUxfTU9ERV9QT1dFUl9PRkYg
aXMgbm90IHNldAoKIwojIENQVSBGcmVxdWVuY3kgc2NhbGluZwojCkNPTkZJR19DUFVfRlJFUT15
CkNPTkZJR19DUFVfRlJFUV9ERUJVRz15CkNPTkZJR19DUFVfRlJFUV9TVEFUPXkKQ09ORklHX0NQ
VV9GUkVRX1NUQVRfREVUQUlMUz15CkNPTkZJR19DUFVfRlJFUV9ERUZBVUxUX0dPVl9QRVJGT1JN
QU5DRT15CiMgQ09ORklHX0NQVV9GUkVRX0RFRkFVTFRfR09WX1VTRVJTUEFDRSBpcyBub3Qgc2V0
CkNPTkZJR19DUFVfRlJFUV9HT1ZfUEVSRk9STUFOQ0U9eQpDT05GSUdfQ1BVX0ZSRVFfR09WX1BP
V0VSU0FWRT15CkNPTkZJR19DUFVfRlJFUV9HT1ZfVVNFUlNQQUNFPXkKQ09ORklHX0NQVV9GUkVR
X0dPVl9PTkRFTUFORD15CkNPTkZJR19DUFVfRlJFUV9UQUJMRT15CgojCiMgQ1BVRnJlcSBwcm9j
ZXNzb3IgZHJpdmVycwojCkNPTkZJR19YODZfQUNQSV9DUFVGUkVRPW0KIyBDT05GSUdfWDg2X1BP
V0VSTk9XX0s2IGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X1BPV0VSTk9XX0s3IGlzIG5vdCBzZXQK
IyBDT05GSUdfWDg2X1BPV0VSTk9XX0s4IGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0dYX1NVU1BN
T0QgaXMgbm90IHNldApDT05GSUdfWDg2X1NQRUVEU1RFUF9DRU5UUklOTz1tCkNPTkZJR19YODZf
U1BFRURTVEVQX0NFTlRSSU5PX0FDUEk9eQpDT05GSUdfWDg2X1NQRUVEU1RFUF9DRU5UUklOT19U
QUJMRT15CiMgQ09ORklHX1g4Nl9TUEVFRFNURVBfSUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2
X1NQRUVEU1RFUF9TTUkgaXMgbm90IHNldAojIENPTkZJR19YODZfUDRfQ0xPQ0tNT0QgaXMgbm90
IHNldAojIENPTkZJR19YODZfQ1BVRlJFUV9ORk9SQ0UyIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2
X0xPTkdSVU4gaXMgbm90IHNldAojIENPTkZJR19YODZfTE9OR0hBVUwgaXMgbm90IHNldAoKIwoj
IHNoYXJlZCBvcHRpb25zCiMKQ09ORklHX1g4Nl9BQ1BJX0NQVUZSRVFfUFJPQ19JTlRGPXkKCiMK
IyBCdXMgb3B0aW9ucyAoUENJLCBQQ01DSUEsIEVJU0EsIE1DQSwgSVNBKQojCkNPTkZJR19QQ0k9
eQojIENPTkZJR19QQ0lfR09CSU9TIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJX0dPTU1DT05GSUcg
aXMgbm90IHNldAojIENPTkZJR19QQ0lfR09ESVJFQ1QgaXMgbm90IHNldApDT05GSUdfUENJX0dP
QU5ZPXkKQ09ORklHX1BDSV9CSU9TPXkKQ09ORklHX1BDSV9ESVJFQ1Q9eQpDT05GSUdfUENJX01N
Q09ORklHPXkKIyBDT05GSUdfUENJRVBPUlRCVVMgaXMgbm90IHNldAojIENPTkZJR19QQ0lfTVNJ
IGlzIG5vdCBzZXQKQ09ORklHX1BDSV9MRUdBQ1lfUFJPQz15CkNPTkZJR19QQ0lfTkFNRVM9eQpD
T05GSUdfSVNBPXkKIyBDT05GSUdfRUlTQSBpcyBub3Qgc2V0CiMgQ09ORklHX01DQSBpcyBub3Qg
c2V0CiMgQ09ORklHX1NDeDIwMCBpcyBub3Qgc2V0CgojCiMgUENDQVJEIChQQ01DSUEvQ2FyZEJ1
cykgc3VwcG9ydAojCiMgQ09ORklHX1BDQ0FSRCBpcyBub3Qgc2V0CgojCiMgUEMtY2FyZCBicmlk
Z2VzCiMKQ09ORklHX1BDTUNJQV9QUk9CRT15CgojCiMgUENJIEhvdHBsdWcgU3VwcG9ydAojCiMg
Q09ORklHX0hPVFBMVUdfUENJIGlzIG5vdCBzZXQKCiMKIyBFeGVjdXRhYmxlIGZpbGUgZm9ybWF0
cwojCkNPTkZJR19CSU5GTVRfRUxGPXkKQ09ORklHX0JJTkZNVF9BT1VUPXkKQ09ORklHX0JJTkZN
VF9NSVNDPXkKCiMKIyBEZXZpY2UgRHJpdmVycwojCgojCiMgR2VuZXJpYyBEcml2ZXIgT3B0aW9u
cwojCkNPTkZJR19TVEFOREFMT05FPXkKQ09ORklHX1BSRVZFTlRfRklSTVdBUkVfQlVJTEQ9eQpD
T05GSUdfRldfTE9BREVSPW0KCiMKIyBNZW1vcnkgVGVjaG5vbG9neSBEZXZpY2VzIChNVEQpCiMK
IyBDT05GSUdfTVREIGlzIG5vdCBzZXQKCiMKIyBQYXJhbGxlbCBwb3J0IHN1cHBvcnQKIwpDT05G
SUdfUEFSUE9SVD15CkNPTkZJR19QQVJQT1JUX1BDPXkKQ09ORklHX1BBUlBPUlRfUENfQ01MMT15
CiMgQ09ORklHX1BBUlBPUlRfU0VSSUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFSUE9SVF9QQ19G
SUZPIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFSUE9SVF9QQ19TVVBFUklPIGlzIG5vdCBzZXQKIyBD
T05GSUdfUEFSUE9SVF9PVEhFUiBpcyBub3Qgc2V0CkNPTkZJR19QQVJQT1JUXzEyODQ9eQoKIwoj
IFBsdWcgYW5kIFBsYXkgc3VwcG9ydAojCkNPTkZJR19QTlA9eQojIENPTkZJR19QTlBfREVCVUcg
aXMgbm90IHNldAoKIwojIFByb3RvY29scwojCiMgQ09ORklHX0lTQVBOUCBpcyBub3Qgc2V0CiMg
Q09ORklHX1BOUEJJT1MgaXMgbm90IHNldAojIENPTkZJR19QTlBBQ1BJIGlzIG5vdCBzZXQKCiMK
IyBCbG9jayBkZXZpY2VzCiMKIyBDT05GSUdfQkxLX0RFVl9GRCBpcyBub3Qgc2V0CiMgQ09ORklH
X0JMS19ERVZfWEQgaXMgbm90IHNldAojIENPTkZJR19QQVJJREUgaXMgbm90IHNldAojIENPTkZJ
R19CTEtfQ1BRX0RBIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0NQUV9DSVNTX0RBIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkxLX0RFVl9EQUM5NjAgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1VN
RU0gaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0NPV19DT01NT04gaXMgbm90IHNldApDT05G
SUdfQkxLX0RFVl9MT09QPXkKIyBDT05GSUdfQkxLX0RFVl9DUllQVE9MT09QIGlzIG5vdCBzZXQK
Q09ORklHX0JMS19ERVZfTkJEPXkKQ09ORklHX0JMS19ERVZfU1g4PXkKIyBDT05GSUdfQkxLX0RF
Vl9VQiBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfUkFNIGlzIG5vdCBzZXQKQ09ORklHX0JM
S19ERVZfUkFNX0NPVU5UPTE2CkNPTkZJR19JTklUUkFNRlNfU09VUkNFPSIiCkNPTkZJR19MQkQ9
eQojIENPTkZJR19DRFJPTV9QS1RDRFZEIGlzIG5vdCBzZXQKCiMKIyBJTyBTY2hlZHVsZXJzCiMK
Q09ORklHX0lPU0NIRURfTk9PUD15CkNPTkZJR19JT1NDSEVEX0FTPXkKQ09ORklHX0lPU0NIRURf
REVBRExJTkU9eQpDT05GSUdfSU9TQ0hFRF9DRlE9eQojIENPTkZJR19BVEFfT1ZFUl9FVEggaXMg
bm90IHNldAoKIwojIEFUQS9BVEFQSS9NRk0vUkxMIHN1cHBvcnQKIwpDT05GSUdfSURFPXkKQ09O
RklHX0JMS19ERVZfSURFPXkKCiMKIyBQbGVhc2Ugc2VlIERvY3VtZW50YXRpb24vaWRlLnR4dCBm
b3IgaGVscC9pbmZvIG9uIElERSBkcml2ZXMKIwojIENPTkZJR19CTEtfREVWX0lERV9TQVRBIGlz
IG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9IRF9JREUgaXMgbm90IHNldApDT05GSUdfQkxLX0RF
Vl9JREVESVNLPXkKQ09ORklHX0lERURJU0tfTVVMVElfTU9ERT15CkNPTkZJR19CTEtfREVWX0lE
RUNEPXkKIyBDT05GSUdfQkxLX0RFVl9JREVUQVBFIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RF
Vl9JREVGTE9QUFkgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9JREVTQ1NJPXkKQ09ORklHX0lE
RV9UQVNLX0lPQ1RMPXkKCiMKIyBJREUgY2hpcHNldCBzdXBwb3J0L2J1Z2ZpeGVzCiMKQ09ORklH
X0lERV9HRU5FUklDPXkKQ09ORklHX0JMS19ERVZfQ01ENjQwPXkKIyBDT05GSUdfQkxLX0RFVl9D
TUQ2NDBfRU5IQU5DRUQgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0lERVBOUCBpcyBub3Qg
c2V0CkNPTkZJR19CTEtfREVWX0lERVBDST15CkNPTkZJR19JREVQQ0lfU0hBUkVfSVJRPXkKIyBD
T05GSUdfQkxLX0RFVl9PRkZCT0FSRCBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0dFTkVSSUM9
eQojIENPTkZJR19CTEtfREVWX09QVEk2MjEgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9SWjEw
MDA9eQpDT05GSUdfQkxLX0RFVl9JREVETUFfUENJPXkKIyBDT05GSUdfQkxLX0RFVl9JREVETUFf
Rk9SQ0VEIGlzIG5vdCBzZXQKQ09ORklHX0lERURNQV9QQ0lfQVVUTz15CiMgQ09ORklHX0lERURN
QV9PTkxZRElTSyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQUVDNjJYWCBpcyBub3Qgc2V0
CiMgQ09ORklHX0JMS19ERVZfQUxJMTVYMyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQU1E
NzRYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQVRJSVhQIGlzIG5vdCBzZXQKIyBDT05G
SUdfQkxLX0RFVl9DTUQ2NFggaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1RSSUZMRVggaXMg
bm90IHNldAojIENPTkZJR19CTEtfREVWX0NZODJDNjkzIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxL
X0RFVl9DUzU1MjAgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0NTNTUzMCBpcyBub3Qgc2V0
CiMgQ09ORklHX0JMS19ERVZfSFBUMzRYIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9IUFQz
NjYgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1NDMTIwMCBpcyBub3Qgc2V0CkNPTkZJR19C
TEtfREVWX1BJSVg9eQojIENPTkZJR19CTEtfREVWX05TODc0MTUgaXMgbm90IHNldAojIENPTkZJ
R19CTEtfREVWX1BEQzIwMlhYX09MRCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfUERDMjAy
WFhfTkVXIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9TVldLUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0JMS19ERVZfU0lJTUFHRSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfU0lTNTUxMyBp
cyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfU0xDOTBFNjYgaXMgbm90IHNldAojIENPTkZJR19C
TEtfREVWX1RSTTI5MCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfVklBODJDWFhYIGlzIG5v
dCBzZXQKIyBDT05GSUdfSURFX0FSTSBpcyBub3Qgc2V0CiMgQ09ORklHX0lERV9DSElQU0VUUyBp
cyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0lERURNQT15CiMgQ09ORklHX0lERURNQV9JVkIgaXMg
bm90IHNldApDT05GSUdfSURFRE1BX0FVVE89eQojIENPTkZJR19CTEtfREVWX0hEIGlzIG5vdCBz
ZXQKCiMKIyBTQ1NJIGRldmljZSBzdXBwb3J0CiMKQ09ORklHX1NDU0k9eQpDT05GSUdfU0NTSV9Q
Uk9DX0ZTPXkKCiMKIyBTQ1NJIHN1cHBvcnQgdHlwZSAoZGlzaywgdGFwZSwgQ0QtUk9NKQojCkNP
TkZJR19CTEtfREVWX1NEPXkKIyBDT05GSUdfQ0hSX0RFVl9TVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0NIUl9ERVZfT1NTVCBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX1NSPXkKQ09ORklHX0JMS19E
RVZfU1JfVkVORE9SPXkKQ09ORklHX0NIUl9ERVZfU0c9eQoKIwojIFNvbWUgU0NTSSBkZXZpY2Vz
IChlLmcuIENEIGp1a2Vib3gpIHN1cHBvcnQgbXVsdGlwbGUgTFVOcwojCiMgQ09ORklHX1NDU0lf
TVVMVElfTFVOIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9DT05TVEFOVFMgaXMgbm90IHNldAoj
IENPTkZJR19TQ1NJX0xPR0dJTkcgaXMgbm90IHNldAoKIwojIFNDU0kgVHJhbnNwb3J0IEF0dHJp
YnV0ZXMKIwojIENPTkZJR19TQ1NJX1NQSV9BVFRSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
RkNfQVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lTQ1NJX0FUVFJTIGlzIG5vdCBzZXQK
CiMKIyBTQ1NJIGxvdy1sZXZlbCBkcml2ZXJzCiMKIyBDT05GSUdfQkxLX0RFVl8zV19YWFhYX1JB
SUQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJXzNXXzlYWFggaXMgbm90IHNldAojIENPTkZJR19T
Q1NJXzcwMDBGQVNTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQUNBUkQgaXMgbm90IHNldAoj
IENPTkZJR19TQ1NJX0FIQTE1MlggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FIQTE1NDIgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX0FBQ1JBSUQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FJ
QzdYWFggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FJQzdYWFhfT0xEIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9BSUM3OVhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9EUFRfSTJPIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9JTjIwMDAgaXMgbm90IHNldAojIENPTkZJR19NRUdBUkFJRF9O
RVdHRU4gaXMgbm90IHNldAojIENPTkZJR19NRUdBUkFJRF9MRUdBQ1kgaXMgbm90IHNldApDT05G
SUdfU0NTSV9TQVRBPXkKIyBDT05GSUdfU0NTSV9TQVRBX0FIQ0kgaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX1NBVEFfU1ZXIGlzIG5vdCBzZXQKQ09ORklHX1NDU0lfQVRBX1BJSVg9eQojIENPTkZJ
R19TQ1NJX1NBVEFfTlYgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NBVEFfUFJPTUlTRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NDU0lfU0FUQV9RU1RPUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
U0FUQV9TWDQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NBVEFfU0lMIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9TQVRBX1NJUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU0FUQV9VTEkgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX1NBVEFfVklBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9T
QVRBX1ZJVEVTU0UgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0JVU0xPR0lDIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0NTSV9ETVgzMTkxRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRFRDMzI4MCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRUFUQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRUFU
QV9QSU8gaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0ZVVFVSRV9ET01BSU4gaXMgbm90IHNldAoj
IENPTkZJR19TQ1NJX0dEVEggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0dFTkVSSUNfTkNSNTM4
MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfR0VORVJJQ19OQ1I1MzgwX01NSU8gaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX0lQUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSU5JVElPIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9JTklBMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9QUEEg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lNTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTkNS
NTNDNDA2QSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU1lNNTNDOFhYXzIgaXMgbm90IHNldAoj
IENPTkZJR19TQ1NJX0lQUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUEFTMTYgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX1BTSTI0MEkgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FMT0dJQ19G
QVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FMT0dJQ19JU1AgaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX1FMT0dJQ19GQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUUxPR0lDXzEyODAgaXMg
bm90IHNldApDT05GSUdfU0NTSV9RTEEyWFhYPXkKIyBDT05GSUdfU0NTSV9RTEEyMVhYIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9RTEEyMlhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9RTEEy
MzAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9RTEEyMzIyIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0NTSV9RTEE2MzEyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9TWU01M0M0MTYgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX0RDMzk1eCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfREMzOTBUIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0NTSV9UMTI4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9VMTRf
MzRGIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9VTFRSQVNUT1IgaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX05TUDMyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9ERUJVRyBpcyBub3Qgc2V0Cgoj
CiMgT2xkIENELVJPTSBkcml2ZXJzIChub3QgU0NTSSwgbm90IElERSkKIwojIENPTkZJR19DRF9O
T19JREVTQ1NJIGlzIG5vdCBzZXQKCiMKIyBNdWx0aS1kZXZpY2Ugc3VwcG9ydCAoUkFJRCBhbmQg
TFZNKQojCiMgQ09ORklHX01EIGlzIG5vdCBzZXQKCiMKIyBGdXNpb24gTVBUIGRldmljZSBzdXBw
b3J0CiMKIyBDT05GSUdfRlVTSU9OIGlzIG5vdCBzZXQKCiMKIyBJRUVFIDEzOTQgKEZpcmVXaXJl
KSBzdXBwb3J0CiMKQ09ORklHX0lFRUUxMzk0PXkKCiMKIyBTdWJzeXN0ZW0gT3B0aW9ucwojCiMg
Q09ORklHX0lFRUUxMzk0X1ZFUkJPU0VERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0lFRUUxMzk0
X09VSV9EQiBpcyBub3Qgc2V0CkNPTkZJR19JRUVFMTM5NF9FWFRSQV9DT05GSUdfUk9NUz15CkNP
TkZJR19JRUVFMTM5NF9DT05GSUdfUk9NX0lQMTM5ND15CgojCiMgRGV2aWNlIERyaXZlcnMKIwoj
IENPTkZJR19JRUVFMTM5NF9QQ0lMWU5YIGlzIG5vdCBzZXQKQ09ORklHX0lFRUUxMzk0X09IQ0kx
Mzk0PXkKCiMKIyBQcm90b2NvbCBEcml2ZXJzCiMKQ09ORklHX0lFRUUxMzk0X1ZJREVPMTM5ND15
CkNPTkZJR19JRUVFMTM5NF9TQlAyPXkKIyBDT05GSUdfSUVFRTEzOTRfU0JQMl9QSFlTX0RNQSBp
cyBub3Qgc2V0CkNPTkZJR19JRUVFMTM5NF9FVEgxMzk0PXkKIyBDT05GSUdfSUVFRTEzOTRfRFYx
Mzk0IGlzIG5vdCBzZXQKQ09ORklHX0lFRUUxMzk0X1JBV0lPPXkKIyBDT05GSUdfSUVFRTEzOTRf
Q01QIGlzIG5vdCBzZXQKCiMKIyBJMk8gZGV2aWNlIHN1cHBvcnQKIwojIENPTkZJR19JMk8gaXMg
bm90IHNldAoKIwojIE5ldHdvcmtpbmcgc3VwcG9ydAojCkNPTkZJR19ORVQ9eQoKIwojIE5ldHdv
cmtpbmcgb3B0aW9ucwojCkNPTkZJR19QQUNLRVQ9bQpDT05GSUdfUEFDS0VUX01NQVA9eQojIENP
TkZJR19ORVRMSU5LX0RFViBpcyBub3Qgc2V0CkNPTkZJR19VTklYPXkKIyBDT05GSUdfTkVUX0tF
WSBpcyBub3Qgc2V0CkNPTkZJR19JTkVUPXkKQ09ORklHX0lQX01VTFRJQ0FTVD15CiMgQ09ORklH
X0lQX0FEVkFOQ0VEX1JPVVRFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX1BOUCBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9JUElQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0lQR1JFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSVBfTVJPVVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJQRCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NZTl9DT09LSUVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9BSCBpcyBub3Qg
c2V0CiMgQ09ORklHX0lORVRfRVNQIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9JUENPTVAgaXMg
bm90IHNldAojIENPTkZJR19JTkVUX1RVTk5FTCBpcyBub3Qgc2V0CkNPTkZJR19JUF9UQ1BESUFH
PXkKIyBDT05GSUdfSVBfVENQRElBR19JUFY2IGlzIG5vdCBzZXQKCiMKIyBJUDogVmlydHVhbCBT
ZXJ2ZXIgQ29uZmlndXJhdGlvbgojCiMgQ09ORklHX0lQX1ZTIGlzIG5vdCBzZXQKIyBDT05GSUdf
SVBWNiBpcyBub3Qgc2V0CkNPTkZJR19ORVRGSUxURVI9eQpDT05GSUdfTkVURklMVEVSX0RFQlVH
PXkKCiMKIyBJUDogTmV0ZmlsdGVyIENvbmZpZ3VyYXRpb24KIwpDT05GSUdfSVBfTkZfQ09OTlRS
QUNLPXkKIyBDT05GSUdfSVBfTkZfQ1RfQUNDVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX0NP
Tk5UUkFDS19NQVJLIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfTkZfQ1RfUFJPVE9fU0NUUCBpcyBu
b3Qgc2V0CkNPTkZJR19JUF9ORl9GVFA9bQpDT05GSUdfSVBfTkZfSVJDPW0KQ09ORklHX0lQX05G
X1RGVFA9bQojIENPTkZJR19JUF9ORl9BTUFOREEgaXMgbm90IHNldAojIENPTkZJR19JUF9ORl9R
VUVVRSBpcyBub3Qgc2V0CkNPTkZJR19JUF9ORl9JUFRBQkxFUz1tCkNPTkZJR19JUF9ORl9NQVRD
SF9MSU1JVD1tCkNPTkZJR19JUF9ORl9NQVRDSF9JUFJBTkdFPW0KQ09ORklHX0lQX05GX01BVENI
X01BQz1tCkNPTkZJR19JUF9ORl9NQVRDSF9QS1RUWVBFPW0KIyBDT05GSUdfSVBfTkZfTUFUQ0hf
TUFSSyBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX01BVENIX01VTFRJUE9SVCBpcyBub3Qgc2V0
CiMgQ09ORklHX0lQX05GX01BVENIX1RPUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX01BVENI
X1JFQ0VOVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX01BVENIX0VDTiBpcyBub3Qgc2V0CiMg
Q09ORklHX0lQX05GX01BVENIX0RTQ1AgaXMgbm90IHNldAojIENPTkZJR19JUF9ORl9NQVRDSF9B
SF9FU1AgaXMgbm90IHNldAojIENPTkZJR19JUF9ORl9NQVRDSF9MRU5HVEggaXMgbm90IHNldAoj
IENPTkZJR19JUF9ORl9NQVRDSF9UVEwgaXMgbm90IHNldApDT05GSUdfSVBfTkZfTUFUQ0hfVENQ
TVNTPW0KIyBDT05GSUdfSVBfTkZfTUFUQ0hfSEVMUEVSIGlzIG5vdCBzZXQKQ09ORklHX0lQX05G
X01BVENIX1NUQVRFPW0KQ09ORklHX0lQX05GX01BVENIX0NPTk5UUkFDSz1tCkNPTkZJR19JUF9O
Rl9NQVRDSF9PV05FUj1tCkNPTkZJR19JUF9ORl9NQVRDSF9BRERSVFlQRT1tCkNPTkZJR19JUF9O
Rl9NQVRDSF9SRUFMTT1tCkNPTkZJR19JUF9ORl9NQVRDSF9TQ1RQPW0KQ09ORklHX0lQX05GX01B
VENIX0NPTU1FTlQ9bQpDT05GSUdfSVBfTkZfTUFUQ0hfSEFTSExJTUlUPW0KQ09ORklHX0lQX05G
X0ZJTFRFUj1tCkNPTkZJR19JUF9ORl9UQVJHRVRfUkVKRUNUPW0KQ09ORklHX0lQX05GX1RBUkdF
VF9MT0c9bQpDT05GSUdfSVBfTkZfVEFSR0VUX1VMT0c9bQpDT05GSUdfSVBfTkZfVEFSR0VUX1RD
UE1TUz1tCkNPTkZJR19JUF9ORl9OQVQ9bQpDT05GSUdfSVBfTkZfTkFUX05FRURFRD15CkNPTkZJ
R19JUF9ORl9UQVJHRVRfTUFTUVVFUkFERT1tCkNPTkZJR19JUF9ORl9UQVJHRVRfUkVESVJFQ1Q9
bQpDT05GSUdfSVBfTkZfVEFSR0VUX05FVE1BUD1tCkNPTkZJR19JUF9ORl9UQVJHRVRfU0FNRT1t
CkNPTkZJR19JUF9ORl9OQVRfU05NUF9CQVNJQz1tCkNPTkZJR19JUF9ORl9OQVRfSVJDPW0KQ09O
RklHX0lQX05GX05BVF9GVFA9bQpDT05GSUdfSVBfTkZfTkFUX1RGVFA9bQpDT05GSUdfSVBfTkZf
TUFOR0xFPW0KQ09ORklHX0lQX05GX1RBUkdFVF9UT1M9bQpDT05GSUdfSVBfTkZfVEFSR0VUX0VD
Tj1tCkNPTkZJR19JUF9ORl9UQVJHRVRfRFNDUD1tCkNPTkZJR19JUF9ORl9UQVJHRVRfTUFSSz1t
CkNPTkZJR19JUF9ORl9UQVJHRVRfQ0xBU1NJRlk9bQojIENPTkZJR19JUF9ORl9SQVcgaXMgbm90
IHNldAojIENPTkZJR19JUF9ORl9BUlBUQUJMRVMgaXMgbm90IHNldAoKIwojIFNDVFAgQ29uZmln
dXJhdGlvbiAoRVhQRVJJTUVOVEFMKQojCiMgQ09ORklHX0lQX1NDVFAgaXMgbm90IHNldAojIENP
TkZJR19BVE0gaXMgbm90IHNldAojIENPTkZJR19CUklER0UgaXMgbm90IHNldAojIENPTkZJR19W
TEFOXzgwMjFRIGlzIG5vdCBzZXQKIyBDT05GSUdfREVDTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdf
TExDMiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQWCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUQUxLIGlz
IG5vdCBzZXQKIyBDT05GSUdfWDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfTEFQQiBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9ESVZFUlQgaXMgbm90IHNldAojIENPTkZJR19FQ09ORVQgaXMgbm90IHNl
dAojIENPTkZJR19XQU5fUk9VVEVSIGlzIG5vdCBzZXQKCiMKIyBRb1MgYW5kL29yIGZhaXIgcXVl
dWVpbmcKIwojIENPTkZJR19ORVRfU0NIRUQgaXMgbm90IHNldApDT05GSUdfTkVUX0NMU19ST1VU
RT15CgojCiMgTmV0d29yayB0ZXN0aW5nCiMKIyBDT05GSUdfTkVUX1BLVEdFTiBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVFBPTEwgaXMgbm90IHNldAojIENPTkZJR19ORVRfUE9MTF9DT05UUk9MTEVS
IGlzIG5vdCBzZXQKQ09ORklHX0hBTVJBRElPPXkKCiMKIyBQYWNrZXQgUmFkaW8gcHJvdG9jb2xz
CiMKIyBDT05GSUdfQVgyNSBpcyBub3Qgc2V0CkNPTkZJR19JUkRBPXkKCiMKIyBJckRBIHByb3Rv
Y29scwojCiMgQ09ORklHX0lSTEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfSVJDT01NIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSVJEQV9VTFRSQSBpcyBub3Qgc2V0CgojCiMgSXJEQSBvcHRpb25zCiMKIyBD
T05GSUdfSVJEQV9DQUNIRV9MQVNUX0xTQVAgaXMgbm90IHNldAojIENPTkZJR19JUkRBX0ZBU1Rf
UlIgaXMgbm90IHNldAojIENPTkZJR19JUkRBX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBJbmZyYXJl
ZC1wb3J0IGRldmljZSBkcml2ZXJzCiMKCiMKIyBTSVIgZGV2aWNlIGRyaXZlcnMKIwojIENPTkZJ
R19JUlRUWV9TSVIgaXMgbm90IHNldAoKIwojIERvbmdsZSBzdXBwb3J0CiMKCiMKIyBPbGQgU0lS
IGRldmljZSBkcml2ZXJzCiMKCiMKIyBPbGQgU2VyaWFsIGRvbmdsZSBzdXBwb3J0CiMKCiMKIyBG
SVIgZGV2aWNlIGRyaXZlcnMKIwojIENPTkZJR19VU0JfSVJEQSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NJR01BVEVMX0ZJUiBpcyBub3Qgc2V0CiMgQ09ORklHX05TQ19GSVIgaXMgbm90IHNldAojIENP
TkZJR19XSU5CT05EX0ZJUiBpcyBub3Qgc2V0CiMgQ09ORklHX1RPU0hJQkFfRklSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU01DX0lSQ0NfRklSIGlzIG5vdCBzZXQKIyBDT05GSUdfQUxJX0ZJUiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1ZMU0lfRklSIGlzIG5vdCBzZXQKIyBDT05GSUdfVklBX0ZJUiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JUIGlzIG5vdCBzZXQKQ09ORklHX05FVERFVklDRVM9eQpDT05GSUdf
RFVNTVk9bQojIENPTkZJR19CT05ESU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfRVFVQUxJWkVSIGlz
IG5vdCBzZXQKIyBDT05GSUdfVFVOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NCMTAwMCBpcyBu
b3Qgc2V0CgojCiMgQVJDbmV0IGRldmljZXMKIwojIENPTkZJR19BUkNORVQgaXMgbm90IHNldAoK
IwojIEV0aGVybmV0ICgxMCBvciAxMDBNYml0KQojCkNPTkZJR19ORVRfRVRIRVJORVQ9eQpDT05G
SUdfTUlJPXkKIyBDT05GSUdfSEFQUFlNRUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfU1VOR0VNIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl8zQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfTEFO
Q0UgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1NNQyBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9WRU5ET1JfUkFDQUwgaXMgbm90IHNldAoKIwojIFR1bGlwIGZhbWlseSBuZXR3b3JrIGRl
dmljZSBzdXBwb3J0CiMKIyBDT05GSUdfTkVUX1RVTElQIGlzIG5vdCBzZXQKIyBDT05GSUdfQVQx
NzAwIGlzIG5vdCBzZXQKIyBDT05GSUdfREVQQ0EgaXMgbm90IHNldAojIENPTkZJR19IUDEwMCBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9JU0EgaXMgbm90IHNldApDT05GSUdfTkVUX1BDST15CiMg
Q09ORklHX1BDTkVUMzIgaXMgbm90IHNldAojIENPTkZJR19BTUQ4MTExX0VUSCBpcyBub3Qgc2V0
CiMgQ09ORklHX0FEQVBURUNfU1RBUkZJUkUgaXMgbm90IHNldAojIENPTkZJR19BQzMyMDAgaXMg
bm90IHNldAojIENPTkZJR19BUFJJQ09UIGlzIG5vdCBzZXQKIyBDT05GSUdfQjQ0IGlzIG5vdCBz
ZXQKIyBDT05GSUdfRk9SQ0VERVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1M4OXgwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfREdSUyBpcyBub3Qgc2V0CiMgQ09ORklHX0VFUFJPMTAwIGlzIG5vdCBzZXQK
IyBDT05GSUdfRTEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZFQUxOWCBpcyBub3Qgc2V0CiMgQ09O
RklHX05BVFNFTUkgaXMgbm90IHNldAojIENPTkZJR19ORTJLX1BDSSBpcyBub3Qgc2V0CiMgQ09O
RklHXzgxMzlDUCBpcyBub3Qgc2V0CkNPTkZJR184MTM5VE9PPXkKQ09ORklHXzgxMzlUT09fUElP
PXkKQ09ORklHXzgxMzlUT09fVFVORV9UV0lTVEVSPXkKIyBDT05GSUdfODEzOVRPT184MTI5IGlz
IG5vdCBzZXQKIyBDT05GSUdfODEzOV9PTERfUlhfUkVTRVQgaXMgbm90IHNldAojIENPTkZJR19T
SVM5MDAgaXMgbm90IHNldAojIENPTkZJR19FUElDMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU1VO
REFOQ0UgaXMgbm90IHNldAojIENPTkZJR19UTEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfVklBX1JI
SU5FIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1BPQ0tFVCBpcyBub3Qgc2V0CgojCiMgRXRoZXJu
ZXQgKDEwMDAgTWJpdCkKIwojIENPTkZJR19BQ0VOSUMgaXMgbm90IHNldAojIENPTkZJR19ETDJL
IGlzIG5vdCBzZXQKIyBDT05GSUdfRTEwMDAgaXMgbm90IHNldAojIENPTkZJR19OUzgzODIwIGlz
IG5vdCBzZXQKIyBDT05GSUdfSEFNQUNISSBpcyBub3Qgc2V0CiMgQ09ORklHX1lFTExPV0ZJTiBp
cyBub3Qgc2V0CiMgQ09ORklHX1I4MTY5IGlzIG5vdCBzZXQKIyBDT05GSUdfU0s5OExJTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1ZJQV9WRUxPQ0lUWSBpcyBub3Qgc2V0CiMgQ09ORklHX1RJR09OMyBp
cyBub3Qgc2V0CgojCiMgRXRoZXJuZXQgKDEwMDAwIE1iaXQpCiMKIyBDT05GSUdfSVhHQiBpcyBu
b3Qgc2V0CkNPTkZJR19TMklPPW0KIyBDT05GSUdfUzJJT19OQVBJIGlzIG5vdCBzZXQKIyBDT05G
SUdfMkJVRkZfTU9ERSBpcyBub3Qgc2V0CgojCiMgVG9rZW4gUmluZyBkZXZpY2VzCiMKIyBDT05G
SUdfVFIgaXMgbm90IHNldAoKIwojIFdpcmVsZXNzIExBTiAobm9uLWhhbXJhZGlvKQojCkNPTkZJ
R19ORVRfUkFESU89eQoKIwojIE9ic29sZXRlIFdpcmVsZXNzIGNhcmRzIHN1cHBvcnQgKHByZS04
MDIuMTEpCiMKIyBDT05GSUdfU1RSSVAgaXMgbm90IHNldAojIENPTkZJR19BUkxBTiBpcyBub3Qg
c2V0CiMgQ09ORklHX1dBVkVMQU4gaXMgbm90IHNldAoKIwojIFdpcmVsZXNzIDgwMi4xMWIgSVNB
L1BDSSBjYXJkcyBzdXBwb3J0CiMKIyBDT05GSUdfQUlSTyBpcyBub3Qgc2V0CiMgQ09ORklHX0hF
Uk1FUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FUTUVMIGlzIG5vdCBzZXQKCiMKIyBQcmlzbSBHVC9E
dWV0dGUgODAyLjExKGEvYi9nKSBQQ0kvQ2FyZGJ1cyBzdXBwb3J0CiMKIyBDT05GSUdfUFJJU001
NCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfV0lSRUxFU1M9eQoKIwojIFdhbiBpbnRlcmZhY2VzCiMK
IyBDT05GSUdfV0FOIGlzIG5vdCBzZXQKIyBDT05GSUdfRkRESSBpcyBub3Qgc2V0CiMgQ09ORklH
X0hJUFBJIGlzIG5vdCBzZXQKIyBDT05GSUdfUExJUCBpcyBub3Qgc2V0CiMgQ09ORklHX1BQUCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NMSVAgaXMgbm90IHNldAojIENPTkZJR19ORVRfRkMgaXMgbm90
IHNldAojIENPTkZJR19TSEFQRVIgaXMgbm90IHNldAojIENPTkZJR19ORVRDT05TT0xFIGlzIG5v
dCBzZXQKCiMKIyBJU0ROIHN1YnN5c3RlbQojCiMgQ09ORklHX0lTRE4gaXMgbm90IHNldAoKIwoj
IFRlbGVwaG9ueSBTdXBwb3J0CiMKIyBDT05GSUdfUEhPTkUgaXMgbm90IHNldAoKIwojIElucHV0
IGRldmljZSBzdXBwb3J0CiMKQ09ORklHX0lOUFVUPXkKCiMKIyBVc2VybGFuZCBpbnRlcmZhY2Vz
CiMKQ09ORklHX0lOUFVUX01PVVNFREVWPXkKQ09ORklHX0lOUFVUX01PVVNFREVWX1BTQVVYPXkK
Q09ORklHX0lOUFVUX01PVVNFREVWX1NDUkVFTl9YPTEwMjQKQ09ORklHX0lOUFVUX01PVVNFREVW
X1NDUkVFTl9ZPTc2OAojIENPTkZJR19JTlBVVF9KT1lERVYgaXMgbm90IHNldAojIENPTkZJR19J
TlBVVF9UU0RFViBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0VWREVWIGlzIG5vdCBzZXQKIyBD
T05GSUdfSU5QVVRfRVZCVUcgaXMgbm90IHNldAoKIwojIElucHV0IEkvTyBkcml2ZXJzCiMKIyBD
T05GSUdfR0FNRVBPUlQgaXMgbm90IHNldApDT05GSUdfU09VTkRfR0FNRVBPUlQ9eQpDT05GSUdf
U0VSSU89eQpDT05GSUdfU0VSSU9fSTgwNDI9eQojIENPTkZJR19TRVJJT19TRVJQT1JUIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VSSU9fQ1Q4MkM3MTAgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19Q
QVJLQkQgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19QQ0lQUzIgaXMgbm90IHNldApDT05GSUdf
U0VSSU9fTElCUFMyPXkKIyBDT05GSUdfU0VSSU9fUkFXIGlzIG5vdCBzZXQKCiMKIyBJbnB1dCBE
ZXZpY2UgRHJpdmVycwojCkNPTkZJR19JTlBVVF9LRVlCT0FSRD15CkNPTkZJR19LRVlCT0FSRF9B
VEtCRD15CiMgQ09ORklHX0tFWUJPQVJEX1NVTktCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJP
QVJEX0xLS0JEIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfWFRLQkQgaXMgbm90IHNldAoj
IENPTkZJR19LRVlCT0FSRF9ORVdUT04gaXMgbm90IHNldApDT05GSUdfSU5QVVRfTU9VU0U9eQpD
T05GSUdfTU9VU0VfUFMyPXkKIyBDT05GSUdfTU9VU0VfU0VSSUFMIGlzIG5vdCBzZXQKIyBDT05G
SUdfTU9VU0VfSU5QT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfTE9HSUJNIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTU9VU0VfUEMxMTBQQUQgaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9WU1hY
WEFBIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfSk9ZU1RJQ0sgaXMgbm90IHNldAojIENPTkZJ
R19JTlBVVF9UT1VDSFNDUkVFTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX01JU0MgaXMgbm90
IHNldAoKIwojIENoYXJhY3RlciBkZXZpY2VzCiMKQ09ORklHX1ZUPXkKQ09ORklHX1ZUX0NPTlNP
TEU9eQpDT05GSUdfSFdfQ09OU09MRT15CiMgQ09ORklHX1NFUklBTF9OT05TVEFOREFSRCBpcyBu
b3Qgc2V0CgojCiMgU2VyaWFsIGRyaXZlcnMKIwpDT05GSUdfU0VSSUFMXzgyNTA9eQojIENPTkZJ
R19TRVJJQUxfODI1MF9DT05TT0xFIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMXzgyNTBfQUNQ
SSBpcyBub3Qgc2V0CkNPTkZJR19TRVJJQUxfODI1MF9OUl9VQVJUUz00CiMgQ09ORklHX1NFUklB
TF84MjUwX0VYVEVOREVEIGlzIG5vdCBzZXQKCiMKIyBOb24tODI1MCBzZXJpYWwgcG9ydCBzdXBw
b3J0CiMKQ09ORklHX1NFUklBTF9DT1JFPXkKQ09ORklHX1VOSVg5OF9QVFlTPXkKQ09ORklHX0xF
R0FDWV9QVFlTPXkKQ09ORklHX0xFR0FDWV9QVFlfQ09VTlQ9MjU2CkNPTkZJR19QUklOVEVSPXkK
IyBDT05GSUdfTFBfQ09OU09MRSBpcyBub3Qgc2V0CiMgQ09ORklHX1BQREVWIGlzIG5vdCBzZXQK
IyBDT05GSUdfVElQQVIgaXMgbm90IHNldAoKIwojIElQTUkKIwojIENPTkZJR19JUE1JX0hBTkRM
RVIgaXMgbm90IHNldAoKIwojIFdhdGNoZG9nIENhcmRzCiMKIyBDT05GSUdfV0FUQ0hET0cgaXMg
bm90IHNldAojIENPTkZJR19IV19SQU5ET00gaXMgbm90IHNldAojIENPTkZJR19OVlJBTSBpcyBu
b3Qgc2V0CkNPTkZJR19SVEM9bQojIENPTkZJR19HRU5fUlRDIGlzIG5vdCBzZXQKIyBDT05GSUdf
RFRMSyBpcyBub3Qgc2V0CiMgQ09ORklHX1IzOTY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQVBQTElD
T00gaXMgbm90IHNldAojIENPTkZJR19TT05ZUEkgaXMgbm90IHNldAoKIwojIEZ0YXBlLCB0aGUg
ZmxvcHB5IHRhcGUgZGV2aWNlIGRyaXZlcgojCkNPTkZJR19BR1A9eQojIENPTkZJR19BR1BfQUxJ
IGlzIG5vdCBzZXQKIyBDT05GSUdfQUdQX0FUSSBpcyBub3Qgc2V0CiMgQ09ORklHX0FHUF9BTUQg
aXMgbm90IHNldAojIENPTkZJR19BR1BfQU1ENjQgaXMgbm90IHNldApDT05GSUdfQUdQX0lOVEVM
PXkKIyBDT05GSUdfQUdQX0lOVEVMX01DSCBpcyBub3Qgc2V0CiMgQ09ORklHX0FHUF9OVklESUEg
aXMgbm90IHNldAojIENPTkZJR19BR1BfU0lTIGlzIG5vdCBzZXQKIyBDT05GSUdfQUdQX1NXT1JL
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0FHUF9WSUEgaXMgbm90IHNldAojIENPTkZJR19BR1BfRUZG
SUNFT04gaXMgbm90IHNldApDT05GSUdfRFJNPXkKIyBDT05GSUdfRFJNX1RERlggaXMgbm90IHNl
dAojIENPTkZJR19EUk1fUjEyOCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9SQURFT04gaXMgbm90
IHNldApDT05GSUdfRFJNX0k4MTA9eQojIENPTkZJR19EUk1fSTgzMCBpcyBub3Qgc2V0CkNPTkZJ
R19EUk1fSTkxNT1tCiMgQ09ORklHX0RSTV9NR0EgaXMgbm90IHNldAojIENPTkZJR19EUk1fU0lT
IGlzIG5vdCBzZXQKIyBDT05GSUdfTVdBVkUgaXMgbm90IHNldAojIENPTkZJR19SQVdfRFJJVkVS
IGlzIG5vdCBzZXQKIyBDT05GSUdfSFBFVCBpcyBub3Qgc2V0CiMgQ09ORklHX0hBTkdDSEVDS19U
SU1FUiBpcyBub3Qgc2V0CgojCiMgSTJDIHN1cHBvcnQKIwpDT05GSUdfSTJDPXkKIyBDT05GSUdf
STJDX0NIQVJERVYgaXMgbm90IHNldAoKIwojIEkyQyBBbGdvcml0aG1zCiMKIyBDT05GSUdfSTJD
X0FMR09CSVQgaXMgbm90IHNldAojIENPTkZJR19JMkNfQUxHT1BDRiBpcyBub3Qgc2V0CiMgQ09O
RklHX0kyQ19BTEdPUENBIGlzIG5vdCBzZXQKCiMKIyBJMkMgSGFyZHdhcmUgQnVzIHN1cHBvcnQK
IwojIENPTkZJR19JMkNfQUxJMTUzNSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTEkxNTYzIGlz
IG5vdCBzZXQKIyBDT05GSUdfSTJDX0FMSTE1WDMgaXMgbm90IHNldAojIENPTkZJR19JMkNfQU1E
NzU2IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0FNRDgxMTEgaXMgbm90IHNldAojIENPTkZJR19J
MkNfSTgwMSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19JODEwIGlzIG5vdCBzZXQKIyBDT05GSUdf
STJDX0lTQSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ORk9SQ0UyIGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX1BBUlBPUlQgaXMgbm90IHNldAojIENPTkZJR19JMkNfUEFSUE9SVF9MSUdIVCBpcyBu
b3Qgc2V0CkNPTkZJR19JMkNfUElJWDQ9bQojIENPTkZJR19JMkNfUFJPU0FWQUdFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSTJDX1NBVkFHRTQgaXMgbm90IHNldAojIENPTkZJR19TQ3gyMDBfQUNCIGlz
IG5vdCBzZXQKIyBDT05GSUdfSTJDX1NJUzU1OTUgaXMgbm90IHNldAojIENPTkZJR19JMkNfU0lT
NjMwIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NJUzk2WCBpcyBub3Qgc2V0CiMgQ09ORklHX0ky
Q19TVFVCIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1ZJQSBpcyBub3Qgc2V0CiMgQ09ORklHX0ky
Q19WSUFQUk8gaXMgbm90IHNldAojIENPTkZJR19JMkNfVk9PRE9PMyBpcyBub3Qgc2V0CiMgQ09O
RklHX0kyQ19QQ0FfSVNBIGlzIG5vdCBzZXQKCiMKIyBIYXJkd2FyZSBTZW5zb3JzIENoaXAgc3Vw
cG9ydAojCiMgQ09ORklHX0kyQ19TRU5TT1IgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FE
TTEwMjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FETTEwMjUgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX0FETTEwMjYgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FETTEwMzEg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FTQjEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfRFMxNjIxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19GU0NIRVIgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX0dMNTE4U00gaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0lU
ODcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNNjMgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX0xNNzUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNNzcgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX0xNNzggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNODAgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNODMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X0xNODUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNODcgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX0xNOTAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDE2MTkgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX1BDODczNjAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X1NNU0M0N0IzOTcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NNU0M0N00xIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19WSUE2ODZBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19X
ODM3ODFEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODNMNzg1VFMgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX1c4MzYyN0hGIGlzIG5vdCBzZXQKCiMKIyBPdGhlciBJMkMgQ2hpcCBz
dXBwb3J0CiMKIyBDT05GSUdfU0VOU09SU19FRVBST00gaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX1BDRjg1NzQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1BDRjg1OTEgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX1JUQzg1NjQgaXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdf
Q09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ERUJVR19BTEdPIGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX0RFQlVHX0JVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ERUJVR19DSElQIGlzIG5v
dCBzZXQKCiMKIyBEYWxsYXMncyAxLXdpcmUgYnVzCiMKIyBDT05GSUdfVzEgaXMgbm90IHNldAoK
IwojIE1pc2MgZGV2aWNlcwojCiMgQ09ORklHX0lCTV9BU00gaXMgbm90IHNldAoKIwojIE11bHRp
bWVkaWEgZGV2aWNlcwojCiMgQ09ORklHX1ZJREVPX0RFViBpcyBub3Qgc2V0CgojCiMgRGlnaXRh
bCBWaWRlbyBCcm9hZGNhc3RpbmcgRGV2aWNlcwojCiMgQ09ORklHX0RWQiBpcyBub3Qgc2V0Cgoj
CiMgR3JhcGhpY3Mgc3VwcG9ydAojCiMgQ09ORklHX0ZCIGlzIG5vdCBzZXQKIyBDT05GSUdfVklE
RU9fU0VMRUNUIGlzIG5vdCBzZXQKCiMKIyBDb25zb2xlIGRpc3BsYXkgZHJpdmVyIHN1cHBvcnQK
IwpDT05GSUdfVkdBX0NPTlNPTEU9eQojIENPTkZJR19NREFfQ09OU09MRSBpcyBub3Qgc2V0CkNP
TkZJR19EVU1NWV9DT05TT0xFPXkKCiMKIyBTb3VuZAojCkNPTkZJR19TT1VORD15CgojCiMgQWR2
YW5jZWQgTGludXggU291bmQgQXJjaGl0ZWN0dXJlCiMKQ09ORklHX1NORD15CkNPTkZJR19TTkRf
VElNRVI9eQpDT05GSUdfU05EX1BDTT15CkNPTkZJR19TTkRfU0VRVUVOQ0VSPXkKIyBDT05GSUdf
U05EX1NFUV9EVU1NWSBpcyBub3Qgc2V0CkNPTkZJR19TTkRfT1NTRU1VTD15CkNPTkZJR19TTkRf
TUlYRVJfT1NTPXkKQ09ORklHX1NORF9QQ01fT1NTPXkKQ09ORklHX1NORF9TRVFVRU5DRVJfT1NT
PXkKIyBDT05GSUdfU05EX1JUQ1RJTUVSIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1ZFUkJPU0Vf
UFJJTlRLIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBHZW5l
cmljIGRldmljZXMKIwojIENPTkZJR19TTkRfRFVNTVkgaXMgbm90IHNldAojIENPTkZJR19TTkRf
VklSTUlESSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9NVFBBViBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9TRVJJQUxfVTE2NTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX01QVTQwMSBpcyBub3Qg
c2V0CgojCiMgSVNBIGRldmljZXMKIwojIENPTkZJR19TTkRfQUQxODQ4IGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX0NTNDIzMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9DUzQyMzIgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfQ1M0MjM2IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VTMTY4OCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9FUzE4WFggaXMgbm90IHNldAojIENPTkZJR19TTkRfR1VTQ0xB
U1NJQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9HVVNFWFRSRU1FIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX0dVU01BWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9JTlRFUldBVkUgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfSU5URVJXQVZFX1NUQiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9PUFRJ
OTJYX0FEMTg0OCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9PUFRJOTJYX0NTNDIzMSBpcyBub3Qg
c2V0CiMgQ09ORklHX1NORF9PUFRJOTNYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NCOCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9TQjE2IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NCQVdFIGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX1dBVkVGUk9OVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9D
TUk4MzMwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX09QTDNTQTIgaXMgbm90IHNldAojIENPTkZJ
R19TTkRfU0dBTEFYWSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TU0NBUEUgaXMgbm90IHNldAoK
IwojIFBDSSBkZXZpY2VzCiMKQ09ORklHX1NORF9BQzk3X0NPREVDPXkKIyBDT05GSUdfU05EX0FM
STU0NTEgaXMgbm90IHNldAojIENPTkZJR19TTkRfQVRJSVhQIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX0FUSUlYUF9NT0RFTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BVTg4MTAgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfQVU4ODIwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FVODgzMCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9BWlQzMzI4IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0JUODdY
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NTNDZYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9D
UzQyODEgaXMgbm90IHNldAojIENPTkZJR19TTkRfRU1VMTBLMSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9FTVUxMEsxWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9DQTAxMDYgaXMgbm90IHNldAoj
IENPTkZJR19TTkRfS09SRzEyMTIgaXMgbm90IHNldAojIENPTkZJR19TTkRfTUlYQVJUIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX05NMjU2IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1JNRTMyIGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX1JNRTk2IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1JNRTk2
NTIgaXMgbm90IHNldAojIENPTkZJR19TTkRfSERTUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9U
UklERU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1lNRlBDSSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9BTFM0MDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NNSVBDSSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9FTlMxMzcwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VOUzEzNzEgaXMgbm90
IHNldAojIENPTkZJR19TTkRfRVMxOTM4IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VTMTk2OCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9NQUVTVFJPMyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9G
TTgwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9JQ0UxNzEyIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX0lDRTE3MjQgaXMgbm90IHNldApDT05GSUdfU05EX0lOVEVMOFgwPXkKQ09ORklHX1NORF9J
TlRFTDhYME09eQojIENPTkZJR19TTkRfU09OSUNWSUJFUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9WSUE4MlhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1ZJQTgyWFhfTU9ERU0gaXMgbm90IHNl
dAojIENPTkZJR19TTkRfVlgyMjIgaXMgbm90IHNldAoKIwojIFVTQiBkZXZpY2VzCiMKIyBDT05G
SUdfU05EX1VTQl9BVURJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9VU0JfVVNYMlkgaXMgbm90
IHNldAoKIwojIE9wZW4gU291bmQgU3lzdGVtCiMKIyBDT05GSUdfU09VTkRfUFJJTUUgaXMgbm90
IHNldAoKIwojIFVTQiBzdXBwb3J0CiMKQ09ORklHX1VTQj15CiMgQ09ORklHX1VTQl9ERUJVRyBp
cyBub3Qgc2V0CgojCiMgTWlzY2VsbGFuZW91cyBVU0Igb3B0aW9ucwojCkNPTkZJR19VU0JfREVW
SUNFRlM9eQojIENPTkZJR19VU0JfQkFORFdJRFRIIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0RZ
TkFNSUNfTUlOT1JTIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NVU1BFTkQgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfT1RHIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9BUkNIX0hBU19IQ0Q9eQpDT05G
SUdfVVNCX0FSQ0hfSEFTX09IQ0k9eQoKIwojIFVTQiBIb3N0IENvbnRyb2xsZXIgRHJpdmVycwoj
CkNPTkZJR19VU0JfRUhDSV9IQ0Q9eQojIENPTkZJR19VU0JfRUhDSV9TUExJVF9JU08gaXMgbm90
IHNldAojIENPTkZJR19VU0JfRUhDSV9ST09UX0hVQl9UVCBpcyBub3Qgc2V0CkNPTkZJR19VU0Jf
T0hDSV9IQ0Q9eQpDT05GSUdfVVNCX1VIQ0lfSENEPXkKIyBDT05GSUdfVVNCX1NMODExX0hDRCBp
cyBub3Qgc2V0CgojCiMgVVNCIERldmljZSBDbGFzcyBkcml2ZXJzCiMKIyBDT05GSUdfVVNCX0FV
RElPIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0JMVUVUT09USF9UVFkgaXMgbm90IHNldAojIENP
TkZJR19VU0JfTUlESSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BQ00gaXMgbm90IHNldApDT05G
SUdfVVNCX1BSSU5URVI9eQoKIwojIE5PVEU6IFVTQl9TVE9SQUdFIGVuYWJsZXMgU0NTSSwgYW5k
ICdTQ1NJIGRpc2sgc3VwcG9ydCcgbWF5IGFsc28gYmUgbmVlZGVkOyBzZWUgVVNCX1NUT1JBR0Ug
SGVscCBmb3IgbW9yZSBpbmZvcm1hdGlvbgojCkNPTkZJR19VU0JfU1RPUkFHRT15CiMgQ09ORklH
X1VTQl9TVE9SQUdFX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfUldfREVU
RUNUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfREFUQUZBQiBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9TVE9SQUdFX0ZSRUVDT00gaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFH
RV9JU0QyMDAgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9EUENNIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX1NUT1JBR0VfSFA4MjAwZSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9S
QUdFX1NERFIwOSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX1NERFI1NSBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0pVTVBTSE9UIGlzIG5vdCBzZXQKCiMKIyBVU0IgSW5w
dXQgRGV2aWNlcwojCkNPTkZJR19VU0JfSElEPXkKQ09ORklHX1VTQl9ISURJTlBVVD15CiMgQ09O
RklHX0hJRF9GRiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9ISURERVYgaXMgbm90IHNldAojIENP
TkZJR19VU0JfQUlQVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1dBQ09NIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX0tCVEFCIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1BPV0VSTUFURSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9NVE9VQ0ggaXMgbm90IHNldAojIENPTkZJR19VU0JfRUdBTEFY
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1hQQUQgaXMgbm90IHNldAojIENPTkZJR19VU0JfQVRJ
X1JFTU9URSBpcyBub3Qgc2V0CgojCiMgVVNCIEltYWdpbmcgZGV2aWNlcwojCiMgQ09ORklHX1VT
Ql9NREM4MDAgaXMgbm90IHNldAojIENPTkZJR19VU0JfTUlDUk9URUsgaXMgbm90IHNldAoKIwoj
IFVTQiBNdWx0aW1lZGlhIGRldmljZXMKIwojIENPTkZJR19VU0JfREFCVVNCIGlzIG5vdCBzZXQK
CiMKIyBWaWRlbzRMaW51eCBzdXBwb3J0IGlzIG5lZWRlZCBmb3IgVVNCIE11bHRpbWVkaWEgZGV2
aWNlIHN1cHBvcnQKIwoKIwojIFVTQiBOZXR3b3JrIEFkYXB0ZXJzCiMKIyBDT05GSUdfVVNCX0NB
VEMgaXMgbm90IHNldAojIENPTkZJR19VU0JfS0FXRVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X1BFR0FTVVMgaXMgbm90IHNldAojIENPTkZJR19VU0JfUlRMODE1MCBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9VU0JORVQgaXMgbm90IHNldAoKIwojIFVTQiBwb3J0IGRyaXZlcnMKIwojIENPTkZJ
R19VU0JfVVNTNzIwIGlzIG5vdCBzZXQKCiMKIyBVU0IgU2VyaWFsIENvbnZlcnRlciBzdXBwb3J0
CiMKIyBDT05GSUdfVVNCX1NFUklBTCBpcyBub3Qgc2V0CgojCiMgVVNCIE1pc2NlbGxhbmVvdXMg
ZHJpdmVycwojCiMgQ09ORklHX1VTQl9FTUk2MiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9FTUky
NiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BVUVSU1dBTEQgaXMgbm90IHNldAojIENPTkZJR19V
U0JfUklPNTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0xFR09UT1dFUiBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9MQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0JfTEVEIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX0NZVEhFUk0gaXMgbm90IHNldAojIENPTkZJR19VU0JfUEhJREdFVEtJVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9QSElER0VUU0VSVk8gaXMgbm90IHNldAojIENPTkZJR19VU0Jf
SURNT1VTRSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9URVNUIGlzIG5vdCBzZXQKCiMKIyBVU0Ig
QVRNL0RTTCBkcml2ZXJzCiMKCiMKIyBVU0IgR2FkZ2V0IFN1cHBvcnQKIwojIENPTkZJR19VU0Jf
R0FER0VUIGlzIG5vdCBzZXQKCiMKIyBNTUMvU0QgQ2FyZCBzdXBwb3J0CiMKIyBDT05GSUdfTU1D
IGlzIG5vdCBzZXQKCiMKIyBJbmZpbmlCYW5kIHN1cHBvcnQKIwojIENPTkZJR19JTkZJTklCQU5E
IGlzIG5vdCBzZXQKCiMKIyBGaWxlIHN5c3RlbXMKIwpDT05GSUdfRVhUMl9GUz15CkNPTkZJR19F
WFQyX0ZTX1hBVFRSPXkKIyBDT05GSUdfRVhUMl9GU19QT1NJWF9BQ0wgaXMgbm90IHNldAojIENP
TkZJR19FWFQyX0ZTX1NFQ1VSSVRZIGlzIG5vdCBzZXQKQ09ORklHX0VYVDNfRlM9eQpDT05GSUdf
RVhUM19GU19YQVRUUj15CiMgQ09ORklHX0VYVDNfRlNfUE9TSVhfQUNMIGlzIG5vdCBzZXQKIyBD
T05GSUdfRVhUM19GU19TRUNVUklUWSBpcyBub3Qgc2V0CkNPTkZJR19KQkQ9eQojIENPTkZJR19K
QkRfREVCVUcgaXMgbm90IHNldApDT05GSUdfRlNfTUJDQUNIRT15CiMgQ09ORklHX1JFSVNFUkZT
X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSkZTX0ZTIGlzIG5vdCBzZXQKCiMKIyBYRlMgc3VwcG9y
dAojCiMgQ09ORklHX1hGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX01JTklYX0ZTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUk9NRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19RVU9UQSBpcyBub3Qgc2V0
CkNPTkZJR19ETk9USUZZPXkKQ09ORklHX0FVVE9GU19GUz15CkNPTkZJR19BVVRPRlM0X0ZTPXkK
CiMKIyBDRC1ST00vRFZEIEZpbGVzeXN0ZW1zCiMKQ09ORklHX0lTTzk2NjBfRlM9eQpDT05GSUdf
Sk9MSUVUPXkKQ09ORklHX1pJU09GUz15CkNPTkZJR19aSVNPRlNfRlM9eQpDT05GSUdfVURGX0ZT
PXkKQ09ORklHX1VERl9OTFM9eQoKIwojIERPUy9GQVQvTlQgRmlsZXN5c3RlbXMKIwpDT05GSUdf
RkFUX0ZTPXkKQ09ORklHX01TRE9TX0ZTPXkKQ09ORklHX1ZGQVRfRlM9eQpDT05GSUdfRkFUX0RF
RkFVTFRfQ09ERVBBR0U9NDM3CkNPTkZJR19GQVRfREVGQVVMVF9JT0NIQVJTRVQ9Imlzbzg4NTkt
MSIKQ09ORklHX05URlNfRlM9eQojIENPTkZJR19OVEZTX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05G
SUdfTlRGU19SVyBpcyBub3Qgc2V0CgojCiMgUHNldWRvIGZpbGVzeXN0ZW1zCiMKQ09ORklHX1BS
T0NfRlM9eQpDT05GSUdfUFJPQ19LQ09SRT15CkNPTkZJR19TWVNGUz15CiMgQ09ORklHX0RFVkZT
X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVWUFRTX0ZTX1hBVFRSIGlzIG5vdCBzZXQKQ09ORklH
X1RNUEZTPXkKIyBDT05GSUdfVE1QRlNfWEFUVFIgaXMgbm90IHNldAojIENPTkZJR19IVUdFVExC
RlMgaXMgbm90IHNldAojIENPTkZJR19IVUdFVExCX1BBR0UgaXMgbm90IHNldApDT05GSUdfUkFN
RlM9eQoKIwojIE1pc2NlbGxhbmVvdXMgZmlsZXN5c3RlbXMKIwojIENPTkZJR19BREZTX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfQUZGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hGU19GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hGU1BMVVNfRlMgaXMgbm90IHNldAojIENPTkZJR19CRUZTX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfQkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRUZTX0ZTIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ1JBTUZTIGlzIG5vdCBzZXQKIyBDT05GSUdfVlhGU19GUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0hQRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19RTlg0RlNfRlMgaXMgbm90
IHNldAojIENPTkZJR19TWVNWX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfVUZTX0ZTIGlzIG5vdCBz
ZXQKCiMKIyBOZXR3b3JrIEZpbGUgU3lzdGVtcwojCkNPTkZJR19ORlNfRlM9eQojIENPTkZJR19O
RlNfVjMgaXMgbm90IHNldAojIENPTkZJR19ORlNfVjQgaXMgbm90IHNldAojIENPTkZJR19ORlNf
RElSRUNUSU8gaXMgbm90IHNldApDT05GSUdfTkZTRD15CiMgQ09ORklHX05GU0RfVjMgaXMgbm90
IHNldApDT05GSUdfTkZTRF9UQ1A9eQpDT05GSUdfTE9DS0Q9eQpDT05GSUdfRVhQT1JURlM9eQpD
T05GSUdfU1VOUlBDPXkKIyBDT05GSUdfUlBDU0VDX0dTU19LUkI1IGlzIG5vdCBzZXQKIyBDT05G
SUdfUlBDU0VDX0dTU19TUEtNMyBpcyBub3Qgc2V0CiMgQ09ORklHX1NNQl9GUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0NJRlMgaXMgbm90IHNldAojIENPTkZJR19OQ1BfRlMgaXMgbm90IHNldAojIENP
TkZJR19DT0RBX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQUZTX0ZTIGlzIG5vdCBzZXQKCiMKIyBQ
YXJ0aXRpb24gVHlwZXMKIwojIENPTkZJR19QQVJUSVRJT05fQURWQU5DRUQgaXMgbm90IHNldApD
T05GSUdfTVNET1NfUEFSVElUSU9OPXkKCiMKIyBOYXRpdmUgTGFuZ3VhZ2UgU3VwcG9ydAojCkNP
TkZJR19OTFM9eQpDT05GSUdfTkxTX0RFRkFVTFQ9Imlzbzg4NTktMSIKQ09ORklHX05MU19DT0RF
UEFHRV80Mzc9eQojIENPTkZJR19OTFNfQ09ERVBBR0VfNzM3IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0NPREVQQUdFXzc3NSBpcyBub3Qgc2V0CkNPTkZJR19OTFNfQ09ERVBBR0VfODUwPXkKIyBD
T05GSUdfTkxTX0NPREVQQUdFXzg1MiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84
NTUgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODU3IGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX0NPREVQQUdFXzg2MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjEg
aXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYyIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0NPREVQQUdFXzg2MyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjQgaXMg
bm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X0NPREVQQUdFXzg2NiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjkgaXMgbm90
IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTM2IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NP
REVQQUdFXzk1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85MzIgaXMgbm90IHNl
dAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTQ5IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQ
QUdFXzg3NCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzggaXMgbm90IHNldAojIENP
TkZJR19OTFNfQ09ERVBBR0VfMTI1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV8x
MjUxIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0FTQ0lJIGlzIG5vdCBzZXQKQ09ORklHX05MU19J
U084ODU5XzE9eQojIENPTkZJR19OTFNfSVNPODg1OV8yIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X0lTTzg4NTlfMyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzQgaXMgbm90IHNldAoj
IENPTkZJR19OTFNfSVNPODg1OV81IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNiBp
cyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzcgaXMgbm90IHNldAojIENPTkZJR19OTFNf
SVNPODg1OV85IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMTMgaXMgbm90IHNldAoj
IENPTkZJR19OTFNfSVNPODg1OV8xNCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzE1
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0tPSThfUiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19L
T0k4X1UgaXMgbm90IHNldAojIENPTkZJR19OTFNfVVRGOCBpcyBub3Qgc2V0CgojCiMgUHJvZmls
aW5nIHN1cHBvcnQKIwpDT05GSUdfUFJPRklMSU5HPXkKQ09ORklHX09QUk9GSUxFPXkKCiMKIyBL
ZXJuZWwgaGFja2luZwojCiMgQ09ORklHX0RFQlVHX0tFUk5FTCBpcyBub3Qgc2V0CkNPTkZJR19E
RUJVR19QUkVFTVBUPXkKQ09ORklHX0RFQlVHX0JVR1ZFUkJPU0U9eQojIENPTkZJR19GUkFNRV9Q
T0lOVEVSIGlzIG5vdCBzZXQKQ09ORklHX0VBUkxZX1BSSU5USz15CiMgQ09ORklHXzRLU1RBQ0tT
IGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9GSU5EX1NNUF9DT05GSUc9eQpDT05GSUdfWDg2X01QUEFS
U0U9eQoKIwojIFNlY3VyaXR5IG9wdGlvbnMKIwpDT05GSUdfS0VZUz15CiMgQ09ORklHX0tFWVNf
REVCVUdfUFJPQ19LRVlTIGlzIG5vdCBzZXQKQ09ORklHX1NFQ1VSSVRZPXkKIyBDT05GSUdfU0VD
VVJJVFlfTkVUV09SSyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX0NBUEFCSUxJVElFUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX1JPT1RQTFVHIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VDVVJJVFlfU0VDTFZMIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VDVVJJVFlfU0VMSU5VWCBpcyBu
b3Qgc2V0CgojCiMgQ3J5cHRvZ3JhcGhpYyBvcHRpb25zCiMKQ09ORklHX0NSWVBUTz15CkNPTkZJ
R19DUllQVE9fSE1BQz15CiMgQ09ORklHX0NSWVBUT19OVUxMIGlzIG5vdCBzZXQKQ09ORklHX0NS
WVBUT19NRDQ9eQpDT05GSUdfQ1JZUFRPX01ENT15CiMgQ09ORklHX0NSWVBUT19TSEExIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NIQTI1NiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19T
SEE1MTIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fV1A1MTIgaXMgbm90IHNldAojIENPTkZJ
R19DUllQVE9fREVTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0JMT1dGSVNIIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1JZUFRPX1RXT0ZJU0ggaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU0VS
UEVOVCBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fQUVTXzU4Nj15CiMgQ09ORklHX0NSWVBUT19D
QVNUNSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DQVNUNiBpcyBub3Qgc2V0CiMgQ09ORklH
X0NSWVBUT19URUEgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0FSQzQ9eQojIENPTkZJR19DUllQ
VE9fS0hBWkFEIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0FOVUJJUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19ERUZMQVRFIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19NSUNIQUVMX01J
Qz15CkNPTkZJR19DUllQVE9fQ1JDMzJDPXkKIyBDT05GSUdfQ1JZUFRPX1RFU1QgaXMgbm90IHNl
dAoKIwojIEhhcmR3YXJlIGNyeXB0byBkZXZpY2VzCiMKIyBDT05GSUdfQ1JZUFRPX0RFVl9QQURM
T0NLIGlzIG5vdCBzZXQKCiMKIyBMaWJyYXJ5IHJvdXRpbmVzCiMKQ09ORklHX0NSQ19DQ0lUVD15
CkNPTkZJR19DUkMzMj15CkNPTkZJR19MSUJDUkMzMkM9eQpDT05GSUdfWkxJQl9JTkZMQVRFPXkK
Q09ORklHX0dFTkVSSUNfSEFSRElSUVM9eQpDT05GSUdfR0VORVJJQ19JUlFfUFJPQkU9eQpDT05G
SUdfWDg2X1NNUD15CkNPTkZJR19YODZfSFQ9eQpDT05GSUdfWDg2X0JJT1NfUkVCT09UPXkKQ09O
RklHX1g4Nl9UUkFNUE9MSU5FPXkKQ09ORklHX1BDPXkK
------=_Part_904_12255298.1118829847271--
