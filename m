Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262731AbTDASbx>; Tue, 1 Apr 2003 13:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262734AbTDASbw>; Tue, 1 Apr 2003 13:31:52 -0500
Received: from smtp01.web.de ([217.72.192.180]:2574 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S262731AbTDASbl>;
	Tue, 1 Apr 2003 13:31:41 -0500
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66 oops
Date: Tue, 1 Apr 2003 20:42:56 +0200
User-Agent: KMail/1.5
References: <200304012032.43228.freesoftwaredeveloper@web.de>
In-Reply-To: <200304012032.43228.freesoftwaredeveloper@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304012042.56333.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, ttylog was incomplete. here is the complete log:


Linux version 2.5.66 (mb@lfs) (gcc version 3.2.2) #2 Die Apr 1 20:10:41 CEST 2003

Video mode to be used for restore is 30b

BIOS-provided physical RAM map:

 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)

 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)

 BIOS-e820: 00000000000d0000 - 00000000000d4000 (reserved)

 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)

 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)

 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)

 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)

 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)

 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)

 BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)

 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)

user-defined physical RAM map:

 user: 0000000000000000 - 000000000009fc00 (usable)

 user: 000000000009fc00 - 00000000000a0000 (reserved)

 user: 00000000000d0000 - 00000000000d4000 (reserved)

 user: 00000000000f0000 - 0000000000100000 (reserved)

 user: 0000000000100000 - 000000000fff0000 (usable)

 user: 000000000fff0000 - 000000000fff8000 (ACPI data)

 user: 000000000fff8000 - 0000000010000000 (ACPI NVS)

 user: 00000000fec00000 - 00000000fec01000 (reserved)

 user: 00000000fee00000 - 00000000fee01000 (reserved)

 user: 00000000ffb00000 - 00000000ffc00000 (reserved)

 user: 00000000fff00000 - 0000000100000000 (reserved)

255MB LOWMEM available.

found SMP MP-table at 000fb800

hm, page 000fb000 reserved twice.

hm, page 000fc000 reserved twice.

hm, page 000f6000 reserved twice.

hm, page 000f7000 reserved twice.

On node 0 totalpages: 65520

  DMA zone: 4096 pages, LIFO batch:1

  Normal zone: 61424 pages, LIFO batch:14

  HighMem zone: 0 pages, LIFO batch:1

ACPI: RSDP (v000 AMI                        ) @ 0x000fa300

ACPI: RSDT (v001 AMIINT INTEL845 00000.00016) @ 0x0fff0000

ACPI: FADT (v001 AMIINT INTEL845 00000.00017) @ 0x0fff0030

ACPI: MADT (v001 AMIINT INTEL845 00000.00009) @ 0x0fff00c0

ACPI: DSDT (v001  INTEL BROKDALE 00000.04096) @ 0x00000000

ACPI: BIOS passes blacklist

ACPI: Local APIC address 0xfee00000

ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)

Processor #0 15:2 APIC version 16

ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])

IOAPIC[0]: Assigned apic_id 2

IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23

ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])

ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])

Enabling APIC mode:  Flat.  Using 1 I/O APICs

Using ACPI (MADT) for SMP configuration information

Building zonelist for node : 0

Kernel command line: console=ttyS0,9600 console=tty0 root=/dev/md0 hdd=ide-scsi hdb=ide-scsi mce vga=779 mem=262080K

ide_setup: hdd=ide-scsi

ide_setup: hdb=ide-scsi

Initializing CPU#0

PID hash table entries: 1024 (order 10: 8192 bytes)

Detected 2240.002 MHz processor.

Console: colour VGA+ 132x50

Calibrating delay loop... 4423.68 BogoMIPS

Memory: 254508k/262080k available (2618k kernel code, 6852k reserved, 911k data, 340k init, 0k highmem)

Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)

Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)

-> /dev

-> /dev/console

-> /root

CPU: Trace cache: 12K uops, L1 D cache: 8K

CPU: L2 cache: 512K

Intel machine check architecture supported.

Intel machine check reporting enabled on CPU#0.

CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available

CPU#0: Thermal monitoring enabled

Machine check exception polling timer started.

CPU: Intel(R) Pentium(R) 4 CPU 1.60GHz stepping 04

Enabling fast FPU save and restore... done.

Enabling unmasked SIMD FPU exception support... done.

Checking 'hlt' instruction... OK.

POSIX conformance testing by UNIFIX

enabled ExtINT on CPU#0

ESR value before enabling vector: 00000000

ESR value after enabling vector: 00000000

ENABLING IO-APIC IRQs

..TIMER: vector=0x31 pin1=2 pin2=0

testing the IO APIC.......................



.................................... done.

Using local APIC timer interrupts.

calibrating APIC timer ...

..... CPU clock speed is 2239.0662 MHz.

..... host bus clock speed is 139.0978 MHz.

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Initializing RT netlink socket

mtrr: v2.0 (20020519)

PCI: PCI BIOS revision 2.10 entry at 0xfdb71, last bus=3

PCI: Using configuration type 1

BIO: pool of 256 setup, 14Kb (56 bytes/bio)

biovec pool[0]:   1 bvecs: 256 entries (12 bytes)

biovec pool[1]:   4 bvecs: 256 entries (48 bytes)

biovec pool[2]:  16 bvecs: 256 entries (192 bytes)

biovec pool[3]:  64 bvecs: 256 entries (768 bytes)

biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)

biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)

ACPI: Subsystem revision 20030228

 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired

Parsing all Control Methods:....................................................................................................................................................

Table [DSDT] - 495 Objects with 44 Devices 148 Methods 15 Regions

ACPI Namespace successfully loaded at root c04e055c

evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode successful

   evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 0000000000000828

   evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE0 to GPE15

   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L1C is not valid

   evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 000000000000082C

   evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE16 to GPE31

   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L0B is not valid

   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L03 is not valid

   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L04 is not valid

   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L1C is not valid

Executing all Device _STA and_INI methods:............................................

44 Devices found containing: 44 _STA, 1 _INI methods

Completing Region/Field/Buffer/Package initialization:..................................................................................

Initialized 10/15 Regions 10/10 Fields 50/50 Buffers 12/12 Packages (495 nodes)

ACPI: Interpreter enabled

ACPI: Using IOAPIC for interrupt routing

 exfldio-0140 [25] ex_setup_region       : Field [TOMR] Base+Offset+Width 0+2+1 is beyond end of region [TMEM] (length 2)

 dswexec-0421 [17] ds_exec_end_op        : [ShiftLeft]: Could not resolve operands, AE_AML_REGION_LIMIT

 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.MDET] (Node c12c88a8), AE_AML_REGION_LIMIT

 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0._CRS] (Node c12c8e28), AE_AML_REGION_LIMIT

  uteval-0098: *** Error: Method execution failed [\_SB_.PCI0._CRS] (Node c12c8e28), AE_AML_REGION_LIMIT

ACPI: PCI Root Bridge [PCI0] (00:00)

PCI: Probing PCI hardware (bus 00)

Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Br

ACPI: Power Resource [URP1] (off)

ACPI: Power Resource [URP2] (off)

ACPI: Power Resource [FDDP] (off)

ACPI: Power Resource [LPTP] (off)

ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)

ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *10 11 12 14 15)

ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *10 11 12 14 15)

ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)

Linux Plug and Play Support v0.95 (c) Adam Belay

PnPBIOS: Found PnP BIOS installation structure at 0xc00f7520

PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x65ab, dseg 0xf0000

PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver

block request queues:

 128 requests per read queue

 128 requests per write queue

 8 requests per batch

 enter congestion at 15

 exit congestion at 17

SCSI subsystem initialized

PCI: Using ACPI for IRQ routing

PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'

SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).

CSLIP: code copyright 1989 Regents of the University of California.

Enabling SEP on CPU 0

Total HugeTLB memory allocated, 0

Journalled Block Device driver loaded

Initializing Cryptographic API

ACPI: Power Button (FF) [PWRF]

ACPI: Sleep Button (CM) [SLPB]

ACPI: Processor [CPU1] (supports C1, 8 throttling states)

pty: 256 Unix98 ptys configured

lp: driver loaded but no devices found

Real Time Clock Driver v1.11

Non-volatile memory driver v1.2

Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0

Linux agpgart interface v0.100 (c) Dave Jones

agpgart: Detected Intel i845 chipset

agpgart: Maximum main memory to use for agp memory: 203M

agpgart: AGP aperture is 64M @ 0xe0000000

Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled

ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]

parport0: irq 7 detected

lp0: using parport0 (polling).

Floppy drive(s): fd0 is 1.44M

FDC 0 is a post-1991 82077

loop: loaded (max 8 devices)

ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker

  http://www.scyld.com/network/ne2k-pci.html

eth0: RealTek RTL-8029 found at 0xb400, IRQ 17, 52:54:05:FF:F5:EA.

PPP generic driver version 2.4.2

PPP Deflate Compression module registered

PPP BSD Compression module registered

Linux video capture interface: v1.00

bttv: driver version 0.9.4 loaded

bttv: using 8 buffers with 2080k (520 pages) each for capture

bttv: Host bridge is Intel Corp. 82845 845 (Brookdale

bttv: Bt8xx card found (0).

bttv0: Bt878 (rev 17) at 03:02.0, irq: 18, latency: 32, mmio: 0xddafe000

bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb

bttv0: using: BT878(Hauppauge (bt878)) [card=10,autodetected]

bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]

bttv0: Hauppauge eeprom: model=44354, tuner=Philips FM1216 (5), radio=yes

bttv0: using tuner=5

bttv0: i2c: checking for MSP34xx @ 0x80... found

bttv0: i2c: checking for TDA9875 @ 0xb0... not found

bttv0: i2c: checking for TDA7432 @ 0x8a... not found

bttv0: registered device video0

bttv0: registered device vbi0

bttv0: registered device radio0

bttv0: PLL: 28636363 => 35468950 .. ok

Unable to handle kernel NULL pointer dereference at virtual address 00000068

 printing eip:

c020ca48

*pde = 00000000

Oops: 0000 [#1]

CPU:    0

EIP:    0060:[<c020ca48>]    Not tainted

EFLAGS: 00010202

EIP is at kobject_get+0x16/0x43

eax: c1292000   ebx: 00000058   ecx: ffffffff   edx: c042ed58

esi: c042ed34   edi: c042ed84   ebp: c1293f38   esp: c1293f34

ds: 007b   es: 007b   ss: 0068

Process swapper (pid: 1, threadinfo=c1292000 task=c12fe080)

Stack: c042ed74 c1293f48 c020c7eb 00000058 c042ed74 c1293f64 c020c9a5 c042ed74 

       c042ed24 c1293f64 c0274c93 c042ed74 c1293f84 c0274ae0 c042ed74 00000042 

       fffffffc c042ed24 c042ed20 00000000 c1293fa0 c0274f83 c042ed58 00008086 

Call Trace:

 [<c020c7eb>] kobject_init+0x2e/0x48

 [<c020c9a5>] kobject_register+0x18/0x61

 [<c0274c93>] get_bus+0x1f/0x38

 [<c0274ae0>] bus_add_driver+0x57/0xeb

 [<c0274f83>] driver_register+0x31/0x35

 [<c02e63b8>] i2c_add_driver+0xa3/0x106

 [<c02a0842>] msp3400_init_module+0x12/0x18

 [<c01050a3>] init+0x39/0x196

 [<c010506a>] init+0x0/0x196

 [<c0107289>] kernel_thread_helper+0x5/0xb



Code: 8b 43 10 85 c0 7e 22 ff 43 10 b8 00 e0 ff ff 21 e0 83 68 14 

 <0>Kernel panic: Attempted to kill init!


