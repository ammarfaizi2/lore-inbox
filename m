Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263178AbSKALqZ>; Fri, 1 Nov 2002 06:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264983AbSKALqU>; Fri, 1 Nov 2002 06:46:20 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:34013 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S263178AbSKALqS>; Fri, 1 Nov 2002 06:46:18 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 1 Nov 2002 13:31:32 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45: initrd broken?
Message-ID: <20021101123132.GA30901@bytesex.org>
References: <20021031170340.GA18058@bytesex.org> <Pine.GSO.4.21.0210311148190.16688-100000@weyl.math.psu.edu> <20021031192155.GA19825@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031192155.GA19825@bytesex.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 08:21:55PM +0100, Gerd Knorr wrote:
> > > 2.5.45 doesn't boot for me.  I'm using a initrd to load some modules.
> [ ... ]
> > > I can hook up a serial console to grab the exact messages if needed.
> > 
> > Please, do.
> 
> Here we go.

Updated today to the latest bk tree.  Still doesn't boot, but crashes
in a different way ...

  Gerd

Linux version 2.5.45 (kraxel@bogomips) (gcc version 3.2) #1 Fri Nov 1 10:34:45 CET 2002
Video mode to be used for restore is f07
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fffc000 (usable)
 BIOS-e820: 000000003fffc000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262140
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32764 pages, LIFO batch:7
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=2.5.45 ro root=306 console=ttyS0,115200n8 console=tty0
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 451.020 MHz processor.
Console: colour VGA+ 80x60
Calibrating delay loop... 890.88 BogoMIPS
Memory: 1034416k/1048560k available (1153k kernel code, 13216k reserved, 958k data, 112k init, 131056k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Katmai) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 450.0951 MHz.
..... host bus clock speed is 100.0211 MHz.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.9 (c) Adam Belay
PCI: PCI BIOS revision 2.10 entry at 0xf08b0, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
slab: reap timer started for cpu 0
Starting kswapd
highmem bounce pool size: 64 pages
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
Capability LSM initialized
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
[c1a16040] eventpoll: driver installed.
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DTLA-305040, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Pioneer DVD-ROM ATAPIModel DVD-104S 012, ATAPI CD/DVD-ROM drive
hdd: LG CD-RW CED-8080B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 80418240 sectors (41174 MB) w/380KiB Cache, CHS=5005/255/63, UDMA(33)
 hda: hda1 hda2 < hda5 hda6 hda7 > hda4
 hda4: <bsd: hda8 hda9 hda10 hda11 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Unable to handle kernel NULL pointer dereference at virtual address 0000005c
 printing eip:
c016e1cf
*pde = 00000000
Oops: 0002
 
CPU:    0
EIP:    0060:[<c016e1cf>]    Not tainted
EFLAGS: 00010246
EIP is at hash_and_remove+0x2f/0xa0
eax: 00000000   ebx: 0000005c   ecx: 0000005c   edx: c0227f72
esi: 00000000   edi: c1b21a40   ebp: f7dca7c0   esp: f7fa5eb4
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 1, threadinfo=f7fa4000 task=c1a16040)
Stack: c0227f72 00000077 c1b35a98 c1b35a40 f7dd5de0 c016c9e9 c1b21a40 c023db37 
       f7dd67a0 f7ff6120 c01aee3f c1b35a40 f7ff6120 c014471a f7dd5de0 f7dd67a0 
       f7dd67a0 c02cd020 00000000 00000000 c014241d f7dd67a0 c02cd020 f7dd67a0 
Call Trace:
 [<c016c9e9>] del_gendisk+0x109/0x140
 [<c01aee3f>] initrd_release+0x3f/0x60
 [<c014471a>] __fput+0xda/0xe0
 [<c014241d>] filp_close+0x4d/0x80
 [<c01424a0>] sys_close+0x50/0x60
 [<c01091d3>] syscall_call+0x7/0xb
 [<c01053d8>] prepare_namespace+0x148/0x1c0
 [<c010506f>] init+0x2f/0x150
 [<c0105040>] init+0x0/0x150
 [<c010730d>] kernel_thread_helper+0x5/0x18

Code: ff 4e 5c 0f 88 04 02 00 00 89 3c 24 8b 44 24 1c 89 44 24 04 
 <0>Kernel panic: Attempted to kill init!
 
