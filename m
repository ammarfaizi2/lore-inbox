Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267770AbUHUU3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267770AbUHUU3M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 16:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267781AbUHUU3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 16:29:12 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:38355 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S267770AbUHUU0C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 16:26:02 -0400
Message-ID: <4127AF46.6090908@ttnet.net.tr>
Date: Sat, 21 Aug 2004 23:23:34 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: zaitcev@redhat.com, mdharm-usb@one-eyed-alien.net,
       marcelo.tosatti@cyclades.com
Subject: PANIC [2.4.27] usb-storage
Content-Type: multipart/mixed;
	boundary="------------070105020500010404060406"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070105020500010404060406
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

Here, I think I captured the panic correctly, ksymoops must be
reliable this time. This report is an extension to the thread
named "blacklist a device in usb-storage" at:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109250806001443&w=2

The dmesg output until  the panic are in dmesg2427v.out.
The painc info went through ksymoops is in panic-27.out.

Ozkan Sezer


--------------070105020500010404060406
Content-Type: text/plain;
	name="dmesg2427v.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="dmesg2427v.out"

Linux version 2.4.27 (ozzie@p733) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Sat Aug 21 21:43:04 EEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131068
zone(0): 4096 pages.
zone(1): 126972 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5a60
ACPI: RSDT (v001 ASUS   P3V_4X   0x30303031 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   P3V_4X   0x30303031 MSFT 0x31313031) @ 0x1fffc080
ACPI: BOOT (v001 ASUS   P3V_4X   0x30303031 MSFT 0x31313031) @ 0x1fffc040
ACPI: DSDT (v001   ASUS P3V_4X   0x00001000 MSFT 0x0100000b) @ 0x00000000
Kernel command line: BOOT_IMAGE=tt2427 ro root=LABEL=Maxtor40root
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 736.022 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1468.00 BogoMIPS
Memory: 514900k/524272k available (1457k kernel code, 8984k reserved, 552k data, 132k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 736.0588 MHz.
..... host bus clock speed is 133.8286 MHz.
cpu: 0, clocks: 1338286, slice: 669143
CPU0<T0:1338272,T1:669120,D:9,S:669143,C:1338286>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20040326
PCI: PCI BIOS revision 2.10 entry at 0xf0890, last bus=1
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:..............................................................................
Table [DSDT](id F004) - 257 Objects with 34 Devices 78 Methods 16 Regions
ACPI Namespace successfully loaded at root c032df3c
ACPI: IRQ9 SCI: Edge set to Level Trigger.
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0867 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000E420 on int 9
evregion-0251 [27] ev_address_space_dispa: No handler for Region [ECOS] (dffeb6e4) [SystemIO]
 exfldio-0283 [26] ex_access_region      : Region SystemIO(1) has no handler
 dswexec-0435 [16] ds_exec_end_op        : [Store]: Could not resolve operands, AE_NOT_EXIST
 psparse-1133: *** Error: Method execution failed [\SPRW] (Node dffea4e4), AE_NOT_EXIST
 psparse-1133: *** Error: Method execution failed [\_SB_.PCI0._PRW] (Node c161e704), AE_NOT_EXIST
  uteval-0154: *** Error: Method execution failed [\_SB_.PCI0._PRW] (Node c161e704), AE_NOT_EXIST
evgpeblk-0925 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 3 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:.................................................
Initialized 15/16 Regions 5/5 Fields 19/19 Buffers 10/11 Packages (266 nodes)
Executing all Device _STA and_INI methods:....................................
36 Devices found containing: 36 _STA, 0 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 *4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 4
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: BIOS reporting unknown device 00:70
PCI: Device 00:71 not found by BIOS
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
apm: overridden by ACPI.
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
vesafb: framebuffer at 0xd8000000, mapped to 0xe080a000, size 1875k
vesafb: mode is 800x600x16, linelength=1600, pages=3
vesafb: protected mode interface info at c000:c0f0
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
SiI680: IDE controller at PCI slot 00:0a.0
SiI680: chipset revision 2
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 133 
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
hda: ASUS CD-S520/A, ATAPI CD/DVD-ROM drive
hdb: RICOH CD-R/RW MP7200A, ATAPI CD/DVD-ROM drive
hdc: HL-DT-STDVD-ROM GDR8162B, ATAPI CD/DVD-ROM drive
hde: Maxtor 6E040L0, ATA DISK drive
blk: queue c03478c8, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xe09e0080-0xe09e0087,0xe09e008a on irq 4
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=79656/16/63, UDMA(133)
Partition check:
 hde: [PTBL] [4998/255/63] hde1 hde2 hde3 hde4 < hde5 hde6 >
ide: late registration of driver.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 402k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
inserting floppy driver for 2.4.27
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 132k freed
Real Time Clock Driver v1.10f
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
ehci_hcd 00:0e.2: VIA Technologies, Inc. USB 2.0
ehci_hcd 00:0e.2: irq 11, pci mem e0a33000
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:0e.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Dec-29/2.4
hub.c: USB hub found
hub.c: 4 ports detected
usb-uhci.c: $Revision: 1.275 $ time 21:54:58 Aug 21 2004
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0x9000, IRQ 4
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0x8800, IRQ 3
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,6), internal journal
Adding Swap: 522104k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
MSDOS FS: IO charset iso8859-1
MSDOS FS: Using codepage 850
MSDOS FS: IO charset iso8859-1
MSDOS FS: Using codepage 850
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: CPU0 already at revision 0x8 (current=0x8)
microcode: No suitable data for cpu 0
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
ACPI: Power Button (FF) [PWRF]
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport0: Printer, Hewlett-Packard HP LaserJet 5L
ip_tables: (C) 2000-2002 Netfilter core team
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:0b.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xa000. Vers LK1.1.18-ac
 00:60:08:6a:23:b5, IRQ 10
  product code 4b4b rev 00.0 date 12-26-95
  Internal config register is 16302d8, transceivers 0xe040.
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786f.
  Enabling bus-master transmits and whole-frame receives.
00:0b.0: scatter/gather enabled. h/w checksums disabled
eth0: Dropping NETIF_F_SG since no checksum feature.
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth1: RealTek RTL-8029 found at 0xd000, IRQ 3, 00:00:21:CB:93:F4.
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
Vortex: init.... <6>done.
Aureal Vortex 2 3D Sound Processor: vortex latency is 0xff
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport0: Printer, Hewlett-Packard HP LaserJet 5L
lp0: using parport0 (polling).
hub.c: new USB device 00:0e.1-2, assigned address 2
usb.c: USB device 2 (vend/prod 0xb86/0x5110) is not claimed by any active driver.
SCSI subsystem driver Revision: 1.00
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
scsi0 : SCSI emulation for USB Mass Storage devices
usb.c: USB disconnect on device 00:0e.1-2 address 2
usb-uhci.c: interrupt, status 3, frame# 592
hub.c: new USB device 00:0e.1-2, assigned address 3
scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 0 lun 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
USB Mass Storage support registered.
scsi1 : SCSI emulation for USB Mass Storage devices
usb-uhci.c: interrupt, status 3, frame# 1514
usb-uhci.c: interrupt, status 3, frame# 378
usb-uhci.c: interrupt, status 3, frame# 1292
usb-uhci.c: interrupt, status 3, frame# 157
usb-uhci.c: interrupt, status 3, frame# 1073
usb-uhci.c: interrupt, status 3, frame# 1986
usb-uhci.c: interrupt, status 3, frame# 852
usb-uhci.c: interrupt, status 3, frame# 1766
usb-uhci.c: interrupt, status 3, frame# 630
usb-uhci.c: interrupt, status 3, frame# 1544
scsi: device set offline - not ready or command retry failed after bus reset: host 1 channel 0 id 0 lun 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 3
usb-uhci.c: interrupt, status 3, frame# 409
usb-uhci.c: interrupt, status 3, frame# 1323
usb-uhci.c: interrupt, status 3, frame# 188
usb-uhci.c: interrupt, status 3, frame# 1104
usb-uhci.c: interrupt, status 3, frame# 2016
usb-uhci.c: interrupt, status 3, frame# 882
usb-uhci.c: interrupt, status 3, frame# 1797
usb-uhci.c: interrupt, status 3, frame# 662

--------------070105020500010404060406
Content-Type: text/plain;
	name="panic-27.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="panic-27.out"

ksymoops 2.4.5 on i686 2.4.27.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.27 (specified)
     -m /boot/System.map-2.4.27 (default)

Error (expand_objects): cannot stat(/lib/floppy.o) for floppy
Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Warning (map_ksym_to_module): cannot match loaded module floppy to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique module object.  Trace may not be reliable.
Unable to handle kernel paging request at virtual address e0ce6d90
 e0ce6d90
CPU: 0
EIP: 0010: [<e0ce6d90>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: dc3d5164   ebx: ffffffac   ecx: dc100003   edx: ffffffac
esi: 00000000   edi: deef44bc   ebp: dc161eb0   esp: dc161e8c
ds: 0018   es: 0018   ss: 0018
Process modprobe: (pid: 2025, stackpage= dc161000)
Stack:  e0a389bf   deef44bc   deef44bc   dc3d5164   df7b2440   dc3d5164   c1617ef0   c1617ed4
        deef44bc   dc161ee0   e0a38dd4   c1617ed4   deef44bc   e0a37c70   dc161ed4   e0a37d1d
        c1617e80   00000000   c1617ef0   00000001   c1617ed4   dc161f10   e0a38e77   c1617ed4
Call Trace:   [<e0a389bf>]   [<e0a38dd4>]   [<e0a37c70>]    [<e0a37d1d>]    [<e0a38e77>]
     [<c010a818>]    [<c010aa03>]    [<e0aeb364>]    [<c010d018>]    [<e0aeb364>]    [<c011ef09>]
     [<c011ebf9>]    [<c0108ea7>]
Code: Bad EIP value


>>EIP; e0ce6d90 <[usb-storage]usb_stor_CBI_irq+0/70>   <=====

>>eax; dc3d5164 <_end+1c082400/2068f2fc>
>>ebx; ffffffac <END_OF_CODE+1f313520/????>
>>ecx; dc100003 <_end+1bdad29f/2068f2fc>
>>edx; ffffffac <END_OF_CODE+1f313520/????>
>>edi; deef44bc <_end+1eba1758/2068f2fc>
>>ebp; dc161eb0 <_end+1be0f14c/2068f2fc>
>>esp; dc161e8c <_end+1be0f128/2068f2fc>

Trace; e0a389bf <[usb-uhci]process_interrupt+21f/260>
Trace; e0a38dd4 <[usb-uhci]process_urb+254/260>
Trace; e0a37c70 <[usb-uhci]rh_int_timer_do+0/50>
Trace; e0a37d1d <[usb-uhci]rh_init_int_timer+5d/70>
Trace; e0a38e77 <[usb-uhci]uhci_interrupt+97/170>
Trace; c010a818 <handle_IRQ_event+48/80>
Trace; c010aa03 <do_IRQ+83/f0>
Trace; e0aeb364 <[ppp_synctty].text.end+1c1/7dd>
Trace; c010d018 <call_do_IRQ+5/d>
Trace; e0aeb364 <[ppp_synctty].text.end+1c1/7dd>
Trace; c011ef09 <find_module+29/50>
Trace; c011ebf9 <sys_query_module+49/190>
Trace; c0108ea7 <system_call+33/38>

<0>Kernel panic: Aiee, killing interrupt handler!

2 warnings and 3 errors issued.  Results may not be reliable.

--------------070105020500010404060406--
