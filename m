Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVE1RBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVE1RBq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 13:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVE1RBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 13:01:46 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:49034 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261167AbVE1RBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 13:01:10 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: How to find if BIOS has already enabled the device
Date: Sat, 28 May 2005 13:01:09 -0400
User-Agent: KMail/1.8
Cc: John Livingston <jujutama@comcast.net>,
       Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <0EF82802ABAA22479BC1CE8E2F60E8C31B5206@scl-exch2k3.phoenix.com> <200505281018.18092.kernel-stuff@comcast.net> <1117296905.2356.23.camel@localhost.localdomain>
In-Reply-To: <1117296905.2356.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200505281301.09911.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 May 2005 12:15, Alan Cox wrote:
>  but you haven't provided dmesg
> data
I did attach the dmesg in last mail - here it goes - inline this time. Let me 
know if you need anything else. The machine is on internet - can provide ssh 
access if need be.

Thanks

Parag

DMESG Output
-----------------------------------------------------------------------------------------------
0 (usable)
 BIOS-e820: 000000002ff70000 - 000000002ff7f000 (ACPI data)
 BIOS-e820: 000000002ff7f000 - 000000002ff80000 (ACPI NVS)
 BIOS-e820: 000000002ff80000 - 0000000030000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 PTLTD                                 ) @ 0x00000000000f7240
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 
0x000000002ff7a87e
ACPI: FADT (v001 NVIDIA CK8      0x06040000 PTL_ 0x000f4240) @ 
0x000000002ff7ee13
ACPI: MADT (v001 NVIDIA NV_APIC_ 0x06040000  LTP 0x00000000) @ 
0x000000002ff7ee87
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 
0x000000002ff7eee1
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 
0x000000002ff7ef09
ACPI: DSDT (v001 NVIDIA      CK8 0x06040000 MSFT 0x0100000e) @ 
0x0000000000000000
No mptable found.
On node 0 totalpages: 196464
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192368 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Nvidia board detected. Ignoring ACPI timer override.
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ e8000000 size 128 MB
Built 1 zonelists
Kernel command line: root=/dev/ram0 real_root=/dev/hda2 vga=0x317 
video=vesafb:ywrap,mtrr splash=silent,theme:gentoo gentoo=devfs console=tty0
fbsplash: silent
fbsplash: theme gentoo
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1994.870 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 766156k/785856k available (3171k kernel code, 18952k reserved, 1272k 
data, 176k init)
Calibrating delay loop... 3948.54 BogoMIPS (lpj=1974272)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 08
Using local APIC NMI watchdog using perfctr0
Using local APIC timer interrupts.
Detected 12.467 MHz APIC timer.
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 33)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 16 18 19) *0
ACPI: PCI Interrupt Link [LNK2] (IRQs 16 18 19) *0
ACPI: PCI Interrupt Link [LNK3] (IRQs 17) *0
ACPI: PCI Interrupt Link [LNK4] (IRQs 16 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 16 18 19) *0
ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [LUS1] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [LMCI] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [LPID] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22) *0, disabled.
SCSI subsystem initialized
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
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: AGP aperture is 128M @ 0xe8000000
PCI-DMA: Disabling IOMMU.
Simple Boot Flag at 0x37 set to 0x1
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
inotify device minor=63
Squashfs 2.1 (released 2004/12/10) (C) 2002-2004 Phillip Lougher
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
SGI XFS with ACLs, large block/inode numbers, no debug enabled
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
vesafb: framebuffer at 0xf0000000, mapped to 0xffffc20000180000, using 3072k, 
total 65536k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (73 C)
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ACPI: PCI Interrupt Link [LMCI] enabled at IRQ 22
ACPI: PCI interrupt 0000:00:06.1[B] -> GSI 22 (level, low) -> IRQ 22
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-150: IDE controller at PCI slot 0000:00:08.0
NFORCE3-150: chipset revision 165
NFORCE3-150: not 100% native mode: will probe irqs later
NFORCE3-150: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-150: 0000:00:08.0 (rev a5) UDMA133 controller
    ide0: BM-DMA at 0x2080-0x2087, BIOS settings: hda:DMA, hdb:pio
Losing some ticks... checking if CPU frequency changed.
    ide1: BM-DMA at 0x2088-0x208f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: FUJITSU MHT2060AT PL, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-ST DVD+RW GCA-4040N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 09:39:32 
2005 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09e)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0xa (1300 mV)
powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0xc, vid 0x2
ACPI wakeup devices:
USB0 USB1 USB2 PS2K PS2M MAC0
ACPI: (supports S0 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 176k freed
ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 21
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:02.2: nVidia Corporation nForce3 USB 2.0
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 21, pci mem 0xe0004000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: park 0
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: Enabling device 0000:00:02.0 (0004 -> 0006)
ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 20
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 20 (level, low) -> IRQ 20
ohci_hcd 0000:00:02.0: nVidia Corporation nForce3 USB 1.1
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 20, pci mem 0xe0000000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
PCI: Enabling device 0000:00:02.1 (0004 -> 0006)
ACPI: PCI Interrupt Link [LUS1] enabled at IRQ 22
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 22 (level, low) -> IRQ 22
ohci_hcd 0000:00:02.1: nVidia Corporation nForce3 USB 1.1 (#2)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 22, pci mem 0xe0001000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
Initializing USB Mass Storage driver...
usb 1-1: new high speed USB device using ehci_hcd and address 2
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 19
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 19 (level, low) -> IRQ 19
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[e0108000-e01087ff]  
Max Packet=[2048]
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
libata version 1.10 loaded.
usb 3-1: new low speed USB device using ohci_hcd and address 2
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[463f0200463f0200]
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
  Vendor: Maxtor    Model: OneTouch          Rev: 0201
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 398295040 512-byte hdwr sectors (203927 MB)
sda: assuming drive cache: write through
SCSI device sda: 398295040 512-byte hdwr sectors (203927 MB)
sda: assuming drive cache: write through
 /dev/scsi/host0/bus0/target0/lun0: p1 p2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
usb-storage: device scan complete
Adding 2241056k swap on /dev/hda4.  Priority:-1 extents:1
st: Version 20041025, fixed bufsize 32768, s/g segs 256
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 18
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 18
eth0: RealTek RTL8139 at 0xffffc20000166800, 00:0f:b0:01:01:65, IRQ 18
eth0:  Identified 8139 chip type 'RTL-8101'
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 16
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-6629  Wed Nov  3 
11:43:48 PST 2004
input: PS/2 Generic Mouse on isa0060/serio4
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x2040
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x2000
ACPI: PCI Interrupt Link [LACI] enabled at IRQ 21
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49413 usecs
intel8x0: clocking to 47436
ACPI: PCI interrupt 0000:00:06.1[B] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:06.1 to 64
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
usbcore: registered new driver hiddev
input: USB HID v1.10 Mouse [ Kensington ? Pocket Mouse Pro Wireless] on 
usb-0000:00:02.1-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
devfs_mk_dev: could not append to parent for vcc/5
devfs_mk_dev: could not append to parent for vcc/a5
devfs_mk_dev: could not append to parent for vcc/6
devfs_mk_dev: could not append to parent for vcc/a6
Disabled Privacy Extensions on device ffffffff80505ba0(lo)
fbsplash: switching to verbose mode
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
devfs_mk_dev: could not append to parent for vcc/2
devfs_mk_dev: could not append to parent for vcc/a2
devfs_mk_dev: could not append to parent for vcc/3
devfs_mk_dev: could not append to parent for vcc/a3
devfs_mk_dev: could not append to parent for vcc/4
devfs_mk_dev: could not append to parent for vcc/a4
devfs_mk_dev: could not append to parent for vcc/7
devfs_mk_dev: could not append to parent for vcc/a7
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
eth0: no IPv6 routers present
floppy0: no floppy controllers found
floppy0: no floppy controllers found
-- 
For every vision there is an equal and opposite revision.
