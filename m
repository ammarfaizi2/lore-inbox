Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbWEaAFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbWEaAFr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 20:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWEaAFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 20:05:47 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60361 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932539AbWEaAFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 20:05:46 -0400
Date: Wed, 31 May 2006 02:04:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, kristen.c.accardi@intel.com
Subject: [oops] 2.6.17-rc4: docking-related problem
Message-ID: <20060531000451.GA25394@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

...but probably unreprocudible one; I kind of mis-inserted machine
into dock, it probably quickly got/lost electrical connection. I got
nice oops...

Same "cursed x32" :-).

								Pavel

Linux version 2.6.17-rc4-g81a95636-dirty (pavel@amd) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #260 SMP Mon May 22 17:46:35 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000005ff60000 (usable)
 BIOS-e820: 000000005ff60000 - 000000005ff77000 (ACPI data)
 BIOS-e820: 000000005ff77000 - 000000005ff79000 (ACPI NVS)
 BIOS-e820: 000000005ff80000 - 0000000060000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
639MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 393056
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 163680 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v002 IBM                                   ) @ 0x000f6df0
ACPI: XSDT (v001 IBM    TP-1Q    0x00003004  LTP 0x00000000) @ 0x5ff69e78
ACPI: FADT (v003 IBM    TP-1Q    0x00003004 IBM  0x00000001) @ 0x5ff69f00
ACPI: SSDT (v001 IBM    TP-1Q    0x00003004 MSFT 0x0100000e) @ 0x5ff6a0b4
ACPI: ECDT (v001 IBM    TP-1Q    0x00003004 IBM  0x00000001) @ 0x5ff76e11
ACPI: TCPA (v001 IBM    TP-1Q    0x00003004 PTL  0x00000001) @ 0x5ff76e63
ACPI: BOOT (v001 IBM    TP-1Q    0x00003004  LTP 0x00000001) @ 0x5ff76fd8
ACPI: DSDT (v001 IBM    TP-1Q    0x00003004 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 70000000 (gap: 60000000:9f800000)
Built 1 zonelists
Kernel command line: root=/dev/hda4 resume=/dev/hda1 psmouse.psmouse_proto=imps psmouse_proto=imps psmouse.proto=imps vga=1 init=/tmp/swsusp-init
Unknown boot option `psmouse.psmouse_proto=imps': ignoring
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01c0e000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 1798.779 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x50
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1549312k/1572224k available (5044k kernel code, 21868k reserved, 2492k data, 296k init, 654720k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3600.33 BogoMIPS (lpj=7200673)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 24k freed
 tbxface-0109 [02] load_tables           : ACPI Tables successfully acquired
Parsing all Control Methods:
Table [DSDT](id 0006) - 1407 Objects with 65 Devices 442 Methods 19 Regions
Parsing all Control Methods:
Table [SSDT](id 0004) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI Namespace successfully loaded at root c0913a98
ACPI: setting ELCR to 0200 (from 0800)
evxfevnt-0091 [03] enable                : Transition to ACPI mode successful
CPU0: Intel(R) Pentium(R) M processor 1.80GHz stepping 06
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
migration_cost=0
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
evgpeblk-0941 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-1037 [05] ev_initialize_gpe_bloc: Found 7 Wake, Enabled 0 Runtime GPEs in this block
ACPI: Found ECDT
Completing Region/Field/Buffer/Package initialization:...........................................................................................................................................................................................................................................
Initialized 12/19 Regions 123/123 Fields 58/58 Buffers 42/49 Packages (1417 nodes)
Executing all Device _STA and_INI methods:.....................................................................
69 Devices found - executed 3 _STA, 12 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28) interrupt mode.
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
irda_init()
NET: Registered protocol family 23
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
PCI: Bridge: 0000:00:01.0
  IO window: 3000-3fff
  MEM window: c0100000-c01fffff
  PREFETCH window: e0000000-e7ffffff
PCI: Bus 3, cardbus bridge: 0000:02:00.0
  IO window: 00004000-000040ff
  IO window: 00004400-000044ff
  PREFETCH window: e8000000-e9ffffff
  MEM window: c2000000-c3ffffff
PCI: Bus 7, cardbus bridge: 0000:02:00.1
  IO window: 00004800-000048ff
  IO window: 00004c00-00004cff
  PREFETCH window: ea000000-ebffffff
  MEM window: c4000000-c5ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-8fff
  MEM window: c0200000-cfffffff
  PREFETCH window: e8000000-efffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
PCI: setting IRQ 11 as level-triggered
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Simple Boot Flag at 0x35 set to 0x80
IBM machine detected. Enabling interrupts during APM calls.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
highmem bounce pool size: 64 pages
Coda Kernel/Venus communications, v6.0.0, coda@cs.cmu.edu
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.27 [Flags: R/O DEBUG].
fuse init (API version 7.6)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ibmphpd: IBM Hot Plug PCI Controller Driver version: 0.6
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
acpiphp: Slot [4294967295] registered
acpiphp_ibm: ibm_find_acpi_device:  Failed to get device information<3>acpiphp_ibm: ibm_find_acpi_device:  Failed to get device information<3>acpiphp_ibm: ibm_find_acpi_device:  Failed to get device information<3>acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=144.00 Mhz, System=144.00 MHz
radeonfb: PLL min 12000 max 35000
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: 1024x768                
radeonfb: detected LVDS panel size from BIOS: 1024x768
radeondb: BIOS provided dividers will be used
radeonfb: Dynamic Clock Power Management enabled
Console: switching to colour frame buffer device 102x42
radeonfb (0000:01:00.0): ATI Radeon LY 
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU] (supports 8 throttling states)
ACPI: Thermal Zone [THM0] (59 C)
ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
ibm_acpi: http://ibm-acpi.sf.net/
acpi_bus-0073 [04] bus_get_device        : No context for object [c1d15adc]
ibm_acpi: bay device not present
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
[drm] Initialized radeon 1.24.0 20060225 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
acpi_bus-0201 [04] bus_set_power         : Device is not power manageable
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
parport0: PC-style at 0x3bc [PCSPP(,...)]
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 7.0.33-k2
Copyright (c) 1999-2005 Intel Corporation.
e1000: 0000:02:01.0: e1000_probe: (PCI:33MHz:32-bit) 00:11:25:b2:13:20
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
pcnet32.c:v1.32 18.Mar.2006 tsbogend@alpha.franken.de
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
CSLIP: code copyright 1989 Regents of the University of California.
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
orinoco 0.15rc3 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
bcm43xx driver
Linux video capture interface: v1.00
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HTS541040G9AT00, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/7539KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
libata version 1.20 loaded.
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[c0211000-c02117ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
ieee1394: raw1394: /dev/raw1394 device initialized
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
Yenta: CardBus bridge found at 0000:02:00.0 [1014:0532]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x8fff
cs: IO port probe 0x4000-0x8fff: clean.
pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xcfffffff
pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
Yenta: CardBus bridge found at 0000:02:00.1 [1014:0532]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x8fff
cs: IO port probe 0x4000-0x8fff: clean.
pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xcfffffff
pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
Intel ISA PCIC probe: not found.
Databook TCIC-2 PCMCIA probe: not found.
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 11, io mem 0xc0000000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v3.0
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 11, io base 0x00001800
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001820
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00061b032904c34f]
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 11, io base 0x00001840
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver for USB modems and ISDN adapters
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver catc
drivers/usb/net/catc.c: v2.8 CATC EL1210A NetMate USB Ethernet driver
usbcore: registered new driver asix
usbcore: registered new driver cdc_ether
usbcore: registered new driver net1080
usbcore: registered new driver cdc_subset
usbcore: registered new driver zaurus
usbcore: registered new driver zd1201
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new driver hci_usb
Bluetooth: HCI UART driver ver 2.2
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
EDAC MC: Ver: 2.0.0 May 19 2006
Advanced Linux Sound Architecture Driver Version 1.0.11rc4 (Wed Mar 22 10:27:24 2006 UTC).
PCI: Setting latency timer of device 0000:00:1f.5 to 64
input: PS/2 Generic Mouse as /class/input/input2
intel8x0_measure_ac97_clock: measured 55341 usecs
intel8x0: clocking to 48000
usbcore: registered new driver snd-usb-audio
ALSA device list:
  #0: Intel 82801DB-ICH4 with AD1981B at 0xc0000c00, irq 11
oprofile: using timer interrupt.
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 204 bytes per conntrack
ip_tables: (C) 2000-2006 Netfilter Core Team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
IrCOMM protocol (Dag Brattli)
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.5
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.7
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
ieee80211: 802.11 data/management/control stack, git-1.1.7
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ieee80211_crypt: registered algorithm 'NULL'
ieee80211_crypt: registered algorithm 'WEP'
Using IPI No-Shortcut mode
swsusp: Resume From Partition /dev/hda1
PM: Checking swsusp image.
PM: Resume from disk failed.
ACPI wakeup devices: 
 LID SLPB PCI0 UART PCI1 DOCK USB0 USB1 AC9M 
ACPI: (supports S0 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 296k freed
EXT3 FS on hda4, internal journal
Adding 2136448k swap on /dev/hda1.  Priority:-1 extents:1 across:2136448k
kjournald starting.  Commit interval 6000 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
pcmcia: Detected deprecated PCMCIA ioctl usage from process: cardmgr.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
cs: IO port probe 0x310-0x380: excluding 0x370-0x377
cs: IO port probe 0x310-0x380: excluding 0x370-0x377
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0xa00-0xaff: clean.
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
coda_read_super: Bad mount data
coda_read_super: device index: 0
coda_read_super: rootfid is (01234567.ffffffff.080519c0.00000000)
coda_upcall: Venus dead on (op,un) (7.2) flags 10
Failure of coda_cnode_make for root: error -19
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.1.1
ipw2200: Copyright(c) 2003-2006 Intel Corporation
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ipw2200: Detected geography ZZR (14 802.11bg channels, 0 802.11a channels)
mtrr: 0xe0000000,0x8000000 overlaps existing 0xe0000000,0x1000000
mtrr: 0xe0000000,0x8000000 overlaps existing 0xe0000000,0x1000000
mtrr: 0xe0000000,0x8000000 overlaps existing 0xe0000000,0x1000000
[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[drm:drm_unlock] *ERROR* Process 1667 using kernel context 0
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
PCI: Found IBM Dock II Cardbus Bridge applying quirk
PCI: Found IBM Dock II Cardbus Bridge applying quirk
PCI: Transparent bridge - 0000:02:03.0
PCI: Bus #09 (-#0c) is hidden behind transparent bridge #02 (-#08) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
PCI: Bus #0d (-#10) is hidden behind transparent bridge #02 (-#08) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
PCI: Bus #08 (-#10) is hidden behind transparent bridge #02 (-#08) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10454]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10408]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d103bc]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10370]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10324]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d102d8]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d1028c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10240]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d101f4]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d101a8]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d1015c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10110]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10a44]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d109f8]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d109ac]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10960]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10914]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d108c8]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d1087c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10830]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d107e4]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10798]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d1074c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10700]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d106b4]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10668]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d1061c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d105d0]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10f04]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10eb8]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10e6c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10e20]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10dd4]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10d88]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10d3c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10cf0]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10ca4]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10c58]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10c0c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10bc0]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10b74]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10b28]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10f9c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d10f50]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11584]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11538]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d114ec]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d114a0]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11454]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11408]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d113bc]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11370]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11324]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d112d8]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d1128c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11240]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d111f4]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d111a8]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d1115c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11110]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11a44]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d119f8]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d119ac]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11960]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11914]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d118c8]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d1187c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11830]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d117e4]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11798]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d1174c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11700]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d116b4]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11668]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d1161c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d115d0]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11f04]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11eb8]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11e6c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11e20]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11dd4]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11d88]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d11d3c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d1274c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12700]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d126b4]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12668]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d1261c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d125d0]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12f04]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12eb8]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12e6c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12e20]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12dd4]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12d88]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12d3c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12cf0]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12c58]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12c0c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12bc0]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12b74]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12b28]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12adc]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12a90]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12f9c]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d12f50]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d14584]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d14538]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d144ec]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d144a0]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d14454]
acpi_bus-0073 [50] bus_get_device        : No context for object [c1d1ac58]
pci_bind-0306 [51] pci_unbind            : Unable to get data from device DOCK
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1.DOCK._PRT]
PCI: Bus 3, cardbus bridge: 0000:02:00.0
  IO window: 00004000-000040ff
  IO window: 00004400-000044ff
  PREFETCH window: e8000000-e9ffffff
  MEM window: c2000000-c3ffffff
PCI: Bus 7, cardbus bridge: 0000:02:00.1
  IO window: 00004800-000048ff
  IO window: 00004c00-00004cff
  PREFETCH window: ea000000-ebffffff
  MEM window: c4000000-c5ffffff
PCI: Ignore bogus resource 1 [3f6:3f6] of 0000:08:01.0
PCI: Ignore bogus resource 3 [376:376] of 0000:08:01.0
PCI: Bus 9, cardbus bridge: 0000:08:02.0
  IO window: 00005400-000054ff
  IO window: 00005800-000058ff
  PREFETCH window: c6000000-c7ffffff
  MEM window: ca000000-cbffffff
PCI: Bus 13, cardbus bridge: 0000:08:02.1
  IO window: 00005c00-00005cff
  IO window: 00006000-000060ff
  PREFETCH window: c8000000-c9ffffff
  MEM window: cc000000-cdffffff
PCI: Bridge: 0000:02:03.0
  IO window: 5000-6fff
  MEM window: ca000000-ceffffff
  PREFETCH window: c6000000-c9ffffff
PCI: Enabling device 0000:02:03.0 (0000 -> 0003)
PCI: Enabling device 0000:08:02.0 (0000 -> 0003)
PCI: Setting latency timer of device 0000:08:02.0 to 64
PCI: Enabling device 0000:08:02.1 (0000 -> 0003)
PCI: Setting latency timer of device 0000:08:02.1 to 64
PCI: Enabling device 0000:08:00.0 (0000 -> 0003)
hp100: Busmaster mode enabled.
hp100: at 0x5000, IRQ 11, PCI bus, 32k SRAM (rx/tx 75%).
hp100: Adapter is attached to 10Mb/s network (coax).
Yenta: CardBus bridge found at 0000:08:02.0 [1014:0148]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:08:02.0, mfunc 0x00001002, devctl 0x66
usb 1-1: new high speed USB device using ehci_hcd and address 2
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x5000 - 0x6fff
cs: IO port probe 0x5000-0x6fff: clean.
pcmcia: parent PCI bridge Memory window: 0xca000000 - 0xceffffff
pcmcia: parent PCI bridge Memory window: 0xc6000000 - 0xc9ffffff
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x8fff
pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xcfffffff
pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
hub 1-1:1.0: 4 ports detected
Yenta: CardBus bridge found at 0000:08:02.1 [1014:0148]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:08:02.1, mfunc 0x00001002, devctl 0x66
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x5000 - 0x6fff
cs: IO port probe 0x5000-0x6fff: clean.
pcmcia: parent PCI bridge Memory window: 0xca000000 - 0xceffffff
pcmcia: parent PCI bridge Memory window: 0xc6000000 - 0xc9ffffff
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x8fff
pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xcfffffff
pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
ACPI: PCI interrupt for device 0000:08:00.0 disabled
ACPI: PCI interrupt for device 0000:08:02.0 disabled
ACPI: PCI interrupt for device 0000:08:02.1 disabled
usb 1-1: USB disconnect, address 2
usb 3-1: new full speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
usb 3-1: wlan0: ZD1201 USB Wireless interface
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
usb 3-1: wlan0: rx urb failed: -84
usb 3-1: USB disconnect, address 2
usb 3-1: new full speed USB device using uhci_hcd and address 3
usb 3-1: configuration #1 chosen from 1 choice
usb 3-1: wlan0: ZD1201 USB Wireless interface
eth1: NETDEV_TX_BUSY returned; driver should report queue full via ieee_device->is_queue_full.
usb 3-1: wlan0: rx urb failed: -84
usb 3-1: USB disconnect, address 3
usb 3-1: new full speed USB device using uhci_hcd and address 4
usb 3-1: configuration #1 chosen from 1 choice
usb 3-1: wlan0: ZD1201 USB Wireless interface
usb 3-1: wlan0: rx urb failed: -84
usb 3-1: USB disconnect, address 4
usb 3-1: new full speed USB device using uhci_hcd and address 5
usb 3-1: configuration #1 chosen from 1 choice
usb 3-1: wlan0: ZD1201 USB Wireless interface
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
usb 3-1: wlan0: rx urb failed: -84
usb 3-1: USB disconnect, address 5
usb 3-1: new full speed USB device using uhci_hcd and address 6
usb 3-1: configuration #1 chosen from 1 choice
usb 3-1: wlan0: ZD1201 USB Wireless interface
usb 3-1: wlan0: rx urb failed: -84
usb 3-1: USB disconnect, address 6
usb 3-1: new full speed USB device using uhci_hcd and address 7
usb 3-1: configuration #1 chosen from 1 choice
usb 3-1: wlan0: ZD1201 USB Wireless interface
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
usb 3-1: wlan0: rx urb failed: -75
usb 3-1: USB disconnect, address 7
usb 3-1: new full speed USB device using uhci_hcd and address 8
usb 3-1: configuration #1 chosen from 1 choice
usb 3-1: wlan0: ZD1201 USB Wireless interface
usb 3-1: wlan0: rx urb failed: -84
usb 3-1: USB disconnect, address 8
usb 3-1: new full speed USB device using uhci_hcd and address 9
usb 3-1: configuration #1 chosen from 1 choice
usb 3-1: wlan0: ZD1201 USB Wireless interface
usb 3-1: wlan0: rx urb failed: -75
usb 3-1: USB disconnect, address 9
usb 3-1: new full speed USB device using uhci_hcd and address 10
usb 3-1: configuration #1 chosen from 1 choice
usb 3-1: wlan0: ZD1201 USB Wireless interface
usb 3-1: wlan0: rx urb failed: -84
usb 3-1: USB disconnect, address 10
usb 3-1: new full speed USB device using uhci_hcd and address 11
usb 3-1: configuration #1 chosen from 1 choice
usb 3-1: wlan0: ZD1201 USB Wireless interface
eth1: NETDEV_TX_BUSY returned; driver should report queue full via ieee_device->is_queue_full.
usb 3-1: wlan0: rx urb failed: -84
usb 3-1: USB disconnect, address 11
usb 3-1: new full speed USB device using uhci_hcd and address 12
usb 3-1: configuration #1 chosen from 1 choice
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 12
usb-storage: waiting for device to settle before scanning
  Vendor:  HP       Model: Digital Drive     Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 62720 512-byte hdwr sectors (32 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
SCSI device sda: 62720 512-byte hdwr sectors (32 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
 sda: sda1
sd 0:0:0:0: Attached scsi removable disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
usb-storage: device scan complete
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
SCSI device sda: 59776 512-byte hdwr sectors (31 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
SCSI device sda: 59776 512-byte hdwr sectors (31 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
 sda: sda1
SCSI device sda: 62720 512-byte hdwr sectors (32 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
SCSI device sda: 62720 512-byte hdwr sectors (32 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
 sda: sda1
SCSI device sda: 59776 512-byte hdwr sectors (31 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
SCSI device sda: 59776 512-byte hdwr sectors (31 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
 sda: sda1
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
usb 3-1: USB disconnect, address 12
usb 3-1: new full speed USB device using uhci_hcd and address 13
usb 3-1: configuration #1 chosen from 1 choice
usb 3-1: wlan0: ZD1201 USB Wireless interface
usb 3-1: wlan0: rx urb failed: -84
usb 3-1: USB disconnect, address 13
usb 3-1: new full speed USB device using uhci_hcd and address 14
usb 3-1: configuration #1 chosen from 1 choice
usb 3-1: wlan0: ZD1201 USB Wireless interface
usb 3-1: wlan0: rx urb failed: -84
usb 3-1: USB disconnect, address 14
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
usb 3-1: new full speed USB device using uhci_hcd and address 15
usb 3-1: configuration #1 chosen from 1 choice
hub 3-1:1.0: USB hub found
hub 3-1:1.0: 4 ports detected
usb 3-1.1: new full speed USB device using uhci_hcd and address 16
usb 3-1.1: no configuration chosen from 1 choice
usb 3-1: USB disconnect, address 15
usb 3-1.1: USB disconnect, address 16
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
usb 3-1: new full speed USB device using uhci_hcd and address 17
usb 3-1: configuration #1 chosen from 1 choice
hub 3-1:1.0: USB hub found
hub 3-1:1.0: 4 ports detected
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
usb 3-1: USB disconnect, address 17
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
spurious 8259A interrupt: IRQ7.
PCI: Found IBM Dock II Cardbus Bridge applying quirk
PCI: Found IBM Dock II Cardbus Bridge applying quirk
PCI: Transparent bridge - 0000:02:03.0
PCI: Bus #09 (-#0c) is hidden behind transparent bridge #02 (-#08) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
PCI: Bus #0d (-#10) is hidden behind transparent bridge #02 (-#08) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
PCI: Bus #08 (-#10) is hidden behind transparent bridge #02 (-#08) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10454]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10408]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d103bc]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10370]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10324]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d102d8]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d1028c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10240]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d101f4]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d101a8]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d1015c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10110]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10a44]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d109f8]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d109ac]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10960]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10914]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d108c8]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d1087c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10830]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d107e4]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10798]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d1074c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10700]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d106b4]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10668]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d1061c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d105d0]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10f04]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10eb8]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10e6c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10e20]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10dd4]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10d88]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10d3c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10cf0]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10ca4]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10c58]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10c0c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10bc0]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10b74]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10b28]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10f9c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d10f50]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11584]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11538]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d114ec]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d114a0]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11454]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11408]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d113bc]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11370]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11324]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d112d8]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d1128c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11240]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d111f4]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d111a8]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d1115c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11110]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11a44]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d119f8]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d119ac]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11960]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11914]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d118c8]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d1187c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11830]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d117e4]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11798]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d1174c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11700]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d116b4]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11668]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d1161c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d115d0]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11f04]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11eb8]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11e6c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11e20]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11dd4]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11d88]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11cf0]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11ca4]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11c58]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11c0c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11bc0]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11b74]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11b28]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11adc]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11a90]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11f9c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d11f50]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12584]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12538]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d124ec]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d124a0]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12454]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12408]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d123bc]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12370]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12324]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d122d8]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12240]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d121f4]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d121a8]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d1215c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12110]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12a44]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d129f8]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d129ac]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12914]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d128c8]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d1287c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12830]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d127e4]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d24adc]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d24a90]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d24f9c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d24f50]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d2b584]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d2b538]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d2b4ec]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d2b4a0]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d24c58]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d24c0c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d24bc0]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d24b74]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d24b28]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d1274c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12700]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d126b4]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12668]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d1261c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d125d0]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12f04]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12eb8]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12e6c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12e20]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12dd4]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12d88]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12d3c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12cf0]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12c58]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12c0c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12bc0]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12b74]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12b28]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12adc]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12a90]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12f9c]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d12f50]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d14584]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d14538]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d144ec]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d144a0]
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d14454]
ACPI: Delete PCI Interrupt Routing Table for 0:6b
acpi_bus-0073 [216] bus_get_device        : No context for object [c1d1ac58]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1.DOCK._PRT]
PCI: Bus 3, cardbus bridge: 0000:02:00.0
  IO window: 00004000-000040ff
  IO window: 00004400-000044ff
  PREFETCH window: e8000000-e9ffffff
  MEM window: c2000000-c3ffffff
PCI: Bus 7, cardbus bridge: 0000:02:00.1
  IO window: 00004800-000048ff
  IO window: 00004c00-00004cff
  PREFETCH window: ea000000-ebffffff
  MEM window: c4000000-c5ffffff
PCI: Ignore bogus resource 1 [3f6:3f6] of 0000:08:01.0
PCI: Ignore bogus resource 3 [376:376] of 0000:08:01.0
PCI: Bus 9, cardbus bridge: 0000:08:02.0
  IO window: 00005400-000054ff
  IO window: 00005800-000058ff
  PREFETCH window: c6000000-c7ffffff
  MEM window: ca000000-cbffffff
PCI: Bus 13, cardbus bridge: 0000:08:02.1
  IO window: 00005c00-00005cff
  IO window: 00006000-000060ff
  PREFETCH window: c8000000-c9ffffff
  MEM window: cc000000-cdffffff
PCI: Bridge: 0000:02:03.0
  IO window: 5000-6fff
  MEM window: ca000000-ceffffff
  PREFETCH window: c6000000-c9ffffff
PCI: Enabling device 0000:02:03.0 (0000 -> 0003)
PCI: Enabling device 0000:08:02.0 (0000 -> 0003)
PCI: Setting latency timer of device 0000:08:02.0 to 64
PCI: Enabling device 0000:08:02.1 (0000 -> 0003)
PCI: Setting latency timer of device 0000:08:02.1 to 64
PCI: Enabling device 0000:08:00.0 (0000 -> 0003)
hp100: Busmaster mode enabled.
hp100: at 0x5000, IRQ 11, PCI bus, 32k SRAM (rx/tx 75%).
hp100: Adapter is attached to 10Mb/s network (coax).
usb 1-1: new high speed USB device using ehci_hcd and address 18
Yenta: CardBus bridge found at 0000:08:02.0 [1014:0148]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:08:02.0, mfunc 0x00001002, devctl 0x66
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x5000 - 0x6fff
cs: IO port probe 0x5000-0x6fff: clean.
pcmcia: parent PCI bridge Memory window: 0xca000000 - 0xceffffff
pcmcia: parent PCI bridge Memory window: 0xc6000000 - 0xc9ffffff
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x8fff
pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xcfffffff
pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
Yenta: CardBus bridge found at 0000:08:02.1 [1014:0148]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:08:02.1, mfunc 0x00001002, devctl 0x66
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x5000 - 0x6fff
cs: IO port probe 0x5000-0x6fff: clean.
pcmcia: parent PCI bridge Memory window: 0xca000000 - 0xceffffff
pcmcia: parent PCI bridge Memory window: 0xc6000000 - 0xc9ffffff
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x8fff
pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xcfffffff
pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
ACPI: PCI interrupt for device 0000:08:00.0 disabled
ACPI: PCI interrupt for device 0000:08:02.0 disabled
ACPI: PCI interrupt for device 0000:08:02.1 disabled
usb 1-1: USB disconnect, address 18
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
PCI: Found IBM Dock II Cardbus Bridge applying quirk
PCI: Found IBM Dock II Cardbus Bridge applying quirk
PCI: Transparent bridge - 0000:02:03.0
PCI: Bus #09 (-#0c) is hidden behind transparent bridge #02 (-#08) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
PCI: Bus #0d (-#10) is hidden behind transparent bridge #02 (-#08) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
PCI: Bus #08 (-#10) is hidden behind transparent bridge #02 (-#08) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10454]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10408]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d103bc]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10370]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10324]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d102d8]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d1028c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10240]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d101f4]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d101a8]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d1015c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10110]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10a44]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d109f8]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d109ac]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10960]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10914]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d108c8]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d1087c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10830]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d107e4]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10798]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d1074c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10700]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d106b4]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10668]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d1061c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d105d0]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10f04]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10eb8]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10e6c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10e20]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10dd4]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10d88]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10d3c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10cf0]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10ca4]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10c58]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10c0c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10bc0]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10b74]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10b28]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10f9c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d10f50]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11584]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11538]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d114ec]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d114a0]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11454]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11408]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d113bc]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11370]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11324]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d112d8]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d1128c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11240]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d111f4]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d111a8]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d1115c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11110]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11a44]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d119f8]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d119ac]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11960]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11914]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d118c8]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d1187c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11830]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d117e4]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11798]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d1174c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11700]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d116b4]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11668]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d1161c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d115d0]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11f04]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11eb8]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11e6c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11e20]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11dd4]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11d88]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11cf0]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11ca4]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11c58]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11c0c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11bc0]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11b74]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11b28]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11adc]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11a90]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11f9c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d11f50]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d12584]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d12538]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d124ec]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d124a0]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d12454]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d12408]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d123bc]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d12370]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d12324]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d122d8]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d12240]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d121f4]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d121a8]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d1215c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d12110]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d12a44]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d129f8]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d129ac]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d12914]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d128c8]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d1287c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d12830]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d127e4]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d24adc]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d24a90]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d24f9c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d24f50]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d2b584]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d2b538]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d2b4ec]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d2b4a0]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d24c58]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d24c0c]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d24bc0]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d24b74]
acpi_bus-0073 [293] bus_get_device        : No context for object [c1d24b28]
BUG: unable to handle kernel NULL pointer dereference at virtual address 0000004c
 printing eip:
c02df7e9
*pde = 00000000
ipw2200: Firmware error detected.  Restarting.
ipw2200: Firmware error detected.  Restarting.
BUG: soft lockup detected on CPU#0!
 <c01489cd> softlockup_tick+0xad/0xe0   <c012fff1> update_process_times+0x31/0x80
 <c01067c7> timer_interrupt+0x67/0x90   <c0148b03> handle_IRQ_event+0x33/0x70
 <c0148bcd> __do_IRQ+0x8d/0xf0   <c0105969> do_IRQ+0x19/0x30
 <c0103956> common_interrupt+0x1a/0x20   <c0111bd4> delay_pmtmr+0x14/0x20
 <c0267cf9> __delay+0x9/0x10   <c011debb> do_page_fault+0x39b/0x66e
 <c011db20> do_page_fault+0x0/0x66e   <c0103a8b> error_code+0x4f/0x54
 <c02d007b> acpi_ut_allocate_owner_id+0x10b/0x171   <c02df7e9> acpi_pci_unbind+0x179/0x1bc
 <c02eaea1> acpi_bus_remove+0x13b/0x16d   <c02eaf4f> acpi_bus_trim+0x7c/0xd7
 <c0283edb> acpiphp_enable_slot+0x39b/0x480   <c02840fa> handle_hotplug_event_func+0x4a/0x1a0
 <c05189a5> pci_bios_write+0x85/0x100   <c051a90a> pci_write+0x2a/0x30
 <c0284c4d> hotplug_pci+0x2d/0x50   <c0284da5> handle_hotplug_event_dock+0x135/0x2b0
 <c02d46f1> acpi_bus_notify+0x27d/0x283   <c02b54f4> acpi_ev_notify_dispatch+0x4e/0x57
 <c02acc25> acpi_os_execute_deferred+0x67/0x8b   <c0136bb8> run_workqueue+0x78/0xf0
 <c02acbbe> acpi_os_execute_deferred+0x0/0x8b   <c0136dd1> worker_thread+0xe1/0x120
 <c0121dc0> default_wake_function+0x0/0x10   <c0136cf0> worker_thread+0x0/0x120
 <c013a4fc> kthread+0xdc/0xe0   <c013a420> kthread+0x0/0xe0
 <c0101005> kernel_thread_helper+0x5/0x10  
Oops: 0000 [#1]
SMP 
Modules linked in: ipw2200
CPU:    0
EIP:    0060:[<c02df7e9>]    Not tainted VLI
EFLAGS: 00010282   (2.6.17-rc4-g81a95636-dirty #260) 
EIP is at acpi_pci_unbind+0x179/0x1bc
eax: 00000000   ebx: f744ace8   ecx: f7b66da4   edx: c064be91
esi: f64db944   edi: f744ade8   ebp: 00000001   esp: c1d97e04
ds: 007b   es: 007b   ss: 0068
Process kacpid (pid: 10, threadinfo=c1d96000 task=c1d79ad0)
Stack: <0>0000001a f744ace8 f7b66da4 f64db944 00000001 00000000 c02eaea1 f64db944 
       c1e148d4 c02eaf4f 00000001 0000000e c1d11d3c c1d104a0 f64db944 f79e62fc 
       c1fc75e8 f7ebf4f0 f7ebf4f8 c0283edb 00000001 c06491fa 00000010 c1d9d31c 
Call Trace:
 <c02eaea1> acpi_bus_remove+0x13b/0x16d   <c02eaf4f> acpi_bus_trim+0x7c/0xd7
 <c0283edb> acpiphp_enable_slot+0x39b/0x480   <c02840fa> handle_hotplug_event_func+0x4a/0x1a0
 <c05189a5> pci_bios_write+0x85/0x100   <c051a90a> pci_write+0x2a/0x30
 <c0284c4d> hotplug_pci+0x2d/0x50   <c0284da5> handle_hotplug_event_dock+0x135/0x2b0
 <c02d46f1> acpi_bus_notify+0x27d/0x283   <c02b54f4> acpi_ev_notify_dispatch+0x4e/0x57
 <c02acc25> acpi_os_execute_deferred+0x67/0x8b   <c0136bb8> run_workqueue+0x78/0xf0
 <c02acbbe> acpi_os_execute_deferred+0x0/0x8b   <c0136dd1> worker_thread+0xe1/0x120
 <c0121dc0> default_wake_function+0x0/0x10   <c0136cf0> worker_thread+0x0/0x120
 <c013a4fc> kthread+0xdc/0xe0   <c013a420> kthread+0x0/0xe0
 <c0101005> kernel_thread_helper+0x5/0x10  
Code: 68 5f 27 60 c0 68 3b 01 00 00 6a 01 e8 11 f3 fe ff b8 ed ff ff ff 83 c4 1c eb 27 8b 4c 24 08 8b 41 0c 83 78 14 00 74 0f 8b 41 08 <0f> b6 50 4c 0f b7 01 e8 05 ee ff ff 8b 44 24 08 e8 e2 65 e8 ff 
EIP: [<c02df7e9>] acpi_pci_unbind+0x179/0x1bc SS:ESP 0068:c1d97e04
 BUG: kacpid/10, lock held at task exit time!
 [f7ebf504] {register_slot}
.. held by:            kacpid:   10 [c1d79ad0, 110]
... acquired at:               acpiphp_enable_slot+0x15/0x480
usb 1-1: new high speed USB device using ehci_hcd and address 19
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
