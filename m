Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132118AbQLIQrb>; Sat, 9 Dec 2000 11:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132120AbQLIQrV>; Sat, 9 Dec 2000 11:47:21 -0500
Received: from durham-ar1-228-164.dsl.gte.net ([4.35.228.164]:2821 "EHLO
	smtp.gte.net") by vger.kernel.org with ESMTP id <S132118AbQLIQrQ> convert rfc822-to-8bit;
	Sat, 9 Dec 2000 11:47:16 -0500
From: "Victor J. Orlikowski" <v.j.orlikowski@gte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <14898.23275.791179.32908@critterling.garfield.home>
Date: Sat, 9 Dec 2000 11:16:43 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.2.18pre25, S3, AMD K6-2, and MTRR.... addendum
X-Mailer: VM 6.87 under Emacs 20.7.1
Reply-To: v.j.orlikowski@gte.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies for following myself up. Here is slightly more info, if
it will help.

Linux version 2.2.18pre25 (root@critterling.garfield.home) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #2 Sat Dec 9 09:39:50 EST 2000
Detected 400915 kHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 799.53 BogoMIPS
Memory: 128092k/131072k available (852k kernel code, 408k reserved, 1664k data, 56k init)
Dentry hash table entries: 16384 (order 5, 128k)
Buffer cache hash table entries: 131072 (order 7, 512k)
Page cache hash table entries: 32768 (order 5, 128k)
VFS: Diskquotas version dquot_6.4.0 initialized
Enabling new style K6 write allocation for 128 Mb
CPU: L1 I Cache: 32K  L1 D Cache: 32K
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb640
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 131072 bhash 65536)
Initializing RT netlink socket
Starting kswapd v 1.5 
vesafb: enabling S3 linear frame buffer
vesafb: framebuffer at 0xe0000000, mapped to 0xc8800000, size 2048k
vesafb: mode is 640x480x16, linelength=1280, pages=0
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 80x30
fb0: VESA VGA frame buffer device
Serial driver version 4.27 with MANY_PORTS SHARE_IRQ enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS14 at 0x0100 (irq = 5) is a 16550A
pty: 2048 Unix98 ptys configured
Real Time Clock Driver v1.09
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM SIROCCO1700A, ATA DISK drive
hdb: ZIPCD 4x650, ATAPI CDROM drive
hdc: ST34321A, ATA DISK drive
hdd: 20DY, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: QUANTUM SIROCCO1700A, 1628MB w/75kB Cache, CHS=827/64/63, DMA
hdc: ST34321A, 4103MB w/128kB Cache, CHS=8894/15/63, UDMA
scsi : 0 hosts.
scsi : detected total.
Partition check:
 hda: hda1 hda2 hda3 hda4
 hdc: hdc1 hdc2 hdc3 hdc4
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 56k freed
Adding Swap: 131032k swap-space (priority -1)
ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
MAD16 audio driver Copyright (C) by Hannu Savolainen 1993-1996
CDROM Disabled.
Joystick port disabled.
YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft 1993-1996
parport0: PC-style at 0x378, irq 7, dma 2 [SPP,PS2,EPP]
parport_probe: failed
parport0: no IEEE-1284 device present.
ppa: Version 2.03 (for Linux 2.2.x)
ppa: Found device at ID 6, Attempting to use EPP 32 bit
ppa: Communication established with ID 6 using EPP 32 bit
scsi0 : Iomega VPI0 (ppa) interface
scsi : 1 host.
  Vendor: IOMEGA    Model: ZIP 100           Rev: J.03
  Type:   Direct-Access                      ANSI SCSI revision: 02
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xc8a5f000, IRQ 11
usb.c: new USB bus registered, assigned bus number 1
usb.c: USB new device connect, assigned device number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
mice: PS/2 mouse device common for all mice
usb.c: USB new device connect, assigned device number 2
mouse0: PS/2 mouse device for input0
input0: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on usb1:2.0


XFree86 Version 3.3.6 / X Window System
(protocol Version 11, revision 0, vendor release 6300)
Release Date: January 8 2000
	If the server is older than 6-12 months, or if your card is newer
	than the above date, look for a newer version before reporting
	problems.  (see http://www.XFree86.Org/FAQ)
Operating System: Linux 2.2.5-22smp i686 [ELF] 
Configured drivers:
  SVGA: server for SVGA graphics adaptors (Patchlevel 1):
      s3_savage, NV1, STG2000, RIVA 128, RIVA TNT, RIVA TNT2,
      RIVA ULTRA TNT2, RIVA VANTA, RIVA ULTRA VANTA, RIVA INTEGRATED,
      GeForce 256, GeForce DDR, Quadro, ET4000, ET4000W32, ET4000W32i,
      ET4000W32i_rev_b, ET4000W32i_rev_c, ET4000W32p, ET4000W32p_rev_a,
      ET4000W32p_rev_b, ET4000W32p_rev_c, ET4000W32p_rev_d, ET6000, ET6100,
      et3000, pvga1, wd90c00, wd90c10, wd90c30, wd90c24, wd90c31, wd90c33,
      gvga, r128, ati, sis86c201, sis86c202, sis86c205, sis86c215,
      sis86c225, sis5597, sis5598, sis6326, sis530, sis620, sis300, sis630,
      sis540, tvga8200lx, tvga8800cs, tvga8900b, tvga8900c, tvga8900cl,
      tvga8900d, tvga9000, tvga9000i, tvga9100b, tvga9200cxr, tgui9400cxi,
      tgui9420, tgui9420dgi, tgui9430dgi, tgui9440agi, cyber9320, tgui9660,
      tgui9680, tgui9682, tgui9685, cyber9382, cyber9385, cyber9388,
      cyber9397, cyber9520, cyber9525, 3dimage975, 3dimage985, cyber9397dvd,
      blade3d, cyberblade, clgd5420, clgd5422, clgd5424, clgd5426, clgd5428,
      clgd5429, clgd5430, clgd5434, clgd5436, clgd5446, clgd5480, clgd5462,
      clgd5464, clgd5465, clgd6205, clgd6215, clgd6225, clgd6235, clgd7541,
      clgd7542, clgd7543, clgd7548, clgd7555, clgd7556, ncr77c22, ncr77c22e,
      cpq_avga, mga2064w, mga1064sg, mga2164w, mga2164w AGP, mgag200,
      mgag100, mgag400, oti067, oti077, oti087, oti037c, al2101, ali2228,
      ali2301, ali2302, ali2308, ali2401, cl6410, cl6412, cl6420, cl6440,
      video7, ark1000vl, ark1000pv, ark2000pv, ark2000mt, mx, realtek,
      s3_virge, AP6422, AT24, AT3D, s3_svga, NM2070, NM2090, NM2093, NM2097,
      NM2160, NM2200, ct65520, ct65525, ct65530, ct65535, ct65540, ct65545,
      ct65546, ct65548, ct65550, ct65554, ct65555, ct68554, ct69000,
      ct64200, ct64300, mediagx, V1000, V2100, V2200, p9100, spc8110, i740,
      i740_pci, Voodoo Banshee, Voodoo3, i810, i810-dc100, i810e, smi,
      generic
(using VT number 4)

XF86Config: /usr/X11R6/lib/X11/XF86Config
(**) stands for supplied, (--) stands for probed/default values
	PEX extension module for XFree86 3.3.6 
(**) module pex5.so successfully loaded from /usr/X11R6/lib/modules/
	XIE extension module for XFree86 3.3.6 
(**) module xie.so successfully loaded from /usr/X11R6/lib/modules/
(**) XKB: keycodes: "xfree86"
(**) XKB: types: "default"
(**) XKB: compat: "default"
(**) XKB: symbols: "us(pc101)"
(**) XKB: geometry: "pc"
(**) XKB: rules: "xfree86"
(**) XKB: model: "microsoft"
(**) XKB: layout: "us"
(**) Mouse: type: IMPS/2, device: /dev/mouse, buttons: 5
(**) Mouse: zaxismapping: (-)4 (+)5
(**) SVGA: Graphics device ID: "Stealth 64"
(**) SVGA: Monitor ID: "Maxtech"
(**) FontPath set to "unix/:-1"
(--) SVGA: PCI: S3 Trio32/64 rev 84, Memory @ 0xe0000000
(--) SVGA: chipset:   Trio64V+ rev. 54
(--) SVGA: Using new style S3 MMIO
(--) SVGA: bus type: PCI
(--) SVGA: Ramdac type: s3_trio64v+ or compatible.
(--) SVGA: Max RAMDAC speed for this depth: 95 MHz
(--) SVGA: Using Trio32/64 programmable clock (MCLK 54.886 MHz)
(--) SVGA: chipset:  s3_svga
(--) SVGA: videoram: 2048k
(**) SVGA: Option "power_saver"
(**) SVGA: Using 16 bpp, Depth 16, Color weight: 565
(--) SVGA: Maximum allowed dot-clock: 95.000 MHz
(**) SVGA: Mode "1024x768": mode clock =  75.000
(**) SVGA: Virtual resolution set to 1024x768
(--) SVGA: Framebuffer aligned on 1024 pixel width
(--) SVGA: Linear mapped framebuffer at 0xe0000000
(--) SVGA: Using built-in S3 hardware cursor.
(--) SVGA: Using XAA (XFree86 Acceleration Architecture)
(--) SVGA: XAA: Solid filled rectangles
(--) SVGA: XAA: Screen-to-screen copy
(--) SVGA: XAA: 8x8 pattern fill
(--) SVGA: XAA: CPU to screen color expansion (TE/NonTE imagetext, TE/NonTE polytext)
(--) SVGA: XAA: Using 8 128x128 areas for pixmap caching
(--) SVGA: XAA: Caching tiles and stipples
(--) SVGA: XAA: General lines and segments
(--) SVGA: XAA: Dashed lines and segments

-- 
Victor J. Orlikowski
======================
v.j.orlikowski@gte.net
vjo@raleigh.ibm.com
vjo@us.ibm.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
