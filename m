Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVDXOj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVDXOj4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 10:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVDXOj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 10:39:56 -0400
Received: from darkside.froggycorp.com ([213.41.129.184]:31369 "HELO
	froggycorp.com") by vger.kernel.org with SMTP id S262333AbVDXOjd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 10:39:33 -0400
Message-ID: <426BAFF2.54160A91@froggycorp.com>
Date: Sun, 24 Apr 2005 16:40:50 +0200
From: "Froggy / Froggy Corp." <froggy@froggycorp.com>
Organization: .oO Froggy Corporation Oo.
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Memory problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I just see a memory problem : i have 1Gb install on my computer and only
275Mb are available when i take a look with "free".
I use kernel 2.6.10, the bios tell me that i really have 1Gb (2*512
DDR), the kernel have 4Gb option enable, so i dont understand.

If someone have an idea.

Thx in advance for any help,
Regards,

Here is some information :
-------------------------------------------------------------------------
Odyssee:~# free
             total       used       free     shared    buffers    
cached
Mem:        275896      51932     223964          0       2976     
23952
-/+ buffers/cache:      25004     250892
Swap:      8433976          0    8433976
-------------------------------------------------------------------------
Odyssee:~# cat /proc/meminfo 
MemTotal:       275896 kB
MemFree:        223516 kB
Buffers:          3124 kB
Cached:          24008 kB
SwapCached:          0 kB
Active:          20620 kB
Inactive:        14740 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       275896 kB
LowFree:        223516 kB
SwapTotal:     8433976 kB
MemTotal:       275896 kB
MemFree:        223516 kB
Buffers:          3124 kB
Cached:          24008 kB
SwapCached:          0 kB
Active:          20620 kB
Inactive:        14740 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       275896 kB
LowFree:        223516 kB
SwapTotal:     8433976 kB
SwapFree:      8433976 kB
Dirty:               4 kB
Writeback:           0 kB
Mapped:          15944 kB
Slab:            10680 kB
CommitLimit:   8571924 kB
Committed_AS:   517448 kB
PageTables:        732 kB
VmallocTotal:   745464 kB
VmallocUsed:      4484 kB
VmallocChunk:   740696 kB
-------------------------------------------------------------------------
Linux version 2.6.10 (root@Odyssee) (gcc version 3.3.5 (Debian
1:3.3.5-12)) #3 S
MP Sun Apr 24 16:00:50 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
 BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000011340400 (usable)
 BIOS-e820: 0000000011340400 - 0000000011343400 (ACPI NVS)
 BIOS-e820: 0000000011343400 - 0000000011350400 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009d800 (usable)
 user: 000000000009d800 - 00000000000a0000 (reserved)
 user: 00000000000f0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 0000000011340400 (usable)
 user: 0000000011340400 - 0000000011343400 (ACPI NVS)
 user: 0000000011343400 - 0000000011350400 (ACPI data)
 user: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
275MB LOWMEM available.
found SMP MP-table at 000f5650
On node 0 totalpages: 70464
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 66368 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 IntelR                                ) @ 0x000f7110
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x3fff3000
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x3fff3040
ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x3fff7280
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000e) @
0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec10000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 32, address 0xfec10000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=linux ro root=901 mem=1024M
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec10000)
Initializing CPU#0
CPU 0 irqstacks, hard=c03c1000 soft=c03bf000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2800.832 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 275576k/281856k available (1828k kernel code, 5752k reserved,
769k data,
 188k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 5537.79 BogoMIPS (lpj=2768896)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 03
per-CPU timeslice cutoff: 2926.38 usecs.
task migration cache decay timeout: 3 msecs.
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=c03c2000 soft=c03c0000
Initializing CPU#1
Calibrating delay loop... 5586.94 BogoMIPS (lpj=2793472)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 03
Total of 2 processors activated (11124.73 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0:
 domain 0: span 3
  groups: 1 2
  domain 1: span 3
   groups: 3
CPU1:
 domain 0: span 3
  groups: 2 1
  domain 1: span 3
   groups: 3
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xface0, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HRB_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 *9 10 11 12 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
audit: initializing netlink socket (disabled)
audit(1114353108.896:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
ttyS3 at I/O 0x2e8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Intel(R) PRO/1000 Network Driver - version 5.5.4-k2
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:01:01.0[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:01:01.0 to 64
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:03:02.0[A] -> GSI 17 (level, low) -> IRQ 17
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
Probing IDE interface ide0...
Probing IDE interface ide1...
ide1: Wait for ready failed before probe !
hdd: FX600S, ATAPI CD/DVD-ROM drive
ide2: I/O resource 0x3EE-0x3EE not free.
ide2: ports already in use, skipping probe
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
elevator: using anticipatory as default io scheduler
ide1 at 0x170-0x177,0x376 on irq 15
libata version 1.10 loaded.
sata_sil version 0.8
ACPI: PCI interrupt 0000:03:03.0[A] -> GSI 20 (level, low) -> IRQ 20
ata1: SATA max UDMA/100 cmd 0xD2002080 ctl 0xD200208A bmdma 0xD2002000
irq 20
ata2: SATA max UDMA/100 cmd 0xD20020C0 ctl 0xD20020CA bmdma 0xD2002008
irq 20
ata3: SATA max UDMA/100 cmd 0xD2002280 ctl 0xD200228A bmdma 0xD2002200
irq 20
ata4: SATA max UDMA/100 cmd 0xD20022C0 ctl 0xD20022CA bmdma 0xD2002208
irq 20
ata1: no device found (phy stat 00000000)
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
ata3: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e8 86:3c02 87:4023
88:203f
ata3: dev 0 ATA, max UDMA/100, 321672960 sectors: lba48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_sil
ata4: no device found (phy stat 00000000)
scsi3 : sata_sil
  Vendor: ATA       Model: HDS722516VLSA80   Rev: V34O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi2, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
md: raid1 personality registered as nr 3
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
ACPI wakeup devices: 
PCI0 CSAD HUB0 UAR1 UAR2 USB0 USB1 USBE MODM 
ACPI: (supports S0 S1 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sda7 ...
md:  adding sda7 ...
md: sda6 has different UUID to sda7
md: sda5 has different UUID to sda7
md: sda3 has different UUID to sda7
md: sda2 has different UUID to sda7
md: sda1 has different UUID to sda7
md: created md5
md: bind<sda7>
md: running: <sda7>
raid1: raid set md5 active with 1 out of 2 mirrors
md: considering sda6 ...
md:  adding sda6 ...
md: sda5 has different UUID to sda6
md: sda3 has different UUID to sda6
md: sda2 has different UUID to sda6
md: sda1 has different UUID to sda6
md: created md4
md: bind<sda6>
md: running: <sda6>
raid1: raid set md4 active with 1 out of 2 mirrors
md: considering sda5 ...
md:  adding sda5 ...
md: sda3 has different UUID to sda5
md: sda2 has different UUID to sda5
md: sda1 has different UUID to sda5
md: created md3
md: bind<sda5>
md: running: <sda5>
raid1: raid set md3 active with 1 out of 2 mirrors
md: considering sda3 ...
md:  adding sda3 ...
md: sda2 has different UUID to sda3
md: sda1 has different UUID to sda3
md: created md2
md: bind<sda3>
md: running: <sda3>
raid1: raid set md2 active with 1 out of 2 mirrors
md: considering sda2 ...
md:  adding sda2 ...
md: sda1 has different UUID to sda2
md: created md1
md: bind<sda2>
md: running: <sda2>
raid1: raid set md1 active with 1 out of 2 mirrors
md: considering sda1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: running: <sda1>
raid1: raid set md0 active with 1 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 188k freed
Adding 8433976k swap on /dev/md5.  Priority:-1 extents:1
EXT3 FS on md1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex

------------------------------------------------------------
