Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932769AbWKNLbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769AbWKNLbn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 06:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933409AbWKNLbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 06:31:43 -0500
Received: from tornado.reub.net ([203.222.131.131]:37092 "EHLO
	tornado.reub.net") by vger.kernel.org with ESMTP id S932769AbWKNLbl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 06:31:41 -0500
Message-ID: <4559A91C.10009@reub.net>
Date: Tue, 14 Nov 2006 22:31:40 +1100
From: Reuben Farrelly <reuben-linuxkernel@reub.net>
User-Agent: Thunderbird 2.0b1pre (Windows/20061113)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, davej@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5-mm2
References: <20061114014125.dd315fff.akpm@osdl.org>
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/11/2006 8:41 PM, Andrew Morton wrote:
> Presently at
> 
> http://userweb.kernel.org/~akpm/2.6.19-rc5-mm2/
> 
> and will appear later at
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm2/

Oops:

(davej cc'd - I think it's his specialty)

Linux version 2.6.19-rc5-mm2 (root@tornado.reub.net) (gcc version 4.1.1 20061108 
(Red Hat 4.1.1-35)) #1 SMP Tue Nov 14 21:56:04 EST 2006
Command line: ro root=/dev/md0 panic=60 console=ttyS0,57600
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003f66d000 (usable)
  BIOS-e820: 000000003f66d000 - 000000003f6e8000 (ACPI NVS)
  BIOS-e820: 000000003f6e8000 - 000000003f6ec000 (usable)
  BIOS-e820: 000000003f6ec000 - 000000003f6ff000 (ACPI data)
  BIOS-e820: 000000003f6ff000 - 000000003f700000 (usable)
end_pfn_map = 259840
DMI 2.3 present.
Zone PFN ranges:
   DMA             0 ->     4096
   DMA32        4096 ->  1048576
   Normal    1048576 ->  1048576
early_node_map[4] active PFN ranges
     0:        0 ->      159
     0:      256 ->   259693
     0:   259816 ->   259820
     0:   259839 ->   259840
ACPI: PM-Timer IO Port: 0x408
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Setting APIC routing to flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000e0000
Nosave address range: 00000000000e0000 - 0000000000100000
Nosave address range: 000000003f66d000 - 000000003f6e8000
Nosave address range: 000000003f6ec000 - 000000003f6ff000
Allocating PCI resources starting at 40000000 (gap: 3f700000:c0900000)
PERCPU: Allocating 33920 bytes of per cpu data
Built 1 zonelists.  Total pages: 253902
Kernel command line: ro root=/dev/md0 panic=60 console=ttyS0,57600
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
  memory used by lock dependency info: 1328 kB
  per task-struct memory footprint: 1680 bytes
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Checking aperture...
Memory: 1011700k/1039360k available (2635k kernel code, 25964k reserved, 1784k 
data, 240k init)
Calibrating delay using timer specific routine.. 6007.58 BogoMIPS (lpj=12015160)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
Freeing SMP alternatives: 28k freed
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12500426
Detected 12.500 MHz APIC timer.
lockdep: not fixing up alternatives.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 5999.97 BogoMIPS (lpj=11999958)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM1)
               Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Brought up 2 CPUs
testing NMI watchdog ... OK.
time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
time.c: Detected 3000.112 MHz processor.
migration_cost=9
checking if image is initramfs... it is
Freeing initrd memory: 1238k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 0500-053f claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 *9 10 11 12)
intel_rng: FWH not detected
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
PCI-GART: No AMD northbridge found.
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
   IO window: 2000-2fff
   MEM window: 48100000-481fffff
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.3
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.5
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
   IO window: 1000-1fff
   MEM window: 48000000-480fffff
   PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 16
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
IPv4 FIB: Using LC-trie version 0.407
TCP established hash table entries: 65536 (order: 9, 3670016 bytes)
TCP bind hash table entries: 32768 (order: 8, 1835008 bytes)
TCP: Hash tables configured (established 65536 bind 32768)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1163502407.084:1): initialized
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered (default)
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Sleep Button (CM) as /class/input/input1
ACPI: Sleep Button (CM) [SLPB]
ACPI: Getting cpuindex for acpiid 0x3
ACPI: Getting cpuindex for acpiid 0x4
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ÿserial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 19 (level, low) -> IRQ 19
0000:06:03.0: ttyS1 at I/O 0x1000 (irq = 19) is a 16550A
0000:06:03.0: ttyS2 at I/O 0x1008 (irq = 19) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 4 RAM disks of 16384K size 1024 blocksize
Intel(R) PRO/1000 Network Driver - version 7.3.15-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
e1000: 0000:01:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:16:76:ce:4a:2c
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part
ata1: SATA max UDMA/133 cmd 0xFFFFC20000016100 ctl 0x0 bmdma 0x0 irq 314
ata2: SATA max UDMA/133 cmd 0xFFFFC20000016180 ctl 0x0 bmdma 0x0 irq 314
ata3: SATA max UDMA/133 cmd 0xFFFFC20000016200 ctl 0x0 bmdma 0x0 irq 314
ata4: SATA max UDMA/133 cmd 0xFFFFC20000016280 ctl 0x0 bmdma 0x0 irq 314
scsi0 : ahci
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 31/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-6, max UDMA/133, 156301488 sectors: LBA48 NCQ (depth 31/32)
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
scsi2 : ahci
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 31/32)
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/133
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      ST3300622AS      3.AA PQ: 0 ANSI: 5
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 >
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Direct-Access     ATA      ST380817AS       3.42 PQ: 0 ANSI: 5
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
  sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
scsi 2:0:0:0: Direct-Access     ATA      ST3300622AS      3.AA PQ: 0 ANSI: 5
SCSI device sdc: 586072368 512-byte hdwr sectors (300069 MB)
sdc: Write Protect is off
SCSI device sdc: drive cache: write back
SCSI device sdc: 586072368 512-byte hdwr sectors (300069 MB)
sdc: Write Protect is off
SCSI device sdc: drive cache: write back
  sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 sdc6 sdc7 sdc8 sdc9 sdc10 sdc11 >
sd 2:0:0:0: Attached scsi disk sdc
sd 2:0:0:0: Attached scsi generic sg2 type 0
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x30B0 irq 14
ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x30B8 irq 15
scsi4 : ata_piix
ata5.00: ATAPI, max UDMA/66
ata5.00: configured for UDMA/66
scsi5 : ata_piix
ata6: port disabled. ignoring.
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/66
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/66
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/66
ata5: EH complete
ata5.00: limiting speed to UDMA/44
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/44
ata5: EH complete
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: irq 23, io mem 0x482a0400
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
USB Universal Host Controller Interface driver v3.0
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.19-rc5-mm2 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 23, io base 0x00003080
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.19-rc5-mm2 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00003060
ACPI: PCI Interrupt 0000:00:1d.2[C] -> <6>usb usb3: new device found, 
idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.19-rc5-mm2 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00003040
ACPI: PCI Interrupt 0000:00:1d.3[D] -> <6>usb usb4: new device found, 
idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.19-rc5-mm2 uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.2
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00003020
usb usb5: new device found, idVendor=0000, idProduct=0000
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.19-rc5-mm2 uhci_hcd
usb usb5: SerialNumber: 0000:00:1d.3
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 2-2: new full speed USB device using uhci_hcd and address 2
usbcore: registered new interface driver libusual
usbcore: registered new interface driver hiddev
usb 2-2: new device found, idVendor=0451, idProduct=2046
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
md: raid1 personality registered for level 1
EDAC MC: Ver: 2.0.1 Nov 14 2006
usb 2-2: new device strings: Mfr=0, Product=0, SerialNumber=0
TCP bic registered
NET: Registered protocol family 1
usb 2-2: configuration #1 chosen from 1 choice
hub 2-2:1.0: USB hub found
NET: Registered protocol family 17
------------[ cut here ]------------
kernel BUG at drivers/cpufreq/cpufreq_userspace.c:138!
invalid opcode: 0000 [1] SMP
last sysfs file:
CPU 0
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.19-rc5-mm2 #1
RIP: 0010:[<ffffffff80435299>]  [<ffffffff80435299>] 
cpufreq_governor_userspace+0x4e/0x1aa
RSP: 0000:ffff81003f61fb40  EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff81003ef4a0d8 RCX: 0000000000000003
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff81003ef4a0d8
RBP: ffff81003f61fb60 R08: 0000000000000002 R09: 0000000000000001
R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000000
R13: 00000000ffffffea R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff80652000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000201000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo ffff81003f61e000, task ffff810037ff0040)
Stack:  ffff81003f61fb60 ffff81003ef4a0d8 0000000000000001 ffff81003ef4a0d8
  ffff81003f61fb90 ffffffff80433b11 ffffffff805d0e80 ffff81003f61fc20
  0000000000000000 ffff81003ef4a0d8 ffff81003f61fbc0 ffffffff80434278
Call Trace:
  [<ffffffff80433b11>] __cpufreq_governor+0x51/0x9b
  [<ffffffff80434278>] __cpufreq_set_policy+0xf8/0x13b
  [<ffffffff804343e9>] cpufreq_set_policy+0x3c/0x93
  [<ffffffff80435125>] cpufreq_add_dev+0x315/0x427
  [<ffffffff803b6f87>] sysdev_driver_register+0x87/0xdb
  [<ffffffff80434a8e>] cpufreq_register_driver+0x9e/0x120
  [<ffffffff806837b2>] acpi_cpufreq_init+0xbe/0xc9
  [<ffffffff802666c0>] init+0x160/0x31c
  [<ffffffff8025deb8>] child_rip+0xa/0x12


Code: 0f 0b eb fe 48 c7 c7 20 13 5d 80 e8 a6 c8 e2 ff 48 8d bb 28
RIP  [<ffffffff80435299>] cpufreq_governor_userspace+0x4e/0x1aa
  RSP <ffff81003f61fb40>
  <0>Kernel panic - not syncing: Attempted to kill init!
  <0>Rebooting in 60 seconds..

I've put the full config up at 
http://www.reub.net/files/kernel/configs/2.6.19-rc5-mm1-brokencpufreq

Disable cpufreq in the config and the kernel otherwise boots and works fine.

Reuben

