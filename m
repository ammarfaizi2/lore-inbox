Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWGSLHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWGSLHS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 07:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWGSLHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 07:07:18 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:29157 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S932302AbWGSLHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 07:07:16 -0400
Date: Wed, 19 Jul 2006 13:04:39 +0200
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc2 tg3  Dead loop on netdevice eth0 fix it urgently!
Message-ID: <20060719110439.GJ23431@puettmann.net>
References: <20060719090407.GI23431@puettmann.net> <1153306545.2702.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XBg9NAhDNArbJUtw"
Content-Disposition: inline
In-Reply-To: <1153306545.2702.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *1G39r5-0007qq-00*MkPLtwoN.vI* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XBg9NAhDNArbJUtw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 19, 2006 at 11:55:45AM +0100, Sergio Monteiro Basto wrote:
> I also have this same problem 
> dmesg | grep -i lost 
> have you lost tickets ? 

no no lost tickets. 
dmesg is attached.
 
> You may open a bug in bugzilla http://bugme.osdl.org/ and include your
> dmesg 
> 

Yes But in the moment I thing  I have not enough informations.

        Ruben

-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net

--XBg9NAhDNArbJUtw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="dmesg.txt"
Content-Transfer-Encoding: quoted-printable

Bootdata ok (command line is auto BOOT_IMAGE=3Dlinux ro root=3D6801)
Linux version 2.6.18-rc2 (root@test) (gcc-Version 4.0.4 20060507 (prereleas=
e) (Debian 4.0.3-3)) #1 SMP Mon Jul 17 16:01:49 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000f57f6800 (usable)
 BIOS-e820: 00000000f57f6800 - 00000000f5800000 (ACPI data)
 BIOS-e820: 00000000fdc00000 - 00000000fdc01000 (reserved)
 BIOS-e820: 00000000fdc10000 - 00000000fdc11000 (reserved)
 BIOS-e820: 00000000fdc20000 - 00000000fdc21000 (reserved)
 BIOS-e820: 00000000fdc30000 - 00000000fdc31000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fec10000 - 00000000fec11000 (reserved)
 BIOS-e820: 00000000fec20000 - 00000000fec21000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 00000003fffff000 (usable)
DMI 2.3 present.
ACPI: RSDP (v002 HP                                    ) @ 0x00000000000f4f=
20
ACPI: XSDT (v001 HP     A01      0x00000002 =D2=04 0x0000162e) @ 0x00000000=
f57f6c00
ACPI: FADT (v003 HP     A01      0x00000002 =D2=04 0x0000162e) @ 0x00000000=
f57f6c80
ACPI: MADT (v001 HP     00000083 0x00000002  0x00000000) @ 0x00000000f57f69=
00
ACPI: SPCR (v001 HP     SPCRRBSU 0x00000001 =D2=04 0x0000162e) @ 0x00000000=
f57f6a00
ACPI: SRAT (v001 HP     A01      0x00000001  0x00000000) @ 0x00000000f57f6a=
80
ACPI: DSDT (v001 HP         DSDT 0x00000001 MSFT 0x02000001) @ 0x0000000000=
000000
SRAT: PXM 1 -> APIC 0 -> Node 0
SRAT: PXM 2 -> APIC 2 -> Node 1
SRAT: PXM 3 -> APIC 4 -> Node 2
SRAT: PXM 4 -> APIC 6 -> Node 3
SRAT: PXM 1 -> APIC 1 -> Node 0
SRAT: PXM 2 -> APIC 3 -> Node 1
SRAT: PXM 3 -> APIC 5 -> Node 2
SRAT: PXM 4 -> APIC 7 -> Node 3
SRAT: Node 0 PXM 1 0-100000000
SRAT: Node 1 PXM 2 100000000-200000000
SRAT: Node 2 PXM 3 200000000-300000000
SRAT: Node 3 PXM 4 300000000-400000000
NUMA: Using 32 for the hash shift.
Bootmem setup node 0 0000000000000000-0000000100000000
Bootmem setup node 1 0000000100000000-0000000200000000
Bootmem setup node 2 0000000200000000-0000000300000000
Bootmem setup node 3 0000000300000000-00000003fffff000
On node 0 totalpages: 989760
  DMA zone: 2578 pages, LIFO batch:0
  DMA32 zone: 987182 pages, LIFO batch:31
On node 1 totalpages: 1034240
  Normal zone: 1034240 pages, LIFO batch:31
On node 2 totalpages: 1034240
  Normal zone: 1034240 pages, LIFO batch:31
On node 3 totalpages: 1034240
  Normal zone: 1034240 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x908
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] enabled)
Processor #4 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
Processor #6 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Processor #3 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] enabled)
Processor #5 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
Processor #7 15:1 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x05] address[0xfec10000] gsi_base[24])
IOAPIC[1]: apic_id 5, version 17, address 0xfec10000, GSI 24-27
ACPI: IOAPIC (id[0x06] address[0xfec20000] gsi_base[28])
IOAPIC[2]: apic_id 6, version 17, address 0xfec20000, GSI 28-31
ACPI: IOAPIC (id[0x07] address[0xfdc00000] gsi_base[32])
IOAPIC[3]: apic_id 7, version 17, address 0xfdc00000, GSI 32-35
ACPI: IOAPIC (id[0x08] address[0xfdc10000] gsi_base[36])
IOAPIC[4]: apic_id 8, version 17, address 0xfdc10000, GSI 36-39
ACPI: IOAPIC (id[0x09] address[0xfdc20000] gsi_base[40])
IOAPIC[5]: apic_id 9, version 17, address 0xfdc20000, GSI 40-43
ACPI: IOAPIC (id[0x0a] address[0xfdc30000] gsi_base[44])
IOAPIC[6]: apic_id 10, version 17, address 0xfdc30000, GSI 44-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at f6000000 (gap: f5800000:8400000)
Built 4 zonelists.  Total pages: 4092480
Kernel command line: auto BOOT_IMAGE=3Dlinux ro root=3D6801
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 2599.929 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Checking aperture...
CPU 0: aperture @ 8000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Memory: 16278800k/16777212k available (2232k kernel code, 325952k reserved,=
 1233k data, 196k init)
Calibrating delay using timer specific routine.. 5205.81 BogoMIPS (lpj=3D10=
411628)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
Freeing SMP alternatives: 24k freed
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12499677
Detected 12.499 MHz APIC timer.
Booting processor 1/8 APIC 0x2
Initializing CPU#1
Calibrating delay using timer specific routine.. 5200.27 BogoMIPS (lpj=3D10=
400550)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1/2 -> Node 1
CPU: Physical Processor ID: 1
CPU: Processor Core ID: 0
AMD Opteron (tm) Processor 885 stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 2 cycles, maxerr 1036 cycles)
Booting processor 2/8 APIC 0x4
Initializing CPU#2
Calibrating delay using timer specific routine.. 5200.23 BogoMIPS (lpj=3D10=
400477)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2/4 -> Node 2
CPU: Physical Processor ID: 2
CPU: Processor Core ID: 0
AMD Opteron (tm) Processor 885 stepping 02
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -3 cycles, maxerr 1782 cycles)
Booting processor 3/8 APIC 0x6
Initializing CPU#3
Calibrating delay using timer specific routine.. 5200.21 BogoMIPS (lpj=3D10=
400435)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3/6 -> Node 3
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
AMD Opteron (tm) Processor 885 stepping 02
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 1029 cycles)
Booting processor 4/8 APIC 0x1
Initializing CPU#4
Calibrating delay using timer specific routine.. 5200.25 BogoMIPS (lpj=3D10=
400513)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 4/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Opteron (tm) Processor 885 stepping 02
CPU 4: Syncing TSC to CPU 0.
CPU 4: synchronized TSC with CPU 0 (last diff -1 cycles, maxerr 1005 cycles)
Booting processor 5/8 APIC 0x3
Initializing CPU#5
Calibrating delay using timer specific routine.. 5200.15 BogoMIPS (lpj=3D10=
400308)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 5/3 -> Node 1
CPU: Physical Processor ID: 1
CPU: Processor Core ID: 1
AMD Opteron (tm) Processor 885 stepping 02
CPU 5: Syncing TSC to CPU 0.
CPU 5: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 1036 cycles)
Booting processor 6/8 APIC 0x5
Initializing CPU#6
Calibrating delay using timer specific routine.. 5200.29 BogoMIPS (lpj=3D10=
400597)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 6/5 -> Node 2
CPU: Physical Processor ID: 2
CPU: Processor Core ID: 1
AMD Opteron (tm) Processor 885 stepping 02
CPU 6: Syncing TSC to CPU 0.
CPU 6: synchronized TSC with CPU 0 (last diff -238 cycles, maxerr 1320 cycl=
es)
Booting processor 7/8 APIC 0x7
Initializing CPU#7
Calibrating delay using timer specific routine.. 5200.20 BogoMIPS (lpj=3D10=
400419)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 7/7 -> Node 3
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 1
AMD Opteron (tm) Processor 885 stepping 02
CPU 7: Syncing TSC to CPU 0.
CPU 7: synchronized TSC with CPU 0 (last diff -1 cycles, maxerr 1028 cycles)
Brought up 8 CPUs
testing NMI watchdog ... OK.
migration_cost=3D436,535
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [HP    ] OemTableId [   SSD=
T0] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [HP    ] OemTableId [   SSD=
T1] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [HP    ] OemTableId [   SSD=
T2] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [HP    ] OemTableId [   SSD=
T3] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [HP    ] OemTableId [   SSD=
T4] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [HP    ] OemTableId [   SSD=
T5] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [HP    ] OemTableId [   SSD=
T6] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [HP    ] OemTableId [   SSD=
T7] [20060707]
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [CFG0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:03.0
ACPI: PCI Interrupt Routing Table [\_SB_.CFG0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.CFG0.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.CFG0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.CFG0.PCI2._PRT]
ACPI: PCI Root Bridge [CFG1] (0000:04)
PCI: Probing PCI hardware (bus 04)
ACPI: PCI Interrupt Routing Table [\_SB_.CFG1.PCI3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.CFG1.PCI4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.CFG1.PCI5._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.CFG1.PCI6._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 *7 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *5 7 10 11)
AMD768 RNG detected
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
PCI: Bridge: 0000:00:03.0
  IO window: 4000-4fff
  MEM window: f5f00000-f7dfffff
  PREFETCH window: f8000000-f80fffff
PCI: Bridge: 0000:00:07.0
  IO window: disabled.
  MEM window: f7e00000-f7efffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:08.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:04:09.0
  IO window: 5000-5fff
  MEM window: f7f00000-f7ffffff
  PREFETCH window: f8100000-f81fffff
PCI: Bridge: 0000:04:0a.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:04:0b.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:04:0c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
NET: Registered protocol family 2
IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
ACPI: Power Button (FF) [PWRF]
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
HP CISS Driver (v 2.6.10)
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:05:0d.0[A] -> GSI 32 (level, low) -> IRQ 169
cciss0: <0x3220> at PCI 0000:05:0d.0 IRQ 169 using DAC
      blocks=3D 143305920 block_size=3D 512
      heads=3D 255, sectors=3D 32, cylinders=3D 17562

      blocks=3D 429925920 block_size=3D 512
      heads=3D 255, sectors=3D 32, cylinders=3D 52687

      blocks=3D 143305920 block_size=3D 512
      heads=3D 255, sectors=3D 32, cylinders=3D 17562

 cciss/c0d0: p1 p2
      blocks=3D 429925920 block_size=3D 512
      heads=3D 255, sectors=3D 32, cylinders=3D 52687

 cciss/c0d1: p1
tg3.c:v3.62 (June 30, 2006)
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 25 (level, low) -> IRQ 177
eth0: Tigon3 [partno(N/A) rev 2100 PHY(5704)] (PCIX:100MHz:64-bit) 10/100/1=
000BaseT Ethernet 00:16:35:7c:ac:b3
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap=
[1]=20
eth0: dma_rwctrl[769f4000] dma_mask[64-bit]
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:02:06.1[B] -> GSI 24 (level, low) -> IRQ 185
eth1: Tigon3 [partno(N/A) rev 2100 PHY(5704)] (PCIX:100MHz:64-bit) 10/100/1=
000BaseT Ethernet 00:16:35:7c:ac:b2
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap=
[1]=20
eth1: dma_rwctrl[769f4000] dma_mask[64-bit]
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
AMD8111: IDE controller at PCI slot 0000:00:04.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:04.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:pio, hdb:pio
Probing IDE interface ide0...
hda: HL-DT-ST GCR-8240N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
rtc-test rtc-test.0: rtc intf: sysfs
rtc-test rtc-test.0: rtc intf: proc
rtc-test rtc-test.0: rtc intf: dev (254:0)
rtc-test rtc-test.0: rtc core: registered test as rtc0
rtc-test rtc-test.1: rtc intf: sysfs
rtc-test rtc-test.1: rtc intf: dev (254:1)
rtc-test rtc-test.1: rtc core: registered test as rtc1
input: PS/2 Generic Mouse as /class/input/input1
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
rtc-test rtc-test.0: setting the system clock to 2006-07-18 08:58:07 (11532=
13087)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 196k freed
Adding 2317432k swap on /dev/cciss/c0d0p2.  Priority:-1 extents:1 across:23=
17432k
EXT3 FS on cciss/c0d0p1, internal journal
PM: Writing back config space on device 0000:02:06.0 at offset b (was 16481=
4e4, writing d00e11)
PM: Writing back config space on device 0000:02:06.0 at offset 3 (was 80400=
0, writing 804010)
PM: Writing back config space on device 0000:02:06.0 at offset 2 (was 20000=
00, writing 2000010)
PM: Writing back config space on device 0000:02:06.0 at offset 1 (was 2b000=
00, writing 2b00146)
PM: Writing back config space on device 0000:02:06.1 at offset b (was 16481=
4e4, writing d00e11)
PM: Writing back config space on device 0000:02:06.1 at offset 3 (was 80400=
0, writing 804010)
PM: Writing back config space on device 0000:02:06.1 at offset 2 (was 20000=
00, writing 2000010)
PM: Writing back config space on device 0000:02:06.1 at offset 1 (was 2b000=
00, writing 2b00146)
tg3: eth0: Link is up at 1000 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
tg3: eth1: Link is up at 1000 Mbps, full duplex.
tg3: eth1: Flow control is off for TX and off for RX.
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 304 bytes per conntrack
device eth1 entered promiscuous mode
device eth1 left promiscuous mode
device eth1 entered promiscuous mode
device eth1 left promiscuous mode
device eth1 entered promiscuous mode
device eth1 left promiscuous mode
Dead loop on netdevice eth0, fix it urgently!
Dead loop on netdevice eth1, fix it urgently!
Dead loop on netdevice eth1, fix it urgently!
Dead loop on netdevice eth0, fix it urgently!

--XBg9NAhDNArbJUtw--
