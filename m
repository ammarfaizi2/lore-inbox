Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbUKJHqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUKJHqA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 02:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbUKJHqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 02:46:00 -0500
Received: from [217.222.53.238] ([217.222.53.238]:1154 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S261326AbUKJHpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 02:45:16 -0500
From: Stefano Rivoir <s.rivoir@gts.it>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: 2.6.10-rc1-mm4
Date: Wed, 10 Nov 2004 08:44:39 +0100
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20041109074909.3f287966.akpm@osdl.org> <200411091802.16386.s.rivoir@gts.it> <21d7e997041109151833ef1d90@mail.gmail.com>
In-Reply-To: <21d7e997041109151833ef1d90@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nbckBwGzw3Ehw46"
Message-Id: <200411100844.39821.s.rivoir@gts.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_nbckBwGzw3Ehw46
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 00:18, mercoled=EC 10 novembre 2004, Dave Airlie ha scritto:
> > A glxgears causes Xorg to get immediately out; nothing very notable in
> > the logs, except for

[...]

> Can you put up a dmesg as well? I think it might be something to do

Here you are.

Bye!

=2D-=20
Stefano Rivoir

--Boundary-00=_nbckBwGzw3Ehw46
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.txt"

Linux version 2.6.10-rc1-mm4 (root@nbsteu) (gcc version 3.3.5 (Debian 1:3.3.5-2)) #1 Tue Nov 9 17:37:56 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffa000 (usable)
 BIOS-e820: 000000001fffa000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131066
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126970 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6410
ACPI: RSDT (v001 ASUS   L5C      0x42302e31 MSFT 0x31313031) @ 0x1fffa000
ACPI: FADT (v001 ASUS   L5C      0x42302e31 MSFT 0x31313031) @ 0x1fffa0b6
ACPI: BOOT (v001 ASUS   L5C      0x42302e31 MSFT 0x31313031) @ 0x1fffa030
ACPI: MADT (v001 ASUS   L5C      0x42302e31 MSFT 0x31313031) @ 0x1fffa058
ACPI: DSDT (v001   ASUS L5C      0x00001000 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
Initializing CPU#0
Kernel command line: auto BOOT_IMAGE=Linux ro root=1602
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2667.862 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x50
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 516236k/524264k available (1537k kernel code, 7436k reserved, 723k data, 104k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5259.26 BogoMIPS (lpj=2629632)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 2.66GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1670, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 *11 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 *11 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 11 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS963 that hid as a SIS503 (compatible=1)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [FN0] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 16 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
pnp: 00:02: ioport range 0xe400-0xe47f could not be reserved
pnp: 00:02: ioport range 0xe480-0xe4ff has been reserved
pnp: 00:02: ioport range 0xe800-0xe81f has been reserved
pnp: 00:02: ioport range 0x480-0x48f has been reserved
pnp: 00:0f: ioport range 0x3f0-0x3f1 has been reserved
pnp: 00:0f: ioport range 0x290-0x297 has been reserved
pnp: 00:0f: ioport range 0x500-0x507 has been reserved
Simple Boot Flag at 0x3a set to 0x80
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=195.00 MHz
radeonfb: PLL min 20000 max 35000
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: 1400x1050 TFT           
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
radeonfb: Power Management enabled for Mobility chipsets
Console: switching to colour frame buffer device 175x65
radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
[drm] Initialized drm 1.0.0 20040925
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: IC25N060ATMR04-0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hdc: max request size: 1024KiB
hdc: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3 < hdc5 >
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 4.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 104k freed
kjournald starting.  Commit interval 5 seconds
Adding 248968k swap on /dev/hdc5.  Priority:-1 extents:1
EXT3 FS on hdc2, internal journal
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
eth0: 3Com Gigabit LOM (3C940)
      PrefPort:A  RlmtMode:Check Link State
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 11 (level, low) -> IRQ 11
intel8x0_measure_ac97_clock: measured 49477 usecs
intel8x0: clocking to 48000
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: AC Adapter [AC] (on-line)
Asus Laptop ACPI Extras version 0.29
  Error calling BSTS
  L5G model detected, supported
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (26 C)
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 648 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9]
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
input: PC Speaker
inserting floppy driver for 2.6.10-rc1-mm4
ACPI: Floppy Controller [FDC0] at I/O 0x3f2-0x3f5, 0x3f7 irq 6 dma channel 2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:02.3[B] -> GSI 11 (level, low) -> IRQ 11
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[e7000000-e70007ff]  Max Packet=[2048]
ACPI: PCI interrupt 0000:00:02.6[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:02.6[C] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:03.0: Silicon Integrated Systems [SiS] USB 1.0 Controller
ohci_hcd 0000:00:03.0: irq 5, pci mem 0xe6800000
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:03.1: Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
ohci_hcd 0000:00:03.1: irq 5, pci mem 0xe6000000
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:03.2: Silicon Integrated Systems [SiS] USB 1.0 Controller (#3)
ohci_hcd 0000:00:03.2: irq 5, pci mem 0xe5800000
ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800030a9d55]
usb 2-1: new low speed USB device using ohci_hcd and address 2
usbcore: registered new driver hiddev
input: USB HID v1.00 Mouse [0461:4d03] on usb-0000:00:03.1-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 5 (level, low) -> IRQ 5
ehci_hcd 0000:00:03.3: Silicon Integrated Systems [SiS] USB 2.0 Controller
ehci_hcd 0000:00:03.3: irq 5, pci mem 0xe5000000
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 4
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
usb 2-1: USB disconnect, address 2
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
Linux Kernel Card Services
  options:  [pci] [cardbus]
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:0a.0 [1043:1734]
Yenta: ISA IRQ mask 0x0400, PCI irq 11
Socket status: 30000006
ACPI: PCI interrupt 0000:00:0a.1[B] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:0a.1 [1043:1734]
usb 2-1: new low speed USB device using ohci_hcd and address 3
Yenta: ISA IRQ mask 0x0010, PCI irq 11
Socket status: 30000006
input: USB HID v1.00 Mouse [0461:4d03] on usb-0000:00:03.1-1
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (on)
lp: driver loaded but no devices found
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  enabled
[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[drm:drm_unlock] *ERROR* Process 4956 using kernel context 0

--Boundary-00=_nbckBwGzw3Ehw46--
