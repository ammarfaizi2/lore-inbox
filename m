Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUITA3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUITA3u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 20:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUITA3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 20:29:50 -0400
Received: from smtp5.intermedia.net ([64.78.61.32]:46388 "EHLO
	smtp5.intermedia.net") by vger.kernel.org with ESMTP
	id S265127AbUITA32 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 20:29:28 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.8-r1 mem issues
Date: Sun, 19 Sep 2004 17:29:20 -0700
Message-ID: <0FC82FC6709BE34CB9118EE0E252FD2307994E77@ehost007.exch005intermedia.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.8-r1 mem issues
Thread-Index: AcSep01dSuEv2JR6Syyd1n/E3FEppgAADzaA
From: "Max Michaels" <mmichaels@rightmedia.com>
To: <jonathan@jonmasters.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Sep 2004 00:29:27.0867 (UTC) FILETIME=[E35158B0:01C49EA8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Could you describe the hardware and any devices that you're using -
>looks like you're avoiding modules but it would be helpful to see an
>attached dmesg output and lspci -v or similar.

Dmesg:

Calibrating delay loop... 5505.02 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
per-CPU timeslice cutoff: 1462.56 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Booting processor 1/6 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5570.56 BogoMIPS
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Total of 2 processors activated (11075.58 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 9-0, 9-1, 9-2, 9-3, 9-4, 9-5, 9-6, 9-7, 9-8, 9-9,
9-10, 9-11, 9-12, 9-13, 9-14, 9-15, 10-0, 10-1, 10-2, 10-3, 10-4, 10-5,
10-6, 10-7, 10-8, 10-9, 10-10, 10-11, 10-12, 10-13, 10-14, 10-15 not
connected.
..TIMER: vector=0x31 pin1=0 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2791.0474 MHz.
..... host bus clock speed is 132.0927 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0:  online
 domain 0: span 1
  groups: 1
  domain 1: span 3
   groups: 1 2
CPU1:  online
 domain 0: span 2
  groups: 2
  domain 1: span 3
   groups: 2 1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfc91e, last bus=4
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Root Bridge [PCI4] (00:04)
PCI: Probing PCI hardware (bus 04)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI4._PRT]
ACPI: PCI Root Bridge [PCI3] (00:03)
PCI: Probing PCI hardware (bus 03)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI3._PRT]
ACPI: PCI Root Bridge [PCI2] (00:02)
PCI: Probing PCI hardware (bus 02)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2._PRT]
ACPI: PCI Root Bridge [PCI1] (00:01)
PCI: Probing PCI hardware (bus 01)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
ACPI: PCI Interrupt Link [LNK0] (IRQs 4 5 6 *7 9 10 11 12)
ACPI: PCI Interrupt Link [LNK1] (IRQs 4 *5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNK2] (IRQs 4 5 6 *7 9 10 11 12)
ACPI: PCI Interrupt Link [LNK3] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK6] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK8] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK9] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN10] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN11] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN12] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN13] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN14] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN15] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN16] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN17] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN18] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN19] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN1A] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN1B] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN1C] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN1D] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN1E] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LN1F] (IRQs 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LUSB] (IRQs 4 5 6 7 10 *11 12)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LUSB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:0f.2[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:04:03.0[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:02:00.1[B] -> GSI 17 (level, low) -> IRQ 17
number of MP IRQ sources: 16.
number of IO-APIC #8 registers: 16.
number of IO-APIC #9 registers: 16.
number of IO-APIC #10 registers: 16.
testing the IO APIC.......................
IO APIC #8......
.... register #00: 08000000
.......    : physical APIC id: 08
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 08000000
.......     : arbitration: 08
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  0    0    0   0   0    1    1    31
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  1    0    0   0   0    1    1    41
 03 003 03  0    0    0   0   0    1    1    49
 04 003 03  0    0    0   0   0    1    1    51
 05 003 03  0    0    0   0   0    1    1    59
 06 003 03  0    0    0   0   0    1    1    61
 07 003 03  0    0    0   0   0    1    1    69
 08 003 03  0    0    0   0   0    1    1    71
 09 003 03  0    1    0   1   0    1    1    79
 0a 003 03  0    0    0   0   0    1    1    81
 0b 003 03  1    1    0   1   0    1    1    89
 0c 003 03  0    0    0   0   0    1    1    91
 0d 003 03  0    0    0   0   0    1    1    99
 0e 003 03  0    0    0   0   0    1    1    A1
 0f 003 03  0    0    0   0   0    1    1    A9
IO APIC #9......
.... register #00: 09000000
.......    : physical APIC id: 09
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 09000000
.......     : arbitration: 09
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  1    1    0   1   0    1    1    B9
 01 003 03  1    1    0   1   0    1    1    C1
 02 003 03  1    1    0   1   0    1    1    B1
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IO APIC #10......
.... register #00: 0A000000
.......    : physical APIC id: 0A
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0A000000
.......     : arbitration: 0A
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ2 -> 0:2
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 1:0
IRQ17 -> 1:1
IRQ18 -> 1:2
.................................... done.
Machine check exception polling timer started.
Starting balanced_irq
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
tg3.c:v3.8 (July 14, 2004)
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
eth0: Tigon3 [partno(BCM95704A6) rev 2002 PHY(5704)]
(PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:0b:db:94:e4:e1
eth0: HostTXDS[1] RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0]
WireSpeed[1] TSOcap[1] 
ACPI: PCI interrupt 0000:02:00.1[B] -> GSI 17 (level, low) -> IRQ 17
eth1: Tigon3 [partno(BCM95704A6) rev 2002 PHY(5704)]
(PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:0b:db:94:e4:e2
eth1: HostTXDS[1] RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0]
WireSpeed[1] TSOcap[1] 
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SvrWks CSB5: IDE controller at PCI slot 0000:00:0f.1
SvrWks CSB5: chipset revision 147
SvrWks CSB5: not 100% native mode: will probe irqs later
SvrWks CSB5: simplex device: DMA forced
    ide0: BM-DMA at 0x08b0-0x08b7, BIOS settings: hda:pio, hdb:pio
SvrWks CSB5: simplex device: DMA forced
    ide1: BM-DMA at 0x08b8-0x08bf, BIOS settings: hdc:DMA, hdd:pio
hdc: SAMSUNG CD-ROM SN-124, ATAPI CD/DVD-ROM drive
hdc: Disabling (U)DMA for SAMSUNG CD-ROM SN-124 (blacklisted)
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI interrupt 0000:04:03.0[A] -> GSI 18 (level, low) -> IRQ 18
megaraid: found 0x1028:0x000f:bus 4:slot 3:func 0
scsi0:Found MegaRAID controller at 0xf8829000, IRQ:18
megaraid: [4.10:B111] detected 1 logical drives.
megaraid: supports extended CDBs.
megaraid: channel[0] is raid.
megaraid: channel[1] is raid.
scsi0 : LSI Logic MegaRAID 4.10 254 commands 16 targs 5 chans 7 luns
scsi0: scanning scsi channel 0 for logical drives.
  Vendor: MegaRAID  Model: LD 0 RAID5  139G  Rev: 4.10
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0: scanning scsi channel 1 for logical drives.
scsi0: scanning scsi channel 2 for logical drives.
scsi0: scanning scsi channel 4 [P0] for physical devices.
  Vendor: PE/PV     Model: 1x3 SCSI BP       Rev: 1.1 
  Type:   Processor                          ANSI SCSI revision: 02
scsi0: scanning scsi channel 5 [P1] for physical devices.
SCSI device sda: 285728768 512-byte hdwr sectors (146293 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 4, id 6, lun 0,  type 3
Fusion MPT base driver 3.01.09
Copyright (c) 1999-2004 LSI Logic Corporation
Fusion MPT SCSI Host driver 3.01.09
USB Universal Host Controller Interface driver v2.2
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
NET: Registered protocol family 2
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sda2: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 99228
EXT3-fs: sda2: 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 164k freed
EXT3 FS on sda2, internal journal
ReiserFS: sda3: found reiserfs format "3.6" with standard journal
ReiserFS: sda3: using ordered data mode
ReiserFS: sda3: journal params: device sda3, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sda3: checking transaction log (sda3)
ReiserFS: sda3: Using r5 hash to sort names
tg3: eth0: Link is up at 1000 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel

lspci -v

0000:00:00.0 Host bridge: ServerWorks CMIC-LE Host Bridge (GC-LE
chipset) (rev 33)
        Flags: fast devsel

0000:00:00.1 Host bridge: ServerWorks CMIC-LE Host Bridge (GC-LE
chipset)
        Flags: fast devsel

0000:00:00.2 Host bridge: ServerWorks CMIC-LE Host Bridge (GC-LE
chipset)
        Flags: fast devsel

0000:00:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27) (prog-if 00 [VGA])
        Subsystem: Dell: Unknown device 014a
        Flags: bus master, VGA palette snoop, stepping, medium devsel,
latency 32
        Memory at fd000000 (32-bit, non-prefetchable)
        I/O ports at ec00 [size=256]
        Memory at fe101000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [5c] Power Management version 2

0000:00:0f.0 Host bridge: ServerWorks CSB5 South Bridge (rev 93)
        Subsystem: ServerWorks CSB5 South Bridge
        Flags: bus master, medium devsel, latency 32

0000:00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
(prog-if 8a [Master SecP PriP])
        Subsystem: Dell: Unknown device 014a
        Flags: bus master, medium devsel, latency 64
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at 08b0 [size=16]

0000:00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller
(rev 05) (prog-if 10 [OHCI])
        Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at fe100000 (32-bit, non-prefetchable)

0000:00:0f.3 ISA bridge: ServerWorks CSB5 LPC bridge
        Subsystem: ServerWorks: Unknown device 0230
        Flags: bus master, medium devsel, latency 0

0000:00:10.0 Host bridge: ServerWorks CIOB-E I/O Bridge with Gigabit
Ethernet (rev 12)
        Flags: 66Mhz, medium devsel
        Capabilities: [60]
0000:00:10.2 Host bridge: ServerWorks CIOB-E I/O Bridge with Gigabit
Ethernet (rev 12)
        Flags: 66Mhz, medium devsel
        Capabilities: [60]
0000:00:11.0 Host bridge: ServerWorks CIOB-X2 PCI-X I/O Bridge (rev 05)
        Flags: 66Mhz, medium devsel
        Capabilities: [60]
0000:00:11.2 Host bridge: ServerWorks CIOB-X2 PCI-X I/O Bridge (rev 05)
        Flags: 66Mhz, medium devsel
        Capabilities: [60]
0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 02)
        Subsystem: Dell: Unknown device 014a
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 16
        Memory at fcf30000 (64-bit, non-prefetchable)
        Memory at fcf20000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40]      Capabilities: [48] Power Management
version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-

0000:02:00.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 02)
        Subsystem: Dell: Unknown device 014a
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 17
        Memory at fcf10000 (64-bit, non-prefetchable)
        Memory at fcf00000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40]      Capabilities: [48] Power Management
version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-

0000:04:03.0 RAID bus controller: Dell PowerEdge Expandable RAID
controller 4/Di (rev 02)
        Subsystem: Dell: Unknown device 014a
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 32,
IRQ 18
        Memory at f0000000 (32-bit, prefetchable) [size=fcc00000]
        Memory at fcd00000 (32-bit, non-prefetchable) [size=256K]
        Expansion ROM at 00008000 [disabled]
        Capabilities: [c0] Power Management version 2
        Capabilities: [d0] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable-
        Capabilities: [e0] PCI-X non-bridge device.

