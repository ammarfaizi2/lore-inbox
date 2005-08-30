Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVH3W4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVH3W4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVH3W4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:56:40 -0400
Received: from relay02.pair.com ([209.68.5.16]:28687 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S932246AbVH3W4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:56:39 -0400
X-pair-Authenticated: 67.187.99.138
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: Second "CPU" of 1-core HyperThreading CPU not found in 2.6.13
Date: Tue, 30 Aug 2005 17:56:49 -0500
User-Agent: KMail/1.8.1
References: <88056F38E9E48644A0F562A38C64FB6005950A6F@scsmsx403.amr.corp.intel.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6005950A6F@scsmsx403.amr.corp.intel.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508301756.50098.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Complete 'dmesg' please.

See below.

Thanks,
Chase


Linux version 2.6.13 (root@turbotaz) (gcc version 3.3.5-20050130 (Gentoo Linux 
3.3.5.20050130-r1, ssp-3.3.5.20050130-1, pie-8.7.7.1)) #2 SMP Sun Aug 28 
23:54:34 CDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffbe000 (ACPI data)
 BIOS-e820: 000000003ffbe000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000fb250
ACPI: RSDT (v001 A M I  OEMRSDT  0x11000429 MSFT 0x00000097) @ 0x3ffb0000
ACPI: FADT (v001 A M I  OEMFACP  0x11000429 MSFT 0x00000097) @ 0x3ffb0200
ACPI: OEMB (v001 A M I  AMI_OEM  0x11000429 MSFT 0x00000097) @ 0x3ffbe040
ACPI: MCFG (v001 A M I  OEMMCFG  0x11000429 MSFT 0x00000097) @ 0x3ffb6c70
ACPI: DSDT (v001  A0077 A0077001 0x00000001 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: DELUXE       APIC at: 0xFEE00000
Processor #0 15:4 APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at 40000000 (gap: 40000000:bfb80000)
Built 1 zonelists
Kernel command line: root=/dev/md1 noapic
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3212.948 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 902076k/917504k available (4249k kernel code, 14984k reserved, 1657k 
data, 268k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 6427.67 BogoMIPS 
(lpj=3213838)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 
0000441d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 0000441d 
00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 0000441d 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0cb8)
CPU0: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 01
Total of 1 processors activated (6427.67 BogoMIPS).
Brought up 1 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=4
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:04:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: cdf00000-cfffffff
  PREFETCH window: d0000000-dfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: d000-dfff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: c000-cfff
  MEM window: cde00000-cdefffff
  PREFETCH window: 40000000-400fffff
PCI: Bridge: 0000:00:1e.0
  IO window: b000-bfff
  MEM window: cdc00000-cddfffff
  PREFETCH window: 40100000-401fffff
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:01.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> 
IRQ 10
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> 
IRQ 10
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI Interrupt 0000:00:1c.1[B] -> Link [LNKB] -> GSI 4 (level, low) -> 
IRQ 4
PCI: Setting latency timer of device 0000:00:1c.1 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
pnp: 00:06: ioport range 0x290-0x297 has been reserved
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
audit: initializing netlink socket (disabled)
audit(1125294657.731:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
ACPI: PCI Interrupt 0000:00:01.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> 
IRQ 10
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> 
IRQ 10
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.1[B] -> Link [LNKB] -> GSI 4 (level, low) -> 
IRQ 4
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: CPU0 (power states: C1[C1])
ACPI: Processor [CPU1] (supports 8 throttling states)
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
hw_random: RNG not detected
[drm] Initialized drm 1.0.0 20040925
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
ub: sizeof ub_scsi_cmd 68 ub_dev 2412 ub_lun 140
usbcore: registered new driver ub
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 5 (level, low) -> 
IRQ 5
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
IT8212: IDE controller at PCI slot 0000:01:04.0
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:04.0[A] -> Link [LNKH] -> GSI 11 (level, low) -> 
IRQ 11
IT8212: chipset revision 19
it821x: controller in pass through mode.
IT8212: 100% native mode on irq 11
    ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [LNKF] -> GSI 7 (level, low) -> 
IRQ 7
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2902/04/10/15/20C/30C SCSI adapter>
        aic7850: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

  Vendor: PLEXTOR   Model: CD-R   PX-W124TS  Rev: 1.07
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:4: asynchronous.
 target0:0:4: Beginning Domain Validation
 target0:0:4: Domain Validation skipping write tests
 target0:0:4: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 8)
 target0:0:4: Ending Domain Validation
libata version 1.12 loaded.
ahci version 1.01
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKD] -> GSI 3 (level, low) -> 
IRQ 3
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl IDE mode
ahci(0000:00:1f.2) flags: 64bit ncq pm led slum part 
ata1: SATA max UDMA/133 cmd 0xF881ED00 ctl 0x0 bmdma 0x0 irq 3
ata2: SATA max UDMA/133 cmd 0xF881ED80 ctl 0x0 bmdma 0x0 irq 3
ata3: SATA max UDMA/133 cmd 0xF881EE00 ctl 0x0 bmdma 0x0 irq 3
ata4: SATA max UDMA/133 cmd 0xF881EE80 ctl 0x0 bmdma 0x0 irq 3
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 
88:203f
ata1: dev 0 ATA, max UDMA/100, 625142448 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi1 : ahci
ata2: dev 0 cfg 49:2f00 82:306b 83:7e01 84:4003 85:3069 86:3c01 87:4003 
88:203f
ata2: dev 0 ATA, max UDMA/100, 625142448 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi2 : ahci
ata3: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 
88:203f
ata3: dev 0 ATA, max UDMA/100, 625142448 sectors: lba48
ata3: dev 0 configured for UDMA/100
scsi3 : ahci
ata4: dev 0 cfg 49:2f00 82:306b 83:7e01 84:4003 85:3069 86:3c01 87:4003 
88:203f
ata4: dev 0 ATA, max UDMA/100, 625142448 sectors: lba48
ata4: dev 0 configured for UDMA/100
scsi4 : ahci
  Vendor: ATA       Model: WDC WD3200JD-00K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD3200JD-60K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD3200JD-00K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD3200JD-60K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3
Attached scsi disk sdc at scsi3, channel 0, id 0, lun 0
SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1 sdd2 sdd3
Attached scsi disk sdd at scsi4, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 4, lun 0,  type 5
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg3 at scsi3, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg4 at scsi4, channel 0, id 0, lun 0,  type 0
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:00:1d.7[A] -> Link [LNKH] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 11, io mem 0xcdbff800
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKH] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 11, io base 0x00009880
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 3 (level, low) -> 
IRQ 3
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 3, io base 0x00009c00
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 5 (level, low) -> 
IRQ 5
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 5, io base 0x0000a000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> Link [LNKA] -> GSI 10 (level, low) -> 
IRQ 10
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #4
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 10, io base 0x0000a080
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 1-1: new high speed USB device using ehci_hcd and address 2
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
usb 1-6: new high speed USB device using ehci_hcd and address 6
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usb 3-1: new low speed USB device using uhci_hcd and address 2
usb 3-2: new full speed USB device using uhci_hcd and address 3
usbcore: registered new driver hiddev
usb 4-1: new low speed USB device using uhci_hcd and address 2
input: USB HID v1.10 Keyboard [Key Tronic Keytronic USB Keyboard] on 
usb-0000:00:1d.1-1
hiddev96: USB HID v1.10 Device [American Power Conversion Back-UPS BR  800 
FW:9.o2 .D USB FW:o2] on usb-0000:00:1d.2-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
I2O subsystem v1.288
i2o: max drivers = 8
I2O Configuration OSM v1.248
I2O Bus Adapter OSM v$Rev$
I2O Block Device OSM v1.287
I2O SCSI Peripheral OSM v1.282
I2O ProcFS OSM v1.145
i2c /dev entries driver
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid10 personality registered as nr 9
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  5040.000 MB/sec
raid5: using function: pIII_sse (5040.000 MB/sec)
raid6: int32x1    906 MB/s
raid6: int32x2    976 MB/s
raid6: int32x4    781 MB/s
raid6: int32x8    605 MB/s
usb 1-1.1: new low speed USB device using ehci_hcd and address 7
raid6: mmxx1     1945 MB/s
raid6: mmxx2     2246 MB/s
raid6: sse1x1    1125 MB/s
raid6: sse1x2    1277 MB/s
raid6: sse2x1    2238 MB/s
raid6: sse2x2    2390 MB/s
raid6: using algorithm sse2x2 (2390 MB/s)
md: raid6 personality registered as nr 8
md: multipath personality registered as nr 7
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
device-mapper: dm-multipath version 1.0.4 loaded
device-mapper: dm-round-robin version 1.0.0 loaded
device-mapper: dm-emc version 0.0.3 loaded
padlock: VIA PadLock not detected.
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (7168 buckets, 57344 max) - 248 bytes per conntrack
usb 1-1.2: new low speed USB device using ehci_hcd and address 8
input: USB HID v1.00 Mouse [USB Mouse] on usb-0000:00:1d.7-1.2
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/projects/ipt_recent/
ClusterIP Version 0.7 loaded successfully
arp_tables: (C) 2002 David S. Miller
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0652bc0(lo)
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
registering ipv6 mark target
NET: Registered protocol family 17
NET: Registered protocol family 15
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdd3 ...
md:  adding sdd3 ...
md: sdd1 has different UUID to sdd3
md:  adding sdc3 ...
md: sdc1 has different UUID to sdd3
md:  adding sdb3 ...
md: sdb1 has different UUID to sdd3
md:  adding sda3 ...
md: sda1 has different UUID to sdd3
md: created md1
md: bind<sda3>
md: bind<sdb3>
md: bind<sdc3>
md: bind<sdd3>
md: running: <sdd3><sdc3><sdb3><sda3>
raid10: raid set md1 active with 4 out of 4 devices
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: running: <sdd1><sdc1><sdb1><sda1>
raid1: raid set md0 active with 4 out of 4 mirrors
md: ... autorun DONE.
ReiserFS: md1: found reiserfs format "3.6" with standard journal
ReiserFS: md1: using ordered data mode
ReiserFS: md1: journal params: device md1, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md1: checking transaction log (md1)
ReiserFS: md1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 268k freed
Adding 1004052k swap on /dev/sda2.  Priority:-1 extents:1
Adding 1004052k swap on /dev/sdb2.  Priority:-2 extents:1
Adding 1004052k swap on /dev/sdc2.  Priority:-3 extents:1
Adding 1004052k swap on /dev/sdd2.  Priority:-4 extents:1
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:04:00.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> 
IRQ 10
PCI: Setting latency timer of device 0000:04:00.0 to 64
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7667  Fri Jun 17 
07:01:04 PDT 2005
ACPI: PCI Interrupt 0000:00:1b.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> 
IRQ 10
PCI: Setting latency timer of device 0000:00:1b.0 to 64
eth0: register usbnet at usb-0000:00:1d.7-6, Netgear FA-120 USB Ethernet, 
00:09:5b:e0:77:33
usbcore: registered new driver usbnet
eth0: no IPv6 routers present
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKB] -> GSI 4 (level, low) -> 
IRQ 4
sk98lin: Network Device Driver v8.23.1.3
(C)Copyright 1999-2005 Marvell(R).
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKB] -> GSI 4 (level, low) -> 
IRQ 4
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth1: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
usb 1-1.1: USB disconnect, address 7
usb 1-1.1: new low speed USB device using ehci_hcd and address 9
eth1: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        none
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth1: no IPv6 routers present
usbcore: deregistering driver usbnet
eth0: unregister usbnet usb-0000:00:1d.7-6, Netgear FA-120 USB Ethernet
usb 1-6: USB disconnect, address 6
eth1: network connection down
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKB] -> GSI 4 (level, low) -> 
IRQ 4
sk98lin: Network Device Driver v8.23.1.3
(C)Copyright 1999-2005 Marvell(R).
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKB] -> GSI 4 (level, low) -> 
IRQ 4
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        none
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        none
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: no IPv6 routers present
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        none
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: no IPv6 routers present
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        none
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: no IPv6 routers present
