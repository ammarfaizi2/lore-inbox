Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263867AbUCZEyh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 23:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263934AbUCZEyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 23:54:37 -0500
Received: from 220-244-186-86-qld.tpgi.com.au ([220.244.186.86]:56616 "EHLO
	dawn.private.network") by vger.kernel.org with ESMTP
	id S263867AbUCZExJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 23:53:09 -0500
Subject: Re: RadeonFB
From: Oystein Haare <lkml-account@mazdaracing.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stewart Smith <stewart@flamingspork.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1080275242.1475.36.camel@gaston>
References: <1079366460.853.3.camel@dawn>  <1080187819.2763.1.camel@kennedy>
	 <1080254335.1195.37.camel@gaston>
	 <1080274786.1791.1.camel@dawn.private.network>
	 <1080275242.1475.36.camel@gaston>
Content-Type: multipart/mixed; boundary="=-r1PlOZ+uEtKbDvUl4bwJ"
Message-Id: <1080276555.1791.7.camel@dawn.private.network>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Mar 2004 14:49:15 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-r1PlOZ+uEtKbDvUl4bwJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached!

I use the ATI (fglrx) driver for XFree btw. 

On Fri, 2004-03-26 at 14:27, Benjamin Herrenschmidt wrote:
> On Fri, 2004-03-26 at 15:19, Oystein Haare wrote:
> > On Fri, 2004-03-26 at 08:38, Benjamin Herrenschmidt wrote:
> > > > > This is what it outputs:
> 
> Can you send me the full output from XFree too along with
> you XF86Config file ?
> 
> > > > > radeonfb: Found Intel x86 BIOS ROM Image
> > > > > radeonfb: Retreived PLL infos from BIOS
> > > > > radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz,
> > > > > System=220.00 MHz
> > > > > Non-DDC laptop panel detected
> > > > > radeonfb: Monitor 1 type LCD found
> > > > > radeonfb: Monitor 2 type no found
> > > > > radeonfb: panel ID string: Samsung LTN150P1-L02    
> > > > > radeonfb: detected LVDS panel size from BIOS: 1400x1050
> > > > > radeondb: BIOS provided dividers will be used
> > > > > radeonfb: Assuming panel size 1400x1050
> > > > > radeonfb: Power Management enabled for Mobility chipsets
> > > > > radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
> > > > > 
> > > > > Could the flickering have something to do with the fact that the lcd
> > > > > panel on my laptop can only do 1280x800 resolution? Or doesn't the
> > > > > 1400x1050 have anything to do with resolution at all?
> > > > >
> > > 
> > > That's weird. Yet another case of BIOS lying about the panel
> > > size. Can you try enabling DDC I2C probing ?
> > > 
> > > Ben.
> > 
> > Yes, didn't help.
> > Enabled debug output as well. Relevant dmesg output attached.
> > 
> > Oystein

--=-r1PlOZ+uEtKbDvUl4bwJ
Content-Disposition: attachment; filename=XFree86.0.log
Content-Type: text/plain; name=XFree86.0.log; charset=
Content-Transfer-Encoding: 7bit


This is a pre-release version of XFree86, and is not supported in any
way.  Bugs may be reported to XFree86@XFree86.Org and patches submitted
to fixes@XFree86.Org.  Before reporting bugs in pre-release versions,
please check the latest version in the XFree86 CVS repository
(http://www.XFree86.Org/cvs).

XFree86 Version 4.3.0.1 (Debian 4.3.0-7 20040318043201 root@cyberhq.internal.cyberhqz.com)
Release Date: 15 August 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.6.4 i686 [ELF] 
Build Date: 18 March 2004
	Before reporting problems, check http://www.XFree86.Org/
	to make sure that you have the latest version.
Module Loader present
OS Kernel: Linux version 2.6.1 (root@dawn) (gcc version 3.3.3 20031229 (prerelease) (Debian)) #1 SMP Sat Jan 10 03:44:54 CET 2004 TF
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/XFree86.0.log", Time: Fri Mar 26 14:13:09 2004
(==) Using config file: "/etc/X11/XF86Config-4"
(==) ServerLayout "Server Layout"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "Monitor0"
(**) |   |-->Device "ATI Graphics Adapter"
(**) |-->Input Device "USBMouse"
(**) |-->Input Device "Mouse1"
(**) |-->Input Device "Keyboard1"
(**) Option "AutoRepeat" "500 30"
(**) Option "XkbRules" "xfree86"
(**) XKB: rules: "xfree86"
(**) Option "XkbModel" "pc102"
(**) XKB: model: "pc102"
(**) Option "XkbLayout" "no"
(**) XKB: layout: "no"
(==) Keyboard: CustomKeycode disabled
(**) FontPath set to "/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/75dpi/:unscaled,/usr/X11R6/lib/X11/fonts/100dpi/:unscaled,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/100dpi/"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(--) using VT number 7

(WW) Open APM failed (/dev/apm_bios) (No such file or directory)
(II) Module ABI versions:
	XFree86 ANSI C Emulation: 0.2
	XFree86 Video Driver: 0.6
	XFree86 XInput driver : 0.4
	XFree86 Server Extension : 0.2
	XFree86 Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.6
(II) PCI: Probing config type using method 1
(II) PCI: Config type is 1
(II) PCI: stages = 0x03, oldVal1 = 0x8002203c, mode1Res1 = 0x80000000
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 8086,3340 card 0e11,0860 rev 03 class 06,00,00 hdr 00
(II) PCI: 00:01:0: chip 8086,3341 card 0000,0000 rev 03 class 06,04,00 hdr 01
(II) PCI: 00:1d:0: chip 8086,24c2 card 0e11,0860 rev 01 class 0c,03,00 hdr 80
(II) PCI: 00:1d:1: chip 8086,24c4 card 0e11,0860 rev 01 class 0c,03,00 hdr 00
(II) PCI: 00:1d:2: chip 8086,24c7 card 0e11,0860 rev 01 class 0c,03,00 hdr 00
(II) PCI: 00:1d:7: chip 8086,24cd card 0e11,0860 rev 01 class 0c,03,20 hdr 00
(II) PCI: 00:1e:0: chip 8086,2448 card 0000,0000 rev 81 class 06,04,00 hdr 01
(II) PCI: 00:1f:0: chip 8086,24cc card 0000,0000 rev 01 class 06,01,00 hdr 80
(II) PCI: 00:1f:1: chip 8086,24ca card 0e11,0860 rev 01 class 01,01,8a hdr 00
(II) PCI: 00:1f:3: chip 8086,24c3 card 0e11,0860 rev 01 class 0c,05,00 hdr 00
(II) PCI: 00:1f:5: chip 8086,24c5 card 0e11,0860 rev 01 class 04,01,00 hdr 00
(II) PCI: 00:1f:6: chip 8086,24c6 card 0e11,0860 rev 01 class 07,03,00 hdr 00
(II) PCI: 01:00:0: chip 1002,4c66 card 0e11,0860 rev 01 class 03,00,00 hdr 00
(II) PCI: 02:00:0: chip 1106,3044 card 1106,3044 rev 80 class 0c,00,10 hdr 00
(II) PCI: 02:01:0: chip 10ec,8139 card 0e11,0860 rev 20 class 02,00,00 hdr 00
(II) PCI: 02:02:0: chip 8086,1043 card 8086,2522 rev 04 class 02,80,00 hdr 00
(II) PCI: 02:04:0: chip 1524,1410 card 5000,0000 rev 01 class 06,07,00 hdr 02
(II) PCI: End of PCI scan
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,3), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:1:0), (0,1,1), BCTRL: 0x000c (VGA_EN is set)
(II) Bus 1 I/O range:
	[0] -1	0	0x00003000 - 0x000030ff (0x100) IX[B]
	[1] -1	0	0x00003400 - 0x000034ff (0x100) IX[B]
	[2] -1	0	0x00003800 - 0x000038ff (0x100) IX[B]
	[3] -1	0	0x00003c00 - 0x00003cff (0x100) IX[B]
(II) Bus 1 non-prefetchable memory range:
	[0] -1	0	0x90400000 - 0x904fffff (0x100000) MX[B]
(II) Bus 1 prefetchable memory range:
	[0] -1	0	0x98000000 - 0x9fffffff (0x8000000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 2: bridge is at (0:30:0), (0,2,3), BCTRL: 0x0006 (VGA_EN is cleared)
(II) Bus 2 I/O range:
	[0] -1	0	0x00002000 - 0x000020ff (0x100) IX[B]
	[1] -1	0	0x00002400 - 0x000024ff (0x100) IX[B]
	[2] -1	0	0x00002800 - 0x000028ff (0x100) IX[B]
	[3] -1	0	0x00002c00 - 0x00002cff (0x100) IX[B]
(II) Bus 2 non-prefetchable memory range:
	[0] -1	0	0x90000000 - 0x903fffff (0x400000) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:31:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(II) PCI-to-CardBus bridge:
(II) Bus 3: bridge is at (2:4:0), (2,3,6), BCTRL: 0x05c0 (VGA_EN is cleared)
(--) PCI:*(1:0:0) ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9] rev 1, Mem @ 0x98000000/27, 0x90400000/16, I/O @ 0x3000/8
(II) Addressable bus resource ranges are
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
	[1] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) PCI Memory resource overlap reduced 0xb0000000 from 0xbfffffff to 0xafffffff
(II) Active PCI resource ranges:
	[0] -1	0	0x90000000 - 0x90000fff (0x1000) MX[B]
	[1] -1	0	0x90300000 - 0x903000ff (0x100) MX[B]
	[2] -1	0	0x90200000 - 0x902007ff (0x800) MX[B]
	[3] -1	0	0xa0300000 - 0xa03000ff (0x100) MX[B]
	[4] -1	0	0xa0200000 - 0xa02001ff (0x200) MX[B]
	[5] -1	0	0x20000000 - 0x200003ff (0x400) MX[B]
	[6] -1	0	0xa0000000 - 0xa00003ff (0x400) MX[B]
	[7] -1	0	0xb0000000 - 0xafffffff (0x0) MX[B]O
	[8] -1	0	0x90400000 - 0x9040ffff (0x10000) MX[B](B)
	[9] -1	0	0x98000000 - 0x9fffffff (0x8000000) MX[B](B)
	[10] -1	0	0x00002000 - 0x000020ff (0x100) IX[B]
	[11] -1	0	0x00002400 - 0x0000247f (0x80) IX[B]
	[12] -1	0	0x00004800 - 0x0000487f (0x80) IX[B]
	[13] -1	0	0x00004400 - 0x000044ff (0x100) IX[B]
	[14] -1	0	0x00004880 - 0x000048bf (0x40) IX[B]
	[15] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[16] -1	0	0x00004c20 - 0x00004c3f (0x20) IX[B]
	[17] -1	0	0x00004c40 - 0x00004c4f (0x10) IX[B]
	[18] -1	0	0x00004c00 - 0x00004c1f (0x20) IX[B]
	[19] -1	0	0x000048e0 - 0x000048ff (0x20) IX[B]
	[20] -1	0	0x000048c0 - 0x000048df (0x20) IX[B]
	[21] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0	0x90000000 - 0x90000fff (0x1000) MX[B]
	[1] -1	0	0x90300000 - 0x903000ff (0x100) MX[B]
	[2] -1	0	0x90200000 - 0x902007ff (0x800) MX[B]
	[3] -1	0	0xa0300000 - 0xa03000ff (0x100) MX[B]
	[4] -1	0	0xa0200000 - 0xa02001ff (0x200) MX[B]
	[5] -1	0	0x20000000 - 0x200003ff (0x400) MX[B]
	[6] -1	0	0xa0000000 - 0xa00003ff (0x400) MX[B]
	[7] -1	0	0xb0000000 - 0xafffffff (0x0) MX[B]O
	[8] -1	0	0x90400000 - 0x9040ffff (0x10000) MX[B](B)
	[9] -1	0	0x98000000 - 0x9fffffff (0x8000000) MX[B](B)
	[10] -1	0	0x00002000 - 0x000020ff (0x100) IX[B]
	[11] -1	0	0x00002400 - 0x0000247f (0x80) IX[B]
	[12] -1	0	0x00004800 - 0x0000487f (0x80) IX[B]
	[13] -1	0	0x00004400 - 0x000044ff (0x100) IX[B]
	[14] -1	0	0x00004880 - 0x000048bf (0x40) IX[B]
	[15] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[16] -1	0	0x00004c20 - 0x00004c3f (0x20) IX[B]
	[17] -1	0	0x00004c40 - 0x00004c4f (0x10) IX[B]
	[18] -1	0	0x00004c00 - 0x00004c1f (0x20) IX[B]
	[19] -1	0	0x000048e0 - 0x000048ff (0x20) IX[B]
	[20] -1	0	0x000048c0 - 0x000048df (0x20) IX[B]
	[21] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x1fffffff (0x1ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x1fffffff (0x1ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x90000000 - 0x90000fff (0x1000) MX[B]
	[6] -1	0	0x90300000 - 0x903000ff (0x100) MX[B]
	[7] -1	0	0x90200000 - 0x902007ff (0x800) MX[B]
	[8] -1	0	0xa0300000 - 0xa03000ff (0x100) MX[B]
	[9] -1	0	0xa0200000 - 0xa02001ff (0x200) MX[B]
	[10] -1	0	0x20000000 - 0x200003ff (0x400) MX[B]
	[11] -1	0	0xa0000000 - 0xa00003ff (0x400) MX[B]
	[12] -1	0	0xb0000000 - 0xafffffff (0x0) MX[B]O
	[13] -1	0	0x90400000 - 0x9040ffff (0x10000) MX[B](B)
	[14] -1	0	0x98000000 - 0x9fffffff (0x8000000) MX[B](B)
	[15] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[16] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[17] -1	0	0x00002000 - 0x000020ff (0x100) IX[B]
	[18] -1	0	0x00002400 - 0x0000247f (0x80) IX[B]
	[19] -1	0	0x00004800 - 0x0000487f (0x80) IX[B]
	[20] -1	0	0x00004400 - 0x000044ff (0x100) IX[B]
	[21] -1	0	0x00004880 - 0x000048bf (0x40) IX[B]
	[22] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[23] -1	0	0x00004c20 - 0x00004c3f (0x20) IX[B]
	[24] -1	0	0x00004c40 - 0x00004c4f (0x10) IX[B]
	[25] -1	0	0x00004c00 - 0x00004c1f (0x20) IX[B]
	[26] -1	0	0x000048e0 - 0x000048ff (0x20) IX[B]
	[27] -1	0	0x000048c0 - 0x000048df (0x20) IX[B]
	[28] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension SHAPE
(II) Loading extension MIT-SUNDRY-NONSTANDARD
(II) Loading extension BIG-REQUESTS
(II) Loading extension SYNC
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XC-MISC
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-Misc
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension FontCache
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.2
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 2.0.2
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font FreeType
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_clip.o":  No symbols found
Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_norm.o":  No symbols found
Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_xform.o":  No symbols found
Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_vertex.o":  No symbols found
(II) Module GLcore: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension GLX
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension XFree86-DRI
(II) LoadModule: "fglrx"
(II) Loading /usr/X11R6/lib/modules/drivers/fglrx_drv.o
(II) Module fglrx: vendor="Fire GL - ATI Research GmbH, Germany"
	compiled for 4.3.0.1, module version = 3.7.6
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.6
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	Module class: XFree86 XInput Driver
	ABI class: XFree86 XInput driver, version 0.4
(II) LoadModule: "synaptics"
(II) Loading /usr/X11R6/lib/modules/input/synaptics_drv.o
(II) Module synaptics: vendor="The XFree86 Project"
	compiled for 4.2.0, module version = 1.0.0
	Module class: XFree86 XInput Driver
	ABI class: XFree86 XInput driver, version 0.3
(II) FireGL8700/8800: Driver for chipset: ATI RV250 Id (R9000),
	ATI RV250 Ie (R9000), ATI RV250 If (R9000), ATI RV250 Ig (R9000),
	ATI RV250 Ld (M9), ATI RV250 Le (M9), ATI RV250 Lf (M9),
	ATI RV250 Lg (M9), ATI RV280 5960 (R9200 PRO),
	ATI RV280 Ya (R9200LE), ATI RV250SE Yd (R9200SE),
	ATI RV250 5C61 (M9+), ATI RV250 5C63 (M9+), ATI R200 QH (R8500),
	ATI R200 QL (R8500), ATI R200 QM (R9100), ATI R200 QT (R8500),
	ATI R200 QU (R9100), ATI R200 BB (R8500), ATI RV350 AP (R9600),
	ATI RV350SE AQ (R9600SE), ATI RV350 AR (R9600 PRO),
	ATI RV350 NP (M10), ATI R300 AD (R9500), ATI R300 AE (R9500),
	ATI R300 AF (R9500), ATI R300 AG (Fire GL Z1/X1),
	ATI R300 ND (R9700 PRO), ATI R300 NE (R9700/R9500 PRO),
	ATI R300 NF (R9600 TX), ATI R300 NG (Fire GL X1),
	ATI R350SE AH (R9800SE), ATI R350 AK (Fire GL unknown),
	ATI RV350 AT (Fire GL T2), ATI RV350 AU (Fire GL T2),
	ATI RV350 AV (Fire GL T2), ATI RV350 AW (Fire GL T2),
	ATI R350 NH (R9800), ATI R350LE NI (R9800LE), ATI R350 NJ (R9800),
	ATI R350 NK (Fire GL X2), ATI RV350 NT (WS/M10)
(II) Primary Device is: PCI 01:00:0
(--) Chipset ATI RV250 Lf (M9) found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x1fffffff (0x1ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x90000000 - 0x90000fff (0x1000) MX[B]
	[6] -1	0	0x90300000 - 0x903000ff (0x100) MX[B]
	[7] -1	0	0x90200000 - 0x902007ff (0x800) MX[B]
	[8] -1	0	0xa0300000 - 0xa03000ff (0x100) MX[B]
	[9] -1	0	0xa0200000 - 0xa02001ff (0x200) MX[B]
	[10] -1	0	0x20000000 - 0x200003ff (0x400) MX[B]
	[11] -1	0	0xa0000000 - 0xa00003ff (0x400) MX[B]
	[12] -1	0	0xb0000000 - 0xafffffff (0x0) MX[B]O
	[13] -1	0	0x90400000 - 0x9040ffff (0x10000) MX[B](B)
	[14] -1	0	0x98000000 - 0x9fffffff (0x8000000) MX[B](B)
	[15] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[16] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[17] -1	0	0x00002000 - 0x000020ff (0x100) IX[B]
	[18] -1	0	0x00002400 - 0x0000247f (0x80) IX[B]
	[19] -1	0	0x00004800 - 0x0000487f (0x80) IX[B]
	[20] -1	0	0x00004400 - 0x000044ff (0x100) IX[B]
	[21] -1	0	0x00004880 - 0x000048bf (0x40) IX[B]
	[22] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[23] -1	0	0x00004c20 - 0x00004c3f (0x20) IX[B]
	[24] -1	0	0x00004c40 - 0x00004c4f (0x10) IX[B]
	[25] -1	0	0x00004c00 - 0x00004c1f (0x20) IX[B]
	[26] -1	0	0x000048e0 - 0x000048ff (0x20) IX[B]
	[27] -1	0	0x000048c0 - 0x000048df (0x20) IX[B]
	[28] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) fglrx(0): pEnt->device->identifier=0x820a298
(II) resource ranges after probing:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x1fffffff (0x1ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x90000000 - 0x90000fff (0x1000) MX[B]
	[6] -1	0	0x90300000 - 0x903000ff (0x100) MX[B]
	[7] -1	0	0x90200000 - 0x902007ff (0x800) MX[B]
	[8] -1	0	0xa0300000 - 0xa03000ff (0x100) MX[B]
	[9] -1	0	0xa0200000 - 0xa02001ff (0x200) MX[B]
	[10] -1	0	0x20000000 - 0x200003ff (0x400) MX[B]
	[11] -1	0	0xa0000000 - 0xa00003ff (0x400) MX[B]
	[12] -1	0	0xb0000000 - 0xafffffff (0x0) MX[B]O
	[13] -1	0	0x90400000 - 0x9040ffff (0x10000) MX[B](B)
	[14] -1	0	0x98000000 - 0x9fffffff (0x8000000) MX[B](B)
	[15] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[16] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[17] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[18] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[19] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[20] -1	0	0x00002000 - 0x000020ff (0x100) IX[B]
	[21] -1	0	0x00002400 - 0x0000247f (0x80) IX[B]
	[22] -1	0	0x00004800 - 0x0000487f (0x80) IX[B]
	[23] -1	0	0x00004400 - 0x000044ff (0x100) IX[B]
	[24] -1	0	0x00004880 - 0x000048bf (0x40) IX[B]
	[25] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[26] -1	0	0x00004c20 - 0x00004c3f (0x20) IX[B]
	[27] -1	0	0x00004c40 - 0x00004c4f (0x10) IX[B]
	[28] -1	0	0x00004c00 - 0x00004c1f (0x20) IX[B]
	[29] -1	0	0x000048e0 - 0x000048ff (0x20) IX[B]
	[30] -1	0	0x000048c0 - 0x000048df (0x20) IX[B]
	[31] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
	[32] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[33] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) fglrx(0): === [R200PreInit] === begin, [s]
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.6
(II) fglrx(0): PCI bus 1 card 0 func 0
(**) fglrx(0): Depth 24, (--) framebuffer bpp 32
(II) fglrx(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) fglrx(0): Default visual is TrueColor
(**) fglrx(0): Option "NoAccel" "no"
(**) fglrx(0): Option "NoDRI" "no"
(**) fglrx(0): Option "Capabilities" "0x00000000"
(**) fglrx(0): Option "GammaCorrectionI" "0x00000000"
(**) fglrx(0): Option "GammaCorrectionII" "0x00000000"
(**) fglrx(0): Option "OpenGLOverlay" "off"
(**) fglrx(0): Option "VideoOverlay" "on"
(**) fglrx(0): Option "DesktopSetup" "0x00000100"
(**) fglrx(0): Option "MonitorLayout" "AUTO, NONE"
(**) fglrx(0): Option "HSync2" "unspecified"
(**) fglrx(0): Option "VRefresh2" "unspecified"
(**) fglrx(0): Option "ScreenOverlap" "0"
(**) fglrx(0): Option "IgnoreEDID" "off"
(**) fglrx(0): Option "UseInternalAGPGART" "yes"
(**) fglrx(0): Option "Stereo" "off"
(**) fglrx(0): Option "StereoSyncEnable" "1"
(**) fglrx(0): Option "UseFastTLS" "2"
(**) fglrx(0): Option "BlockSignalsOnLock" "on"
(**) fglrx(0): Option "ForceGenericCPU" "no"
(**) fglrx(0): Option "CenterMode" "off"
(**) fglrx(0): Option "FSAAScale" "1"
(**) fglrx(0): Option "FSAADisableGamma" "no"
(**) fglrx(0): Option "FSAACustomizeMSPos" "no"
(**) fglrx(0): Option "FSAAMSPosX0" "0.000000"
(**) fglrx(0): Option "FSAAMSPosY0" "0.000000"
(**) fglrx(0): Option "FSAAMSPosX1" "0.000000"
(**) fglrx(0): Option "FSAAMSPosY1" "0.000000"
(**) fglrx(0): Option "FSAAMSPosX2" "0.000000"
(**) fglrx(0): Option "FSAAMSPosY2" "0.000000"
(**) fglrx(0): Option "FSAAMSPosX3" "0.000000"
(**) fglrx(0): Option "FSAAMSPosY3" "0.000000"
(**) fglrx(0): Option "FSAAMSPosX4" "0.000000"
(**) fglrx(0): Option "FSAAMSPosY4" "0.000000"
(**) fglrx(0): Option "FSAAMSPosX5" "0.000000"
(**) fglrx(0): Option "FSAAMSPosY5" "0.000000"
(**) fglrx(0): Option "NoTV" "no"
(**) fglrx(0): Option "TVStandard" "PAL-N"
(**) fglrx(0): Option "TVHSizeAdj" "0"
(**) fglrx(0): Option "TVVSizeAdj" "0"
(**) fglrx(0): Option "TVHPosAdj" "0"
(**) fglrx(0): Option "TVVPosAdj" "0"
(**) fglrx(0): Option "TVHStartAdj" "0"
(**) fglrx(0): Option "TVColorAdj" "0"
(**) fglrx(0): Option "PseudoColorVisuals" "off"
(**) fglrx(0): Qbs disabled
(==) fglrx(0): RGB weight 888
(II) fglrx(0): Using 8 bits per RGB (8 bit DAC)
(**) fglrx(0): Gamma Correction for I is 0x00000000
(**) fglrx(0): Gamma Correction for II is 0x00000000
(==) fglrx(0): Buffer Tiling is ON
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.6
(II) fglrx(0): initializing int10
(II) fglrx(0): Primary V_BIOS segment is: 0xc000
(--) fglrx(0): Chipset: "ATI RV250 Lf (M9)" (Chipset = 0x4c66)
(--) fglrx(0): (PciSubVendor = 0x0e11, PciSubDevice = 0x0860)
(--) fglrx(0): board vendor info: Compaq
(--) fglrx(0): Linear framebuffer (phys) at 0x98000000
(--) fglrx(0): MMIO registers at 0x90400000
(--) fglrx(0): ChipExtRevID = 0x01
(--) fglrx(0): ChipIntRevID = 0x00
(--) fglrx(0): VideoRAM: 65536 kByte (64-bit DDR SDRAM)
(II) fglrx(0): board/chipset is supported by this driver (Compaq board)
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.6
(II) Loading sub module "i2c"
(II) LoadModule: "i2c"
(II) Loading /usr/X11R6/lib/modules/libi2c.a
(II) Module i2c: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.2.0
	ABI class: XFree86 Video Driver, version 0.6
(II) fglrx(0): I2C bus "DDC" initialized.
(II) fglrx(0): Connector Layout from BIOS -------- 
(II) fglrx(0): Connector1: DDCType-3, DACType-0, TMDSType--1, ConnectorType-2
(**) fglrx(0): MonitorLayout Option: 
	Monitor1--Type AUTO, Monitor2--Type NONE

(II) fglrx(0): Primary head:
 Monitor   -- LVDS
 Connector -- None
 DAC Type  -- Unknown
 TMDS Type -- NONE
 DDC Type  -- NONE
(II) fglrx(0): Secondary head:
 Monitor   -- NONE
 Connector -- VGA
 DAC Type  -- Primary
 TMDS Type -- NONE
 DDC Type  -- VGA_DDC
(II) fglrx(0): 
(WW) fglrx(0): Only single display is connected, DesktopOption will be ignored
(II) fglrx(0): DesktopSetup 0x0000
(II) fglrx(0): Panel ID string: LCD                     
(II) fglrx(0): Panel Size from BIOS: 1280x800
(**) fglrx(0):  PseudoColor visuals disabled
(**) fglrx(0): Overlay disabled
(**) fglrx(0): Overlay disabled
(II) fglrx(0): PLL parameters: rf=2700 rd=12 min=20000 max=35000; xclk=22000
(==) fglrx(0): Using gamma correction (1.0, 1.0, 1.0)
(**) fglrx(0): Center Mode is disabled 
(==) fglrx(0): TMDS coherent mode is enabled 
(II) fglrx(0): Valid mode using on-chip RMX: 1280x800
(II) fglrx(0): Valid mode using on-chip RMX: 800x600
(II) fglrx(0): Total 2 valid mode(s) found.
(--) fglrx(0): Virtual size is 1280x800 (pitch 1280)
(**) fglrx(0): *Mode "1280x800": 70.0 MHz (scaled from 0.0 MHz), 48.6 kHz, 59.1 Hz
(II) fglrx(0): Modeline "1280x800"   70.00  1280 1328 1360 1440  800 802 808 823
(**) fglrx(0): *Mode "800x600": 70.0 MHz (scaled from 0.0 MHz), 48.6 kHz, 59.1 Hz
(II) fglrx(0): Modeline "800x600"   70.00  800 1328 1360 1440  600 802 808 823
(==) fglrx(0): DPI set to (75, 75)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.2
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.6
(**) fglrx(0): NoAccel = NO
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.1.0
	ABI class: XFree86 Video Driver, version 0.6
(==) fglrx(0): HPV inactive
(==) fglrx(0): FSAA enabled: NO
(**) fglrx(0): FSAA Gamma enabled
(**) fglrx(0): FSAA Multisample Position is fix
(**) fglrx(0): NoDRI = NO
(II) Loading sub module "fglrxdrm"
(II) LoadModule: "fglrxdrm"
(II) Loading /usr/X11R6/lib/modules/linux/libfglrxdrm.a
(II) Module fglrxdrm: vendor="Fire GL - ATI Research GmbH, Germany"
	compiled for 4.3.0.1, module version = 3.7.6
	ABI class: XFree86 Server Extension, version 0.2
(II) fglrx(0): Depth moves disabled by default
(**) fglrx(0): Capabilities: 0x00000000
(**) fglrx(0): cpuFlags: 0x8000001d
(**) fglrx(0): cpuSpeedMHz: 0x00000256
(==) fglrx(0): OpenGL ClientDriverName: "fglrx_dri.so"
(**) fglrx(0): using built in AGPGART module: yes
(**) fglrx(0): UseFastTLS=2
(**) fglrx(0): BlockSignalsOnLock=1
(==) fglrx(0): EnablePrivateBackZ = NO
(II) fglrx(0): using CAIL version [ATI LIB=CAIL.LIB,IA32,2.0024]
(--) Depth 24 pixmap format is 32 bpp
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] 0	0	0x90400000 - 0x9040ffff (0x10000) MX[B]
	[1] 0	0	0x98000000 - 0x9fffffff (0x8000000) MX[B]
	[2] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[3] -1	0	0x00100000 - 0x1fffffff (0x1ff00000) MX[B]E(B)
	[4] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[5] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[6] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[7] -1	0	0x90000000 - 0x90000fff (0x1000) MX[B]
	[8] -1	0	0x90300000 - 0x903000ff (0x100) MX[B]
	[9] -1	0	0x90200000 - 0x902007ff (0x800) MX[B]
	[10] -1	0	0xa0300000 - 0xa03000ff (0x100) MX[B]
	[11] -1	0	0xa0200000 - 0xa02001ff (0x200) MX[B]
	[12] -1	0	0x20000000 - 0x200003ff (0x400) MX[B]
	[13] -1	0	0xa0000000 - 0xa00003ff (0x400) MX[B]
	[14] -1	0	0xb0000000 - 0xafffffff (0x0) MX[B]O
	[15] -1	0	0x90400000 - 0x9040ffff (0x10000) MX[B](B)
	[16] -1	0	0x98000000 - 0x9fffffff (0x8000000) MX[B](B)
	[17] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[18] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[19] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[20] 0	0	0x00003000 - 0x000030ff (0x100) IX[B]
	[21] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[22] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[23] -1	0	0x00002000 - 0x000020ff (0x100) IX[B]
	[24] -1	0	0x00002400 - 0x0000247f (0x80) IX[B]
	[25] -1	0	0x00004800 - 0x0000487f (0x80) IX[B]
	[26] -1	0	0x00004400 - 0x000044ff (0x100) IX[B]
	[27] -1	0	0x00004880 - 0x000048bf (0x40) IX[B]
	[28] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[29] -1	0	0x00004c20 - 0x00004c3f (0x20) IX[B]
	[30] -1	0	0x00004c40 - 0x00004c4f (0x10) IX[B]
	[31] -1	0	0x00004c00 - 0x00004c1f (0x20) IX[B]
	[32] -1	0	0x000048e0 - 0x000048ff (0x20) IX[B]
	[33] -1	0	0x000048c0 - 0x000048df (0x20) IX[B]
	[34] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
	[35] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[36] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) fglrx(0): UMM area:     0x985e8000 (size=0x03a18000)
(II) fglrx(0): driver needs XFree86 version: 4.3.x
(II) fglrx(0): detected XFree86 version: 4.3.0
(II) Loading extension ATIFGLRXDRI
(II) fglrx(0): doing DRIScreenInit
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 6, (OK)
drmGetBusid returned ''
(II) fglrx(0): [drm] loaded kernel module for "fglrx" driver
(II) fglrx(0): [drm] created "fglrx" driver at busid "PCI:1:0:0"
(II) fglrx(0): [drm] added 8192 byte SAREA at 0xe492d000
(II) fglrx(0): [drm] mapped SAREA 0xe492d000 to 0x40231000
(II) fglrx(0): [drm] framebuffer handle = 0x98000000
(II) fglrx(0): [drm] added 1 reserved context for kernel
(II) fglrx(0): DRIScreenInit done
(II) fglrx(0): Kernel Module Version Information:
(II) fglrx(0):     Name: fglrx
(II) fglrx(0):     Version: 3.7.6
(II) fglrx(0):     Date: Mar  5 2004
(II) fglrx(0):     Desc: ATI Fire GL DRM kernel module
(II) fglrx(0): Kernel Module version matches driver.
(II) fglrx(0): Kernel Module Build Time Information:
(II) fglrx(0):     Build-Kernel UTS_RELEASE:        2.6.1
(II) fglrx(0):     Build-Kernel MODVERSIONS:        no
(II) fglrx(0):     Build-Kernel __SMP__:            no
(II) fglrx(0):     Build-Kernel PAGE_SIZE:          0x1000
(II) fglrx(0): [drm] register handle = 0x90400000
(II) fglrx(0): [agp] Mode=0x1f000217 bridge: 0x8086/0x3340
(II) fglrx(0): [agp] AGP v1/2 disable mask 0x00000000
(II) fglrx(0): [agp] AGP v3 disable mask   0x00000000
(II) fglrx(0): [agp] enabling AGP with mode=0x1f000314
(II) fglrx(0): [agp] AGP protocoll is enabled for grafics board. (cmd=0x1f000314)
(II) fglrx(0): [agp] grafics chipset has AGP v2.0
(II) fglrx(0): [drm] ringbuffer size = 0x00100000 bytes
(II) fglrx(0): [drm] DRM buffer queue setup: nbufs = 100 bufsize = 28672
(II) fglrx(0): [drm] texture shared area handle = 0xe8de2000
(II) fglrx(0): shared FSAAScale=1
(II) fglrx(0): DRI initialization successfull!
(II) fglrx(0): FBADPhys: 0x98000000 FBMappedSize: 0x005e8000
(II) fglrx(0): Splitting WC range: base: 0x98000000, size: 0x5e8000
(II) fglrx(0): Splitting WC range: base: 0x98400000, size: 0x1e8000
(II) fglrx(0): Splitting WC range: base: 0x98500000, size: 0xe8000
(II) fglrx(0): Splitting WC range: base: 0x98580000, size: 0x68000
(II) fglrx(0): Splitting WC range: base: 0x985c0000, size: 0x28000
(==) fglrx(0): Write-combining range (0x985e0000,0x8000)
(==) fglrx(0): Write-combining range (0x985c0000,0x28000)
(==) fglrx(0): Write-combining range (0x98580000,0x68000)
(==) fglrx(0): Write-combining range (0x98500000,0xe8000)
(==) fglrx(0): Write-combining range (0x98400000,0x1e8000)
(==) fglrx(0): Write-combining range (0x98000000,0x5e8000)
(II) fglrx(0): FBMM initialized for area (0,0)-(1280,1209)
(II) fglrx(0): FBMM auto alloc for area (0,0)-(1280,800) (front color buffer - assumption)
(==) fglrx(0): Backing store disabled
(==) fglrx(0): Silken mouse enabled
(II) fglrx(0): Using hardware cursor (scanline 800)
(II) fglrx(0): Largest offscreen area available: 1280 x 401
(**) Option "dpms"
(**) fglrx(0): DPMS enabled
(II) fglrx(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Solid Lines
	Dashed Lines
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		30 128x128 slots
(II) fglrx(0): Acceleration enabled
(II) fglrx(0): X context handle = 0x00000001
(II) fglrx(0): [DRI] installation complete
(II) fglrx(0): Direct rendering enabled
(II) Loading extension FGLRXEXTENSION
(II) Loading extension ATITVOUT
(==) RandR enabled
(II) Setting vga for screen 0.
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension LBX
(II) Initializing built-in extension XC-APPGROUP
(II) Initializing built-in extension SECURITY
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFree86-Bigfont
(II) Initializing built-in extension RENDER
(II) Initializing built-in extension RANDR
(**) Option "Protocol" "ImPS/2"
(**) USBMouse: Protocol: "ImPS/2"
(**) Option "AlwaysCore"
(**) USBMouse: always reports core events
(**) Option "Device" "/dev/psaux"
(**) USBMouse: Emulate3Buttons, Emulate3Timeout: 50
(**) Option "ZAxisMapping" "4 5"
(**) USBMouse: ZAxisMapping: buttons 4 and 5
(**) USBMouse: Buttons: 5
(II) Synaptics touchpad driver version 0.12.1
(--) Mouse1 auto-dev sets Synaptics Device to /dev/input/event1
(**) Option "Device" "/dev/input/event1"
(**) Option "SHMConfig" "on"
(**) Option "LeftEdge" "0"
(**) Option "RightEdge" "6000"
(**) Option "TopEdge" "0"
(**) Option "BottomEdge" "6000"
(**) Option "FingerLow" "25"
(**) Option "FingerHigh" "30"
(**) Option "MaxTapTime" "120"
(**) Option "MaxTapMove" "230"
(**) Option "VertScrollDelta" "100"
(**) Option "EdgeMotionSpeed" "0"
(**) Option "CorePointer"
(**) Mouse1: Core Pointer
(II) Keyboard "Keyboard1" handled by legacy driver
(II) XINPUT: Adding extended input device "Mouse1" (type: MOUSE)
(II) XINPUT: Adding extended input device "USBMouse" (type: MOUSE)
Synaptics DeviceInit called
SynapticsCtrl called.
(II) USBMouse: ps2EnableDataReporting: succeeded
Synaptics DeviceOn called

--=-r1PlOZ+uEtKbDvUl4bwJ
Content-Disposition: attachment; filename=XF86Config-4
Content-Type: text/plain; name=XF86Config-4; charset=
Content-Transfer-Encoding: 7bit

# File: XF86Config-4
# File generated by fglrxconfig (C) ATI Research, a substitute for xf86config.

# Note by ATI: the below copyright notice is there for servicing possibly
# pending third party rights on the file format and the instance of this file.
#
# Copyright (c) 1999 by The XFree86 Project, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
# THE XFREE86 PROJECT BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
# OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# 
# Except as contained in this notice, the name of the XFree86 Project shall
# not be used in advertising or otherwise to promote the sale, use or other
# dealings in this Software without prior written authorization from the
# XFree86 Project.
#

# **********************************************************************
# Refer to the XF86Config(4/5) man page for details about the format of 
# this file.
# **********************************************************************

# **********************************************************************
# DRI Section
# **********************************************************************
Section "dri"
# Access to OpenGL ICD is allowed for all users:
    Mode 0666
# Access to OpenGL ICD is restricted to a specific user group:
#    Group 100    # users
#    Mode 0660
EndSection

# **********************************************************************
# Module section -- this  section  is used to specify
# which dynamically loadable modules to load.
# **********************************************************************
#
Section "Module"

# This loads the DBE extension module.

    Load        "dbe"  	# Double buffer extension

# This loads the miscellaneous extensions module, and disables
# initialisation of the XFree86-DGA extension within that module.
    SubSection  "extmod"
#      Option    "omit xfree86-dga" 
    EndSubSection

# This loads the Type1 and FreeType font modules
    Load        "type1"
    Load        "freetype"

# This loads the GLX module
    Load        "glx"   # libglx.a
    Load        "dri"   # libdri.a

EndSection

# **********************************************************************
# Files section.  This allows default font and rgb paths to be set
# **********************************************************************

Section "Files"

# The location of the RGB database.  Note, this is the name of the
# file minus the extension (like ".txt" or ".db").  There is normally
# no need to change the default.

    RgbPath	"/usr/X11R6/lib/X11/rgb"

# Multiple FontPath entries are allowed (which are concatenated together),
# as well as specifying multiple comma-separated entries in one FontPath
# command (or a combination of both methods)
# 
# If you don't have a floating point coprocessor and emacs, Mosaic or other
# programs take long to start up, try moving the Type1 and Speedo directory
# to the end of this list (or comment them out).
# 

#    FontPath   "/usr/X11R6/lib/X11/fonts/local/"
    FontPath   "/usr/X11R6/lib/X11/fonts/misc/"
    FontPath   "/usr/X11R6/lib/X11/fonts/75dpi/:unscaled"
    FontPath   "/usr/X11R6/lib/X11/fonts/100dpi/:unscaled"
#    FontPath   "/usr/X11R6/lib/X11/fonts/Type1/"
#    FontPath   "/usr/X11R6/lib/X11/fonts/Speedo/"
    FontPath   "/usr/X11R6/lib/X11/fonts/75dpi/"
    FontPath   "/usr/X11R6/lib/X11/fonts/100dpi/"

# The module search path.  The default path is shown here.

#    ModulePath "/usr/X11R6/lib/modules"

EndSection

# **********************************************************************
# Server flags section.
# **********************************************************************

Section "ServerFlags"

# Uncomment this to cause a core dump at the spot where a signal is 
# received.  This may leave the console in an unusable state, but may
# provide a better stack trace in the core dump to aid in debugging

#    Option "NoTrapSignals"

# Uncomment this to disable the <Crtl><Alt><BS> server abort sequence
# This allows clients to receive this key event.

#    Option "DontZap"

# Uncomment this to disable the <Crtl><Alt><KP_+>/<KP_-> mode switching
# sequences.  This allows clients to receive these key events.

#    Option "Dont Zoom"

# Uncomment this to disable tuning with the xvidtune client. With
# it the client can still run and fetch card and monitor attributes,
# but it will not be allowed to change them. If it tries it will
# receive a protocol error.

#    Option "DisableVidModeExtension"

# Uncomment this to enable the use of a non-local xvidtune client. 

#    Option "AllowNonLocalXvidtune"

# Uncomment this to disable dynamically modifying the input device
# (mouse and keyboard) settings. 

#    Option "DisableModInDev"

# Uncomment this to enable the use of a non-local client to
# change the keyboard or mouse settings (currently only xset).

#    Option "AllowNonLocalModInDev"

EndSection

# **********************************************************************
# Input devices
# **********************************************************************

# **********************************************************************
# Core keyboard's InputDevice section
# **********************************************************************

Section "InputDevice"

    Identifier	"Keyboard1"
    Driver	"Keyboard"
# For most OSs the protocol can be omitted (it defaults to "Standard").
# When using XQUEUE (only for SVR3 and SVR4, but not Solaris),
# uncomment the following line.

#    Option "Protocol"   "Xqueue"

    Option "AutoRepeat" "500 30"

# Specify which keyboard LEDs can be user-controlled (eg, with xset(1))
#    Option "Xleds"      "1 2 3"

#    Option "LeftAlt"    "Meta"
#    Option "RightAlt"   "ModeShift"

# To customise the XKB settings to suit your keyboard, modify the
# lines below (which are the defaults).  For example, for a non-U.S.
# keyboard, you will probably want to use:
#    Option "XkbModel"   "pc102"
# If you have a US Microsoft Natural keyboard, you can use:
#    Option "XkbModel"   "microsoft"
#
# Then to change the language, change the Layout setting.
# For example, a german layout can be obtained with:
#    Option "XkbLayout"  "de"
# or:
#    Option "XkbLayout"  "de"
#    Option "XkbVariant" "nodeadkeys"
#
# If you'd like to switch the positions of your capslock and
# control keys, use:
#    Option "XkbOptions" "ctrl:swapcaps"

# These are the default XKB settings for XFree86
#    Option "XkbRules"   "xfree86"
#    Option "XkbModel"   "pc101"
#    Option "XkbLayout"  "us"
#    Option "XkbVariant" ""
#    Option "XkbOptions" ""

#    Option "XkbDisable"

    Option "XkbRules"	"xfree86"
    Option "XkbModel"	"pc102"
    Option "XkbLayout"	"no"

EndSection


# **********************************************************************
# Core Pointer's InputDevice section
# **********************************************************************

Section "InputDevice"

# Identifier and driver

    Identifier	"USBMouse"
    Driver "mouse"
    Option "Protocol"   "ImPS/2"
    Option "ZAxisMapping"   "4 5"
    Option "Device"     "/dev/psaux"

EndSection

Section "InputDevice"
# When using XQUEUE, comment out the above two lines, and uncomment
# the following line.

#    Option "Protocol"   "Xqueue"

# Baudrate and SampleRate are only for some Logitech mice. In
# almost every case these lines should be omitted.

#    Option "BaudRate"   "9600"
#    Option "SampleRate" "150"

# Emulate3Buttons is an option for 2-button Microsoft mice
# Emulate3Timeout is the timeout in milliseconds (default is 50ms)

#    Option "Emulate3Buttons"
#    Option "Emulate3Timeout"    "50"

# ChordMiddle is an option for some 3-button Logitech mice

#    Option "ChordMiddle"

#Synaptics

Driver 		"synaptics"
Identifier	"Mouse1"
Option		"Device" 	"/dev/psaux"
Option		"LeftEdge"	"0"
Option		"RightEdge"	"6000"
Option		"TopEdge"	"0"
Option		"BottomEdge"	"6000"
Option		"FingerLow"	"25"
Option		"FingerHigh"	"30"
Option		"MaxTapTime"	"120"
Option		"MaxTapMove"	"230"
Option		"VertScrollDelta" "100"
Option		"MinSpeed"	"0.07"
Option		"MaxSpeed"	"0.25"
Option		"AccelFactor"	"0.0008"
Option		"SHMConfig"	"on"
Option		"EdgeMotionSpeed"	"0"



EndSection


# **********************************************************************
# Other input device sections 
# this is optional and is required only if you
# are using extended input devices.  This is for example only.  Refer
# to the XF86Config man page for a description of the options.
# **********************************************************************
#
# Section "InputDevice" 
#    Identifier  "Mouse2"
#    Driver      "mouse"
#    Option      "Protocol"      "MouseMan"
#    Option      "Device"        "/dev/mouse2"
# EndSection
#
# Section "InputDevice"
#    Identifier "spaceball"
#    Driver     "magellan"
#    Option     "Device"         "/dev/cua0"
# EndSection
#
# Section "InputDevice"
#    Identifier "spaceball2"
#    Driver     "spaceorb"
#    Option     "Device"         "/dev/cua0"
# EndSection
#
# Section "InputDevice"
#    Identifier "touchscreen0"
#    Driver     "microtouch"
#    Option     "Device"         "/dev/ttyS0"
#    Option     "MinX"           "1412"
#    Option     "MaxX"           "15184"
#    Option     "MinY"           "15372"
#    Option     "MaxY"           "1230"
#    Option     "ScreenNumber"   "0"
#    Option     "ReportingMode"  "Scaled"
#    Option     "ButtonNumber"   "1"
#    Option     "SendCoreEvents"
# EndSection
#
# Section "InputDevice"
#    Identifier "touchscreen1"
#    Driver     "elo2300"
#    Option     "Device"         "/dev/ttyS0"
#    Option     "MinX"           "231"
#    Option     "MaxX"           "3868"
#    Option     "MinY"           "3858"
#    Option     "MaxY"           "272"
#    Option     "ScreenNumber"   "0"
#    Option     "ReportingMode"  "Scaled"
#    Option     "ButtonThreshold"    "17"
#    Option     "ButtonNumber"   "1"
#    Option     "SendCoreEvents"
# EndSection

# **********************************************************************
# Monitor section
# **********************************************************************

# Any number of monitor sections may be present

Section "Monitor"
    Identifier  "Monitor0"
    HorizSync   31.5       
    VertRefresh 60 - 85
    Option "DPMS"

# === mode lines based on GTF ===
# VGA @ 100Hz
# Modeline "640x480@100" 43.163 640 680 744 848 480 481 484 509 +hsync +vsync
# SVGA @ 100Hz
# Modeline "800x600@100" 68.179 800 848 936 1072 600 601 604 636 +hsync +vsync
# XVGA @ 100Hz
# Modeline "1024x768@100" 113.309 1024 1096 1208 1392 768 769 772 814 +hsync +vsync
# 1152x864 @ 60Hz
# Modeline "1152x864@60" 81.642 1152 1216 1336 1520 864 865 868 895 +hsync +vsync
# 1152x864 @ 85Hz
# Modeline "1152x864@85" 119.651 1152 1224 1352 1552 864 865 868 907 +hsync +vsync
# 1152x864 @ 100Hz
# Modeline "1152x864@100" 143.472 1152 1232 1360 1568 864 865 868 915 +hsync +vsync
# 1280x960 @ 75Hz
# Modeline "1280x960@75" 129.859 1280 1368 1504 1728 960 961 964 1002 +hsync +vsync
# 1280x960 @ 100Hz
# Modeline "1280x960@100" 178.992 1280 1376 1520 1760 960 961 964 1017  +hsync +vsync
# SXGA @ 100Hz
# Modeline "1280x1024@100" 190.960 1280 1376 1520 1760 1024 1025 1028 1085 +hsync +vsync
# SPEA GDM-1950 (60Hz,64kHz,110MHz,-,-): 1280x1024 @ V-freq: 60.00 Hz, H-freq: 63.73 KHz
# Modeline "GDM-1950"  109.62  1280 1336 1472 1720  1024 1024 1026 1062 -hsync -vsync
# 1600x1000 @ 60Hz
# Modeline "1600x1000" 133.142 1600 1704 1872 2144 1000 1001 1004 1035 +hsync +vsync
# 1600x1000 @ 75Hz
# Modeline "1600x1000" 169.128 1600 1704 1880 2160 1000 1001 1004 1044 +hsync +vsync
# 1600x1000 @ 85Hz
# Modeline "1600x1000" 194.202 1600 1712 1888 2176 1000 1001 1004 1050 +hsync +vsync
# 1600x1000 @ 100Hz
# Modeline "1600x1000" 232.133 1600 1720 1896 2192 1000 1001 1004 1059 +hsync +vsync
# 1600x1024 @ 60Hz
# Modeline "1600x1024" 136.385 1600 1704 1872 2144 1024 1027 1030 1060 +hsync +vsync
# 1600x1024 @ 75Hz
# Modeline "1600x1024" 174.416 1600 1712 1888 2176 1024 1025 1028 1069 +hsync +vsync
# 1600x1024 @ 76Hz
# Modeline "1600x1024" 170.450 1600 1632 1792 2096 1024 1027 1030 1070 +hsync +vsync
# 1600x1024 @ 85Hz
# Modeline "1600x1024" 198.832 1600 1712 1888 2176 1024 1027 1030 1075 +hsync +vsync
# 1920x1080 @ 60Hz
# Modeline "1920x1080" 172.798 1920 2040 2248 2576 1080 1081 1084 1118 -hsync -vsync
# 1920x1080 @ 75Hz
# Modeline "1920x1080" 211.436 1920 2056 2264 2608 1080 1081 1084 1126 +hsync +vsync
# 1920x1200 @ 60Hz
# Modeline "1920x1200" 193.156 1920 2048 2256 2592 1200 1201 1203 1242 +hsync +vsync
# 1920x1200 @ 75Hz
# Modeline "1920x1200" 246.590 1920 2064 2272 2624 1200 1201 1203 1253 +hsync +vsync
# 2048x1536 @ 60
# Modeline "2048x1536" 266.952 2048 2200 2424 2800 1536 1537 1540 1589 +hsync +vsync
# 2048x1536 @ 60
# Modeline "2048x1536" 266.952 2048 2200 2424 2800 1536 1537 1540 1589 +hsync +vsync
# 1400x1050 @ 60Hz M9 Laptop mode 
# ModeLine "1400x1050" 122.000 1400 1488 1640 1880 1050 1052 1064 1082 +hsync +vsync
# 1920x2400 @ 25Hz for IBM T221, VS VP2290 and compatible display devices
# Modeline "1920x2400@25" 124.620 1920 1928 1980 2048 2400 2401 2403 2434 +hsync +vsync
# 1920x2400 @ 30Hz for IBM T221, VS VP2290 and compatible display devices
# Modeline "1920x2400@30" 149.250 1920 1928 1982 2044 2400 2402 2404 2434 +hsync +vsync

EndSection


# **********************************************************************
# Graphics device section
# **********************************************************************

# Any number of graphics device sections may be present

# Standard VGA Device:

Section "Device"
    Identifier  "Standard VGA"
    VendorName  "Unknown"
    BoardName   "Unknown"

# The chipset line is optional in most cases.  It can be used to override
# the driver's chipset detection, and should not normally be specified.

#    Chipset     "generic"

# The Driver line must be present.  When using run-time loadable driver
# modules, this line instructs the server to load the specified driver
# module.  Even when not using loadable driver modules, this line
# indicates which driver should interpret the information in this section.

    Driver      "vga"
# The BusID line is used to specify which of possibly multiple devices
# this section is intended for.  When this line isn't present, a device
# section can only match up with the primary video device.  For PCI
# devices a line like the following could be used.  This line should not
# normally be included unless there is more than one video device
# installed.

#    BusID       "PCI:0:10:0"

#    VideoRam    256

#    Clocks      25.2 28.3

EndSection

# === ATI device section ===

Section "Device"
    Identifier                          "ATI Graphics Adapter"
    Driver                              "fglrx"
# === disable PnP Monitor  ===
    #Option                              "NoDDC"
# === disable/enable XAA/DRI ===
    Option "no_accel"                   "no"
    Option "no_dri"                     "no"
# === FireGL DDX driver module specific settings ===
# === Screen Management ===
    Option "DesktopSetup"               "0x00000100" 
    Option "MonitorLayout"              "AUTO, NONE"
    Option "IgnoreEDID"                 "off"
    Option "HSync2"                     "unspecified" 
    Option "VRefresh2"                  "unspecified" 
    Option "ScreenOverlap"              "0" 
# === TV-out Management ===
    Option "NoTV"                       "no"     
    Option "TVStandard"                 "PAL-N"     
    Option "TVHSizeAdj"                 "0"     
    Option "TVVSizeAdj"                 "0"     
    Option "TVHPosAdj"                  "0"     
    Option "TVVPosAdj"                  "0"     
    Option "TVHStartAdj"                "0"     
    Option "TVColorAdj"                 "0"     
    Option "GammaCorrectionI"           "0x00000000"
    Option "GammaCorrectionII"          "0x00000000"
# === OpenGL specific profiles/settings ===
    Option "Capabilities"               "0x00000000"
# === Video Overlay for the Xv extension ===
    Option "VideoOverlay"               "on"
# === OpenGL Overlay ===
# Note: When OpenGL Overlay is enabled, Video Overlay
#       will be disabled automatically
    Option "OpenGLOverlay"              "off"
# === Center Mode (Laptops only) ===
    Option "CenterMode"                 "off"
# === Pseudo Color Visuals (8-bit visuals) ===
    Option "PseudoColorVisuals"         "off"
# === QBS Management ===
    Option "Stereo"                     "off"
    Option "StereoSyncEnable"           "1"
# === FSAA Management ===
    Option "FSAAScale"                  "1"
    Option "FSAADisableGamma"           "no"
    Option "FSAACustomizeMSPos"         "no"
    Option "FSAAMSPosX0"                "0.000000"
    Option "FSAAMSPosY0"                "0.000000"
    Option "FSAAMSPosX1"                "0.000000"
    Option "FSAAMSPosY1"                "0.000000"
    Option "FSAAMSPosX2"                "0.000000"
    Option "FSAAMSPosY2"                "0.000000"
    Option "FSAAMSPosX3"                "0.000000"
    Option "FSAAMSPosY3"                "0.000000"
    Option "FSAAMSPosX4"                "0.000000"
    Option "FSAAMSPosY4"                "0.000000"
    Option "FSAAMSPosX5"                "0.000000"
    Option "FSAAMSPosY5"                "0.000000"
# === Misc Options ===
    Option "UseFastTLS"                 "2"
    Option "BlockSignalsOnLock"         "on"
    Option "UseInternalAGPGART"         "yes"
    Option "ForceGenericCPU"            "no"
    BusID "PCI:1:0:0"    # vendor=1002, device=4c66
    Screen 0
EndSection

# **********************************************************************
# Screen sections
# **********************************************************************

# Any number of screen sections may be present.  Each describes
# the configuration of a single screen.  A single specific screen section
# may be specified from the X server command line with the "-screen"
# option.
Section "Screen"
    Identifier  "Screen0"
    Device      "ATI Graphics Adapter"
    Monitor     "Monitor0"
    DefaultDepth 24
    #Option "backingstore"

    Subsection "Display"
        Depth       24
        Modes       "1280x800" "800x600"
        ViewPort    0 0  # initial origin if mode is smaller than desktop
#        Virtual     1280 1024
    EndSubsection
EndSection

# **********************************************************************
# ServerLayout sections.
# **********************************************************************

# Any number of ServerLayout sections may be present.  Each describes
# the way multiple screens are organised.  A specific ServerLayout
# section may be specified from the X server command line with the
# "-layout" option.  In the absence of this, the first section is used.
# When now ServerLayout section is present, the first Screen section
# is used alone.

Section "ServerLayout"

# The Identifier line must be present
    Identifier  "Server Layout"

# Each Screen line specifies a Screen section name, and optionally
# the relative position of other screens.  The four names after
# primary screen name are the screens to the top, bottom, left and right
# of the primary screen.

    Screen "Screen0"

# Each InputDevice line specifies an InputDevice section name and
# optionally some options to specify the way the device is to be
# used.  Those options include "CorePointer", "CoreKeyboard" and
# "SendCoreEvents".

    InputDevice "USBMouse" "AlwaysCore"
    InputDevice "Mouse1" "CorePointer"
    InputDevice "Keyboard1" "CoreKeyboard"

EndSection

### EOF ###

--=-r1PlOZ+uEtKbDvUl4bwJ--

