Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbTJAVW7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 17:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbTJAVW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 17:22:58 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:44420 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262570AbTJAVWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 17:22:24 -0400
Message-ID: <3F7B4571.1080507@comcast.net>
Date: Wed, 01 Oct 2003 17:21:53 -0400
From: David van Hoose <david.vanhoose@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre6
References: <Pine.LNX.4.44.0310011434400.6488-100000@dmt.cyclades>
In-Reply-To: <Pine.LNX.4.44.0310011434400.6488-100000@dmt.cyclades>
Content-Type: multipart/mixed;
 boundary="------------020201060901040102060004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020201060901040102060004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> Hi,
> 
> Here goes -pre6. 
> 
> It contains several ACPI fixes (the USB "not working anymore" problems in
> -pre5 should be gone), support for the SCTP protocol, x86-64/PPC/SH
> merges, network drivers update (EMAC, e1000, sk98lin), megaraid update,
> amongst others.
> 
> Enjoy :) 
> 
> Summary of changes from v2.4.23-pre5 to v2.4.23-pre6
> ============================================
<SNIP>

My USB 'not working' problem still exists. Attached are my boot messages 
and config.

-David van Hoose

--------------020201060901040102060004
Content-Type: text/plain;
 name="dmesg-2.4.23-pre6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.4.23-pre6"

Linux version 2.4.23-pre6 (root@aeon) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Wed Oct 1 16:25:14 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 131068
zone(0): 4096 pages.
zone(1): 126972 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5810
ACPI: RSDT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x1fffc0c0
ACPI: BOOT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x1fffc030
ACPI: MADT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x1fffc058
ACPI: DSDT (v001   ASUS P4S8X    0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 128, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x14] polarity[0x3] trigger[0x3])
Using ACPI (MADT) for SMP configuration information
Kernel command line: ro root=LABEL=/ parport=auto 3
Initializing CPU#0
Detected 2533.091 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 5059.37 BogoMIPS
Memory: 514420k/524272k available (1912k kernel code, 9464k reserved, 707k data, 112k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.53GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 17.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178080
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0080
An unexpected IO-APIC was found. If this kernel release is less than
three months old please report this to linux-smp@vger.kernel.org
.... register #02: 02000000
.......     : arbitration: 02
.... register #03: 00000001
.......     : Boot DT    : 1
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
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 001 01  1    1    0   1   0    1    1    71
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
IRQ9 -> 0:9-> 0:20
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2533.0050 MHz.
..... host bus clock speed is 133.3160 MHz.
cpu: 0, clocks: 1333160, slice: 666580
CPU0<T0:1333152,T1:666560,D:12,S:666580,C:1333160>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030918
PCI: PCI BIOS revision 2.10 entry at 0xf11b0, last bus=1
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:....................................................................................................................................
Table [DSDT](id F004) - 326 Objects with 47 Devices 132 Methods 6 Regions
ACPI Namespace successfully loaded at root c03d3cdc
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xa9 -> IRQ 20 Mode:1 Active:1)
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000E420 on int 9
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at 000000000000E430 on int 9
Completing Region/Field/Buffer/Package initialization:........................................
Initialized 6/6 Regions 0/0 Fields 23/23 Buffers 11/11 Packages (334 nodes)
Executing all Device _STA and_INI methods:................................................
48 Devices found containing: 48 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
PCI: Probing PCI hardware
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xb1 -> IRQ 16 Mode:1 Active:1)
00:00:02[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb9 -> IRQ 17 Mode:1 Active:1)
00:00:02[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc1 -> IRQ 18 Mode:1 Active:1)
00:00:02[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc9 -> IRQ 19 Mode:1 Active:1)
00:00:02[D] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21 Mode:1 Active:1)
00:00:03[B] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ 22 Mode:1 Active:1)
00:00:03[C] -> 2-22 -> IRQ 22
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xe1 -> IRQ 23 Mode:1 Active:1)
00:00:03[D] -> 2-23 -> IRQ 23
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
ACPI: Power Button (FF) [PWRF]
acpi_processor-2117 [22] acpi_processor_get_inf: Invalid PBLK length [5]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,EPP,ECP]
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 6Y080P0, ATA DISK drive
hdb: Maxtor 53073H6, ATA DISK drive
blk: queue c03eb8e0, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c03eba1c, I/O limit 4095Mb (mask 0xffffffff)
hdc: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=9964/255/63, UDMA(133)
hdb: attached ide-disk driver.
hdb: host protected area => 1
hdb: 60030432 sectors (30736 MB) w/2048KiB Cache, CHS=3736/255/63, UDMA(100)
hdc: attached ide-cdrom driver.
hdc: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
 hdb: hdb1
Promise Fasttrak(tm) Softwareraid driver 0.03beta: No raid array found
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
ehci_hcd 00:03.3: Silicon Integrated Systems [SiS] USB 2.0 Controller
ehci_hcd 00:03.3: irq 23, pci mem e0806000
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:03.3: ehci_start hcs_params 0x103206 dbg=1 cc=3 pcc=2 ordered !ppc ports=6
ehci_hcd 00:03.3: ehci_start hcc_params 7070 thresh 7 uframes 1024
ehci_hcd 00:03.3: capability 0001 at 70
ehci_hcd 00:03.3: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
PCI: cache line size of 128 is not supported by device 00:03.3
ehci_hcd 00:03.3: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci_hcd 00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hcd.c: 00:03.3 root hub device address 1
usb.c: kmalloc IF dfe47980, numif 1
usb.c: new device strings: Mfr=3, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Manufacturer: Linux 2.4.23-pre6 ehci_hcd
Product: Silicon Integrated Systems [SiS] USB 2.0 Controller
SerialNumber: 00:03.3
hub.c: USB hub found
hub.c: 6 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: individual port over-current protection
hub.c: Single TT
hub.c: TT requires at most 8 FS bit times
hub.c: Port indicators are not supported
hub.c: power on to power good time: 0ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RRRRRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dfe47980
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
host/usb-uhci.c: $Revision: 1.275 $ time 16:26:45 Oct  1 2003
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
host/usb-ohci.c: USB OHCI at membase 0xe081a000, IRQ 20
host/usb-ohci.c: usb-00:03.0, Silicon Integrated Systems [SiS] USB 1.0 Controller
usb.c: new USB bus registered, assigned bus number 2
usb.c: kmalloc IF dfe47c00, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: e081a000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dfe47c00
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
host/usb-ohci.c: USB OHCI at membase 0xe081c000, IRQ 21
host/usb-ohci.c: usb-00:03.1, Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
usb.c: new USB bus registered, assigned bus number 3
usb.c: kmalloc IF dfe47e80, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: e081c000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dfe47e80
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
host/usb-ohci.c: USB OHCI at membase 0xe081e000, IRQ 22
host/usb-ohci.c: usb-00:03.2, Silicon Integrated Systems [SiS] USB 1.0 Controller (#3)
usb.c: new USB bus registered, assigned bus number 4
usb.c: kmalloc IF dfe0f280, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: e081e000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dfe0f280
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
usb.c: registered new driver usbscanner
scanner.c: 0.4.14:USB Scanner Driver
usb.c: registered new driver usblp
printer.c: v0.11: USB Printer Device Class driver
Initializing Cryptographic API
IEEE 802.2 LLC for Linux 2.1 (c) 1996 Tim Alpaerts
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 220k freed
VFS: Mounted root (ext2 filesystem).
ehci_hcd 00:03.3: GetStatus port 1 status 001403 POWER sig=k  CSC CONNECT
hub.c: port 1, portstatus 501, change 1, 480 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 501, change 1, 480 Mb/s
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 112k freed
hub.c: port 1, portstatus 501, change 0, 480 Mb/s
hub.c: port 1, portstatus 501, change 0, 480 Mb/s
hub.c: port 1, portstatus 501, change 0, 480 Mb/s
hub.c: port 1, portstatus 501, change 0, 480 Mb/s
ehci_hcd 00:03.3: port 1 low speed --> companion
ehci_hcd 00:03.3: GetStatus port 1 status 003002 POWER OWNER sig=se0  CSC
hub.c: port 1, portstatus 0, change 1, 12 Mb/s
ehci_hcd 00:03.3: free_config  devnum 0
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
ehci_hcd 00:03.3: GetStatus port 3 status 001803 POWER sig=j  CSC CONNECT
hub.c: port 3, portstatus 501, change 1, 480 Mb/s
hub.c: port 3 connection change
hub.c: port 3, portstatus 501, change 1, 480 Mb/s
hub.c: port 3, portstatus 501, change 0, 480 Mb/s
hub.c: port 3, portstatus 501, change 0, 480 Mb/s
hub.c: port 3, portstatus 501, change 0, 480 Mb/s
hub.c: port 3, portstatus 501, change 0, 480 Mb/s
hub.c: port 3, portstatus 511, change 0, 480 Mb/s
hub.c: port 3 of hub 1 not reset yet, waiting 10ms
hub.c: port 3, portstatus 511, change 0, 480 Mb/s
hub.c: port 3 of hub 1 not reset yet, waiting 10ms
ehci_hcd 00:03.3: port 3 full speed --> companion
ehci_hcd 00:03.3: GetStatus port 3 status 003001 POWER OWNER sig=se0  CONNECT
hub.c: port 3, portstatus 0, change 10, 12 Mb/s
ehci_hcd 00:03.3: free_config  devnum 0
hub.c: port 4, portstatus 100, change 0, 12 Mb/s
hub.c: port 5, portstatus 100, change 0, 12 Mb/s
hub.c: port 6, portstatus 100, change 0, 12 Mb/s
hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 303, change 10, 1.5 Mb/s
hub.c: new USB device 00:03.0-1, assigned address 2
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
Adding Swap: 1004020k swap-space (priority -1)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected SiS 648 chipset
agpgart: AGP aperture is 128M @ 0xe0000000
usb_control/bulk_msg: timeout
host/usb-ohci.c: unlink URB timeout
usb.c: USB device not responding, giving up (error=-12)
hub.c: port 1, portstatus 303, change 10, 1.5 Mb/s
hub.c: new USB device 00:03.0-1, assigned address 3
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
usb_control/bulk_msg: timeout
host/usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=3 (error=-110)
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 103, change 10, 12 Mb/s
hub.c: new USB device 00:03.2-1, assigned address 2
usb.c: kmalloc IF df804500, numif 3
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=3
usb.c: USB device number 2 default language ID 0x409
Manufacturer: Hewlett-Packard
Product: PSC 2100 Series
SerialNumber: MY2ACD80910F
usb.c: ignoring set_interface for dev 2, iface 1, alt 0
printer.c: usblp0: USB Bidirectional printer dev 2 if 1 alt 0 proto 2 vid 0x03F0 pid 0x2811
usb.c: usblp driver claimed interface df804518
usb.c: unhandled interfaces on device
usb.c: kusbd: /sbin/hotplug add 2
usb.c: kusbd: /sbin/hotplug add 2
usb.c: kusbd: /sbin/hotplug add 2
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
ehci_hcd 00:03.3: GetStatus port 1 status 003002 POWER OWNER sig=se0  CSC
hub.c: port 1, portstatus 0, change 1, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 0, change 1, 12 Mb/s
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
ehci_hcd 00:03.3: GetStatus port 3 status 003002 POWER OWNER sig=se0  CSC
hub.c: port 3, portstatus 0, change 1, 12 Mb/s
hub.c: port 3 connection change
hub.c: port 3, portstatus 0, change 1, 12 Mb/s
hub.c: port 4, portstatus 100, change 0, 12 Mb/s
hub.c: port 5, portstatus 100, change 0, 12 Mb/s
hub.c: port 6, portstatus 100, change 0, 12 Mb/s
sis900.c: v1.08.06 9/24/2002
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0x9800, IRQ 19, 00:e0:18:9d:4f:d0.
eth0: Media Link On 100mbps full-duplex 
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
eth1: ADMtek Comet rev 17 at 0x9400, 00:20:78:04:68:6F, IRQ 19.
eth0: no IPv6 routers present
lp0: using parport0 (interrupt-driven).
usb.c: registered new driver serial
usbserial.c: USB Serial support registered for Generic
usbserial.c: USB Serial Driver core v1.4

--------------020201060901040102060004
Content-Type: text/plain;
 name="config-2.4.23-pre6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-2.4.23-pre6"

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MPENTIUM4=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HIGHIO=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_DEBUG=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_STATS=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_MULTIPATH=m
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_AMANDA=y
CONFIG_IP_NF_TFTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_AMANDA=y
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_NAT_TFTP=y
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_IPV6=y
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_LOG=y
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_IPV6_SCTP__=y
CONFIG_VLAN_8021Q=m
CONFIG_IPX=m
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=y
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
CONFIG_BRIDGE=m
CONFIG_LLC=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_ATARAID=y
CONFIG_BLK_DEV_ATARAID_PDC=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_BLK_DEV_SR=m
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_BONDING=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_TULIP=m
CONFIG_SIS900=m
CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_SERIAL_EXTENDED=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m
CONFIG_INPUT_GAMEPORT=y
CONFIG_INPUT_NS558=m
CONFIG_INPUT_EMU10K1=m
CONFIG_INPUT_SERIO=y
CONFIG_INPUT_SERPORT=y
CONFIG_INPUT_ANALOG=m
CONFIG_INPUT_TMDC=m
CONFIG_INTEL_RNG=m
CONFIG_HW_RANDOM=m
CONFIG_RTC=y
CONFIG_AGP=m
CONFIG_AGP_SIS=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_QUOTA=y
CONFIG_QFMT_V2=m
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_HFS_FS=m
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_EFS_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_NTFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_ZISOFS_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=m
CONFIG_USB=y
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI=y
CONFIG_USB_OHCI=y
CONFIG_USB_PRINTER=y
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_DC2XX=m
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=y
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m
CONFIG_USB_CDCETHER=m
CONFIG_USB_USBNET=m
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_TIGL=m
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=16
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m

--------------020201060901040102060004--

