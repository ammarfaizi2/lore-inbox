Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261653AbSJAOk3>; Tue, 1 Oct 2002 10:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261655AbSJAOk3>; Tue, 1 Oct 2002 10:40:29 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:29578 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261653AbSJAOk0>; Tue, 1 Oct 2002 10:40:26 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.39: hdparm: HDIO_SET_DMA failed: Operation not permitted
References: <87vg4mqm3j.fsf@goat.bogus.local>
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Tue, 01 Oct 2002 16:45:07 +0200
In-Reply-To: <87vg4mqm3j.fsf@goat.bogus.local> (Olaf Dietsche's message of
 "Tue, 01 Oct 2002 16:18:08 +0200")
Message-ID: <87ofaeqkuk.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de> writes:

> with 2.5.39 I get the following error (2.5.40/www.kernel.org is
> unavailable at the moment):
>
> # hdparm -d 1 /dev/hda/0
>
> /dev/hda/0:
>  setting using_dma to 1 (on)
>  HDIO_SET_DMA failed: Operation not permitted
>  using_dma    =  0 (off)

I forgot to add dmesg output:

Linux version 2.5.39 (olaf@goat) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Tue Oct 1 15:39:25 MEST 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages
  Normal zone: 126960 pages
  HighMem zone: 0 pages
ACPI: RSDP (v000 VIA694                     ) @ 0x000f7400
ACPI: RSDT (v001 VIA694 AWRDACPI 16944.11825) @ 0x1fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x1fff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Lx-2.5.39-2 ro root=302
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1200.339 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2367.48 BogoMIPS
Memory: 516084k/524224k available (1061k kernel code, 7752k reserved, 427k data, 244k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD Duron(tm) processor stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1199.0923 MHz.
..... host bus clock speed is 199.0987 MHz.
cpu: 0, clocks: 199987, slice: 99993
CPU0<T0:199984,T1:99984,D:7,S:99993,C:199987>
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfb010, last bus=1
PCI: Using configuration type 1
adding '' to cpu class interfaces
ACPI: Subsystem revision 20020918
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:..............................................................................................
Table [DSDT] - 357 Objects with 33 Devices 94 Methods 21 Regions
ACPI Namespace successfully loaded at root c02e923c
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:.................................
33 Devices found containing: 33 _STA, 1 _INI methods
Completing Region/Field/Buffer/Package initialization:...............................................
Initialized 18/21 Regions 0/0 Fields 16/16 Buffers 13/13 Packages (357 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:11.02 not present in PCI namespace
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:11.03 not present in PCI namespace
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:11.04 not present in PCI namespace
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:11.05 not present in PCI namespace
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:11.06 not present in PCI namespace
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:12.00 not present in PCI namespace
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
spurious 8259A interrupt: IRQ7.
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
aio_setup: sizeof(struct page) = 40
Capability LSM initialized
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: SAMSUNG SV4003H, ATA DISK drive
hdb: _NEC CD-ROM CD-3002A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 78242190 sectors (40060 MB) w/468KiB Cache, CHS=4870/255/63
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 hda15 hda16 hda17 hda18 hda19 hda20 hda21 >
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 244k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding 497972k swap on /dev/hda/10.  Priority:-1 extents:1
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xe0863000, 00:e0:7d:c5:b5:57, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
MTRR: setting reg 2
input: PS/2 Logitech Mouse on isa0060/serio1
psmouse.c: Lost synchronization, throwing 1 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
hdb: ATAPI 52X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12

Regards, Olaf.
