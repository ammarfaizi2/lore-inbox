Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270857AbTHFSNy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270858AbTHFSNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:13:53 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:41888 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S270857AbTHFSNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:13:38 -0400
Date: Wed, 6 Aug 2003 20:13:46 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: 2.4.22rc1 bug report
Message-ID: <20030806181346.GA23285@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Hubert Tonneau <hubert.tonneau@fullpliant.org>,
	linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
References: <03B790J11@hubert.heliogroup.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <03B790J11@hubert.heliogroup.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 06:07:30PM +0000, Hubert Tonneau wrote:
> It seams that 2.4.22 rc1 is raising a bug at boot time, also it seams to recover
> gracefully.
> See 'Unable to handle kernel NULL pointer dereference at virtual address 0000002c'
> in the kernel log attached below.

please could you decode this oops with ksymoops?

TIA,
Herbert

> 2.4.21 works fine, and I have not tested anything in the middle of 2.4.21 and
> 2.4.22rc1
> 
> Also as Marcelo suggested, I tester the box with memtest86 and it is fine.
> 
> Regards,
> Hubert Tonneau
> 
> 
> <4>Linux version 2.4.22 (root@hubert) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Wed Aug 6 03:07:09 CEST 2003
> <6>BIOS-provided physical RAM map:
> <4> BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
> <4> BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
> <4> BIOS-e820: 00000000000ea000 - 0000000000100000 (reserved)
> <4> BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
> <4> BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)
> <4> BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)
> <4> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> <5>255MB LOWMEM available.
> <4>On node 0 totalpages: 65520
> <4>zone(0): 4096 pages.
> <4>zone(1): 61424 pages.
> <4>zone(2): 0 pages.
> <6>Dell Inspiron 7500 machine detected. Disabling APM idle calls.
> <4>Kernel command line: auto BOOT_IMAGE=fullpliant ro root=301
> <6>Initializing CPU#0
> <4>Detected 751.716 MHz processor.
> <4>Console: colour dummy device 80x25
> <4>Calibrating delay loop... 1500.77 BogoMIPS
> <6>Memory: 257560k/262080k available (819k kernel code, 4132k reserved, 195k data, 80k init, 0k highmem)
> <6>Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
> <6>Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
> <6>Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> <6>Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
> <4>Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
> <6>CPU: L1 I cache: 16K, L1 D cache: 16K
> <6>CPU: L2 cache: 256K
> <7>CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
> <7>CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
> <4>CPU: Intel Pentium III (Coppermine) stepping 06
> <6>Enabling fast FPU save and restore... done.
> <6>Enabling unmasked SIMD FPU exception support... done.
> <6>Checking 'hlt' instruction... OK.
> <4>POSIX conformance testing by UNIFIX
> <4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> <4>mtrr: detected mtrr type: Intel
> <6>PCI: PCI BIOS revision 2.10 entry at 0xfd9ae, last bus=1
> <6>PCI: Using configuration type 1
> <6>PCI: Probing PCI hardware
> <4>PCI: Probing PCI hardware (bus 00)
> <6>PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
> <6>PCI: Found IRQ 11 for device 00:04.0
> <6>PCI: Sharing IRQ 11 with 00:04.1
> <6>PCI: Sharing IRQ 11 with 01:00.0
> <3>PCI: Cannot allocate resource region 4 of device 00:07.1
> <6>Limiting direct PCI/PCI transfers.
> <6>Linux NET4.0 for Linux 2.4
> <6>Based upon Swansea University Computer Society NET3.039
> <4>Initializing RT netlink socket
> <6>apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
> <4>Starting kswapd
> <6>vesafb: framebuffer at 0xfd000000, mapped to 0xd0800000, size 2560k
> <6>vesafb: mode is 1280x1024x8, linelength=1280, pages=5
> <6>vesafb: protected mode interface info at c000:506a
> <6>vesafb: scrolling: redraw
> <4>Console: switching to colour frame buffer device 160x64
> <6>fb0: VESA VGA frame buffer device
> <6>Real Time Clock Driver v1.10e
> <6>Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
> <6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> <6>PIIX4: IDE controller at PCI slot 00:07.1
> <6>PIIX4: chipset revision 1
> <6>PIIX4: not 100% native mode: will probe irqs later
> <6>    ide0: BM-DMA at 0x1080-0x1087, BIOS settings: hda:DMA, hdb:pio
> <6>    ide1: BM-DMA at 0x1088-0x108f, BIOS settings: hdc:DMA, hdd:pio
> <4>hda: IBM-DJSA-220, ATA DISK drive
> <4>blk: queue c0234de0, I/O limit 4095Mb (mask 0xffffffff)
> <4>hdc: MATSHITA CD-RW UJDA310, ATAPI CD/DVD-ROM drive
> <4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> <4>ide1 at 0x170-0x177,0x376 on irq 15
> <4>hda: attached ide-disk driver.
> <4>hda: host protected area => 1
> <6>hda: 39070080 sectors (20004 MB) w/1874KiB Cache, CHS=2584/240/63, UDMA(33)
> <6>Partition check:
> <6> hda: hda1 hda2
> <6>NET4: Linux TCP/IP 1.0 for NET4.0
> <6>IP Protocols: ICMP, UDP, TCP
> <6>IP: routing cache hash table of 2048 buckets, 16Kbytes
> <6>TCP: Hash tables configured (established 16384 bind 16384)
> <6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> <4>VFS: Mounted root (ext2 filesystem) readonly.
> <6>Freeing unused kernel memory: 80k freed
> <6>Linux PCMCIA Card Services 3.2.4
> <6>  kernel build: 2.4.22 #1 Wed Aug 6 03:07:09 CEST 2003
> <6>  options:  [pci] [cardbus] [apm]
> <6>Intel ISA/PCI/CardBus PCIC probe:
> <6>PCI: Found IRQ 11 for device 00:04.0
> <6>PCI: Sharing IRQ 11 with 00:04.1
> <6>PCI: Sharing IRQ 11 with 01:00.0
> <6>PCI: Found IRQ 11 for device 00:04.1
> <6>PCI: Sharing IRQ 11 with 00:04.0
> <6>PCI: Sharing IRQ 11 with 01:00.0
> <6>  TI 1225 rev 01 PCI-to-CardBus at slot 00:04, mem 0x10000000
> <6>    host opts [0]: [ring] [serial pci & irq] [pci irq 11] [lat 168/32] [bus 2/5]
> <6>    host opts [1]: [ring] [serial pci & irq] [pci irq 11] [lat 168/32] [bus 6/9]
> <6>    ISA irqs (scanned) = 3,4,7,10 PCI status changes
> <1>Unable to handle kernel NULL pointer dereference at virtual address 0000002c
> <4> printing eip:
> <4>c01800d6
> <1>*pde = 00000000
> <4>Oops: 0000
> <4>CPU:    0
> <4>EIP:    0010:[<c01800d6>]    Not tainted
> <4>EFLAGS: 00010046
> <4>eax: 00000006   ebx: 00000246   ecx: 00000024   edx: 00000006
> <4>esi: 0000001c   edi: 0000001c   ebp: c77d7b50   esp: c77d7b0c
> <4>ds: 0018   es: 0018   ss: 0018
> <4>Process cardctl (pid: 40, stackpage=c77d7000)
> <4>Stack: 00000024 c7804000 d0a88866 0000001c 00000024 ffffffff ff000000 00000006 
> <4>       c0121908 00000006 c01f21e0 000001ff 00000001 00000000 c780408c 00000000 
> <4>       00000286 c77d7b90 d0a88a51 c7804000 00000006 000001d2 cfe9a3a0 00000002 
> <4>Call Trace:    [<d0a88866>] [<c0121908>] [<d0a88a51>] [<d0a84b22>] [<c0121908>]
> <4>  [<c0121908>] [<c012a0a6>] [<c0120eed>] [<d0a84f3e>] [<c0121908>] [<d0a84d5b>]
> <4>  [<c01213c2>] [<c012190e>] [<d0a83b5f>] [<d0a9bc33>] [<c01c9c26>] [<c0121908>]
> <4>  [<c0147644>] [<c01239b3>] [<c012a2b0>] [<c012a0a6>] [<c0120db6>] [<c0123329>]
> <4>  [<c013266b>] [<c013085e>] [<c0130707>] [<c013077a>] [<c013122f>] [<c0124494>]
> <4>  [<c01244c1>] [<c0131850>] [<c014f2c9>] [<c014fe61>] [<c015265d>] [<c013917f>]
> <4>  [<c013b197>] [<c0106be3>]
> <4>
> <4>Code: 8b 46 10 8b 50 30 8b 44 24 14 50 51 56 8b 42 14 ff d0 83 c4 
> <4> <6>cs: cb_alloc(bus 2): vendor 0x10b7, device 0x5257
> <6>3c59x.c:v0.99Q 5/16/2000 Donald Becker, becker@scyld.com
> <6>  http://www.scyld.com/network/vortex.html
> <6>cs: cb_config(bus 2)
> <6>cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3f8-0x3ff 0x4d0-0x4d7
> <6>cs: IO port probe 0x0380-0x03f7: clean.
> <6>cs: IO port probe 0x0400-0x04cf: clean.
> <6>cs: IO port probe 0x04d8-0x04ff: clean.
> <6>cs: IO port probe 0x0800-0x08ff: clean.
> <6>cs: IO port probe 0x0a00-0x0aff: clean.
> <6>cs: IO port probe 0x0c00-0x0cff: clean.
> <6>  fn 0 bar 1: io 0x200-0x27f
> <6>  fn 0 bar 2: mem 0x60021000-0x6002107f
> <6>  fn 0 bar 3: mem 0x60020000-0x6002007f
> <6>  fn 0 rom: mem 0x60000000-0x6001ffff
> <6>  irq 11
> <7>cs: cb_enable(bus 2)
> <7>  bridge io map 0 (flags 0x21): 0x200-0x27f
> <7>  bridge mem map 0 (flags 0x1): 0x60000000-0x60021fff
> <6>vortex_attach(device 02:00.0)
> <6>eth0: 3Com 3CCFE575CT Tornado CardBus at 0x200, 00:01:02:e3:cc:c0, irq 11
> <6>  product code 'ZX' rev 10.0 date 10-19-00
> <6>  8K byte-wide RAM 5:3 Rx:Tx split, MII interface.
> <4>spurious 8259A interrupt: IRQ7.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
