Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbTLQSX0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 13:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264507AbTLQSX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 13:23:26 -0500
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:27476 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264506AbTLQSW7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 13:22:59 -0500
Date: Wed, 17 Dec 2003 19:22:25 +0100
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <aradorlinux@yahoo.es>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11-mm1
Message-Id: <20031217192225.58842400.aradorlinux@yahoo.es>
In-Reply-To: <20031217014350.028460b2.akpm@osdl.org>
References: <20031217014350.028460b2.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 17 Dec 2003 01:43:50 -0800 Andrew Morton <akpm@osdl.org> escribió:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test11/2.6.0-test11-mm1/


I got this oops while disconnecting and connecting my (normal, AT 105 keys) keyboard (the keyboard behaviour
was/is strange, it feels like it has "latency"). Full dmesg attached.


NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f64e0
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 VIA694                                    ) @ 0x000f7e10
ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: MADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff5b80
ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Building zonelist for node : 0
Kernel command line: profile=2 nmi_watchdog=1 ro root=/dev/hda2 vga=0x30a noirqbalance debug
kernel profiling enabled
current: c0312ba0
current->thread_info: c0356000
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 803.113 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 132x43
Memory: 513576k/524224k available (1834k kernel code, 9864k reserved, 555k data, 196k init, 0k highmem)
Calibrating delay loop... 1581.05 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.26 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1601.53 BogoMIPS
CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3182.59 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
number of MP IRQ sources: 18.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   1   0    1    1    71
 0a 001 01  1    1    0   1   0    1    1    79
 0b 001 01  1    1    0   1   0    1    1    81
 0c 001 01  1    1    0   1   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ25 -> 0:9
IRQ26 -> 0:10
IRQ27 -> 0:11
IRQ28 -> 0:12
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 802.0779 MHz.
..... host bus clock speed is 133.0796 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
zapping low mappings.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb250, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: the driver 'system' has been registered
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbcc0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbcf0, dseg 0xf0000
pnp: match found with the PnP device '00:07' and the driver 'system'
pnp: match found with the PnP device '00:08' and the driver 'system'
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 113
PCI->APIC IRQ transform: (B0,I7,P3) -> 113
PCI->APIC IRQ transform: (B0,I7,P2) -> 137
PCI->APIC IRQ transform: (B0,I13,P0) -> 129
PCI->APIC IRQ transform: (B1,I0,P0) -> 121
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
ikconfig 0.7 with /proc/config*
PCI: Enabling Via external APIC routing
PCI: Via IRQ fixup for 0000:00:07.2, from 9 to 1
PCI: Via IRQ fixup for 0000:00:07.3, from 9 to 1
PCI: Via IRQ fixup for 0000:00:07.5, from 12 to 9
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
ppdev: user-space parallel port driver
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xc0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:0d' and the driver 'serial'
pnp: match found with the PnP device '00:0e' and the driver 'serial'
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:10' and the driver 'parport_pc'
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
lp0: console ready
parport_pc: Via 686A parallel port: io=0x378
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0d.0: 3Com PCI 3c905C Tornado at 0xec00. Vers LK1.1.19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y060L0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST GCE-8520B, ATAPI CD/DVD-ROM drive
hdd: LG CD-ROM CRD-8522B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 120103200 sectors (61492 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 < hda5 hda6 hda7 hda8 > hda2 hda3
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
PCI: Setting latency timer of device 0000:00:07.5 to 64
ALSA device list:
  #0: VIA 82C686A/B rev50 at 0xdc00, irq 137
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 196k freed
Adding 500400k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 304 bytes per conntrack
input: AT Translated Set 2 keyboard on isa0060/serio0
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
PPP BSD Compression module registered
PPP Deflate Compression module registered
NET: Registered protocol family 17
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
local_bh_enable() was called in hard irq context.   This is probably a bug
Call Trace:
 [<c0127b96>] local_bh_enable+0x96/0xa0
 [<e08fc4d8>] ppp_asynctty_receive+0x78/0xd0 [ppp_async]
 [<c01cec6c>] flush_to_ldisc+0xdc/0x130
 [<c01ecc17>] receive_chars+0x227/0x240
 [<c01eccd5>] transmit_chars+0xa5/0xe0
 [<c01ecf7c>] serial8250_interrupt+0x12c/0x130
 [<c010c9f9>] handle_IRQ_event+0x49/0x80
 [<c010cdc8>] do_IRQ+0xb8/0x180
 [<c02ca760>] common_interrupt+0x18/0x20
 [<c0116429>] delay_tsc+0x9/0x20
 [<c01bb492>] __delay+0x12/0x20
 [<c022408c>] atkbd_command+0x8c/0x1e0
 [<c0224516>] atkbd_probe+0x36/0xe0
 [<c02288c8>] serio_open+0x18/0x40
 [<c0224bdc>] atkbd_connect+0x36c/0x400
 [<c022825a>] serio_find_dev+0x6a/0x70
 [<c0228356>] serio_handle_events+0xa6/0x100
 [<c0228405>] serio_thread+0x55/0x150
 [<c011ec70>] default_wake_function+0x0/0x20
 [<c02283b0>] serio_thread+0x0/0x150
 [<c0108f99>] kernel_thread_helper+0x5/0xc

local_bh_enable() was called in hard irq context.   This is probably a bug
Call Trace:
 [<c0127b96>] local_bh_enable+0x96/0xa0
 [<e08f6f86>] ppp_input_error+0x116/0x150 [ppp_generic]
 [<e08fcfd6>] ppp_async_input+0x156/0x5b0 [ppp_async]
 [<c0134006>] queue_delayed_work+0x86/0xa0
 [<e08fc4c1>] ppp_asynctty_receive+0x61/0xd0 [ppp_async]
 [<c01cec6c>] flush_to_ldisc+0xdc/0x130
 [<c01ecc17>] receive_chars+0x227/0x240
 [<c01eccd5>] transmit_chars+0xa5/0xe0
 [<c01ecf7c>] serial8250_interrupt+0x12c/0x130
 [<c010c9f9>] handle_IRQ_event+0x49/0x80
 [<c010cdc8>] do_IRQ+0xb8/0x180
 [<c02ca760>] common_interrupt+0x18/0x20
 [<c0116436>] delay_tsc+0x16/0x20
 [<c01bb492>] __delay+0x12/0x20
 [<c0223fbc>] atkbd_sendbyte+0x4c/0x90
 [<c02241d6>] atkbd_command+0x1d6/0x1e0
 [<c0224790>] atkbd_enable+0x50/0xb0
 [<c0224c15>] atkbd_connect+0x3a5/0x400
 [<c022825a>] serio_find_dev+0x6a/0x70
 [<c0228356>] serio_handle_events+0xa6/0x100
 [<c0228405>] serio_thread+0x55/0x150
 [<c011ec70>] default_wake_function+0x0/0x20
 [<c02283b0>] serio_thread+0x0/0x150
 [<c0108f99>] kernel_thread_helper+0x5/0xc

local_bh_enable() was called in hard irq context.   This is probably a bug
Call Trace:
 [<c0127b96>] local_bh_enable+0x96/0xa0
 [<e08fcfd6>] ppp_async_input+0x156/0x5b0 [ppp_async]
 [<c0134006>] queue_delayed_work+0x86/0xa0
 [<e08fc4c1>] ppp_asynctty_receive+0x61/0xd0 [ppp_async]
 [<c01cec6c>] flush_to_ldisc+0xdc/0x130
 [<c01ecc17>] receive_chars+0x227/0x240
 [<c01eccd5>] transmit_chars+0xa5/0xe0
 [<c01ecf7c>] serial8250_interrupt+0x12c/0x130
 [<c010c9f9>] handle_IRQ_event+0x49/0x80
 [<c010cdc8>] do_IRQ+0xb8/0x180
 [<c02ca760>] common_interrupt+0x18/0x20
 [<c0116436>] delay_tsc+0x16/0x20
 [<c01bb492>] __delay+0x12/0x20
 [<c0223fbc>] atkbd_sendbyte+0x4c/0x90
 [<c02241d6>] atkbd_command+0x1d6/0x1e0
 [<c0224790>] atkbd_enable+0x50/0xb0
 [<c0224c15>] atkbd_connect+0x3a5/0x400
 [<c022825a>] serio_find_dev+0x6a/0x70
 [<c0228356>] serio_handle_events+0xa6/0x100
 [<c0228405>] serio_thread+0x55/0x150
 [<c011ec70>] default_wake_function+0x0/0x20
 [<c02283b0>] serio_thread+0x0/0x150
 [<c0108f99>] kernel_thread_helper+0x5/0xc

local_bh_enable() was called in hard irq context.   This is probably a bug
Call Trace:
 [<c0127b96>] local_bh_enable+0x96/0xa0
 [<e08fc4d8>] ppp_asynctty_receive+0x78/0xd0 [ppp_async]
 [<c01cec6c>] flush_to_ldisc+0xdc/0x130
 [<c01ecc17>] receive_chars+0x227/0x240
 [<c01eccd5>] transmit_chars+0xa5/0xe0
 [<c01ecf7c>] serial8250_interrupt+0x12c/0x130
 [<c010c9f9>] handle_IRQ_event+0x49/0x80
 [<c010cdc8>] do_IRQ+0xb8/0x180
 [<c02ca760>] common_interrupt+0x18/0x20
 [<c0116436>] delay_tsc+0x16/0x20
 [<c01bb492>] __delay+0x12/0x20
 [<c0223fbc>] atkbd_sendbyte+0x4c/0x90
 [<c02241d6>] atkbd_command+0x1d6/0x1e0
 [<c0224790>] atkbd_enable+0x50/0xb0
 [<c0224c15>] atkbd_connect+0x3a5/0x400
 [<c022825a>] serio_find_dev+0x6a/0x70
 [<c0228356>] serio_handle_events+0xa6/0x100
 [<c0228405>] serio_thread+0x55/0x150
 [<c011ec70>] default_wake_function+0x0/0x20
 [<c02283b0>] serio_thread+0x0/0x150
 [<c0108f99>] kernel_thread_helper+0x5/0xc

input: AT Translated Set 2 keyboard on isa0060/serio0
