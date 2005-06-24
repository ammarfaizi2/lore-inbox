Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263293AbVFXSMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbVFXSMX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 14:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263217AbVFXSKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 14:10:32 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:19873 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263389AbVFXSHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 14:07:42 -0400
Date: Fri, 24 Jun 2005 14:07:52 -0400
From: Frank Peters <frank.peters@comcast.net>
To: linux-kernel@vger.kernel.org
Cc: Sean Bruno <sean.bruno@dsl-only.net>
Subject: Re: Asus MB and 2.6.12 Problems
Message-Id: <20050624140752.3d7a9093.frank.peters@comcast.net>
In-Reply-To: <1119633158.3180.5.camel@home-lap>
References: <20050624113404.198d254c.frank.peters@comcast.net>
	<1119633158.3180.5.camel@home-lap>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2005 10:12:38 -0700
Sean Bruno <sean.bruno@dsl-only.net> wrote:

> 
> Can you post the output of dmesg and lspci -vv please?
> 

Following the latest successful boot, with keyboard functioning
normally, here is the kernal log.

To save space, I deleted the "Jun 24 10:52:09 (none) kernel:"
that occurs before every line.

klogd 1.4.1, log source = /proc/kmsg started.
Inspecting /boot/System.map
Loaded 23754 symbols from /boot/System.map.
Symbols match kernel version 2.6.12.
No module symbols loaded - kernel modules not enabled. 
Linux version 2.6.12 (root@localhost.localdomain) (gcc version 2.95.3 20010315 (release)) #9 SMP Tue Jun 21 11:09:26 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffec000 (usable)
 BIOS-e820: 000000003ffec000 - 000000003ffef000 (ACPI data)
 BIOS-e820: 000000003ffef000 - 000000003ffff000 (reserved)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262124
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32748 pages, LIFO batch:15
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f52b0
ACPI: RSDT (v001 ASUS   P4B533   0x42302e31 MSFT 0x31313031) @ 0x3ffec000
ACPI: FADT (v001 ASUS   P4B533   0x42302e31 MSFT 0x31313031) @ 0x3ffec0c0
ACPI: BOOT (v001 ASUS   P4B533   0x42302e31 MSFT 0x31313031) @ 0x3ffec030
ACPI: MADT (v001 ASUS   P4B533   0x42302e31 MSFT 0x31313031) @ 0x3ffec058
ACPI: DSDT (v001   ASUS P4B533   0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 40000000:bec00000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6.12 ro root=302 pci=usepirqmask i8042.nomux
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3102.282 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035872k/1048496k available (1368k kernel code, 11864k reserved, 571k data, 408k init, 130992k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 6127.61 BogoMIPS (lpj=3063808)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.06GHz stepping 09
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay loop... 6193.15 BogoMIPS (lpj=3096576)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
CPU1: Intel(R) Pentium(R) 4 CPU 3.06GHz stepping 09
Total of 2 processors activated (12320.76 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0 attaching sched-domain:
 domain 0: span 03
  groups: 01 02
  domain 1: span 03
   groups: 03
CPU1 attaching sched-domain:
 domain 0: span 03
  groups: 02 01
  domain 1: span 03
   groups: 03
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1eb0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Enabled i801 SMBus device
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Simple Boot Flag at 0x3a set to 0x80
highmem bounce pool size: 64 pages
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 22 (level, low) -> IRQ 22
ttyS4 at I/O 0xb800 (irq = 22) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH4: chipset revision 1
ICH4: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: WDC WD800BB-00CAA1, ATA DISK drive
hdb: WDC WD300BB-32CCB0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: PLEXTOR DVDR PX-712A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
hdb: max request size: 128KiB
hdb: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=58168/16/63, UDMA(100)
hdb: cache flushes not supported
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hdb8 >
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
Starting balanced_irq
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 408k freed
Adding 1952992k swap on /dev/hda3.  Priority:-1 extents:1
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
Real Time Clock Driver v1.12
input: AT Translated Set 2 keyboard on isa0060/serio0
ACPI: PCI Interrupt 0000:02:0c.0[A] -> GSI 20 (level, low) -> IRQ 20
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:0c.0: 3Com PCI 3c900 Cyclone 10Mbps TPO at 0xa000. Vers LK1.1.19
NET: Registered protocol family 17
ACPI: PCI Interrupt 0000:02:0c.0[A] -> GSI 20 (level, low) -> IRQ 20


Following an unsuccessful boot, with the keyboard dead, the log is identical
except that the "input: AT Translated Set 2 keyboard on isa0060/serio0"
line does not appear.  During a successful boot up, with keyboard functional,
this line is liable to pop up in different places (on the terminal screen)
as if there is a variable lag in keyboard detection.

But there are never any obvious error messages of any kind.



Here is output from lspci -vv:

00:00.0 Class 0600: 8086:1a30 (rev 11)
	Subsystem: 1043:8088
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [e4] #09 [a104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 Class 0604: 8086:1a31 (rev 11)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: ee000000-efdfffff
	Prefetchable memory behind bridge: eff00000-fbffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 Class 0c03: 8086:24c2 (rev 01)
	Subsystem: 1043:8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at d800 [size=32]

00:1d.1 Class 0c03: 8086:24c4 (rev 01)
	Subsystem: 1043:8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at d400 [size=32]

00:1d.2 Class 0c03: 8086:24c7 (rev 01)
	Subsystem: 1043:8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 255
	Region 4: I/O ports at d000 [size=32]

00:1d.7 Class 0c03: 8086:24cd (rev 01) (prog-if 20)
	Subsystem: 1043:8089
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 9
	Region 0: Memory at ed800000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [2080]

00:1e.0 Class 0604: 8086:244e (rev 81)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000bfff
	Memory behind bridge: ec800000-ed7fffff
	Prefetchable memory behind bridge: efe00000-efefffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 Class 0601: 8086:24c0 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 Class 0101: 8086:24cb (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: 1043:8089
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at f000 [size=16]
	Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 Class 0c05: 8086:24c3 (rev 01)
	Subsystem: 1043:8089
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 0
	Region 4: I/O ports at e800 [size=32]

01:00.0 Class 0300: 10de:0185 (rev c1)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at effe0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

02:0a.0 Class 0780: 11c1:0480
	Subsystem: 11c1:5656
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at ed000000 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at b800 [size=256]
	Region 2: I/O ports at b400 [size=256]
	Region 3: I/O ports at b000 [size=8]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0b.0 Class 0401: 1102:0002 (rev 07)
	Subsystem: 1102:8071
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at a800 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0b.1 Class 0980: 1102:7002 (rev 07)
	Subsystem: 1102:0020
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at a400 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0c.0 Class 0200: 10b7:9004 (rev 04)
	Subsystem: 10b7:9004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 12000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at a000 [size=128]
	Region 1: Memory at ec800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-



Frank Peters

(Please CC at frank.peters@comcast.net because I am not a subscriber
to this list.)


