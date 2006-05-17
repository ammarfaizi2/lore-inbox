Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWEQHLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWEQHLm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 03:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWEQHLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 03:11:42 -0400
Received: from tassadar.physics.auth.gr ([155.207.123.25]:43992 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id S932456AbWEQHLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 03:11:41 -0400
Date: Wed, 17 May 2006 10:11:25 +0300 (EEST)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: events/0 eats 100% cpu on core duo laptop
In-Reply-To: <20060516165121.105315a8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0605171008020.739@tassadar.physics.auth.gr>
References: <Pine.LNX.4.64.0605162002150.9606@tassadar.physics.auth.gr>
 <20060516122303.48b14dc1.akpm@osdl.org> <Pine.LNX.4.64.0605170041570.16352@tassadar.physics.auth.gr>
 <20060516152256.34c2feea@localhost.localdomain> <20060516165121.105315a8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-838198917-675495676-1147849885=:739"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---838198917-675495676-1147849885=:739
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE


 =09I have just installed 2.6.17-rc4 and the problems I mentioned=20
have vanished. However I am now  flooded with messages during boot:

Linux version 2.6.17-rc4 (root@mitsos) (=DD=EA=E4=EF=F3=E7 gcc 3.3.6) #1 SM=
P PREEMPT Wed May 17 09:49:38 EEST 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001f660000 (usable)
  BIOS-e820: 000000001f660000 - 000000001f66b000 (ACPI data)
  BIOS-e820: 000000001f66b000 - 000000001f700000 (ACPI NVS)
  BIOS-e820: 000000001f700000 - 0000000020000000 (reserved)
  BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
  BIOS-e820: 00000000fec00000 - 00000000fed90000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
502MB LOWMEM available.
On node 0 totalpages: 128608
   DMA zone: 4096 pages, LIFO batch:0
   Normal zone: 124512 pages, LIFO batch:31
DMI 2.4 present.
ACPI: RSDP (v000 FUJ                                   ) @ 0x000f5b90
ACPI: RSDT (v001 FUJ    FJNB1AF  0x01100000 FUJ  0x00000100) @ 0x1f6632ac
ACPI: FADT (v001 FUJ    FJNB1AF  0x01100000 FUJ  0x00000100) @ 0x1f66af8c
ACPI: SSDT (v001 FUJ    FJNB1AF  0x01100000 MSFT 0x0100000e) @ 0x1f669e42
ACPI: MCFG (v001 FUJ    FJNB1AF  0x01100000 FUJ  0x00000100) @ 0x1f66a0a7
ACPI: SSDT (v001 FUJ    FJNB1AF  0x01100000 INTL 0x20050624) @ 0x1f66a0e3
ACPI: SSDT (v001 FUJ    FJNB1AF  0x01100000 INTL 0x20050624) @ 0x1f66ac93
ACPI: MADT (v001 FUJ    FJNB1AF  0x01100000  LTP 0x00000000) @ 0x1f66aec4
ACPI: HPET (v001 FUJ    FJNB1AF  0x01100000 FUJ  0x00000100) @ 0x1f66af2c
ACPI: BOOT (v001 FUJ    FJNB1AF  0x01100000 FUJ  0x00000100) @ 0x1f66af64
ACPI: DSDT (v001 FUJ    FJNB1AF  0x01100000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:14 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:14 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:d8000000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=3DLinux ro root=3D805
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 1663.504 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 504572k/514432k available (3167k kernel code, 9364k reserved, 1187k=
 data, 216k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok=
=2E
Calibrating delay using timer specific routine.. 3328.95 BogoMIPS (lpj=3D16=
64476)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000=
c1a9 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c=
1a9 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c1a9 00=
000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 20k freed
CPU0: Intel Genuine Intel(R) CPU           T2300  @ 1.66GHz stepping 08
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3324.58 BogoMIPS (lpj=3D16=
62294)
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000=
c1a9 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c=
1a9 00000000 00000000
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c1a9 00=
000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Genuine Intel(R) CPU           T2300  @ 1.66GHz stepping 08
Total of 2 processors activated (6653.54 BogoMIPS).
ENABLING IO-APIC IRQs
=2E.TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=3D1000
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area is not E820-reserved
PCI: Not using MMCONFIG.
PCI: BIOS BUG #81[000fdc70] found
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #09 (-#0c) is hidden behind transparent bridge #08 (-#09) (try 'pc=
i=3Dassign-busses')
Please report the result to linux-kernel to fix this permanently
PCI: Bus #0d (-#10) is hidden behind transparent bridge #08 (-#09) (try 'pc=
i=3Dassign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: Embedded Controller [EC] (gpe 23) interrupt mode.
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 0 of device 0000:05:00.0
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
   IO window: 2000-2fff
   MEM window: f0000000-f00fffff
   PREFETCH window: 34000000-340fffff
PCI: Bridge: 0000:00:1c.1
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
   IO window: disabled.
   MEM window: 34100000-341fffff
   PREFETCH window: disabled.
PCI: Bus 9, cardbus bridge: 0000:08:03.0
   IO window: 00003000-000030ff
   IO window: 00003400-000034ff
   PREFETCH window: 30000000-31ffffff
   MEM window: 36000000-37ffffff
PCI: Bus 13, cardbus bridge: 0000:08:03.1
   IO window: 00003800-000038ff
   IO window: 00003c00-00003cff
   PREFETCH window: 32000000-33ffffff
   MEM window: 38000000-39ffffff
PCI: Bridge: 0000:00:1e.0
   IO window: 3000-3fff
   MEM window: f0200000-f02fffff
   PREFETCH window: 30000000-33ffffff
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 22 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 21 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.1 to 64
PCI: Enabling device 0000:00:1c.2 (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 20 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:08:03.0[A] -> GSI 16 (level, low) -> IRQ 19
PCI: Enabling device 0000:08:03.1 (0080 -> 0083)
ACPI: PCI Interrupt 0000:08:03.1[A] -> GSI 16 (level, low) -> IRQ 19
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 196608 bytes)
TCP bind hash table entries: 8192 (order: 4, 98304 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Simple Boot Flag at 0x7b set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1147860151.851:1): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.27 [Flags: R/W].
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [CMB1] (battery present)
ACPI: Battery Slot [CMB2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Thermal Zone [TZ00] (27 C)
ACPI: Thermal Zone [TZ01] (27 C)
lp: driver loaded but no devices found
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 945GM Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xe0000000
[drm] Initialized drm 1.0.1 20051102
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
serial8250: ttyS3 at I/O 0x2e8 (irq =3D 3) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
floppy0: no floppy controllers found
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:02:00.0 to 64
sky2 v1.3 addr 0xf0000000 irq 19 Yukon-EC Ultra (0xb4) rev 2
sky2 eth0: addr 00:17:42:04:0c:3e
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 20
ICH7: chipset revision 2
ICH7: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
hda: _NEC DVD+/-RW ND-6650A, ATAPI CD/DVD-ROM drive
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
hda: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.20 loaded.
ahci 0000:00:1f.2: version 1.2
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 21
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x5 impl SATA m=
ode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part=20
ata1: SATA max UDMA/133 cmd 0xE002E500 ctl 0x0 bmdma 0x0 irq 21
ata2: SATA max UDMA/133 cmd 0xE002E580 ctl 0x0 bmdma 0x0 irq 21
ata3: SATA max UDMA/133 cmd 0xE002E600 ctl 0x0 bmdma 0x0 irq 21
ata4: SATA max UDMA/133 cmd 0xE002E680 ctl 0x0 bmdma 0x0 irq 21
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
ata1: SATA link up 1.5 Gbps (SStatus 113)
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
ata1: dev 0 cfg 49:2f00 82:746b 83:7f01 84:6003 85:3c69 86:3f01 87:6003 88:=
20ff
ata1: dev 0 ATA-7, max UDMA7, 156301488 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ahci
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
ata2: SATA link down (SStatus 0)
scsi1 : ahci
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
ata3: SATA link down (SStatus 0)
scsi2 : ahci
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
ata4: SATA link down (SStatus 0)
scsi3 : ahci
   Vendor: ATA       Model: SAMSUNG HM080JI   Rev: YC10
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda:<4>sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
  sda1 sda2 <<4>sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
  sda5 sda6 >
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
ACPI: PCI Interrupt 0000:08:03.4[A] -> GSI 16 (level, low) -> IRQ 19
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[19]  MMIO=3D[f0201000-f0201=
7ff]  Max Packet=3D[2048]  IR/IT contexts=3D[8/8]
ieee1394: raw1394: /dev/raw1394 device initialized
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 22, io mem 0xf0644000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 22, io base 0x00001820
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 20 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 18, io base 0x00001840
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 20, io base 0x00001860
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 19, io base 0x00001880
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
usb 2-2: new low speed USB device using uhci_hcd and address 2
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
usb 2-2: configuration #1 chosen from 1 choice
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: Microsoft Microsoft 3-Button Mouse with IntelliEye? as /class/input/=
input0
input: USB HID v1.00 Mouse [Microsoft Microsoft 3-Button Mouse with Intelli=
Eye?] on usb-0000:00:1d.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.11rc4 (Wed Mar 22 10:2=
7:24 2006 UTC).
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 17 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1b.0 to 64
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
input: AT Translated Set 2 keyboard as /class/input/input1
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
ALSA device list:
   #0: HDA Intel at 0xf0640000 irq 23
ip_conntrack version 2.4 (4019 buckets, 32152 max) - 224 bytes per conntrac=
k
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00000e1003435956]
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 216k freed
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x1a0b1, caps: 0xa04793/0x302000
serio: Synaptics pass-through port at isa0060/serio4/input0
input: SynPS/2 Synaptics TouchPad as /class/input/input2
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
Adding 248968k swap on /dev/sda6.  Priority:-1 extents:1 across:248968k
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
EXT3 FS on sda5, internal journal
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
NTFS volume version 3.1.
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
input: PS/2 Generic Mouse as /class/input/input3
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: phy read timeout
sky2 eth0: enabling interface
sky2 eth0: Link is up at 100 Mbps, full duplex, flow control none
ACPI: PCI Interrupt 0000:08:03.0[A] -> GSI 16 (level, low) -> IRQ 19
Yenta: CardBus bridge found at 0000:08:03.0 [10cf:131e]
Yenta O2: res at 0x94/0xD4: 00/ea
Yenta O2: enabling read prefetch/write burst
Yenta: ISA IRQ mask 0x0438, PCI irq 19
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
cs: IO port probe 0x3000-0x3fff: clean.
pcmcia: parent PCI bridge Memory window: 0xf0200000 - 0xf02fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x33ffffff
ACPI: PCI Interrupt 0000:08:03.1[A] -> GSI 16 (level, low) -> IRQ 19
Yenta: CardBus bridge found at 0000:08:03.1 [10cf:131e]
Yenta: ISA IRQ mask 0x0c38, PCI irq 19
Socket status: 30000410
pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
cs: IO port probe 0x3000-0x3fff: clean.
pcmcia: parent PCI bridge Memory window: 0xf0200000 - 0xf02fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x33ffffff
pccard: PCMCIA card inserted into slot 1
mtrr: no more MTRRs available
mtrr: no more MTRRs available

>>
>> That's my driver.  I put a lot of fixes in for 2.6.17, one of which chan=
ges
>> the setup of the chip type used in this machine. The driver is significa=
ntly
>> changed from 2.6.16 so best bet is to just take the 2.6.17 latest versio=
n
>> and compile it on 2.6.16 (or update to 2.6.17). I got reports from Fujit=
su E610
>> user that it now works fine.

 =09Best regards,


--
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

Dimitris Zilaskos

Department of Physics @ Aristotle University of Thessaloniki , Greece
PGP key : http://tassadar.physics.auth.gr/~dzila/pgp_public_key.asc
 =09  http://egnatia.ee.auth.gr/~dzila/pgp_public_key.asc
MD5sum  : de2bd8f73d545f0e4caf3096894ad83f  pgp_public_key.asc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
---838198917-675495676-1147849885=:739--
