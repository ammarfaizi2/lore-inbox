Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbWEaNzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWEaNzH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 09:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWEaNzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 09:55:07 -0400
Received: from mcclure-nat.wal.novell.com ([130.57.22.22]:38758 "EHLO
	mcclure.wal.novell.com") by vger.kernel.org with ESMTP
	id S965022AbWEaNzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 09:55:04 -0400
Message-Id: <447D5919.AAAE.008A.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 31 May 2006 09:54:59 -0400
From: "David Corlette" <dcorlette@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: Message "hidden behind transparent bridge"
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartD2F7E623.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=__PartD2F7E623.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I get this message in my dmesg output:

PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#03) (try =
'pci=3Dassign-busses')
Please report the result to linux-kernel to fix this permanently

Booting SuSE Linux Enterprise Desktop 10 B10 on an HP Compaq nc6230.

Full dmesg output is attached (there are some other exceptions and errors =
if you are interested).

No need for a response; the system seems to work mostly fine.

Thanks!


--=__PartD2F7E623.0__=
Content-Type: text/plain; name="dmesg.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.6.16-20-default (geeko@buildhost) (gcc version 4.1.0 (SUSE Linux)) #1 Mon Apr 10 04:51:13 UTC 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffd0000 (usable)
 BIOS-e820: 000000007ffd0000 - 000000007ffefc00 (reserved)
 BIOS-e820: 000000007ffefc00 - 000000007fffb000 (ACPI NVS)
 BIOS-e820: 000000007fffb000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed9b000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fedc0000 (reserved)
 BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
No mptable found.
On node 0 totalpages: 524240
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294864 pages, LIFO batch:31
DMI 2.3 present.
IO/L-APIC allowed because system is MP or new enough
ACPI: RSDP (v000 HP                                    ) @ 0x000fe270
ACPI: RSDT (v001 HP     0944     0x22070520 HP   0x00000001) @ 0x7ffefc84
ACPI: FADT (v002 HP     0944     0x00000002 HP   0x00000001) @ 0x7ffefc00
ACPI: MADT (v001 HP     0944     0x00000001 HP   0x00000001) @ 0x7ffefcb8
ACPI: MCFG (v001 HP     0944     0x00000001 HP   0x00000001) @ 0x7ffefd14
ACPI: SSDT (v001 HP       HPQPpc 0x00001001 MSFT 0x0100000e) @ 0x7fff7d5b
ACPI: DSDT (v001 HP       nc6200 0x00010000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfec01000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
Built 1 zonelists
Kernel command line: root=/dev/hda6 vga=0x317    resume=/dev/hda5  splash=silent
bootsplash: silent mode.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1862.342 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2073504k/2096960k available (1492k kernel code, 22220k reserved, 606k data, 156k init, 1179456k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3729.63 BogoMIPS (lpj=7459276)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1.86GHz stepping 08
Checking 'hlt' instruction... OK.
checking if image is initramfs... it is
Freeing initrd memory: 2318k freed
 not found!
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
HP Compaq Laptop series board detected. Selecting BIOS-method for reboots.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0322, last bus=32
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI Error (evgpeblk-0284): Unknown GPE method type: C268 (name not of form _Lxx or _Exx) [20060127]
ACPI Error (evgpeblk-0284): Unknown GPE method type: C1E8 (name not of form _Lxx or _Exx) [20060127]
ACPI Error (evgpeblk-0284): Unknown GPE method type: C269 (name not of form _Lxx or _Exx) [20060127]
ACPI Error (evgpeblk-0284): Unknown GPE method type: C26A (name not of form _Lxx or _Exx) [20060127]
ACPI Error (evgpeblk-0284): Unknown GPE method type: C1CA (name not of form _Lxx or _Exx) [20060127]
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [C002] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.C002] bus is 0
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1100-113f claimed by ICH6 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#03) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.C002._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C002.C057._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C002.C06C._PRT]
ACPI: Power Resource [C1C8] (on)
ACPI: Embedded Controller [C004] (gpe 16) interrupt mode.
ACPI: Power Resource [C1A2] (on)
ACPI: Power Resource [C1AA] (on)
ACPI: Power Resource [C1B1] (on)
ACPI: Power Resource [C1C1] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.C002.C006._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C002.C0DD._PRT]
ACPI: PCI Interrupt Link [C0D9] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0DA] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C0DB] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C0DC] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0EF] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0F0] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C0F1] (IRQs *10 11)
ACPI Exception (pci_link-0182): AE_NOT_FOUND, Evaluating _PRS [20060127]
ACPI: Power Resource [C25C] (off)
ACPI: Power Resource [C25D] (off)
ACPI: Power Resource [C25E] (off)
ACPI: Power Resource [C25F] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.1
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
Setting up standard PCI resources
pnp: 00:0d: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0d: ioport range 0x1000-0x107f could not be reserved
pnp: 00:0d: ioport range 0x1100-0x113f has been reserved
pnp: 00:0d: ioport range 0x1200-0x121f has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: c8800000-c8bfffff
  PREFETCH window: c0000000-c7ffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: c8000000-c83fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bus 3, cardbus bridge: 0000:02:06.0
  IO window: 00004000-000040ff
  IO window: 00004400-000044ff
  PREFETCH window: 88000000-89ffffff
  MEM window: 8a000000-8bffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-4fff
  MEM window: c8400000-c87fffff
  PREFETCH window: 88000000-89ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.1 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 18 (level, low) -> IRQ 185
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1149068080.968:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
vesafb: framebuffer at 0xc0000000, mapped to 0xf8880000, using 6144k, total 65472k
vesafb: mode is 1024x768x16, linelength=2048, pages=41
vesafb: protected mode interface info at c000:5aad
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
bootsplash 3.1.6-2004/03/31: looking for picture...<6> silentjpeg size 47656 bytes,<6>...found (1024x768, 30698 bytes, v3).
Console: switching to colour frame buffer device 123x44
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
PNP: PS/2 Controller [PNP0303:C1BE,PNP0f13:C1BF] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
00:02: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt 0000:00:1e.3[B] -> GSI 22 (level, low) -> IRQ 225
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 524288 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
NET: Registered protocol family 1
Using IPI Shortcut mode
ACPI wakeup devices: 
C06C C0BD C0C4 C0C5 C0C7 C006 C007 C0DD C1CB 
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 156k freed
Write protecting the kernel read-only data: 281k
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 169
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x3580-0x3587, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: HTS541060G9AT00, ATA DISK drive
hdb: HL-DT-STCD-RW/DVD DRIVE GCC-4246N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide_acpi_hwif_get_handle: ENTER: device ide0
ide_get_dev_handle: ENTER: pci 00:1f.1
ide_get_dev_handle: for dev=0x1f.1, addr=0x1f0001, parent=0xdff63c00, *handle=0xdffe93c0
ide_acpi_hwif_get_handle: chan adr=0: handle=0xdffe2200
ide_acpi_init: ACPI methods disabled on boot
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB) w/7539KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 >
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [C000] (supports 8 throttling states)
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x25a0b1, caps: 0xa04793/0x300000
serio: Synaptics pass-through port at isa0060/serio4/input0
ACPI: Thermal Zone [TZ1] (44 C)
input: SynPS/2 Synaptics TouchPad as /class/input/input2
ACPI: Thermal Zone [TZ2] (35 C)
ACPI: Thermal Zone [TZ3] (25 C)
ACPI: Fan [C260] (off)
ACPI: Fan [C261] (off)
ACPI: Fan [C262] (off)
ACPI: Fan [C263] (on)
Attempting manual resume
input: PS/2 Generic Mouse as /class/input/input3
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
reiserfs: using flush barriers
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
Adding 2104472k swap on /dev/hda5.  Priority:-1 extents:1 across:2104472k
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 1 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
tg3.c:v3.49 (Feb 2, 2006)
ACPI: PCI Interrupt 0000:10:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:10:00.0 to 64
eth0: Tigon3 [partno(BCM95751M) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:14:38:1c:f4:54
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 233, io base 0x00003000
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.16-20-default uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
i8xx TCO timer: heartbeat value must be 2<heartbeat<39, using 30
i8xx TCO timer: initialized (0x1060). heartbeat=30 sec (nowayout=0)
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 177, io base 0x00003020
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.16-20-default uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 185, io base 0x00003040
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.16-20-default uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
usb 1-2: new low speed USB device using uhci_hcd and address 2
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
Linux agpgart interface v0.101 (c) Dave Jones
ieee80211_crypt: module not supported by Novell, setting U taint flag.
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: module not supported by Novell, setting U taint flag.
ieee80211: 802.11 data/management/control stack, git-1.1.7
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 21 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:1e.2 to 64
usb 1-2: new device found, idVendor=046d, idProduct=c00c
usb 1-2: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-2: Product: USB Optical Mouse
usb 1-2: Manufacturer: Logitech
usb 1-2: configuration #1 chosen from 1 choice
usb 2-1: new full speed USB device using uhci_hcd and address 2
ipw2200: module not supported by Novell, setting U taint flag.
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.0.10
ipw2200: Copyright(c) 2003-2005 Intel Corporation
usb 2-1: new device found, idVendor=413c, idProduct=1002
usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1: Product: Dell USB Keyboard Hub
usb 2-1: Manufacturer: Dell
usb 2-1: configuration #1 chosen from 1 choice
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 3 ports detected
intel8x0_measure_ac97_clock: measured 55486 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1d.7: irq 233, io mem 0xc8c00000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: EHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.16-20-default ehci_hcd
usb usb4: SerialNumber: 0000:00:1d.7
usb usb4: configuration #1 chosen from 1 choice
usb 2-1.1: new full speed USB device using uhci_hcd and address 3
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 8 ports detected
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 2-1:1.0: cannot disable port 1 (err = -71)
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 2-1:1.0: cannot disable port 1 (err = -71)
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 2-1:1.0: cannot disable port 1 (err = -71)
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: cannot reset port 1 (err = -71)
agpgart: Detected an Intel 915GM Chipset.
hub 2-1:1.0: cannot reset port 1 (err = -71)
hub 2-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 2-1:1.0: cannot disable port 1 (err = -71)
hub 2-1:1.0: cannot disable port 1 (err = -71)
agpgart: AGP aperture is 256M @ 0x0
hub 2-1:1.0: hub_port_status failed (err = -71)
hub 2-1:1.0: hub_port_status failed (err = -71)
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 18 (level, low) -> IRQ 185
hub 2-1:1.0: hub_port_status failed (err = -71)
usb 2-1: USB disconnect, address 2
Yenta: CardBus bridge found at 0000:02:06.0 [103c:0944]
Yenta: Enabling burst memory read transactions
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:06.0, mfunc 0x01111b22, devctl 0x64
Yenta: ISA IRQ mask 0x0c78, PCI irq 185
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
cs: IO port probe 0x4000-0x4fff: clean.
pcmcia: parent PCI bridge Memory window: 0xc8400000 - 0xc87fffff
pcmcia: parent PCI bridge Memory window: 0x88000000 - 0x89ffffff
ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 21 (level, low) -> IRQ 50
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
cs: IO port probe 0x100-0x3af: clean.
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
hw_random: RNG not detected
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
dm-netlink version 0.0.2 loaded
loop: loaded (max 8 devices)
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
ReiserFS: hda7: using ordered data mode
reiserfs: using flush barriers
ReiserFS: hda7: journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: Using r5 hash to sort names
NTFS driver 2.1.26 [Flags: R/W MODULE].
NTFS volume version 3.1.
AppArmor: AppArmor (version 2.0-19.43r6320) initialized
audit(1149068283.656:2): AppArmor (version 2.0-19.43r6320) initialized

NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 232 bytes per conntrack
ACPI: AC Adapter [C16F] (on-line)
ACPI: Battery Slot [C171] (battery present)
ACPI: Battery Slot [C170] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [C1E9]
ACPI: Lid Switch [C1EA]
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
IA-32 Microcode Update Driver v1.14 unregistered
ADDRCONF(NETDEV_UP): eth0: link is not ready
bootsplash: status on console 0 changed to on
ADDRCONF(NETDEV_UP): eth1: link is not ready
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
NET: Registered protocol family 17
fglrx: module not supported by Novell, setting U taint flag.
fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
[fglrx] Maximum main memory to use for locked dma buffers: 1900 MBytes.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
[fglrx] module loaded - fglrx 8.24.8 [Apr 11 2006] on minor 0
[fglrx] Maximum main memory to use for locked dma buffers: 1900 MBytes.
[fglrx] free  PCIe = 54804480
[fglrx] max   PCIe = 54804480
[fglrx] free  LFB = 55504896
[fglrx] max   LFB = 55504896
[fglrx] free  Inv = 0
[fglrx] max   Inv = 0
[fglrx] total Inv = 0
[fglrx] total TIM = 0
[fglrx] total FB  = 0
[fglrx] total PCIe = 16384
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=172.16.2.175 DST=224.0.0.251 LEN=74 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=54 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=172.16.2.175 DST=224.0.0.251 LEN=74 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=54 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=172.16.2.175 DST=224.0.0.251 LEN=74 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=54 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=172.16.2.175 DST=224.0.0.251 LEN=107 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=87 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=172.16.2.175 DST=224.0.0.251 LEN=107 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=87 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=172.16.2.175 DST=224.0.0.251 LEN=107 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=87 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=172.16.2.175 DST=224.0.0.251 LEN=107 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=87 
eth0: no IPv6 routers present
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=172.16.2.175 DST=224.0.0.251 LEN=107 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=87 
audit(:0): major=252 name_count=0: freeing multiple contexts (1)
audit(:0): major=113 name_count=0: freeing multiple contexts (2)
[fglrx] Maximum main memory to use for locked dma buffers: 1900 MBytes.
[fglrx] free  PCIe = 54804480
[fglrx] max   PCIe = 54804480
[fglrx] free  LFB = 55504896
[fglrx] max   LFB = 55504896
[fglrx] free  Inv = 0
[fglrx] max   Inv = 0
[fglrx] total Inv = 0
[fglrx] total TIM = 0
[fglrx] total FB  = 0
[fglrx] total PCIe = 16384
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=172.16.2.175 DST=224.0.0.251 LEN=107 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=87 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=172.16.2.175 DST=224.0.0.251 LEN=107 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=87 
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
SCSI subsystem initialized
Driver 'sd' needs updating - please use bus_type methods
st: Version 20050830, fixed bufsize 32768, s/g segs 256
ieee80211_crypt_tkip: module not supported by Novell, setting U taint flag.
ieee80211_crypt: registered algorithm 'TKIP'
ieee80211_crypt_ccmp: module not supported by Novell, setting U taint flag.
ieee80211_crypt: registered algorithm 'CCMP'
pnp: Device 00:04 disabled.
parport 0x378 (WARNING): CTR: wrote 0x0c, read 0xff
parport 0x378 (WARNING): DATA: wrote 0xaa, read 0xff
parport 0x378: You gave this address, but there is probably no parallel port there!
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
pnp: Device 00:04 activated.
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 1 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
lp0: using parport0 (interrupt-driven).
pnp: Device 00:04 disabled.
parport 0x378 (WARNING): CTR: wrote 0x0c, read 0xff
parport 0x378 (WARNING): DATA: wrote 0xaa, read 0xff
parport 0x378: You gave this address, but there is probably no parallel port there!
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
ppa: Version 2.07 (for Linux 2.4.x)
audit(:0): major=252 name_count=0: freeing multiple contexts (1)
audit(:0): major=113 name_count=0: freeing multiple contexts (2)
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC=00:14:38:1c:f4:54:00:04:dc:46:87:f4:08:00 SRC=164.99.215.25 DST=172.16.2.175 LEN=278 TOS=0x00 PREC=0x00 TTL=125 ID=57355 PROTO=UDP SPT=1304 DPT=1026 LEN=258 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC=00:14:38:1c:f4:54:00:04:dc:46:87:f4:08:00 SRC=164.99.215.25 DST=172.16.2.175 LEN=278 TOS=0x00 PREC=0x00 TTL=125 ID=15628 PROTO=UDP SPT=1305 DPT=1026 LEN=258 

--=__PartD2F7E623.0__=--
