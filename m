Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWC2EUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWC2EUS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 23:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWC2EUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 23:20:17 -0500
Received: from web31814.mail.mud.yahoo.com ([68.142.206.167]:8098 "HELO
	web31814.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750812AbWC2EUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 23:20:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=RWRwk0Rz4Nb/DdSZDrSVVIVML1Doqh1XA+aVAHqS/SLYi4cr513jzEuIlhYQGyyXqVkKgOoqxc3eO3p+fhxGK3SY2KUXzIAzLJDg8knp8jBgJpDtCD7iKCjOaDjm01oFV7GrzBtcrRUzzlD9CCLY7wpbI+XNBl/s7Mp19IM0xho=  ;
Message-ID: <20060329042011.53197.qmail@web31814.mail.mud.yahoo.com>
Date: Tue, 28 Mar 2006 20:20:11 -0800 (PST)
From: cyber rigger <cyber_rigger@yahoo.com>
Subject: Re: Need help reporting bug, no 3D accel with Matrox g400
To: Sergey Panov <sipan@sipan.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1143604435.28440.4.camel@sipan.sipan.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1172205391-1143606011=:51400"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1172205391-1143606011=:51400
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

My g400 just has only one plug.
I'm using just one monitor.

The 3D acceleration WORKS with a 2.6.16 kernel (using
xorg)
but at only about half the frame rate
of 2.6.8 with xfree86.

The workarounds for 2.6.15 didn't work for me.

See attached Xorg.0.log for the 2.6.15 kernel.



--- Sergey Panov <sipan@sipan.org> wrote:

> Are you using dual-screen setup? Direct rendering is
> disabled when
> Xinerama is enabled. In any case , look what your
> /var/log/Xorg.0.log 
> is saying about rendering settings.
> 
>  Sergey
> 
> On Tue, 2006-03-28 at 07:13 -0800, cyber rigger
> wrote:
> > I need help reporting a bug.
> > 
> > 
> > It appears that some later kernel versions
> > do not support 3D acceleration in some cases.
> > I'm getting this problem with Debain etch and
> >Ubuntu
> > Dapper. I first thought it was a problem caused by
> > switching to xorg but Ubuntu 5.10 is fine and it
> uses
> > xorg. 
> > 
> >
> ----------------------------------------------------
> > The 3D acceleration doesn't work with xorg using
> the
> > mga driver for a Matrox g400.
> > My test case is ppracer which runs dreadfully
> slow.
> > 
> > This is a Debian etch machine with Debian's 
> > 2.6.15-1-k7 kernel.
> > 
> > 
> > This is what I have found so far.
> > 
> > Re: No direct rendering with recent kernels
> >
>
http://lists.debian.org/debian-x/2006/01/msg00133.html[mga]
> > 
> > 
> > DRM for MGA broken since 2005-Aug-04.
> > https://bugs.freedesktop.org/show_bug.cgi?id=4797
> > 
> > 
> > 
> > The 3D acceleration for mga appears to still be
> > broken.
> > 
> > Where and how may I respectfully plead for this to
> be
> > fixed?
> > 
> > :^)
> > 
> > 
> > Thanks
> > 
> > 
> > 
> > 
> > __________________________________________________
> > Do You Yahoo!?
> > Tired of spam?  Yahoo! Mail has the best spam
> protection around 
> > http://mail.yahoo.com 
> > -
> > To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1172205391-1143606011=:51400
Content-Type: text/x-log; name="Xorg.0.log"
Content-Description: pat1776990414
Content-Disposition: inline; filename="Xorg.0.log"


X Window System Version 6.9.0 (Debian 6.9.0.dfsg.1-4 20060114230205 David Nusinow <dnusinow@debian.org>)
Release Date: 21 December 2005
X Protocol Version 11, Revision 0, Release 6.9
Build Operating System: Linux 2.6.15-1-686 i686 [ELF] 
Current Operating System: Linux leo 2.6.15-1-k7 #2 Mon Mar 6 15:42:39 UTC 2006 i686
Build Date: 14 January 2006
	Before reporting problems, check http://wiki.X.Org
	to make sure that you have the latest version.
Module Loader present
OS Kernel: Linux version 2.6.15-1-k7 (Debian 2.6.15-8) (waldi@debian.org) (gcc version 4.0.3 20060212 (prerelease) (Debian 4.0.2-9)) #2 Mon Mar 6 15:42:39 UTC 2006 
Markers: (--) probed, (**) from config file, (==) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/Xorg.0.log", Time: Tue Mar 28 11:39:54 2006
(==) Using config file: "/etc/X11/xorg.conf"
(==) ServerLayout "Default Layout"
(**) |-->Screen "Default Screen" (0)
(**) |   |-->Monitor "Generic Monitor"
(**) |   |-->Device "Generic Video Card"
(**) |-->Input Device "Generic Keyboard"
(**) Option "XkbRules" "xorg"
(**) XKB: rules: "xorg"
(**) Option "XkbModel" "pc104"
(**) XKB: model: "pc104"
(**) Option "XkbLayout" "us"
(**) XKB: layout: "us"
(==) Keyboard: CustomKeycode disabled
(**) |-->Input Device "Configured Mouse"
(WW) The directory "/usr/lib/X11/fonts/cyrillic" does not exist.
	Entry deleted from font path.
(WW) The directory "/usr/lib/X11/fonts/CID" does not exist.
	Entry deleted from font path.
(**) FontPath set to "unix/:7100,/usr/lib/X11/fonts/misc,/usr/lib/X11/fonts/100dpi/:unscaled,/usr/lib/X11/fonts/75dpi/:unscaled,/usr/lib/X11/fonts/Type1,/usr/lib/X11/fonts/100dpi,/usr/lib/X11/fonts/75dpi"
(==) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(II) Open ACPI successful (/proc/acpi/event)
(II) Module ABI versions:
	X.Org ANSI C Emulation: 0.2
	X.Org Video Driver: 0.8
	X.Org XInput driver : 0.5
	X.Org Server Extension : 0.2
	X.Org Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.so
(II) Module bitmap: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.0.0
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.so
(II) Module pcidata: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.8
(++) using VT number 7

(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 1039,0741 card 1019,1b29 rev 03 class 06,00,00 hdr 00
(II) PCI: 00:01:0: chip 1039,0003 card 0000,0000 rev 00 class 06,04,00 hdr 01
(II) PCI: 00:02:0: chip 1039,0964 card 0000,0000 rev 36 class 06,01,00 hdr 80
(II) PCI: 00:02:5: chip 1039,5513 card 1019,1b29 rev 01 class 01,01,80 hdr 00
(II) PCI: 00:02:7: chip 1039,7012 card 1019,1b29 rev a0 class 04,01,00 hdr 00
(II) PCI: 00:03:0: chip 1039,7001 card 1019,1b29 rev 0f class 0c,03,10 hdr 80
(II) PCI: 00:03:1: chip 1039,7001 card 1019,1b29 rev 0f class 0c,03,10 hdr 00
(II) PCI: 00:03:2: chip 1039,7001 card 1019,1b29 rev 0f class 0c,03,10 hdr 00
(II) PCI: 00:03:3: chip 1039,7002 card 1019,1b29 rev 00 class 0c,03,20 hdr 00
(II) PCI: 00:04:0: chip 1039,0900 card 1019,1b29 rev 91 class 02,00,00 hdr 00
(II) PCI: 00:0b:0: chip 134d,2189 card 134d,1002 rev 04 class 07,03,00 hdr 00
(II) PCI: 01:00:0: chip 102b,0525 card 102b,0378 rev 04 class 03,00,00 hdr 00
(II) PCI: End of PCI scan
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,1), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:1:0), (0,1,1), BCTRL: 0x000e (VGA_EN is set)
(II) Bus 1 non-prefetchable memory range:
	[0] -1	0	0xda000000 - 0xdcffffff (0x3000000) MX[B]
(II) Bus 1 prefetchable memory range:
	[0] -1	0	0xd8000000 - 0xd9ffffff (0x2000000) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:2:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(--) PCI:*(1:0:0) Matrox Graphics, Inc. G400/G450 rev 4, Mem @ 0xd8000000/25, 0xda000000/14, 0xdb000000/23
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
(II) PCI Memory resource overlap reduced 0xd0000000 from 0xd7ffffff to 0xcfffffff
(II) Active PCI resource ranges:
	[0] -1	0	0xde005000 - 0xde005fff (0x1000) MX[B]
	[1] -1	0	0xde003000 - 0xde003fff (0x1000) MX[B]
	[2] -1	0	0xde002000 - 0xde002fff (0x1000) MX[B]
	[3] -1	0	0xde001000 - 0xde001fff (0x1000) MX[B]
	[4] -1	0	0xde000000 - 0xde000fff (0x1000) MX[B]
	[5] -1	0	0xde004000 - 0xde004fff (0x1000) MX[B]
	[6] -1	0	0xd0000000 - 0xcfffffff (0x0) MX[B]O
	[7] -1	0	0xdb000000 - 0xdb7fffff (0x800000) MX[B](B)
	[8] -1	0	0xda000000 - 0xda003fff (0x4000) MX[B](B)
	[9] -1	0	0xd8000000 - 0xd9ffffff (0x2000000) MX[B](B)
	[10] -1	0	0x0000ec00 - 0x0000ecff (0x100) IX[B]
	[11] -1	0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
	[12] -1	0	0x0000e400 - 0x0000e47f (0x80) IX[B]
	[13] -1	0	0x0000e000 - 0x0000e0ff (0x100) IX[B]
	[14] -1	0	0x00004000 - 0x0000400f (0x10) IX[B]
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0	0xde005000 - 0xde005fff (0x1000) MX[B]
	[1] -1	0	0xde003000 - 0xde003fff (0x1000) MX[B]
	[2] -1	0	0xde002000 - 0xde002fff (0x1000) MX[B]
	[3] -1	0	0xde001000 - 0xde001fff (0x1000) MX[B]
	[4] -1	0	0xde000000 - 0xde000fff (0x1000) MX[B]
	[5] -1	0	0xde004000 - 0xde004fff (0x1000) MX[B]
	[6] -1	0	0xd0000000 - 0xcfffffff (0x0) MX[B]O
	[7] -1	0	0xdb000000 - 0xdb7fffff (0x800000) MX[B](B)
	[8] -1	0	0xda000000 - 0xda003fff (0x4000) MX[B](B)
	[9] -1	0	0xd8000000 - 0xd9ffffff (0x2000000) MX[B](B)
	[10] -1	0	0x0000ec00 - 0x0000ecff (0x100) IX[B]
	[11] -1	0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
	[12] -1	0	0x0000e400 - 0x0000e47f (0x80) IX[B]
	[13] -1	0	0x0000e000 - 0x0000e0ff (0x100) IX[B]
	[14] -1	0	0x00004000 - 0x0000400f (0x10) IX[B]
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xde005000 - 0xde005fff (0x1000) MX[B]
	[6] -1	0	0xde003000 - 0xde003fff (0x1000) MX[B]
	[7] -1	0	0xde002000 - 0xde002fff (0x1000) MX[B]
	[8] -1	0	0xde001000 - 0xde001fff (0x1000) MX[B]
	[9] -1	0	0xde000000 - 0xde000fff (0x1000) MX[B]
	[10] -1	0	0xde004000 - 0xde004fff (0x1000) MX[B]
	[11] -1	0	0xd0000000 - 0xcfffffff (0x0) MX[B]O
	[12] -1	0	0xdb000000 - 0xdb7fffff (0x800000) MX[B](B)
	[13] -1	0	0xda000000 - 0xda003fff (0x4000) MX[B](B)
	[14] -1	0	0xd8000000 - 0xd9ffffff (0x2000000) MX[B](B)
	[15] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[16] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[17] -1	0	0x0000ec00 - 0x0000ecff (0x100) IX[B]
	[18] -1	0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
	[19] -1	0	0x0000e400 - 0x0000e47f (0x80) IX[B]
	[20] -1	0	0x0000e000 - 0x0000e0ff (0x100) IX[B]
	[21] -1	0	0x00004000 - 0x0000400f (0x10) IX[B]
(II) LoadModule: "bitmap"
(II) Reloading /usr/X11R6/lib/modules/fonts/libbitmap.so
(II) Loading font Bitmap
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.so
(II) Module dbe: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.so
(II) Module ddc: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.8
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.so
(II) Module dri: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.so
(II) Module drm: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension XFree86-DRI
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.so
(II) Module extmod: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
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
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.so
(II) Module freetype: vendor="X.Org Foundation & the After X-TT Project"
	compiled for 6.9.0, module version = 2.1.0
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font FreeType
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.so
(II) Module glx: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.so
(II) Module GLcore: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension GLX
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.so
(II) Module int10: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.8
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.so
(II) Module record: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.13.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension RECORD
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.so
(II) Module type1: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.0.2
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "vbe"
(II) Loading /usr/X11R6/lib/modules/libvbe.so
(II) Module vbe: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.1.0
	ABI class: X.Org Video Driver, version 0.8
(II) LoadModule: "mga"
(II) Loading /usr/X11R6/lib/modules/drivers/mga_drv.so
(II) Module mga: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.2.1
	Module class: X.Org Video Driver
	ABI class: X.Org Video Driver, version 0.8
(II) LoadModule: "keyboard"
(II) Loading /usr/X11R6/lib/modules/input/keyboard_drv.so
(II) Module keyboard: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.0.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.5
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.so
(II) Module mouse: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.0.3
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.5
(II) MGA: driver for Matrox chipsets: mga2064w, mga1064sg, mga2164w,
	mga2164w AGP, mgag100, mgag100 PCI, mgag200, mgag200 PCI, mgag400,
	mgag550
(II) Primary Device is: PCI 01:00:0
(--) Assigning device section with no busID to primary device
(--) Chipset mgag400 found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xde005000 - 0xde005fff (0x1000) MX[B]
	[6] -1	0	0xde003000 - 0xde003fff (0x1000) MX[B]
	[7] -1	0	0xde002000 - 0xde002fff (0x1000) MX[B]
	[8] -1	0	0xde001000 - 0xde001fff (0x1000) MX[B]
	[9] -1	0	0xde000000 - 0xde000fff (0x1000) MX[B]
	[10] -1	0	0xde004000 - 0xde004fff (0x1000) MX[B]
	[11] -1	0	0xd0000000 - 0xcfffffff (0x0) MX[B]O
	[12] -1	0	0xdb000000 - 0xdb7fffff (0x800000) MX[B](B)
	[13] -1	0	0xda000000 - 0xda003fff (0x4000) MX[B](B)
	[14] -1	0	0xd8000000 - 0xd9ffffff (0x2000000) MX[B](B)
	[15] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[16] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[17] -1	0	0x0000ec00 - 0x0000ecff (0x100) IX[B]
	[18] -1	0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
	[19] -1	0	0x0000e400 - 0x0000e47f (0x80) IX[B]
	[20] -1	0	0x0000e000 - 0x0000e0ff (0x100) IX[B]
	[21] -1	0	0x00004000 - 0x0000400f (0x10) IX[B]
(II) resource ranges after probing:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xde005000 - 0xde005fff (0x1000) MX[B]
	[6] -1	0	0xde003000 - 0xde003fff (0x1000) MX[B]
	[7] -1	0	0xde002000 - 0xde002fff (0x1000) MX[B]
	[8] -1	0	0xde001000 - 0xde001fff (0x1000) MX[B]
	[9] -1	0	0xde000000 - 0xde000fff (0x1000) MX[B]
	[10] -1	0	0xde004000 - 0xde004fff (0x1000) MX[B]
	[11] -1	0	0xd0000000 - 0xcfffffff (0x0) MX[B]O
	[12] -1	0	0xdb000000 - 0xdb7fffff (0x800000) MX[B](B)
	[13] -1	0	0xda000000 - 0xda003fff (0x4000) MX[B](B)
	[14] -1	0	0xd8000000 - 0xd9ffffff (0x2000000) MX[B](B)
	[15] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[16] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[17] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[18] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[19] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[20] -1	0	0x0000ec00 - 0x0000ecff (0x100) IX[B]
	[21] -1	0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
	[22] -1	0	0x0000e400 - 0x0000e47f (0x80) IX[B]
	[23] -1	0	0x0000e000 - 0x0000e0ff (0x100) IX[B]
	[24] -1	0	0x00004000 - 0x0000400f (0x10) IX[B]
	[25] 0	0	0xda0103b0 - 0xda0103bb (0xc) IS[B]
	[26] 0	0	0xda0103c0 - 0xda0103df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.so
(II) Module vgahw: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 0.1.0
	ABI class: X.Org Video Driver, version 0.8
(--) MGA(0): Chipset: "mgag400" (G400)
(II) Loading sub module "mga_hal"
(II) LoadModule: "mga_hal"
(WW) Warning, couldn't open module mga_hal
(II) UnloadModule: "mga_hal"
(EE) MGA: Failed to load module "mga_hal" (module does not exist, 0)
(==) MGA(0): Matrox HAL module not loaded - using builtin mode setup instead
(**) MGA(0): Depth 24, (--) framebuffer bpp 32
(==) MGA(0): RGB weight 888
(==) MGA(0): Using AGP 1x mode
(--) MGA(0): Linear framebuffer at 0xD8000000
(--) MGA(0): MMIO registers at 0xDA000000
(--) MGA(0): Pseudo-DMA transfer window at 0xDB000000
(==) MGA(0): BIOS at 0xC0000
(--) MGA(0): Video BIOS info block at offset 0x07A80
(==) MGA(0): Write-combining range (0xd8000000,0x2000000)
(--) MGA(0): VideoRAM: 32768 kByte
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Reloading /usr/X11R6/lib/modules/libddc.so
(II) Loading sub module "i2c"
(II) LoadModule: "i2c"
(II) Loading /usr/X11R6/lib/modules/libi2c.so
(II) Module i2c: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.2.0
	ABI class: X.Org Video Driver, version 0.8
(==) MGA(0): Write-combining range (0xd8000000,0x2000000)
(II) MGA(0): vgaHWGetIOBase: hwp->IOBase is 0x03d0, hwp->PIOOffset is 0x0000
(II) MGA(0): I2C bus "DDC P1" initialized.
(II) MGA(0): I2C device "DDC P1:ddc2" registered at address 0xA0.
(II) MGA(0): I2C device "DDC P1:ddc2" removed.
(II) MGA(0): I2C Monitor info: (nil)
(II) MGA(0): end of I2C Monitor info
(--) MGA(0): No DDC signal
(II) MGA(0): DDC Monitor info: (nil)
(II) MGA(0): end of DDC Monitor info
(II) Loading sub module "vbe"
(II) LoadModule: "vbe"
(II) Reloading /usr/X11R6/lib/modules/libvbe.so
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Reloading /usr/X11R6/lib/modules/linux/libint10.so
(II) MGA(0): initializing int10
(II) MGA(0): Primary V_BIOS segment is: 0xc000
(II) MGA(0): VESA BIOS detected
(II) MGA(0): VESA VBE Version 2.0
(II) MGA(0): VESA VBE Total Mem: 32768 kB
(II) MGA(0): VESA VBE OEM: Matrox Graphics Inc.
(II) MGA(0): VESA VBE OEM Software Rev: 1.5
(II) MGA(0): VESA VBE OEM Vendor: Matrox
(II) MGA(0): VESA VBE OEM Product: Matrox G400
(II) MGA(0): VESA VBE OEM Product Rev: 00
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Reloading /usr/X11R6/lib/modules/libddc.so
(II) MGA(0): VESA VBE DDC supported
(II) MGA(0): VESA VBE DDC Level 2
(II) MGA(0): VESA VBE DDC transfer in appr. 1 sec.
(II) MGA(0): VESA VBE DDC read successfully
(II) MGA(0): VBE DDC Monitor info: 0x82704e8
(II) MGA(0): Manufacturer: SAM  Model: 115  Serial#: 1196634425
(II) MGA(0): Year: 2005  Week: 26
(II) MGA(0): EDID Version: 1.3
(II) MGA(0): Analog Display Input,  Input Voltage Level: 0.700/0.700 V
(II) MGA(0): Sync:  Separate  Composite
(II) MGA(0): Max H-Image Size [cm]: horiz.: 38  vert.: 30
(II) MGA(0): Gamma: 2.20
(II) MGA(0): DPMS capabilities: Off; RGB/Color Display
(II) MGA(0): First detailed timing is preferred mode
(II) MGA(0): redX: 0.634 redY: 0.354   greenX: 0.304 greenY: 0.581
(II) MGA(0): blueX: 0.143 blueY: 0.102   whiteX: 0.310 whiteY: 0.330
(II) MGA(0): Supported VESA Video Modes:
(II) MGA(0): 720x400@70Hz
(II) MGA(0): 640x480@60Hz
(II) MGA(0): 640x480@67Hz
(II) MGA(0): 640x480@72Hz
(II) MGA(0): 640x480@75Hz
(II) MGA(0): 800x600@56Hz
(II) MGA(0): 800x600@60Hz
(II) MGA(0): 800x600@72Hz
(II) MGA(0): 800x600@75Hz
(II) MGA(0): 832x624@75Hz
(II) MGA(0): 1024x768@60Hz
(II) MGA(0): 1024x768@70Hz
(II) MGA(0): 1024x768@75Hz
(II) MGA(0): 1280x1024@75Hz
(II) MGA(0): 1152x870@75Hz
(II) MGA(0): Manufacturer's mask: 0
(II) MGA(0): Supported Future Video Modes:
(II) MGA(0): #0: hsize: 1280  vsize 1024  refresh: 60  vid: 32897
(II) MGA(0): #1: hsize: 1152  vsize 864  refresh: 75  vid: 20337
(II) MGA(0): Supported additional Video Mode:
(II) MGA(0): clock: 108.0 MHz   Image Size:  376 x 301 mm
(II) MGA(0): h_active: 1280  h_sync: 1328  h_sync_end 1440 h_blank_end 1688 h_border: 0
(II) MGA(0): v_active: 1024  v_sync: 1025  v_sync_end 1028 v_blanking: 1066 v_border: 0
(II) MGA(0): Ranges: V min: 56  V max: 75 Hz, H min: 30  H max: 81 kHz, PixClock max 140 MHz
(II) MGA(0): Monitor name: SyncMaster
(II) MGA(0): Serial No: HVEY603147
(II) MGA(0): end of VBE DDC Monitor info

(==) MGA(0): Using gamma correction (1.0, 1.0, 1.0)
(==) MGA(0): Min pixel clock is 17 MHz
(--) MGA(0): Max pixel clock is 300 MHz
(WW) MGA(0): config file vrefresh range 50-75Hz not within DDC vrefresh ranges.
(II) MGA(0): Generic Monitor: Using hsync range of 30.00-65.00 kHz
(II) MGA(0): Generic Monitor: Using vrefresh range of 50.00-75.00 Hz
(II) MGA(0): Clock range:  17.75 to 300.00 MHz
(II) MGA(0): Not using default mode "640x350" (vrefresh out of range)
(II) MGA(0): Not using default mode "320x175" (bad mode clock/interlace/doublescan)
(II) MGA(0): Not using default mode "640x400" (vrefresh out of range)
(II) MGA(0): Not using default mode "320x200" (bad mode clock/interlace/doublescan)
(II) MGA(0): Not using default mode "720x400" (vrefresh out of range)
(II) MGA(0): Not using default mode "360x200" (vrefresh out of range)
(II) MGA(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) MGA(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) MGA(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) MGA(0): Not using default mode "640x480" (vrefresh out of range)
(II) MGA(0): Not using default mode "320x240" (vrefresh out of range)
(II) MGA(0): Not using default mode "800x600" (vrefresh out of range)
(II) MGA(0): Not using default mode "400x300" (vrefresh out of range)
(II) MGA(0): Not using default mode "1024x768" (vrefresh out of range)
(II) MGA(0): Not using default mode "512x384" (vrefresh out of range)
(II) MGA(0): Not using default mode "1024x768" (hsync out of range)
(II) MGA(0): Not using default mode "512x384" (hsync out of range)
(II) MGA(0): Not using default mode "1152x864" (hsync out of range)
(II) MGA(0): Not using default mode "576x432" (hsync out of range)
(WW) (1280x960,Generic Monitor) mode clock 148.5MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1280x960" (hsync out of range)
(II) MGA(0): Not using default mode "640x480" (hsync out of range)
(II) MGA(0): Not using default mode "1280x1024" (hsync out of range)
(II) MGA(0): Not using default mode "640x512" (hsync out of range)
(WW) (1280x1024,Generic Monitor) mode clock 157.5MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1280x1024" (hsync out of range)
(II) MGA(0): Not using default mode "640x512" (hsync out of range)
(WW) (1600x1200,Generic Monitor) mode clock 162MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1600x1200" (hsync out of range)
(II) MGA(0): Not using default mode "800x600" (hsync out of range)
(WW) (1600x1200,Generic Monitor) mode clock 175.5MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1600x1200" (hsync out of range)
(II) MGA(0): Not using default mode "800x600" (hsync out of range)
(WW) (1600x1200,Generic Monitor) mode clock 189MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1600x1200" (hsync out of range)
(II) MGA(0): Not using default mode "800x600" (hsync out of range)
(WW) (1600x1200,Generic Monitor) mode clock 202.5MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1600x1200" (hsync out of range)
(II) MGA(0): Not using default mode "800x600" (hsync out of range)
(WW) (1600x1200,Generic Monitor) mode clock 229.5MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1600x1200" (hsync out of range)
(II) MGA(0): Not using default mode "800x600" (hsync out of range)
(WW) (1792x1344,Generic Monitor) mode clock 204.8MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1792x1344" (hsync out of range)
(II) MGA(0): Not using default mode "896x672" (hsync out of range)
(WW) (1792x1344,Generic Monitor) mode clock 261MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1792x1344" (hsync out of range)
(II) MGA(0): Not using default mode "896x672" (hsync out of range)
(WW) (1856x1392,Generic Monitor) mode clock 218.3MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1856x1392" (hsync out of range)
(II) MGA(0): Not using default mode "928x696" (hsync out of range)
(WW) (1856x1392,Generic Monitor) mode clock 288MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1856x1392" (hsync out of range)
(WW) (928x696,Generic Monitor) mode clock 144MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "928x696" (hsync out of range)
(WW) (1920x1440,Generic Monitor) mode clock 234MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1920x1440" (hsync out of range)
(II) MGA(0): Not using default mode "960x720" (hsync out of range)
(WW) (1920x1440,Generic Monitor) mode clock 297MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1920x1440" (hsync out of range)
(WW) (960x720,Generic Monitor) mode clock 148.5MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "960x720" (hsync out of range)
(II) MGA(0): Not using default mode "1152x864" (hsync out of range)
(II) MGA(0): Not using default mode "576x432" (hsync out of range)
(WW) (1400x1050,Generic Monitor) mode clock 151MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1400x1050" (hsync out of range)
(II) MGA(0): Not using default mode "700x525" (hsync out of range)
(WW) (1400x1050,Generic Monitor) mode clock 155.8MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1400x1050" (hsync out of range)
(II) MGA(0): Not using default mode "700x525" (hsync out of range)
(WW) (1400x1050,Generic Monitor) mode clock 184MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1400x1050" (hsync out of range)
(II) MGA(0): Not using default mode "700x525" (hsync out of range)
(WW) (1680x1050,Generic Monitor) mode clock 147.14MHz exceeds DDC maximum 140MHz
(WW) (1920x1200,Generic Monitor) mode clock 193.16MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1920x1200" (hsync out of range)
(II) MGA(0): Not using default mode "960x600" (hsync out of range)
(WW) (1920x1200,Generic Monitor) mode clock 230MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1920x1200" (hsync out of range)
(II) MGA(0): Not using default mode "960x600" (hsync out of range)
(II) MGA(0): Not using default mode "1920x1440" (bad mode clock/interlace/doublescan)
(WW) (960x720,Generic Monitor) mode clock 170.675MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "960x720" (hsync out of range)
(WW) (2048x1536,Generic Monitor) mode clock 266.95MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "2048x1536" (hsync out of range)
(II) MGA(0): Not using default mode "1024x768" (hsync out of range)
(II) MGA(0): Not using default mode "2048x1536" (bad mode clock/interlace/doublescan)
(WW) (1024x768,Generic Monitor) mode clock 170.24MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1024x768" (hsync out of range)
(II) MGA(0): Not using default mode "2048x1536" (bad mode clock/interlace/doublescan)
(WW) (1024x768,Generic Monitor) mode clock 194.02MHz exceeds DDC maximum 140MHz
(II) MGA(0): Not using default mode "1024x768" (hsync out of range)
(II) MGA(0): Not using default mode "1680x1050" (width too large for virtual size)
(II) MGA(0): Not using default mode "1400x1050" (width too large for virtual size)
(II) MGA(0): Not using default mode "1440x900" (width too large for virtual size)
(--) MGA(0): Has SDRAM
(--) MGA(0): Virtual size is 1280x1024 (pitch 1280)
(**) MGA(0): *Default mode "1280x1024": 108.0 MHz, 64.0 kHz, 60.0 Hz
(II) MGA(0): Modeline "1280x1024"  108.00  1280 1328 1440 1688  1024 1025 1028 1066 +hsync +vsync
(**) MGA(0): *Default mode "1024x768": 78.8 MHz, 60.1 kHz, 75.1 Hz
(II) MGA(0): Modeline "1024x768"   78.80  1024 1040 1136 1312  768 769 772 800 +hsync +vsync
(**) MGA(0): *Default mode "800x600": 49.5 MHz, 46.9 kHz, 75.0 Hz
(II) MGA(0): Modeline "800x600"   49.50  800 816 896 1056  600 601 604 625 +hsync +vsync
(**) MGA(0): *Default mode "640x480": 31.5 MHz, 37.5 kHz, 75.0 Hz
(II) MGA(0): Modeline "640x480"   31.50  640 656 720 840  480 481 484 500 -hsync -vsync
(**) MGA(0):  Default mode "1280x960": 108.0 MHz, 60.0 kHz, 60.0 Hz
(II) MGA(0): Modeline "1280x960"  108.00  1280 1376 1488 1800  960 961 964 1000 +hsync +vsync
(**) MGA(0):  Default mode "1280x800": 83.5 MHz, 49.7 kHz, 60.0 Hz
(II) MGA(0): Modeline "1280x800"   83.46  1280 1344 1480 1680  800 801 804 828
(**) MGA(0):  Default mode "1280x768": 80.1 MHz, 47.7 kHz, 60.0 Hz
(II) MGA(0): Modeline "1280x768"   80.14  1280 1344 1480 1680  768 769 772 795
(**) MGA(0):  Default mode "1152x768": 65.0 MHz, 44.2 kHz, 54.8 Hz
(II) MGA(0): Modeline "1152x768"   65.00  1152 1178 1314 1472  768 771 777 806 +hsync +vsync
(**) MGA(0):  Default mode "1024x768": 75.0 MHz, 56.5 kHz, 70.1 Hz
(II) MGA(0): Modeline "1024x768"   75.00  1024 1048 1184 1328  768 771 777 806 -hsync -vsync
(**) MGA(0):  Default mode "1024x768": 65.0 MHz, 48.4 kHz, 60.0 Hz
(II) MGA(0): Modeline "1024x768"   65.00  1024 1048 1184 1344  768 771 777 806 -hsync -vsync
(**) MGA(0):  Default mode "832x624": 57.3 MHz, 49.7 kHz, 74.6 Hz
(II) MGA(0): Modeline "832x624"   57.28  832 864 928 1152  624 625 628 667 -hsync -vsync
(**) MGA(0):  Default mode "800x600": 50.0 MHz, 48.1 kHz, 72.2 Hz
(II) MGA(0): Modeline "800x600"   50.00  800 856 976 1040  600 637 643 666 +hsync +vsync
(**) MGA(0):  Default mode "800x600": 40.0 MHz, 37.9 kHz, 60.3 Hz
(II) MGA(0): Modeline "800x600"   40.00  800 840 968 1056  600 601 605 628 +hsync +vsync
(**) MGA(0):  Default mode "800x600": 36.0 MHz, 35.2 kHz, 56.2 Hz
(II) MGA(0): Modeline "800x600"   36.00  800 824 896 1024  600 601 603 625 +hsync +vsync
(**) MGA(0):  Default mode "840x525": 73.6 MHz, 65.2 kHz, 60.1 Hz (D)
(II) MGA(0): Modeline "840x525"   73.57  840 892 984 1128  525 525 527 543 doublescan
(**) MGA(0):  Default mode "700x525": 61.0 MHz, 64.9 kHz, 60.0 Hz (D)
(II) MGA(0): Modeline "700x525"   61.00  700 744 820 940  525 526 532 541 doublescan +hsync +vsync
(**) MGA(0):  Default mode "640x512": 54.0 MHz, 64.0 kHz, 60.0 Hz (D)
(II) MGA(0): Modeline "640x512"   54.00  640 664 720 844  512 512 514 533 doublescan +hsync +vsync
(**) MGA(0):  Default mode "720x450": 54.4 MHz, 56.9 kHz, 60.2 Hz (D)
(II) MGA(0): Modeline "720x450"   54.42  720 736 940 956  450 459 463 473 doublescan +hsync +vsync
(**) MGA(0):  Default mode "640x480": 31.5 MHz, 37.9 kHz, 72.8 Hz
(II) MGA(0): Modeline "640x480"   31.50  640 664 704 832  480 489 491 520 -hsync -vsync
(**) MGA(0):  Default mode "640x480": 25.2 MHz, 31.5 kHz, 60.0 Hz
(II) MGA(0): Modeline "640x480"   25.20  640 656 752 800  480 490 492 525 -hsync -vsync
(**) MGA(0):  Default mode "640x480": 54.0 MHz, 60.0 kHz, 60.0 Hz (D)
(II) MGA(0): Modeline "640x480"   54.00  640 688 744 900  480 480 482 500 doublescan +hsync +vsync
(**) MGA(0):  Default mode "640x400": 41.7 MHz, 49.7 kHz, 60.0 Hz (D)
(II) MGA(0): Modeline "640x400"   41.73  640 672 740 840  400 400 402 414 doublescan
(**) MGA(0):  Default mode "640x384": 40.1 MHz, 47.7 kHz, 60.1 Hz (D)
(II) MGA(0): Modeline "640x384"   40.07  640 672 740 840  384 384 386 397 doublescan
(**) MGA(0):  Default mode "576x384": 32.5 MHz, 44.2 kHz, 54.8 Hz (D)
(II) MGA(0): Modeline "576x384"   32.50  576 589 657 736  384 385 388 403 doublescan +hsync +vsync
(**) MGA(0):  Default mode "512x384": 39.4 MHz, 60.1 kHz, 75.1 Hz (D)
(II) MGA(0): Modeline "512x384"   39.40  512 520 568 656  384 384 386 400 doublescan +hsync +vsync
(**) MGA(0):  Default mode "512x384": 37.5 MHz, 56.5 kHz, 70.1 Hz (D)
(II) MGA(0): Modeline "512x384"   37.50  512 524 592 664  384 385 388 403 doublescan -hsync -vsync
(**) MGA(0):  Default mode "512x384": 32.5 MHz, 48.4 kHz, 60.0 Hz (D)
(II) MGA(0): Modeline "512x384"   32.50  512 524 592 672  384 385 388 403 doublescan -hsync -vsync
(**) MGA(0):  Default mode "416x312": 28.6 MHz, 49.7 kHz, 74.7 Hz (D)
(II) MGA(0): Modeline "416x312"   28.64  416 432 464 576  312 312 314 333 doublescan -hsync -vsync
(**) MGA(0):  Default mode "400x300": 24.8 MHz, 46.9 kHz, 75.1 Hz (D)
(II) MGA(0): Modeline "400x300"   24.75  400 408 448 528  300 300 302 312 doublescan +hsync +vsync
(**) MGA(0):  Default mode "400x300": 25.0 MHz, 48.1 kHz, 72.2 Hz (D)
(II) MGA(0): Modeline "400x300"   25.00  400 428 488 520  300 318 321 333 doublescan +hsync +vsync
(**) MGA(0):  Default mode "400x300": 20.0 MHz, 37.9 kHz, 60.3 Hz (D)
(II) MGA(0): Modeline "400x300"   20.00  400 420 484 528  300 300 302 314 doublescan +hsync +vsync
(**) MGA(0):  Default mode "400x300": 18.0 MHz, 35.2 kHz, 56.3 Hz (D)
(II) MGA(0): Modeline "400x300"   18.00  400 412 448 512  300 300 301 312 doublescan +hsync +vsync
(++) MGA(0): DPI set to (96, 96)
(II) MGA(0): YDstOrg is set to 0
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.so
(II) Module fb: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.0.0
	ABI class: X.Org ANSI C Emulation, version 0.2
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.so
(II) Module xaa: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 1.2.0
	ABI class: X.Org Video Driver, version 0.8
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib/modules/libramdac.so
(II) Module ramdac: vendor="X.Org Foundation"
	compiled for 6.9.0, module version = 0.1.0
	ABI class: X.Org Video Driver, version 0.8
(--) Depth 24 pixmap format is 32 bpp
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] 0	0	0xdb000000 - 0xdb7fffff (0x800000) MX[B]
	[1] 0	0	0xda000000 - 0xda003fff (0x4000) MX[B]
	[2] 0	0	0xd8000000 - 0xd9ffffff (0x2000000) MX[B]
	[3] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[4] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[5] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[6] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[7] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[8] -1	0	0xde005000 - 0xde005fff (0x1000) MX[B]
	[9] -1	0	0xde003000 - 0xde003fff (0x1000) MX[B]
	[10] -1	0	0xde002000 - 0xde002fff (0x1000) MX[B]
	[11] -1	0	0xde001000 - 0xde001fff (0x1000) MX[B]
	[12] -1	0	0xde000000 - 0xde000fff (0x1000) MX[B]
	[13] -1	0	0xde004000 - 0xde004fff (0x1000) MX[B]
	[14] -1	0	0xd0000000 - 0xcfffffff (0x0) MX[B]O
	[15] -1	0	0xdb000000 - 0xdb7fffff (0x800000) MX[B](B)
	[16] -1	0	0xda000000 - 0xda003fff (0x4000) MX[B](B)
	[17] -1	0	0xd8000000 - 0xd9ffffff (0x2000000) MX[B](B)
	[18] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B](OprD)
	[19] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B](OprD)
	[20] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B](OprD)
	[21] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[22] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[23] -1	0	0x0000ec00 - 0x0000ecff (0x100) IX[B]
	[24] -1	0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
	[25] -1	0	0x0000e400 - 0x0000e47f (0x80) IX[B]
	[26] -1	0	0x0000e000 - 0x0000e0ff (0x100) IX[B]
	[27] -1	0	0x00004000 - 0x0000400f (0x10) IX[B]
	[28] 0	0	0xda0103b0 - 0xda0103bb (0xc) IS[B](OprU)
	[29] 0	0	0xda0103c0 - 0xda0103df (0x20) IS[B](OprU)
(==) MGA(0): Write-combining range (0xd8000000,0x2000000)
(II) MGA(0): vgaHWGetIOBase: hwp->IOBase is 0x03d0, hwp->PIOOffset is 0x0000
(--) MGA(0): 16 DWORD fifo
(==) MGA(0): Default visual is TrueColor
(II) MGA(0): [drm] bpp: 32 depth: 24
(II) MGA(0): [drm] Sarea 2200+664: 2864
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (No such device or address)
drmOpenDevice: open result is -1, (No such device or address)
drmOpenDevice: Open failed
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (No such device or address)
drmOpenDevice: open result is -1, (No such device or address)
drmOpenDevice: Open failed
drmOpenByBusid: Searching for BusID pci:0000:01:00.0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 8, (OK)
drmOpenByBusid: drmOpenMinor returns 8
drmOpenByBusid: drmGetBusid reports pci:0000:01:00.0
(II) MGA(0): [drm] loaded kernel module for "mga" driver
(II) MGA(0): [drm] DRM interface version 1.2
(II) MGA(0): [drm] created "mga" driver at busid "pci:0000:01:00.0"
(II) MGA(0): [drm] added 8192 byte SAREA at 0xe0909000
(II) MGA(0): [drm] mapped SAREA 0xe0909000 to 0xb512a000
(II) MGA(0): [drm] framebuffer handle = 0xd8000000
(II) MGA(0): [drm] added 1 reserved context for kernel
(II) MGA(0): [dri] visual configs initialized
(II) MGA(0): Memory manager initialized to (0,0) (1280,2047)
(II) MGA(0): Largest offscreen area available: 1280 x 1023
(II) MGA(0): Reserved back buffer at offset 0xa00000
(II) MGA(0): Reserved depth buffer at offset 0xf00000
(II) MGA(0): Reserved 12288 kb for textures at offset 0x1400000
(II) MGA(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	Solid filled trapezoids
	8x8 mono pattern filled rectangles
	8x8 mono pattern filled trapezoids
	Indirect CPU to Screen color expansion
	Screen to Screen color expansion
	Solid Lines
	Dashed Lines
	Scanline Image Writes
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		32 128x128 slots
		9 256x256 slots
(==) MGA(0): Backing store disabled
(==) MGA(0): Silken mouse enabled
(**) Option "dpms"
(**) MGA(0): DPMS enabled
(II) MGA(0): Using overlay video
(II) MGA(0): X context handle = 0x1
(II) MGA(0): [drm] installed DRM signal handler
(II) MGA(0): [DRI] installation complete
(EE) MGA(0): [drm] Failed to map DMA buffers list
(II) MGA(0): [drm] removed 1 reserved context for kernel
(II) MGA(0): [drm] unmapping 8192 bytes of SAREA 0xe0909000 at 0xb512a000
(WW) MGA(0): Direct rendering disabled
(==) RandR enabled
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension LBX
(II) Initializing built-in extension XC-APPGROUP
(II) Initializing built-in extension SECURITY
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFIXES
(II) Initializing built-in extension XFree86-Bigfont
(II) Initializing built-in extension RENDER
(II) Initializing built-in extension RANDR
(II) Initializing built-in extension COMPOSITE
(II) Initializing built-in extension DAMAGE
(II) Initializing built-in extension XEVIE
(**) Generic Keyboard: Core Keyboard
(**) Option "Protocol" "standard"
(**) Generic Keyboard: Protocol: standard
(**) Option "AutoRepeat" "500 30"
(**) Option "XkbRules" "xorg"
(**) Generic Keyboard: XkbRules: "xorg"
(**) Option "XkbModel" "pc104"
(**) Generic Keyboard: XkbModel: "pc104"
(**) Option "XkbLayout" "us"
(**) Generic Keyboard: XkbLayout: "us"
(**) Option "CustomKeycodes" "off"
(**) Generic Keyboard: CustomKeycodes disabled
(**) Option "Protocol" "ImPS/2"
(**) Configured Mouse: Device: "/dev/psaux"
(**) Configured Mouse: Protocol: "ImPS/2"
(**) Option "CorePointer"
(**) Configured Mouse: Core Pointer
(**) Option "Device" "/dev/psaux"
(**) Option "Emulate3Buttons" "false"
(**) Option "ZAxisMapping" "4 5"
(**) Configured Mouse: ZAxisMapping: buttons 4 and 5
(**) Configured Mouse: Buttons: 9
(II) XINPUT: Adding extended input device "Configured Mouse" (type: MOUSE)
(II) XINPUT: Adding extended input device "Generic Keyboard" (type: KEYBOARD)
(II) Configured Mouse: ps2EnableDataReporting: succeeded
Warning: font renderer for ".pcf" already registered at priority 0
Warning: font renderer for ".pcf.Z" already registered at priority 0
Warning: font renderer for ".pcf.gz" already registered at priority 0
Warning: font renderer for ".snf" already registered at priority 0
Warning: font renderer for ".snf.Z" already registered at priority 0
Warning: font renderer for ".snf.gz" already registered at priority 0
Warning: font renderer for ".bdf" already registered at priority 0
Warning: font renderer for ".bdf.Z" already registered at priority 0
Warning: font renderer for ".bdf.gz" already registered at priority 0
Warning: font renderer for ".pmf" already registered at priority 0
Could not init font path element unix/:7100, removing from list!

--0-1172205391-1143606011=:51400--
