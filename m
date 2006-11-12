Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753164AbWKLUoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbWKLUoq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 15:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753168AbWKLUoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 15:44:46 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:55015 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S1753164AbWKLUoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 15:44:44 -0500
Message-ID: <455787B7.1090401@scientia.net>
Date: Sun, 12 Nov 2006 21:44:39 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: unexplainable read errors, copy/diff-issue
References: <4553DD90.1090604@scientia.net> <20061110135649.16cccca0.vsu@altlinux.ru>
In-Reply-To: <20061110135649.16cccca0.vsu@altlinux.ru>
Content-Type: multipart/mixed;
 boundary="------------070609000108070501080902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070609000108070501080902
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sergey Vlasov wrote:
> So you have 4GB RAM, and most likely some memory is remapped above the
> 4GB address boundary.  Could you show the full dmesg output after boot?
Here it comes :)


I'll try the other things this night or tomorrow :)

Regards,
Chris.


Bootdata ok (command line is root=/dev/sda1 ro snd-ice1724.index=0
snd-intel8x0.index=1 )
Linux version 2.6.18 () (root@euler) (gcc version 4.1.2 20061028
(prerelease) (Debian 4.1.1-19)) #1 SMP PREEMPT Fri Nov 10 01:18:51 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b000 (usable)
 BIOS-e820: 000000000009b000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000da000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff80000 (usable)
 BIOS-e820: 000000007ff80000 - 000000007ff91000 (ACPI data)
 BIOS-e820: 000000007ff91000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 0000000080000000 - 000000009ff80000 (usable)
 BIOS-e820: 000000009ff80000 - 00000000a0000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000160000000 (usable)
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @
0x00000000000f78f0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @
0x000000007ff8b258
ACPI: FADT (v001 NVIDIA CK8S     0x06040000 PTL_ 0x000f4240) @
0x000000007ff90b06
ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @
0x000000007ff90b7a
ACPI: MADT (v001 PTLTD       APIC   0x06040000  LTP 0x00000000) @
0x000000007ff90bca
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @
0x000000007ff90c68
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @
0x000000007ff90c90
ACPI: DSDT (v001 NVIDIA      CK8 0x06040000 MSFT 0x0100000e) @
0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 2
Node 0 using interleaving mode 1/0
No NUMA configuration found
Faking a node at 0000000000000000-0000000160000000
Bootmem setup node 0 0000000000000000-0000000160000000
On node 0 totalpages: 1027242
  DMA zone: 2674 pages, LIFO batch:0
  DMA32 zone: 636728 pages, LIFO batch:31
  Normal zone: 387840 pages, LIFO batch:31
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Processor #3 15:1 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x05] address[0xd0000000] gsi_base[24])
IOAPIC[1]: apic_id 5, version 17, address 0xd0000000, GSI 24-27
ACPI: IOAPIC (id[0x06] address[0xd0001000] gsi_base[28])
IOAPIC[2]: apic_id 6, version 17, address 0xd0001000, GSI 28-31
ACPI: IOAPIC (id[0x07] address[0xd0800000] gsi_base[32])
IOAPIC[3]: apic_id 7, version 17, address 0xd0800000, GSI 32-55
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at a4000000 (gap: a0000000:40000000)
Built 1 zonelists.  Total pages: 1027242
Kernel command line: root=/dev/sda1 ro snd-ice1724.index=0
snd-intel8x0.index=1
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 2210.208 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Checking aperture...
CPU 0: aperture @ ac000000 size 64 MB
CPU 1: aperture @ ac000000 size 64 MB
Memory: 4102504k/5767168k available (3007k kernel code, 90372k reserved,
1245k data, 216k init)
Calibrating delay using timer specific routine.. 4422.26 BogoMIPS
(lpj=2211131)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
Freeing SMP alternatives: 32k freed
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12558021
Detected 12.558 MHz APIC timer.
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4419.78 BogoMIPS
(lpj=2209893)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
Dual Core AMD Opteron(tm) Processor 275 stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 2 cycles, maxerr 581 cycles)
Booting processor 2/4 APIC 0x2
Initializing CPU#2
Calibrating delay using timer specific routine.. 4419.79 BogoMIPS
(lpj=2209899)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2/2 -> Node 0
CPU: Physical Processor ID: 1
CPU: Processor Core ID: 0
Dual Core AMD Opteron(tm) Processor 275 stepping 02
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -234 cycles, maxerr 878
cycles)
Booting processor 3/4 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 4419.73 BogoMIPS
(lpj=2209865)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3/3 -> Node 0
CPU: Physical Processor ID: 1
CPU: Processor Core ID: 1
Dual Core AMD Opteron(tm) Processor 275 stepping 02
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -121 cycles, maxerr 1076
cycles)
Brought up 4 CPUs
testing NMI watchdog ... OK.
migration_cost=380
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:02:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 16 17 18 19) *0
ACPI: PCI Interrupt Link [LNK2] (IRQs 16 17 18 19) *0
ACPI: PCI Interrupt Link [LNK3] (IRQs 16 17 18 19) *0
ACPI: PCI Interrupt Link [LNK4] (IRQs 16 17 18 19) *0
ACPI: PCI Interrupt Link [LNK5] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LMCI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LPID] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LSI1] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Root Bridge [PCI2] (0000:10)
PCI: Probing PCI hardware (bus 10)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2.G0PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2.G0PB._PRT]
ACPI: PCI Root Bridge [PCI1] (0000:80)
PCI: Probing PCI hardware (bus 80)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.XVR0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 48 49 50 51) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 48 49 50 51) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 48 49 50 51) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 48 49 50 51) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 48 49 50 51) *0, disabled.
ACPI: PCI Interrupt Link [LUS0] (IRQs 52 53 54 55) *0, disabled.
ACPI: PCI Interrupt Link [LUS2] (IRQs 52 53 54 55) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs 52 53 54 55) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 52 53 54 55) *0, disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 52 53 54 55) *0, disabled.
ACPI: PCI Interrupt Link [LPID] (IRQs 52 53 54 55) *0, disabled.
ACPI: PCI Interrupt Link [LTID] (IRQs 52 53 54 55) *0, disabled.
ACPI: PCI Interrupt Link [LSI1] (IRQs 52 53 54 55) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ ac000000 size 65536 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
pnp: 00:02: ioport range 0x8000-0x807f could not be reserved
pnp: 00:02: ioport range 0x8080-0x80ff has been reserved
pnp: 00:02: ioport range 0x8400-0x847f has been reserved
pnp: 00:02: ioport range 0x8480-0x84ff has been reserved
pnp: 00:02: ioport range 0x8800-0x887f has been reserved
pnp: 00:02: ioport range 0x8880-0x88ff has been reserved
pnp: 00:02: ioport range 0xa000-0xa03f has been reserved
pnp: 00:02: ioport range 0xa040-0xa07f has been reserved
PCI: Bridge: 0000:00:09.0
  IO window: disabled.
  MEM window: b0100000-b01fffff
  PREFETCH window: disabled.
PCI: Failed to allocate mem resource #6:20000@d0000000 for 0000:02:00.0
PCI: Bridge: 0000:00:0e.0
  IO window: 2000-2fff
  MEM window: b1000000-b2ffffff
  PREFETCH window: c0000000-cfffffff
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
PCI: Bridge: 0000:10:0a.0
  IO window: 3000-3fff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:10:0b.0
  IO window: 4000-4fff
  MEM window: d0100000-d05fffff
  PREFETCH window: a4000000-a41fffff
PCI: Bridge: 0000:80:0e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:80:0e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
audit: initializing netlink socket (disabled)
audit(1163360476.201:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
PCI: Setting latency timer of device 0000:80:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:80:0e.0:pcie00]
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
nbd: registered device at major 43
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.56.
ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 23
GSI 16 sharing vector 0xC9 and IRQ 16
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LMAC] -> GSI 23 (level,
high) -> IRQ 201
PCI: Setting latency timer of device 0000:00:0a.0 to 64
forcedeth: using HIGHDMA
eth0: forcedeth.c: subsystem: 010f1:2895 bound to 0000:00:0a.0
ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 55
GSI 17 sharing vector 0xD1 and IRQ 17
ACPI: PCI Interrupt 0000:80:0a.0[A] -> Link [LMAC] -> GSI 55 (level,
high) -> IRQ 209
PCI: Setting latency timer of device 0000:80:0a.0 to 64
forcedeth: using HIGHDMA
eth1: forcedeth.c: subsystem: 010f1:2895 bound to 0000:80:0a.0
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Linux video capture interface: v2.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 242
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
    ide0: BM-DMA at 0x1c00-0x1c07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x1c08-0x1c0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: IC35L120AVV207-1, ATA DISK drive
hdb: PLEXTOR DVDR PX-760A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 512KiB
hda: 241254720 sectors (123522 MB) w/7965KiB Cache, CHS=16383/255/63,
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdb: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
Loading iSCSI transport class v1.1-646.<7>libata version 2.00 loaded.
sata_nv 0000:00:07.0: version 2.0
ACPI: PCI Interrupt Link [LTID] enabled at IRQ 22
GSI 18 sharing vector 0xD9 and IRQ 18
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 22 (level,
high) -> IRQ 217
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0x1C40 ctl 0x1C36 bmdma 0x1C10 irq 217
ata2: SATA max UDMA/133 cmd 0x1C38 ctl 0x1C32 bmdma 0x1C18 irq 217
scsi0 : sata_nv
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : sata_nv
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
  Vendor: ATA       Model: HDT722525DLA380   Rev: V44O
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: HDT722525DLA380   Rev: V44O
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: PCI Interrupt Link [LSI1] enabled at IRQ 21
GSI 19 sharing vector 0xE1 and IRQ 19
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LSI1] -> GSI 21 (level,
high) -> IRQ 225
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0x1C58 ctl 0x1C4E bmdma 0x1C20 irq 225
ata4: SATA max UDMA/133 cmd 0x1C50 ctl 0x1C4A bmdma 0x1C28 irq 225
scsi2 : sata_nv
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : sata_nv
ata4: SATA link down (SStatus 0 SControl 300)
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
Fusion MPT base driver 3.04.01
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.04.01
GSI 20 sharing vector 0xE9 and IRQ 20
ACPI: PCI Interrupt 0000:12:06.0[A] -> GSI 30 (level, low) -> IRQ 233
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator,Target}
scsi4 : ioc0: LSI53C1030, FwRev=01032700h, Ports=1, MaxQ=255, IRQ=233
GSI 21 sharing vector 0x32 and IRQ 21
ACPI: PCI Interrupt 0000:12:06.1[B] -> GSI 31 (level, low) -> IRQ 50
mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator,Target}
scsi5 : ioc1: LSI53C1030, FwRev=01032700h, Ports=1, MaxQ=255, IRQ=50
Fusion MPT misc device (ioctl) driver 3.04.01
mptctl: Registered with Fusion MPT base driver
mptctl: /dev/mptctl @ (major,minor=10,220)
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 19
GSI 22 sharing vector 0x3A and IRQ 22
ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNK4] -> GSI 19 (level,
high) -> IRQ 58
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[58] 
MMIO=[b0104000-b01047ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ieee1394: raw1394: /dev/raw1394 device initialized
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 20
GSI 23 sharing vector 0x42 and IRQ 23
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUS2] -> GSI 20 (level,
high) -> IRQ 66
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: irq 66, io mem 0xb0001000
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ACPI: PCI Interrupt 0000:12:04.2[C] -> GSI 30 (level, low) -> IRQ 233
PCI: VIA IRQ fixup for 0000:12:04.2, from 5 to 9
ehci_hcd 0000:12:04.2: EHCI Host Controller
ehci_hcd 0000:12:04.2: new USB bus registered, assigned bus number 2
ehci_hcd 0000:12:04.2: irq 233, io mem 0xd0100000
ehci_hcd 0000:12:04.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUS0] -> GSI 23 (level,
high) -> IRQ 201
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:02.0: irq 201, io mem 0xb0000000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 10 ports detected
Initializing USB Mass Storage driver...
usb 2-1: new high speed USB device using ehci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
usb 3-2: new low speed USB device using ohci_hcd and address 2
usb 3-2: configuration #1 chosen from 1 choice
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e0810000238d2d]
usb 3-4: new full speed USB device using ohci_hcd and address 3
usb 3-4: configuration #1 chosen from 1 choice
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
input: Microsoft Natural® Ergonomic Keyboard 4000 as /class/input/input0
input: USB HID v1.11 Keyboard [Microsoft Natural® Ergonomic Keyboard
4000] on usb-0000:00:02.0-2
input: Microsoft Natural® Ergonomic Keyboard 4000 as /class/input/input1
input: USB HID v1.11 Device [Microsoft Natural® Ergonomic Keyboard 4000]
on usb-0000:00:02.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input2
i2c /dev entries driver
i2c_adapter i2c-0: nForce2 SMBus adapter at 0xa000
i2c_adapter i2c-1: nForce2 SMBus adapter at 0xa040
smsc47b397: found SMSC LPC47B397-NC (base address 0x0480, revision 1)
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised:
dm-devel@redhat.com
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22
13:55:50 2006 UTC).
ACPI: PCI Interrupt Link [LACI] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LACI] -> GSI 22 (level,
high) -> IRQ 217
PCI: Setting latency timer of device 0000:00:04.0 to 64
input: PS2++ Logitech MX Mouse as /class/input/input3
AC'97 0 analog subsections not ready
intel8x0_measure_ac97_clock: measured 51816 usecs
intel8x0: clocking to 46928
GSI 24 sharing vector 0x4A and IRQ 24
ACPI: PCI Interrupt 0000:11:04.0[A] -> GSI 24 (level, low) -> IRQ 74
usbcore: registered new driver snd-usb-audio
ALSA device list:
  #0: Terratec Aureon 7.1-Universe at 0x3080, irq 74
  #1: NVidia CK804 with AD1981B at 0xb0002000, irq 217
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 216k freed
EDAC MC: Ver: 2.0.1 Nov 10 2006
EDAC MC0: Giving out device to k8_edac Athlon64/Opteron: DEV 0000:00:18.2
EDAC MC1: Giving out device to k8_edac Athlon64/Opteron: DEV 0000:00:19.2
eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Adding 4882712k swap on /dev/hda6.  Priority:-1 extents:1 across:4882712k
EXT3 FS on sda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
NET: Registered protocol family 24
eth0: no IPv6 routers present
eth1: no IPv6 routers present
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 18
GSI 25 sharing vector 0x52 and IRQ 25
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNK3] -> GSI 18 (level,
high) -> IRQ 82
PCI: Setting latency timer of device 0000:02:00.0 to 64
NVRM: loading NVIDIA Linux x86_64 Kernel Module  1.0-8776  Mon Oct 16
21:53:43 PDT 2006
i2c_adapter i2c-2: SMBus Quick command not supported, can't probe for chips
i2c_adapter i2c-3: SMBus Quick command not supported, can't probe for chips
i2c_adapter i2c-4: SMBus Quick command not supported, can't probe for chips


--------------070609000108070501080902
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------070609000108070501080902--
