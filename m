Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263097AbSJBKaJ>; Wed, 2 Oct 2002 06:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263098AbSJBKaI>; Wed, 2 Oct 2002 06:30:08 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:60354 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263097AbSJBKaE>; Wed, 2 Oct 2002 06:30:04 -0400
Date: Wed, 2 Oct 2002 12:35:12 +0200 (CEST)
From: eduard.epi@t-online.de (root)
To: linux-kernel@vger.kernel.org
Subject: [BUG] in 2.5.40 plain
Message-ID: <Pine.LNX.4.44.0210021232150.1129-100000@eduard.t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During bootup I get the following messages (dmesg):

Linux version 2.5.40 (root@eduard) (gcc version 3.0.4) #3 Mit Okt 2 11:36:01 CEST 2002
Video mode to be used for restore is f03
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131052
  DMA zone: 4096 pages
  Normal zone: 126956 pages
  HighMem zone: 0 pages
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=debian.old ro root=1601 auto
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 700.102 MHz processor.
Console: colour VGA+ 80x28
Calibrating delay loop... 1376.25 BogoMIPS
Memory: 516468k/524208k available (1259k kernel code, 7352k reserved, 453k data, 100k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0183fbff c1c3fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c3fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
CPU:     After generic, caps: 0183fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 699.0959 MHz.
..... host bus clock speed is 199.0988 MHz.
cpu: 0, clocks: 199988, slice: 99994
CPU0<T0:199984,T1:99984,D:6,S:99994,C:199988>
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xf1010, last bus=1
PCI: Using configuration type 1
adding '' to cpu class interfaces
usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
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
PCI: Disabling Via external APIC routing
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
pty: 256 Unix98 ptys configured
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 21) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 52049U4, ATA DISK drive
hdb: FUJITSU MPG3409AT E, ATA DISK drive
hda: DMA disabled
hdb: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: WDC WD400EB-00CPF0, ATA DISK drive
hdd: IBM-DHEA-36481, ATA DISK drive
hdc: DMA disabled
hdd: DMA disabled
Debug: sleeping function called from illegal context at slab.c:1374
dffcfe98 c0114d32 c0240f80 c0242fe7 0000055e c0318298 c0130b16 c0242fe7
       0000055e 00000003 dffcfeec c0318288 42007530 0001ff0c 00010003 00030004
       00000046 c0318298 c03182d0 c03181dc c0318298 c01bc9c0 c1581134 000001d0
Call Trace: [<c0114d32>] [<c0130b16>] [<c01bc9c0>] [<c01bca4d>] [<c01c2268>] [<c01c89c0>] [<c01c2495>] [<c01c2856>] [<c01c219d>] [<c01cef67>] [<c01c1233>] [<c01050a7>] [<c0105070>] [<c01054f9>]
spurious 8259A interrupt: IRQ7.
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 40020624 sectors (20491 MB) w/2048KiB Cache, CHS=2491/255/63, UDMA(66)
 hda: hda1
hdb: host protected area => 1
hdb: 80063424 sectors (40992 MB) w/2048KiB Cache, CHS=4983/255/63, UDMA(66)
 hdb: hdb1 hdb2
hdc: host protected area => 1
hdc: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, UDMA(66)
 hdc: hdc1 hdc2 < hdc5 hdc6 hdc7 >
hdd: 12692736 sectors (6499 MB) w/472KiB Cache, CHS=12592/16/63, UDMA(33)
 hdd: hdd1 hdd2
uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v2.0:USB HID core driver
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT2-fs warning (device ide1(22,1)): ext2_fill_super: mounting ext3 filesystem as ext2

VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 100k freed
Adding 1052816k swap on /dev/hdb1.  Priority:-1 extents:1
Real Time Clock Driver v1.11
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 3 for device 00:09.0
PCI: Sharing IRQ 3 with 00:0d.0
eth0: RealTek RTL8139 Fast Ethernet at 0xe088f000, 00:50:bf:08:85:96, IRQ 3
eth0:  Identified 8139 chip type 'RTL-8139B'
SCSI subsystem driver Revision: 1.00
sym53c8xx: setup=mpar:0,spar:0,tags:0,sync:50,burst:0,led:0,wide:1,diff:1,irqm:0, buschk:2
sym53c8xx: setup=hostid:7,offs:15,luns:1,pcifix:0,revprob:0,verb:2,debug:0x0,setlle_delay:10
PCI: Found IRQ 10 for device 00:0b.0
sym.0.11.0: setting PCI_COMMAND_PARITY...
sym.0.11.0: 53c810a detected with Symbios NVRAM
sym0: <810a> rev 0x23 on pci bus 0 device 11 function 0 irq 10
sym0: using memory mapped IO
sym0: Symbios NVRAM, ID 7, Fast-10, SE, NO parity
sym0: open drain IRQ line driver
sym0: using LOAD/STORE-based firmware.
sym0: initial SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 00/00/00/00/00/00
sym0: final   SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 03/0e/a0/01/80/00
sym0: SCSI BUS has been reset.
sym0: command processing suspended for 10 seconds
scsi0 : sym-2.1.16a
sym0: command processing resumed
  Vendor: TEAC      Model: CD-ROM CD-532S    Rev: 1.0A
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0e
  Type:   CD-ROM                             ANSI SCSI revision: 04
Debug: sleeping function called from illegal context at slab.c:1374
df7a1e48 c0114d32 c0240f80 c0242fe7 0000055e 000001d0 c0130d3f c0242fe7
       0000055e c16b8cc0 c0113a50 00000000 00000000 00000100 00000000 df7a1e90
       df7a0000 dffec000 00001000 00001000 000001d2 c012f79d 0000001c 000001d0
Call Trace: [<c0114d32>] [<c0130d3f>] [<c0113a50>] [<c012f79d>] [<c012faad>] [<c012fbaa>] [<e08a1471>] [<e08a57c0>] [<e0894f3d>] [<e08a1b29>] [<e08a57c0>] [<c01181d5>] [<e08a577c>] [<e089f060>] [<c0107253>]
bad: scheduling while atomic!
df7a1d30 c01139df c0240e40 00000001 c0276038 df7a1d58 df7a0000 df7a1e20
       e08bd020 df7a1da4 c0113c59 00000000 c16b8cc0 c0113a50 00000000 00000000
       df7a0000 e08bd020 df7a1d98 00000001 c16b8cc0 c0113a50 df7a1e24 df7a1e24
Call Trace: [<c01139df>] [<c0113c59>] [<c0113a50>] [<c0113a50>] [<c0124bb1>] [<c0124aa0>] [<c0124aa0>] [<c01a67d6>] [<c01a501c>] [<e089b497>] [<c01a4496>] [<c01a474d>] [<e08a17c5>] [<e08a4f57>] [<e08a4f50>] [<c01638ff>] [<c0163c5d>] [<e08a3706>] [<e08a5149>] [<e08a57c0>] [<e0894f6a>] [<e08a1b29>] [<e08a57c0>] [<c01181d5>] [<e08a577c>] [<e089f060>] [<c0107253>]
bad: scheduling while atomic!
df7a1d30 c01139df c0240e40 00000001 c0276038 df7a1d58 df7a0000 df7a1e20
       e08bf020 df7a1da4 c0113c59 00000000 c16b8cc0 c0113a50 00000000 00000000
       df7a0000 e08bf020 df7a1d98 00000001 c16b8cc0 c0113a50 df7a1e24 df7a1e24
Call Trace: [<c01139df>] [<c0113c59>] [<c0113a50>] [<c0113a50>] [<c0124bb1>] [<c0124aa0>] [<c0124aa0>] [<c01a67d6>] [<c01a501c>] [<e089b497>] [<c01a4496>] [<c01a474d>] [<e08a17c5>] [<e08a4f57>] [<e08a4f50>] [<c0163c5d>] [<e0893eab>] [<e08a57c0>] [<e0894f6a>] [<e08a1b29>] [<e08a57c0>] [<c01181d5>] [<e08a577c>] [<e089f060>] [<c0107253>]
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xe4000000
agpgart: Oops, don't init more than one agpgart device.
parport 0x378 (WARNING): CTR: wrote 0x0c, read 0x0b
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport1: PC-style at 0x9400, irq 9 [PCSPP,EPP]
parport1: cpp_daisy: aa5500ff(38)
parport1: assign_addrs: aa5500ff(38)
parport1: cpp_daisy: aa5500ff(38)
parport1: assign_addrs: aa5500ff(38)
lp0: using parport0 (interrupt-driven).
lp1: using parport1 (interrupt-driven).
FAT: Using codepage cp850
FAT: Using IO charset iso8859-15
FAT: Using codepage cp850
FAT: Using IO charset iso8859-15
FAT: Using codepage cp850
FAT: Using IO charset iso8859-15
FAT: Using codepage cp850
FAT: Using IO charset iso8859-15
FAT: Using codepage cp850
FAT: Using IO charset iso8859-15
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
PCI: Found IRQ 4 for device 00:0a.0
PPP BSD Compression module registered
PPP Deflate Compression module registered
Debug: sleeping function called from illegal context at /linux2/usr/src/linux-2.5.x/include/asm/semaphore.h:119
df3c1d04 c0114d32 c0240f80 e093f800 00000077 df25fc04 e0936386 e093f800
       00000077 df138c00 df3c0000 00000200 00000200 df25fc04 e0938151 dfe2d6c4
       00004140 00000200 e0938371 dfe2d6c4 00004140 00000200 c01c8550 c0318288
Call Trace: [<c0114d32>] [<e093f800>] [<e0936386>] [<e093f800>] [<e0938151>] [<e0938371>] [<c01c8550>] [<c01b5296>] [<c01d20e8>] [<c01b691e>] [<c01b89a2>] [<c01b8d79>] [<c01d20e8>] [<c01293f8>] [<c01b5e17>] [<c012963e>] [<c0113a50>] [<c011337a>] [<c011f4f4>] [<c011f3a6>] [<c011f5ba>] [<c010c5fc>] [<c013e946>] [<c014e4e3>] [<c010915f>] [<c0107253>]

Ksymoopsed this becomes:

ksymoops 2.4.5 on i686 2.5.40.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.40/ (default)
     -m /boot/System.map-2.5.40 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Machine check exception polling timer started.
cpu: 0, clocks: 199988, slice: 99994
dffcfe98 c0114d32 c0240f80 c0242fe7 0000055e c0318298 c0130b16 c0242fe7
       0000055e 00000003 dffcfeec c0318288 42007530 0001ff0c 00010003 00030004
       00000046 c0318298 c03182d0 c03181dc c0318298 c01bc9c0 c1581134 000001d0
Call Trace: [<c0114d32>] [<c0130b16>] [<c01bc9c0>] [<c01bca4d>] [<c01c2268>] [<c01c89c0>] [<c01c2495>] [<c01c2856>] [<c01c219d>] [<c01cef67>] [<c01c1233>] [<c01050a7>] [<c0105070>] [<c01054f9>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c0114d32 <__might_sleep+52/60>
Trace; c0130b16 <kmem_cache_alloc+26/1f0>
Trace; c01bc9c0 <blk_init_free_list+50/d0>
Trace; c01bca4d <blk_init_queue+d/e0>
Trace; c01c2268 <ide_init_queue+28/70>
Trace; c01c89c0 <do_ide_request+0/20>
Trace; c01c2495 <init_irq+1e5/380>
Trace; c01c2856 <hwif_init+76/270>
Trace; c01c219d <probe_hwif_init+1d/60>
Trace; c01cef67 <ide_setup_pci_device+57/60>
Trace; c01c1233 <via_init_one+33/40>
Trace; c01050a7 <init+37/1c0>
Trace; c0105070 <init+0/1c0>
Trace; c01054f9 <kernel_thread_helper+5/c>

8139too Fast Ethernet driver 0.9.26
df7a1e48 c0114d32 c0240f80 c0242fe7 0000055e 000001d0 c0130d3f c0242fe7
       0000055e c16b8cc0 c0113a50 00000000 00000000 00000100 00000000 df7a1e90
       df7a0000 dffec000 00001000 00001000 000001d2 c012f79d 0000001c 000001d0
Call Trace: [<c0114d32>] [<c0130d3f>] [<c0113a50>] [<c012f79d>] [<c012faad>] [<c012fbaa>] [<e08a1471>] [<e08a57c0>] [<e0894f3d>] [<e08a1b29>] [<e08a57c0>] [<c01181d5>] [<e08a577c>] [<e089f060>] [<c0107253>]
df7a1d30 c01139df c0240e40 00000001 c0276038 df7a1d58 df7a0000 df7a1e20
       e08bd020 df7a1da4 c0113c59 00000000 c16b8cc0 c0113a50 00000000 00000000
       df7a0000 e08bd020 df7a1d98 00000001 c16b8cc0 c0113a50 df7a1e24 df7a1e24
Call Trace: [<c01139df>] [<c0113c59>] [<c0113a50>] [<c0113a50>] [<c0124bb1>] [<c0124aa0>] [<c0124aa0>] [<c01a67d6>] [<c01a501c>] [<e089b497>] [<c01a4496>] [<c01a474d>] [<e08a17c5>] [<e08a4f57>] [<e08a4f50>] [<c01638ff>] [<c0163c5d>] [<e08a3706>] [<e08a5149>] [<e08a57c0>] [<e0894f6a>] [<e08a1b29>] [<e08a57c0>] [<c01181d5>] [<e08a577c>] [<e089f060>] [<c0107253>]
df7a1d30 c01139df c0240e40 00000001 c0276038 df7a1d58 df7a0000 df7a1e20
       e08bf020 df7a1da4 c0113c59 00000000 c16b8cc0 c0113a50 00000000 00000000
       df7a0000 e08bf020 df7a1d98 00000001 c16b8cc0 c0113a50 df7a1e24 df7a1e24
Call Trace: [<c01139df>] [<c0113c59>] [<c0113a50>] [<c0113a50>] [<c0124bb1>] [<c0124aa0>] [<c0124aa0>] [<c01a67d6>] [<c01a501c>] [<e089b497>] [<c01a4496>] [<c01a474d>] [<e08a17c5>] [<e08a4f57>] [<e08a4f50>] [<c0163c5d>] [<e0893eab>] [<e08a57c0>] [<e0894f6a>] [<e08a1b29>] [<e08a57c0>] [<c01181d5>] [<e08a577c>] [<e089f060>] [<c0107253>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c0114d32 <__might_sleep+52/60>
Trace; c0130d3f <kmalloc+5f/220>
Trace; c0113a50 <default_wake_function+0/40>
Trace; c012f79d <get_vm_area+1d/100>
Trace; c012faad <__vmalloc+3d/120>
Trace; c012fbaa <vmalloc+1a/20>
Trace; e08a1471 <[sg]sg_init+51/130>
Trace; e08a57c0 <[sg]sg_template+0/94>
Trace; e0894f3d <[scsi_mod]scsi_register_device+8d/150>
Trace; e08a1b29 <[sg]init_sg+19/50>
Trace; e08a57c0 <[sg]sg_template+0/94>
Trace; c01181d5 <sys_init_module+565/640>
Trace; e08a577c <[sg].rodata.end+2d7/2fb>
Trace; e089f060 <[sg]sg_open+0/2c0>
Trace; c0107253 <syscall_call+7/b>
Trace; c01139df <schedule+36f/380>
Trace; c0113c59 <wait_for_completion+d9/110>
Trace; c0113a50 <default_wake_function+0/40>
Trace; c0113a50 <default_wake_function+0/40>
Trace; c0124bb1 <call_usermodehelper+e1/f0>
Trace; c0124aa0 <__call_usermodehelper+0/30>
Trace; c0124aa0 <__call_usermodehelper+0/30>
Trace; c01a67d6 <dev_hotplug+1d6/230>
Trace; c01a501c <bus_for_each_drv+bc/110>
Trace; e089b497 <[scsi_mod]__module_parm_desc_max_scsi_luns+17/1f>
Trace; c01a4496 <device_attach+36/40>
Trace; c01a474d <device_register+14d/1a0>
Trace; e08a17c5 <[sg]sg_attach+215/340>
Trace; e08a4f57 <[sg]__module_parm_desc_def_reserved_size+117/665>
Trace; e08a4f50 <[sg]__module_parm_desc_def_reserved_size+110/665>
Trace; c01638ff <proc_register+f/90>
Trace; c0163c5d <create_proc_entry+6d/a0>
Trace; e08a3706 <[sg]sg_proc_init+66/a0>
Trace; e08a5149 <[sg]__module_parm_desc_def_reserved_size+309/665>
Trace; e08a57c0 <[sg]sg_template+0/94>
Trace; e0894f6a <[scsi_mod]scsi_register_device+ba/150>
Trace; e08a1b29 <[sg]init_sg+19/50>
Trace; e08a57c0 <[sg]sg_template+0/94>
Trace; c01181d5 <sys_init_module+565/640>
Trace; e08a577c <[sg].rodata.end+2d7/2fb>
Trace; e089f060 <[sg]sg_open+0/2c0>
Trace; c0107253 <syscall_call+7/b>
Trace; c01139df <schedule+36f/380>
Trace; c0113c59 <wait_for_completion+d9/110>
Trace; c0113a50 <default_wake_function+0/40>
Trace; c0113a50 <default_wake_function+0/40>
Trace; c0124bb1 <call_usermodehelper+e1/f0>
Trace; c0124aa0 <__call_usermodehelper+0/30>
Trace; c0124aa0 <__call_usermodehelper+0/30>
Trace; c01a67d6 <dev_hotplug+1d6/230>
Trace; c01a501c <bus_for_each_drv+bc/110>
Trace; e089b497 <[scsi_mod]__module_parm_desc_max_scsi_luns+17/1f>
Trace; c01a4496 <device_attach+36/40>
Trace; c01a474d <device_register+14d/1a0>
Trace; e08a17c5 <[sg]sg_attach+215/340>
Trace; e08a4f57 <[sg]__module_parm_desc_def_reserved_size+117/665>
Trace; e08a4f50 <[sg]__module_parm_desc_def_reserved_size+110/665>
Trace; c0163c5d <create_proc_entry+6d/a0>
Trace; e0893eab <[scsi_mod]scsi_build_commandblocks+6b/1e0>
Trace; e08a57c0 <[sg]sg_template+0/94>
Trace; e0894f6a <[scsi_mod]scsi_register_device+ba/150>
Trace; e08a1b29 <[sg]init_sg+19/50>
Trace; e08a57c0 <[sg]sg_template+0/94>
Trace; c01181d5 <sys_init_module+565/640>
Trace; e08a577c <[sg].rodata.end+2d7/2fb>
Trace; e089f060 <[sg]sg_open+0/2c0>
Trace; c0107253 <syscall_call+7/b>

df3c1d04 c0114d32 c0240f80 e093f800 00000077 df25fc04 e0936386 e093f800
       00000077 df138c00 df3c0000 00000200 00000200 df25fc04 e0938151 dfe2d6c4
       00004140 00000200 e0938371 dfe2d6c4 00004140 00000200 c01c8550 c0318288
Call Trace: [<c0114d32>] [<e093f800>] [<e0936386>] [<e093f800>] [<e0938151>] [<e0938371>] [<c01c8550>] [<c01b5296>] [<c01d20e8>] [<c01b691e>] [<c01b89a2>] [<c01b8d79>] [<c01d20e8>] [<c01293f8>] [<c01b5e17>] [<c012963e>] [<c0113a50>] [<c011337a>] [<c011f4f4>] [<c011f3a6>] [<c011f5ba>] [<c010c5fc>] [<c013e946>] [<c014e4e3>] [<c010915f>] [<c0107253>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c0114d32 <__might_sleep+52/60>
Trace; e093f800 <[snd-pcm]__kstrtab_snd_interval_muldivk+0/20>
Trace; e0936386 <[snd-pcm]snd_pcm_prepare+26/1f0>
Trace; e093f800 <[snd-pcm]__kstrtab_snd_interval_muldivk+0/20>
Trace; e0938151 <[snd-pcm]snd_pcm_common_ioctl1+91/260>
Trace; e0938371 <[snd-pcm]snd_pcm_playback_ioctl1+51/340>
Trace; c01c8550 <start_request+160/1c0>
Trace; c01b5296 <scrup+136/150>
Trace; c01d20e8 <vgacon_cursor+148/1d0>
Trace; c01b691e <lf+5e/70>
Trace; c01b89a2 <do_con_trol+da2/fa0>
Trace; c01b8d79 <do_con_write+1d9/6b0>
Trace; c01d20e8 <vgacon_cursor+148/1d0>
Trace; c01293f8 <do_no_page+178/2d0>
Trace; c01b5e17 <set_cursor+67/80>
Trace; c012963e <handle_mm_fault+ee/120>
Trace; c0113a50 <default_wake_function+0/40>
Trace; c011337a <scheduler_tick+1a/300>
Trace; c011f4f4 <update_process_times+24/30>
Trace; c011f3a6 <update_wall_time+16/50>
Trace; c011f5ba <do_timer+4a/100>
Trace; c010c5fc <timer_interrupt+bc/1a0>
Trace; c013e946 <vfs_write+96/160>
Trace; c014e4e3 <sys_ioctl+d3/2b0>
Trace; c010915f <do_IRQ+10f/130>
Trace; c0107253 <syscall_call+7/b>


4 warnings issued.  Results may not be reliable.

This is on an Athlon 700 UP with preempt enabled. Same result with gcc
3.2. On request I will provide more information.
I hope this helps.

Peter B

