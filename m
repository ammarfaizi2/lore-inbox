Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263148AbTCSQtg>; Wed, 19 Mar 2003 11:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263149AbTCSQtf>; Wed, 19 Mar 2003 11:49:35 -0500
Received: from lgsx01.lg.ehu.es ([158.227.2.34]:29710 "EHLO lgsx01.lg.ehu.es")
	by vger.kernel.org with ESMTP id <S263148AbTCSQtQ> convert rfc822-to-8bit;
	Wed, 19 Mar 2003 11:49:16 -0500
Date: Wed, 19 Mar 2003 18:06:08 +0100
From: Luis Miguel Garcia <ktech@wanadoo.es>
To: linux-kernel@vger.kernel.org
Subject: Oops with pcmcia and 2.5.65
Message-Id: <20030319180608.5d34b7fe.ktech@wanadoo.es>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

I can see this oops when I insmod or modprobe i82365 module for pcmcia in my laptop.

Kernel 2.5.65. Here goes the dmesg:

Linux version 2.5.65 (root@txiki) (gcc versión 3.2.2) #1 Tue Mar 18 13:37:49 CET 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8c00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007fffc00 (ACPI data)
 BIOS-e820: 0000000007fffc00 - 0000000008000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32752
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 28656 pages, LIFO batch:6
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 SONY                       ) @ 0x000f6d20
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x07ffd513
ACPI: FADT (v001 SONY   H0       01540.00000) @ 0x07fffb65
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x07fffbd9
ACPI: DSDT (v001   SONY          01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
Sony Vaio laptop detected.
BIOS strings suggest APM reports battery life in minutes and wrong byte order.
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=linux2565 ro root=301
Initializing CPU#0
PID hash table entries: 512 (order 9: 4096 bytes)
Detected 331.511 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 653.31 BogoMIPS
Memory: 126728k/131008k available (1649k kernel code, 3744k reserved, 516k data, 88k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Mendocino) stepping 0a
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfd9be, last bus=0
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 246 entries (12 bytes)
biovec pool[1]:   4 bvecs: 246 entries (48 bytes)
biovec pool[2]:  16 bvecs: 246 entries (192 bytes)
biovec pool[3]:  64 bvecs: 246 entries (768 bytes)
biovec pool[4]: 128 bvecs: 123 entries (1536 bytes)
biovec pool[5]: 256 bvecs:  61 entries (3072 bytes)
ACPI: Subsystem revision 20030228
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 9)
ACPI: PCI Interrupt Link [LNKA] (IRQs *3)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs *9)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
Linux Plug and Play Support v0.95 (c) Adam Belay
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: ACPI BOOT descriptor is wrong length (39)
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Enabling SEP on CPU 0
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Limiting direct PCI/PCI transfers.
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
ACPI: Thermal Zone [ATF0] (24 C)
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc90-0xfc97, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc98-0xfc9f, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA MK6412MAT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 12685680 sectors (6495 MB), CHS=13424/15/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ACPI: (supports S0 S1 S2 S3 S4 S5)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,1), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,1)) for (ide0(3,1))
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 88k freed
Adding 144576k swap on /dev/hda2.  Priority:-1 extents:1
sonypi: Sony Programmable I/O Controller Driver v1.18.
sonypi: detected type1 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on
sonypi: enabled at irq=11, port1=0x10c0, port2=0x10c4
sonypi: device allocated minor is 63
Sony VAIO Jog Dial installed.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
ds: no socket drivers loaded!
PCI: Enabling device 00:0c.0 (0000 -> 0002)
Yenta IRQ list 04b0, PCI irq9
Socket status: 30000a20
ohci1394: $Rev: 801 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[fedf7000-fedf77ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[00:1023]  GUID[08004603002ea82a]  [Unknown] (Linux OHCI-1394)
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
Intel PCIC probe: not found.
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c02110c8
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c02110c8>]    Not tainted
EFLAGS: 00010246
eax: c8980c28   ebx: c8917884   ecx: 00000000   edx: 00000000
esi: c8917840   edi: c8980be0   ebp: c706c000   esp: c706df3c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 3087, threadinfo=c706c000 task=c78b40c0)
Stack: 0000000a c8980be0 c02df0d8 c02df0d8 c0210945 c8980be0 c8980be0 c02df0d8 
       c0210d83 c8980be0 c8980d40 c88ec340 c8980be0 00000000 00000019 0000001b 
       c740d8e0 c8965343 00000001 00003116 00000210 c8916160 c02df0d8 00000000 
Call Trace: [<c8980be0>]  [<c0210945>]  [<c8980be0>]  [<c8980be0>]  [<c0210d83>]  [<c8980be0>]  [<c8980d40>]  [<c88ec340>]  [<c8980be0>]  [<c8916160>]  [<c013031d>]  [<c010926b>] 
Code: 89 4a 04 89 11 89 40 04 89 47 48 89 3c 24 e8 75 fe ff ff 89 
 <6>cs: cb_alloc(bus 1): vendor 0x13d1, device 0xab02
PCI: Enabling device 01:00.0 (0000 -> 0003)
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x377 0x398-0x39f 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.


If any of you want for me to do some test, say it to me.

Thanks!

=============================================================
Luis Miguel Garcia Mancebo
Ingenieria Tecnica en Informatica de Gestion
Universidad de Deusto / University of Deusto
Bilbao / Spain
=============================================================
