Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbUKAHLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbUKAHLu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 02:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUKAHLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 02:11:50 -0500
Received: from FW-30-241.go.retevision.es ([62.174.241.30]:15946 "EHLO
	mayhem.ghetto") by vger.kernel.org with ESMTP id S261589AbUKAHIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 02:08:19 -0500
Date: Mon, 1 Nov 2004 08:08:08 +0100
To: linux-kernel@vger.kernel.org
Subject: swsusp almost working
Message-ID: <20041101070808.GA3514@larroy.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

gug

I'm very impressed with the current status of swsusp, it's almost
working in my laptop. The only problem is that most of the time the
network card won't work after resuming. The card is a vanilla realtek
8139.

I attach the dmesg output.

Regards.
-- 
Pedro Larroy Tovar | Linux & Network consultant |  pedro%larroy.com 
Make debian mirrors with debian-multimirror: http://pedro.larroy.com/deb_mm/
	* Las patentes de programación son nocivas para la innovación * 
				http://proinnova.hispalinux.es/

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

eeaed2
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1eeeafd8
ACPI: MADT (v001 INTEL  MONTARAG 0x06040000 PTL  0x00000050) @ 0x1eeeaf7e
ACPI: DSDT (v001   ACER MONTARAG 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/hda1 devfs=mount resume=/dev/hda2 
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1998.927 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 498512k/506752k available (2114k kernel code, 7788k reserved, 860k data, 160k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3956.73 BogoMIPS (lpj=1978368)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0117 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:....................................................................................................................................................................................................
Table [DSDT](id F004) - 667 Objects with 59 Devices 196 Methods 22 Regions
ACPI Namespace successfully loaded at root c04280bc
evxfevnt-0093 [03] acpi_enable           : Transition to ACPI mode successful
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd7f4, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
evgpeblk-0980 [07] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs at 0000000000001028 on int 0x9
evgpeblk-0989 [07] ev_create_gpe_block   : Found 6 Wake, Enabled 1 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:..................................................................
Initialized 22/22 Regions 0/0 Fields 32/32 Buffers 12/18 Packages (676 nodes)
Executing all Device _STA and_INI methods:...............................................................
63 Devices found containing: 63 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs *10 11)
ACPI: Embedded Controller [EC0] (gpe 29)
[ACPI Debug] String: Length 0x11, "==Battery1 _STA=="
[ACPI Debug] String: Length 0x11, "==Battery1 _STA=="
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 20 (level, low) -> IRQ 20
ACPI: PCI interrupt 0000:02:04.1[B] -> GSI 21 (level, low) -> IRQ 21
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 22 (level, low) -> IRQ 22
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
ACPI: AC Adapter [ACAD] (on-line)
[ACPI Debug] String: Length 0x11, "==Battery1 _STA=="
[ACPI Debug] String: Length 0x11, "==Battery1 _BIF=="
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (36 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
hw_random: cannot enable RNG, aborting
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Maximum main memory to use for agp memory: 423M
agpgart: Detected 16252K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
[drm] Initialized i830 1.3.2 20021108 on minor 0: 
[drm] Initialized i830 1.3.2 20021108 on minor 1: 
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 17
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
eth0: RealTek RTL8139 at 0xdf806800, 00:02:3f:b7:e6:52, IRQ 19
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC25N030ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QSI CD-RW/DVD-ROM SBW-241, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/1768KiB Cache, CHS=58140/16/63, UDMA(100)
hda: cache flushes not supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 20 (level, low) -> IRQ 20
Yenta: CardBus bridge found at 0000:02:04.0 [1025:0021]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:04.0, mfunc 0x011c1122, devctl 0x44
Yenta: ISA IRQ mask 0x0000, PCI irq 20
Socket status: 30000006
ACPI: PCI interrupt 0000:02:04.1[B] -> GSI 21 (level, low) -> IRQ 21
Yenta: CardBus bridge found at 0000:02:04.1 [1025:0021]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:04.1, mfunc 0x011c1122, devctl 0x44
Yenta: ISA IRQ mask 0x0000, PCI irq 21
Socket status: 30000006
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem df81a000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 00001820
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 00001840
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 00001860
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
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
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49512 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801DB-ICH4 at 0xe0100c00, irq 17
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices: 
ELAN MODM USB1 USB2 USB3 EUSB 
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 160k freed
Adding 297192k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Disabled Privacy Extensions on device c0397c60(lo)
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (3959 buckets, 31672 max) - 332 bytes per conntrack
HTB init, kernel part version 3.17
HTB: quantum of class 10010 is big. Consider r2q change.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x20f 0x378-0x37f 0x4d0-0x4d7
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
Disabled Privacy Extensions on device ded6f800(sit0)
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: no IPv6 routers present
Stopping tasks: ======================================|
Freeing memory: .....................................................................................................................................................................................................................................|
PM: Attempting to suspend to disk.
PM: snapshotting memory.
PM: Image restored successfully.
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Restarting tasks... done
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0005 c07f media 10.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a049. (queue head)
eth0:  Tx descriptor 1 is 0008a049.
eth0:  Tx descriptor 2 is 0008a042.
eth0:  Tx descriptor 3 is 0008a042.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0005 c07f media 10.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a049. (queue head)
eth0:  Tx descriptor 1 is 0008a049.
eth0:  Tx descriptor 2 is 0008a03c.
eth0:  Tx descriptor 3 is 0008a042.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0005 c07f media 10.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a03c. (queue head)
eth0:  Tx descriptor 1 is 0008a03c.
eth0:  Tx descriptor 2 is 0008a03c.
eth0:  Tx descriptor 3 is 0008a03c.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg2

ocessor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/hda1 devfs=mount resume=/dev/hda2 
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1998.927 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 498512k/506752k available (2114k kernel code, 7788k reserved, 860k data, 160k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3956.73 BogoMIPS (lpj=1978368)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0117 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:....................................................................................................................................................................................................
Table [DSDT](id F004) - 667 Objects with 59 Devices 196 Methods 22 Regions
ACPI Namespace successfully loaded at root c04280bc
evxfevnt-0093 [03] acpi_enable           : Transition to ACPI mode successful
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd7f4, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
evgpeblk-0980 [07] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs at 0000000000001028 on int 0x9
evgpeblk-0989 [07] ev_create_gpe_block   : Found 6 Wake, Enabled 1 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:..................................................................
Initialized 22/22 Regions 0/0 Fields 32/32 Buffers 12/18 Packages (676 nodes)
Executing all Device _STA and_INI methods:...............................................................
63 Devices found containing: 63 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs *10 11)
ACPI: Embedded Controller [EC0] (gpe 29)
[ACPI Debug] String: Length 0x11, "==Battery1 _STA=="
[ACPI Debug] String: Length 0x11, "==Battery1 _STA=="
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 20 (level, low) -> IRQ 20
ACPI: PCI interrupt 0000:02:04.1[B] -> GSI 21 (level, low) -> IRQ 21
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 22 (level, low) -> IRQ 22
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
ACPI: AC Adapter [ACAD] (on-line)
[ACPI Debug] String: Length 0x11, "==Battery1 _STA=="
[ACPI Debug] String: Length 0x11, "==Battery1 _BIF=="
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (36 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
hw_random: cannot enable RNG, aborting
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Maximum main memory to use for agp memory: 423M
agpgart: Detected 16252K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
[drm] Initialized i830 1.3.2 20021108 on minor 0: 
[drm] Initialized i830 1.3.2 20021108 on minor 1: 
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 17
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
eth0: RealTek RTL8139 at 0xdf806800, 00:02:3f:b7:e6:52, IRQ 19
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC25N030ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QSI CD-RW/DVD-ROM SBW-241, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/1768KiB Cache, CHS=58140/16/63, UDMA(100)
hda: cache flushes not supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 20 (level, low) -> IRQ 20
Yenta: CardBus bridge found at 0000:02:04.0 [1025:0021]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:04.0, mfunc 0x011c1122, devctl 0x44
Yenta: ISA IRQ mask 0x0000, PCI irq 20
Socket status: 30000006
ACPI: PCI interrupt 0000:02:04.1[B] -> GSI 21 (level, low) -> IRQ 21
Yenta: CardBus bridge found at 0000:02:04.1 [1025:0021]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:04.1, mfunc 0x011c1122, devctl 0x44
Yenta: ISA IRQ mask 0x0000, PCI irq 21
Socket status: 30000006
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem df81a000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 00001820
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 00001840
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 00001860
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
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
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49512 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801DB-ICH4 at 0xe0100c00, irq 17
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices: 
ELAN MODM USB1 USB2 USB3 EUSB 
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 160k freed
Adding 297192k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Disabled Privacy Extensions on device c0397c60(lo)
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (3959 buckets, 31672 max) - 332 bytes per conntrack
HTB init, kernel part version 3.17
HTB: quantum of class 10010 is big. Consider r2q change.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x20f 0x378-0x37f 0x4d0-0x4d7
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
Disabled Privacy Extensions on device ded6f800(sit0)
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: no IPv6 routers present
Stopping tasks: ======================================|
Freeing memory: .....................................................................................................................................................................................................................................|
PM: Attempting to suspend to disk.
PM: snapshotting memory.
PM: Image restored successfully.
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Restarting tasks... done
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0005 c07f media 10.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a049. (queue head)
eth0:  Tx descriptor 1 is 0008a049.
eth0:  Tx descriptor 2 is 0008a042.
eth0:  Tx descriptor 3 is 0008a042.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0005 c07f media 10.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a049. (queue head)
eth0:  Tx descriptor 1 is 0008a049.
eth0:  Tx descriptor 2 is 0008a03c.
eth0:  Tx descriptor 3 is 0008a042.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0005 c07f media 10.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a03c. (queue head)
eth0:  Tx descriptor 1 is 0008a03c.
eth0:  Tx descriptor 2 is 0008a03c.
eth0:  Tx descriptor 3 is 0008a03c.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0005 c07f media 10.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a03c. (queue head)
eth0:  Tx descriptor 1 is 0008a03c.
eth0:  Tx descriptor 2 is 0008a03c.
eth0:  Tx descriptor 3 is 0008a03c.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg3
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.9-mm1 (root@falafell) (gcc version 3.3.4 (Debian 1:3.3.4-=
13)) #2 Sun Oct 31 07:21:04 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001eee0000 (usable)
 BIOS-e820: 000000001eee0000 - 000000001eeeb000 (ACPI data)
 BIOS-e820: 000000001eeeb000 - 000000001ef00000 (ACPI NVS)
 BIOS-e820: 000000001ef00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec10000 - 00000000fec20000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
494MB LOWMEM available.
On node 0 totalpages: 126688
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 122592 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 ACER                                  ) @ 0x000f6600
ACPI: RSDT (v001 ACER   Montara  0x06040000  LTP 0x00000000) @ 0x1eee592e
ACPI: FADT (v001 ACER   MONTARA  0x06040000 PTL  0x00000050) @ 0x1eeeaed2
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1eeeafd8
ACPI: MADT (v001 INTEL  MONTARAG 0x06040000 PTL  0x00000050) @ 0x1eeeaf7e
ACPI: DSDT (v001   ACER MONTARAG 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=3D/dev/hda1 devfs=3Dmount resume=3D/dev/hda2=20
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1998.759 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 498556k/506752k available (2109k kernel code, 7696k reserved, 825k =
data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3956.73 BogoMIPS (lpj=3D1978368)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd7f4, last bus=3D2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs *10 11)
ACPI: Embedded Controller [EC0] (gpe 29)
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
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (58 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
hw_random: cannot enable RNG, aborting
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Maximum main memory to use for agp memory: 423M
agpgart: Detected 16252K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized i830 1.3.2 20021108 on minor 0:=20
[drm] Initialized i830 1.3.2 20021108 on minor 1:=20
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 17
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: Floppy Controller [FDC] at I/O 0x3f0-0x3f5, 0x3f7 irq 6 dma channel 2
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
eth0: RealTek RTL8139 at 0xdf806800, 00:02:3f:b7:e6:52, IRQ 19
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC25N030ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QSI CD-RW/DVD-ROM SBW-241, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/1768KiB Cache, CHS=3D58140/16/63, UDMA(1=
00)
hda: cache flushes not supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem 0xe0100000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0x1820
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0x1840
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0x1860
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
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
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53=
 2004 UTC).
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49323 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801DB-ICH4 with ALC202 at 0xe0100c00, irq 17
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices:=20
ELAN MODM USB1 USB2 USB3 EUSB=20
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 156k freed
Adding 297192k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Disabled Privacy Extensions on device c0397ba0(lo)
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (3959 buckets, 31672 max) - 300 bytes per conntrack
HTB init, kernel part version 3.17
HTB: quantum of class 10010 is big. Consider r2q change.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
Freeing memory...  =08done (0 pages freed)
=2E..........swsusp: Need to copy 10156 pages
=2E<6>ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
Restarting tasks... done
Disabled Privacy Extensions on device dec0a000(sit0)
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: no IPv6 routers present
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
mtrr: base(0xe8020000) is not aligned on a size(0x300000) boundary
Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
Freeing memory...  =08done (0 pages freed)
=2E....................................swsusp: Need to copy 38082 pages
=2E<6>ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Restarting tasks... done
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled on user request.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0005 c07f media 10.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a049. (queue head)
eth0:  Tx descriptor 1 is 0008a03c.
eth0:  Tx descriptor 2 is 0008a03c.
eth0:  Tx descriptor 3 is 0008a03c.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: Promiscuous mode enabled.
device eth0 entered promiscuous mode
device eth0 left promiscuous mode
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0005 c07f media 10.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a03c. (queue head)
eth0:  Tx descriptor 1 is 0008a03c.
eth0:  Tx descriptor 2 is 0008a03c.
eth0:  Tx descriptor 3 is 0008a03c.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg4
Content-Transfer-Encoding: quoted-printable

IOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
494MB LOWMEM available.
On node 0 totalpages: 126688
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 122592 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 ACER                                  ) @ 0x000f6600
ACPI: RSDT (v001 ACER   Montara  0x06040000  LTP 0x00000000) @ 0x1eee592e
ACPI: FADT (v001 ACER   MONTARA  0x06040000 PTL  0x00000050) @ 0x1eeeaed2
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1eeeafd8
ACPI: MADT (v001 INTEL  MONTARAG 0x06040000 PTL  0x00000050) @ 0x1eeeaf7e
ACPI: DSDT (v001   ACER MONTARAG 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=3D/dev/hda1 devfs=3Dmount resume=3D/dev/hda2=20
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1998.759 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 498556k/506752k available (2109k kernel code, 7696k reserved, 825k =
data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3956.73 BogoMIPS (lpj=3D1978368)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd7f4, last bus=3D2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs *10 11)
ACPI: Embedded Controller [EC0] (gpe 29)
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
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (58 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
hw_random: cannot enable RNG, aborting
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Maximum main memory to use for agp memory: 423M
agpgart: Detected 16252K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized i830 1.3.2 20021108 on minor 0:=20
[drm] Initialized i830 1.3.2 20021108 on minor 1:=20
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 17
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: Floppy Controller [FDC] at I/O 0x3f0-0x3f5, 0x3f7 irq 6 dma channel 2
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
eth0: RealTek RTL8139 at 0xdf806800, 00:02:3f:b7:e6:52, IRQ 19
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC25N030ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QSI CD-RW/DVD-ROM SBW-241, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/1768KiB Cache, CHS=3D58140/16/63, UDMA(1=
00)
hda: cache flushes not supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem 0xe0100000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0x1820
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0x1840
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0x1860
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
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
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53=
 2004 UTC).
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49323 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801DB-ICH4 with ALC202 at 0xe0100c00, irq 17
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices:=20
ELAN MODM USB1 USB2 USB3 EUSB=20
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 156k freed
Adding 297192k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Disabled Privacy Extensions on device c0397ba0(lo)
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (3959 buckets, 31672 max) - 300 bytes per conntrack
HTB init, kernel part version 3.17
HTB: quantum of class 10010 is big. Consider r2q change.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
Freeing memory...  =08done (0 pages freed)
=2E..........swsusp: Need to copy 10156 pages
=2E<6>ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
Restarting tasks... done
Disabled Privacy Extensions on device dec0a000(sit0)
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: no IPv6 routers present
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
mtrr: base(0xe8020000) is not aligned on a size(0x300000) boundary
Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
Freeing memory...  =08done (0 pages freed)
=2E....................................swsusp: Need to copy 38082 pages
=2E<6>ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Restarting tasks... done
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled on user request.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0005 c07f media 10.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a049. (queue head)
eth0:  Tx descriptor 1 is 0008a03c.
eth0:  Tx descriptor 2 is 0008a03c.
eth0:  Tx descriptor 3 is 0008a03c.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: Promiscuous mode enabled.
device eth0 entered promiscuous mode
device eth0 left promiscuous mode
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0005 c07f media 10.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a03c. (queue head)
eth0:  Tx descriptor 1 is 0008a03c.
eth0:  Tx descriptor 2 is 0008a03c.
eth0:  Tx descriptor 3 is 0008a03c.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: no IPv6 routers present
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0005 c07f media 10.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a05a. (queue head)
eth0:  Tx descriptor 1 is 0008a04e.
eth0:  Tx descriptor 2 is 0008a046.
eth0:  Tx descriptor 3 is 0008a156.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: no IPv6 routers present
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0005 c07f media 10.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a05a. (queue head)
eth0:  Tx descriptor 1 is 0008a04e.
eth0:  Tx descriptor 2 is 0008a156.
eth0:  Tx descriptor 3 is 0008a046.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0005 c07f media 10.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a046. (queue head)
eth0:  Tx descriptor 1 is 0008a046.
eth0:  Tx descriptor 2 is 0008a156.
eth0:  Tx descriptor 3 is 0008a156.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

--VbJkn9YxBvnuCH5J--
