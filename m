Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313827AbSEASRG>; Wed, 1 May 2002 14:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313854AbSEASRF>; Wed, 1 May 2002 14:17:05 -0400
Received: from [213.149.7.11] ([213.149.7.11]:3588 "HELO
	matrix.awr.open.net.pl") by vger.kernel.org with SMTP
	id <S313827AbSEASRD>; Wed, 1 May 2002 14:17:03 -0400
Date: Wed, 1 May 2002 20:17:03 +0200
From: Eugenij Butusov <dinorage@wp.pl>
To: Alan Cox <linux-kernel@vger.kernel.org>
Subject: Kernels 2.2.19-2.4.x. Why why why?
Message-ID: <20020501201703.A990@matrix.awr.open.net.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Description: letter
Content-Disposition: inline

Dear Alan,

 I'm writing to You because of my problem with kernels > 2.2.17.
This kernel is the last that works on my machine. I've tried almost
all, including 2.3.x and 2.5.x, but they simple don't work. After
compilation and reboot system starts as usual, but after few minutes,
when I'm trying to switch to different console, all freezes. On some
kernels I saw message like "timeout: AT keyborad not present?". But
the keyboard is on the right place. Usually there is no error/warning
messages at all (so I don't have any debug info). I've included my
dmesg (from 2.2.17) and interrupts. My hardware:

PROC: p200MMX
MB: pc chips, SiS, tx-pro m570(v12), apg, 1MB L2 cache, onboard soundpro
MEM: 64MB sdram
GFX: diamond viper v330 agp (4mb)
NIC: realtek8139 (D-Link NetEasy)
HDD: 2x3.2GB (samsung & seagate, both udma33)

The stranges thing is that I have other 2 OS's on this machine:
FreeBSD 4.5 and Windows98SE, and they works correctly and pretty
stable. Why Linux doesn't work? The main question is: what was
changed in kernel from version 2.2.17 to 2.2.19? Is there any
critical changes? I asked a lot of people, but they couldn't help
(in 99% the answer was: upgrade/check your hardware...). So I've
decided to write to You, the most known kernel hacker. If You won't
give me any answer, I'll probably just buy a new computer... 
Thank You for interesting in my problem. :) And sorry for my fatal
english. I'm waiting for Your reply.

Best regards,

-- 
Eugenij 'dino' Butusov
dinorage@wp.pl | dino@laizsme.edu.pl

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Description: dmesg_2.2.17
Content-Disposition: attachment; filename=dm2-2-17

Linux version 2.2.17 (dino@matrix.awr.open.net.pl) (gcc version 2.95.3 19991030 (prerelease)) #2 sob lut 23 00:41:31 CET 2002
Detected 200456 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 399.77 BogoMIPS
Memory: 62948k/65536k available (992k kernel code, 412k reserved, 1068k data, 116k init, 0k bigmem)
Dentry hash table entries: 8192 (order 4, 64k)
Buffer cache hash table entries: 65536 (order 6, 256k)
Page cache hash table entries: 16384 (order 4, 64k)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Intel Pentium MMX stepping 03
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
Intel Pentium with F0 0F bug - workaround enabled.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfdb61, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 65536 bhash 65536)
Initializing RT netlink socket
Starting kswapd v 1.5 
Detected PS/2 Mouse Port.
Serial driver version 4.27 with MANY_PORTS MULTIPORT SHARE_IRQ enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09
RAM disk driver initialized:  16 RAM disks of 4096K size
Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 01
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS5591
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG WU33205A (3.2GB), ATA DISK drive
hdc: ST33221A, ATA DISK drive
hdd: CRD-8320B, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: SAMSUNG WU33205A (3.2GB), 3090MB w/109kB Cache, CHS=785/128/63, UDMA(33)
hdc: ST33221A, 3077MB w/128kB Cache, CHS=6253/16/63, UDMA(33)
hdd: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12
raid5: measuring checksumming speed
raid5: MMX detected, trying high-speed MMX checksum routines
   pII_mmx   :   307.467 MB/sec
   p5_mmx    :   360.807 MB/sec
   8regs     :   218.313 MB/sec
   32regs    :   172.212 MB/sec
using fastest function: p5_mmx (360.807 MB/sec)
md.c: sizeof(mdp_super_t) = 4096
Partition check:
 hda: hda1 hda2 < hda5 > hda3! < hda6 hda7 >
 hdc: [PTBL] [781/128/63] hdc1 hdc2 < hdc5 >
autodetecting RAID arrays
autorun ...
... autorun DONE.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 116k freed
Adding Swap: 133016k swap-space (priority -1)
rtl8139.c:v1.07 5/6/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/rtl8139.html
eth0: RealTek RTL8139 Fast Ethernet at 0xdc00, IRQ 11, 00:50:ba:5d:37:4c.
parport0: PC-style at 0x378 [SPP,PS2,EPP]
parport_probe: succeeded
parport0: Printer, HEWLETT-PACKARD DESKJET 720C
lp0: using parport0 (polling).

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Description: interrupts
Content-Disposition: attachment; filename=in2-2-17

           CPU0       
  0:     217772          XT-PIC  timer
  1:      18072          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
 11:       2972          XT-PIC  eth0
 12:       7948          XT-PIC  PS/2 Mouse
 13:          0          XT-PIC  fpu
 14:         19          XT-PIC  ide0
 15:       5374          XT-PIC  ide1
NMI:          0

--h31gzZEtNLTqOjlF--
