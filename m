Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbUKFKtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbUKFKtk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 05:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbUKFKtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 05:49:40 -0500
Received: from smtp803.mail.ukl.yahoo.com ([217.12.12.140]:433 "HELO
	smtp803.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261341AbUKFKtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 05:49:14 -0500
From: Nick Sanders <sandersn@btinternet.com>
To: linux-kernel@vger.kernel.org
Subject: Problem burning Audio CDs
Date: Sat, 6 Nov 2004 10:49:38 +0000
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CxKjBMypl+ZI744"
Message-Id: <200411061049.38278.sandersn@btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_CxKjBMypl+ZI744
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I've got problem with burning audio cds using k3b with 2.6.9 onwards. It gets 
about 22% through and then cdrecord hangs saying '/usr/bin/cdrecord: Caught 
interrupt.'

2.6.7 works fine and I couldn't test 2.6.8.

I noticed that the CPU usage is alot higher in the caes where it fails

Buring data CDs and DVDs works fine.

I have also just noticed audio cd ripping doesn't work.

Has anyone else had this problem?

Regards

Nick Sanders

 

--Boundary-00=_CxKjBMypl+ZI744
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

Linux version 2.6.10-rc1-mm1 (sandersn@gandalf) (gcc version 3.3.5 (Debian 1:3.3.5-2)) #1 Thu Oct 28 14:03:18 BST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f4d10
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 GBT                                   ) @ 0x000f6680
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fff3040
ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fff7380
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hda1 ro 
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1836.947 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 516292k/524224k available (1485k kernel code, 7376k reserved, 695k data, 136k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3612.67 BogoMIPS (lpj=1806336)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2500+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfa0f0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041015
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *0, disabled.
ACPI: PCI Interrupt Link [ALKB] (IRQs 21) *0, disabled.
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *0, disabled.
ACPI: PCI Interrupt Link [ALKD] (IRQs 23) *0, disabled.
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Machine check exception polling timer started.
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 20
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
ACPI: PCI interrupt 0000:00:11.1[A] -> GSI 20 (level, low) -> IRQ 20
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: WDC WD400BB-00CAA0, ATA DISK drive
hdb: WDC WD205BA, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: PIONEER DVD-RW DVR-107D, ATAPI CD/DVD-ROM drive
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
hda: Host Protected Area detected.
	current capacity is 78163247 sectors (40019 MB)
	native  capacity is 78165360 sectors (40020 MB)
hda: 78163247 sectors (40019 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdb: max request size: 128KiB
hdb: 40088160 sectors (20525 MB) w/2048KiB Cache, CHS=39770/16/63, UDMA(66)
hdb: cache flushes not supported
 hdb: hdb1
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 136k freed
Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA KT400/KT400A/KT600 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xd0000000
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized r128 2.5.0 20030725 on minor 0: ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS
Real Time Clock Driver v1.12
Linux Tulip driver version 1.1.13 (May 11, 2002)
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
tulip0:  MII transceiver #1 config 3000 status 7809 advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 32 at 0001d000, 00:A0:CC:5D:5E:01, IRQ 19.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 17
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [ALKB] BIOS reported IRQ 0, using IRQ 21
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 21
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 5
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: irq 21, io base 0xdc00
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.1[B] -> GSI 21 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 5
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:10.1: irq 21, io base 0xe000
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.2[C] -> GSI 21 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 5
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:10.2: irq 21, io base 0xe400
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.3: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.3: irq 21, pci mem 0xdf001000
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
usb 3-1: new full speed USB device using uhci_hcd and address 2
NET: Registered protocol family 8
NET: Registered protocol family 20
usb 3-2: new full speed USB device using uhci_hcd and address 3
usb 3-1: control timeout on ep0in
usbcore: registered new driver speedtch
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 proto 2 vid 0x03F0 pid 0x6004
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
HDLC line discipline: version $Revision: 4.8 $, maxframe=4096
N_HDLC line discipline registered.
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
agpgart: Device is in legacy mode, falling back to 2.x
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
usb 1-2: new full speed USB device using uhci_hcd and address 2
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
  Vendor: FUJIFILM  Model: USB-DRIVEUNIT     Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 00
usb-storage: device scan complete
SCSI device sda: 32000 512-byte hdwr sectors (16 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
usb 1-2: USB disconnect, address 2

--Boundary-00=_CxKjBMypl+ZI744--
