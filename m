Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270194AbRHGLv5>; Tue, 7 Aug 2001 07:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270195AbRHGLvr>; Tue, 7 Aug 2001 07:51:47 -0400
Received: from iridium1.acn.gr ([213.5.40.19]:24477 "EHLO iridium1.int.acn.gr")
	by vger.kernel.org with ESMTP id <S270194AbRHGLvg>;
	Tue, 7 Aug 2001 07:51:36 -0400
Message-ID: <3B6FD644.7020409@cs.teiher.gr>
Date: Tue, 07 Aug 2001 14:51:32 +0300
From: Thodoris Pitikaris <thodoris@cs.teiher.gr>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.8-pre4 i686; en-US; rv:0.9.1) Gecko/20010622
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: is this a bug?
Content-Type: multipart/mixed;
 boundary="------------070100010706060005050408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070100010706060005050408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

As you will see in the attached file (it's a dmesg from the boot)
I have an 1Ghz athlon cpu with a VIA KT133 on a gigabyte GA-7ZX 
motherboard with 100mhz SDRAM.When I compiled the kernel with 
cputype=Athlon I continiusly experienced this crash.When I compiled with 
cputype=i686 everything went smooth (OS is Redhat 7.1)        
Yours

Theodore Pitikaris

--------------070100010706060005050408
Content-Type: text/plain;
 name="1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="1"

Linux version 2.4.8-pre4 (root@feidias.kerkyra.gr) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)) #1 Ôñé Áýã 7 13:28:12 EEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000bff0000 (usable)
 BIOS-e820: 000000000bff0000 - 000000000bff8000 (ACPI data)
 BIOS-e820: 000000000bff8000 - 000000000c000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 49136
zone(0): 4096 pages.
zone(1): 45040 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=new ro root=306 BOOT_FILE=/boot/2.4.8 lba32
Initializing CPU#0
Detected 1002.302 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1998.84 BogoMIPS
Memory: 191352k/196544k available (834k kernel code, 4804k reserved, 286k data, 188k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdb71, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA PCI latency patch (found VT82C686B).
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLlct08 17, ATA DISK drive
hdb: ST39140A, ATA DISK drive
hdc: ASUS DVD-ROM E608, ATAPI CD/DVD-ROM drive
hdd: SONY CDU4811, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 33906432 sectors (17360 MB) w/418KiB Cache, CHS=2110/255/63, UDMA(33)
hdb: 17803440 sectors (9115 MB) w/448KiB Cache, CHS=1108/255/63, UDMA(33)
hdc: ATAPI 40X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
Partition check:
 hda: hda1 hda2 < hda5 hda6 >
 hdb: hdb1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 149M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 188k freed
Adding Swap: 248968k swap-space (priority -1)
memory.c:83: bad pmd c5e77b40.
memory.c:83: bad pmd c5e5e000.
memory.c:83: bad pmd c020ac74.
memory.c:83: bad pmd c117f59c.
memory.c:83: bad pmd c020ac98.
memory.c:83: bad pmd 00000001.
memory.c:83: bad pmd 00000002.
kernel BUG at page_alloc.c:73!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0129603>]
EFLAGS: 00010282
eax: 0000001f   ebx: c1324048   ecx: 00000001   edx: c02099e4
esi: c1324048   edi: 00000000   ebp: c675e1d8   esp: cbc2de7c
ds: 0018   es: 0018   ss: 0018
Process ifup-aliases (pid: 161, stackpage=cbc2d000)
Stack: c01d98a6 c01d997a 00000049 c01cbf4f c11b0ac8 c117f844 c011fc7c c65ce000 
       c1324048 c1324048 00048000 c675e1d8 c012a535 4015dcbc ffffffff 00000001 
       c13cd440 c1324048 0000004a c011ef04 c1324048 0000002c 00000000 000c0000 
Call Trace: [<c01cbf4f>] [<c011fc7c>] [<c012a535>] [<c011ef04>] [<c010fd50>] [<c010fec6>] [<c0121638>] 
       [<c01385ba>] [<c0111a66>] [<c0115832>] [<c01109a4>] [<c010fd50>] [<c0106ecb>] 

Code: 0f 0b 83 c4 0c 8b 46 08 85 c0 74 16 6a 4b 68 7a 99 1d c0 68 
kernel BUG at page_alloc.c:73!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0129603>]
EFLAGS: 00010282
eax: 0000001f   ebx: c1324048   ecx: 00000001   edx: c02099e4
esi: c1324048   edi: 00000000   ebp: c66fb1d8   esp: cbc2de7c
ds: 0018   es: 0018   ss: 0018
Process ifup-aliases (pid: 163, stackpage=cbc2d000)
Stack: c01d98a6 c01d997a 00000049 c01cbf4f c11d34e0 c117f844 c011fc7c c6df4000 
       c1324048 c1324048 00048000 c66fb1d8 c012a535 4015dcbc ffffffff 00000001 
       c13cd380 c1324048 0000004a c011ef04 c1324048 0000002c 00000000 000c0000 
Call Trace: [<c01cbf4f>] [<c011fc7c>] [<c012a535>] [<c011ef04>] [<c010fd50>] [<c010fec6>] [<c0121638>] 
       [<c01385ba>] [<c0111a66>] [<c0115832>] [<c01109a4>] [<c010fd50>] [<c0106ecb>] 

Code: 0f 0b 83 c4 0c 8b 46 08 85 c0 74 16 6a 4b 68 7a 99 1d c0 68 
kernel BUG at page_alloc.c:73!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0129603>]
EFLAGS: 00010286
eax: 0000001f   ebx: c1324048   ecx: 00000001   edx: c02099e4
esi: c1324048   edi: 00000000   ebp: c6f511d8   esp: c4ab5b80
ds: 0018   es: 0018   ss: 0018
Process ifup-post (pid: 170, stackpage=c4ab5000)
Stack: c01d98a6 c01d997a 00000049 c4ab5c88 cbfe56c0 c01398ac cbfe55c0 00000001 
       c1324048 c1324048 00048000 c6f511d8 c012a535 08054b88 00000001 40016000 
       c4ab4000 c1324048 0000004a c011ef04 c1324048 0000002c 00000000 000c0000 
Call Trace: [<c01398ac>] [<c012a535>] [<c011ef04>] [<c0142cba>] [<c0122c43>] [<c0121638>] [<c0122d10>] 
       [<c01375a3>] [<c0137710>] [<c01454ff>] [<c01c5507>] [<c01450c0>] [<c0137c6f>] [<c0137efb>] [<c0138dad>] 
       [<c0105b4d>] [<c0106ecb>] 

Code: 0f 0b 83 c4 0c 8b 46 08 85 c0 74 16 6a 4b 68 7a 99 1d c0 68 
exit_mmap: map count is 25
PCI: Found IRQ 10 for device 00:0d.0
3c59x.c:LK1.1.15 6 June 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:0d.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xd400,  00:60:08:7e:13:4b, IRQ 10
  product code 4b4b rev 00.0 date 01-25-98
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786f.
  Enabling bus-master transmits and whole-frame receives.
00:0d.0: scatter/gather enabled. h/w checksums disabled
eth0: first available media type: MII
kernel BUG at page_alloc.c:73!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0129603>]
EFLAGS: 00010286
eax: 0000001f   ebx: c1324048   ecx: 00000001   edx: c02099e4
esi: c1324048   edi: 00000000   ebp: c609a1d8   esp: cbbafb80
ds: 0018   es: 0018   ss: 0018
Process S10network (pid: 256, stackpage=cbbaf000)
Stack: c01d98a6 c01d997a 00000049 cbbafc88 cbfe56c0 c01398ac cbfe55c0 00000001 
       c1324048 c1324048 00048000 c609a1d8 c012a535 cbbae000 080c5dd4 c0144a2c 
       080c5dd4 c1324048 0000004a c011ef04 c1324048 0000002c 00000000 000c0000 
Call Trace: [<c01398ac>] [<c012a535>] [<c0144a2c>] [<c011ef04>] [<c0142cba>] [<c0122c43>] [<c0121638>] 
       [<c0122d10>] [<c01375a3>] [<c0137710>] [<c01454ff>] [<c0137caf>] [<c01450c0>] [<c0137c6f>] [<c0137efb>] 
       [<c0138dad>] [<c0105b4d>] [<c0106ecb>] 

Code: 0f 0b 83 c4 0c 8b 46 08 85 c0 74 16 6a 4b 68 7a 99 1d c0 68 
exit_mmap: map count is 25
kernel BUG at page_alloc.c:168!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0129a84>]
EFLAGS: 00010082
eax: 00000020   ebx: c11600a4   ecx: 00000001   edx: c02099e4
esi: c020ac98   edi: 00000001   ebp: 00000000   esp: c9f97e54
ds: 0018   es: 0018   ss: 0018
Process S85gpm (pid: 365, stackpage=c9f97000)
Stack: c01d98a6 c01d997a 000000a8 000042d5 00000286 00000000 c020ac74 c020ac74 
       c020ae00 00000000 000000d2 c0129c74 00000001 c020adfc bfffefe0 c1312168 
       0b8f6065 c13cda40 c011fc41 c020ac74 c020ac74 c020ade0 00000000 bfffefe0 
Call Trace: [<c0129c74>] [<c011fc41>] [<c01202f0>] [<c01cbe3d>] [<c010fd50>] [<c010fec6>] [<c0111d4a>] 
       [<c0112757>] [<c012ef22>] [<c010fd50>] [<c0106fbc>] 

Code: 0f 0b 83 c4 0c ff 74 24 04 9d c7 43 14 01 00 00 00 8b 44 24 

--------------070100010706060005050408--

