Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318782AbSHBLa6>; Fri, 2 Aug 2002 07:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318783AbSHBLa6>; Fri, 2 Aug 2002 07:30:58 -0400
Received: from [195.63.194.11] ([195.63.194.11]:33542 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318782AbSHBLa4>; Fri, 2 Aug 2002 07:30:56 -0400
Message-ID: <3D4A6D14.6020805@evision.ag>
Date: Fri, 02 Aug 2002 13:29:24 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.30 ide problems booting
References: <200208020726.51659.tomlins@cam.org>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Ed Tomlinson napisa?:
> Hi,
> 
> I get the following booting 2.5.30:
> 
> Linux version 2.5.30 (ed@oscar) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Thu Aug 1 21:16:02 EDT 2002
> Video mode to be used for restore is f00
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
>  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
>  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 511MB LOWMEM available.
> On node 0 totalpages: 131056
> zone(0): 4096 pages.
> zone(1): 126960 pages.
> zone(2): 0 pages.
> Kernel command line: BOOT_IMAGE=Linux25 ro root=2103 console=tty0 console=ttyS0,38400 video=matrox:mem:32 idebus=33
> idebus=33
> Initializing CPU#0
> Detected 400.879 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 790.52 BogoMIPS
> Memory: 516836k/524224k available (1076k kernel code, 7004k reserved, 324k data, 208k init, 0k highmem)
> Security Scaffold v1.0.0 initialized
> Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> Enabling new style K6 write allocation for 511 Mb
> CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
> CPU: L2 Cache: 256K (32 bytes/line)
> CPU: AMD-K6(tm) 3D+ Processor stepping 01
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> mtrr: detected mtrr type: AMD K6
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> PCI: PCI BIOS revision 2.10 entry at 0xfb520, last bus=1
> PCI: Using configuration type 1
> usb.c: registered new driver usbfs
> usb.c: registered new driver hub
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Using IRQ router VIA [1106/0586] at 00:07.0
> Starting kswapd
> BIO: pool of 256 setup, 14Kb (56 bytes/bio)
> biovec: init pool 0, 1 entries, 12 bytes
> biovec: init pool 1, 4 entries, 48 bytes
> biovec: init pool 2, 16 entries, 192 bytes
> biovec: init pool 3, 64 entries, 768 bytes
> biovec: init pool 4, 128 entries, 1536 bytes
> biovec: init pool 5, 256 entries, 3072 bytes
> Capability LSM initialized
> Activating ISA DMA hang workarounds.
> Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
> matroxfb: Matrox Millennium G400 MAX (AGP) detected
> matroxfb: MTRR's turned on
> matroxfb: 640x480x8bpp (virtual: 640x26208)
> matroxfb: framebuffer at 0xE8000000, mapped to 0xe0805000, size 33554432
> Console: switching to colour frame buffer device 80x30
> fb0: MATROX VGA frame buffer device
> pty: 256 Unix98 ptys configured
> block: 256 slots per queue, batch=32
> ATA/ATAPI device driver v7.0.0
> ATA: PCI bus speed 33.3MHz
> ATA: VIA Technologies, Inc. Bus Master IDE, PCI slot 00:07.1
> ATA: chipset rev.: 6
> ATA: non-legacy mode: IRQ probe delayed
> VP_IDE: VIA vt82c586b (rev 47) ATA UDMA33 controller on PCI 00:07.1
>     ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
> ATA: Promise Technology, Inc. 20267, PCI slot 00:09.0
> PCI: Found IRQ 12 for device 00:09.0
> ATA: chipset rev.: 2
> ATA: non-legacy mode: IRQ probe delayed
> Promise Technology, Inc. 20267: ROM enabled at 0xeb000000
> Promise Technology, Inc. 20267: (U)DMA BURST enabled, primary PCI mode, secondary PCI mode.
>     ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:pio
>     ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:DMA, hdh:DMA
> hda: QUANTUM FIREBALLP KA13.6, DISK drive
> hdc: CD-ROM 50X, ATAPI CD/DVD-ROM drive
> hdd: HP COLORADO 20GB, ATAPI TAPE drive
> hde: QUANTUM FIREBALLP AS40.0, DISK drive
> hdg: QUANTUM FIREBALLP AS40.0, DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0xac00-0xac07,0xb002 on irq 12
> ide3 at 0xb400-0xb407,0xb802 on irq 12
>  hda: 27067824 sectors w/371KiB Cache, CHS=26853/16/63, UDMA(33)
>  hda: hda1 hda2 hda3 hda4 < hda5 >
>  hde: 78177792 sectors w/1902KiB Cache, CHS=77557/16/63, UDMA(100)
>  hde: hde1 hde2 hde3 hde4 < hde5 >
>  hdg: 78177792 sectors w/1902KiB Cache, CHS=77557/16/63, UDMA(100)
>  hdg: hdg1 hdg2 hdg3 hdg4 < hdg5 >
> uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
> hcd-pci.c: uhci-hcd @ 00:07.2, VIA Technologies, Inc. UHCI USB
> hcd-pci.c: irq 10, io base 0000a400
> hcd.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found at /
> hub.c: 2 ports detected
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 32768)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> found reiserfs format "3.6" with standard journal
> Reiserfs journal params: device ide2(33,3), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> reiserfs: checking transaction log (ide2(33,3)) for (ide2(33,3))
> hde: dma_intr: bad DMA status (dma_stat=36)
> hde: ide_dma_intr: status=0x50 [ drive ready,seek complete] 
> hde: request error, nr. 1
> 
> The system did work compile from the bk tree before ide 110/111 were added.

But I guess that there where ide_dma_intr error messages still in the
log?

