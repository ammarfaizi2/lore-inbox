Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319710AbSIMQBc>; Fri, 13 Sep 2002 12:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319711AbSIMQBc>; Fri, 13 Sep 2002 12:01:32 -0400
Received: from f196.law10.hotmail.com ([64.4.15.196]:13576 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S319710AbSIMQBQ>;
	Fri, 13 Sep 2002 12:01:16 -0400
X-Originating-IP: [129.186.93.101]
From: "Femitha Majeed" <m_femitha@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel module and X
Date: Fri, 13 Sep 2002 16:06:03 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F196T6Ssuot0OUIHNkj00000161@hotmail.com>
X-OriginalArrivalTime: 13 Sep 2002 16:06:03.0371 (UTC) FILETIME=[759743B0:01C25B3F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

I have a kernel module that reads the files in the /proc directory. It works 
fine when I am not using X. But when I use X, it gives me the follwoing 
error in the log:


XFree86 Version 4.1.0 (Red Hat Linux release: 4.1.0-3) / X Window System
(protocol Version 11, revision 0, vendor release 6510)
Release Date: 2 June 2001
	If the server is older than 6-12 months, or if your card is
	newer than the above date, look for a newer version before
	reporting problems.  (See http://www.XFree86.Org/FAQ)
Build Operating System: Linux 2.4.7-0.13.1smp i686 [ELF]
Build Host: stripples.devel.redhat.com

Module Loader present
(==) Log file: "/var/log/XFree86.0.log", Time: Mon Jul 15 07:01:42 2002
(==) Using config file: "/etc/X11/XF86Config-4"
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) ServerLayout "Anaconda Configured"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "Monitor0"
(**) |   |-->Device "RIVA128"
(**) |-->Input Device "Mouse0"
(**) |-->Input Device "Keyboard0"
(**) Option "XkbRules" "xfree86"
(**) XKB: rules: "xfree86"
(**) Option "XkbModel" "pc105"
(**) XKB: model: "pc105"
(**) Option "XkbLayout" "us"
(**) XKB: layout: "us"
(==) Keyboard: CustomKeycode disabled
(**) FontPath set to "unix/:7100"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(--) using VT number 7

(WW) Cannot open APM
(II) Module ABI versions:
	XFree86 ANSI C Emulation: 0.1
	XFree86 Video Driver: 0.4
	XFree86 XInput driver : 0.2
	XFree86 Server Extension : 0.1
	XFree86 Font Renderer : 0.2
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.2
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.4
(II) PCI: Probing config type using method 1
(II) PCI: Config type is 1
(II) PCI: stages = 0x03, oldVal1 = 0x00000000, mode1Res1 = 0x80000000
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 8086,7180 card 0000,0000 rev 03 class 06,00,00 hdr 
00
(II) PCI: 00:01:0: chip 8086,7181 card 0000,0000 rev 03 class 06,04,00 hdr 
01
(II) PCI: 00:07:0: chip 8086,7110 card 0000,0000 rev 01 class 06,01,00 hdr 
80
(II) PCI: 00:07:1: chip 8086,7111 card 0000,0000 rev 01 class 01,01,80 hdr 
00
(II) PCI: 00:07:2: chip 8086,7112 card 0000,0000 rev 01 class 0c,03,00 hdr 
00
(II) PCI: 00:07:3: chip 8086,7113 card 0000,0000 rev 01 class 06,80,00 hdr 
00
(II) PCI: 00:0d:0: chip 10b7,9050 card 0000,0000 rev 00 class 02,00,00 hdr 
00
(II) PCI: 01:00:0: chip 12d2,0018 card 10b4,1b1b rev 10 class 03,00,00 hdr 
00
(II) PCI: End of PCI scan
(II) LoadModule: "scanpci"
(II) Loading /usr/X11R6/lib/modules/libscanpci.a
(II) Module scanpci: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.4
(II) UnloadModule: "scanpci"
(II) Unloading /usr/X11R6/lib/modules/libscanpci.a
(II) Host-to-PCI bridge:
(II) PCI-to-ISA bridge:
(II) PCI-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (-1,0,0), BCTRL: 0x08 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 1: bridge is at (0:1:0), (0,1,1), BCTRL: 0x0c (VGA_EN is set)
(II) Bus 1 I/O range:
(II) Bus 1 non-prefetchable memory range:
	[0] -1	0xfd000000 - 0xfdffffff (0x1000000) MX[B]
(II) Bus 1 prefetchable memory range:
	[0] -1	0xf6000000 - 0xf6ffffff (0x1000000) MX[B]
(II) Bus -1: bridge is at (0:7:0), (0,-1,0), BCTRL: 0x08 (VGA_EN is set)
(II) Bus -1 I/O range:
(II) Bus -1 non-prefetchable memory range:
(II) Bus -1 prefetchable memory range:
(--) PCI:*(1:0:0) NVidia/SGS-Thomson Riva128 rev 16, Mem @ 0xfd000000/24, 
0xf6000000/24
(II) Addressable bus resource ranges are
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
	[1] -1	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
	[0] -1	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0x00000000 - 0x000000ff (0x100) IX[B]
(II) Active PCI resource ranges:
	[0] -1	0xf8000000 - 0xfbffffff (0x4000000) MX[B]
	[1] -1	0xf6000000 - 0xf6ffffff (0x1000000) MX[B](B)
	[2] -1	0xfd000000 - 0xfdffffff (0x1000000) MX[B](B)
	[3] -1	0x0000fcc0 - 0x0000fcff (0x40) IX[B]
	[4] -1	0x0000fca0 - 0x0000fcbf (0x20) IX[B]
	[5] -1	0x0000fc90 - 0x0000fc9f (0x10) IX[B]
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0xf8000000 - 0xfbffffff (0x4000000) MX[B]
	[1] -1	0xf6000000 - 0xf6ffffff (0x1000000) MX[B](B)
	[2] -1	0xfd000000 - 0xfdffffff (0x1000000) MX[B](B)
	[3] -1	0x0000fcc0 - 0x0000fcff (0x40) IX[B]
	[4] -1	0x0000fca0 - 0x0000fcbf (0x20) IX[B]
	[5] -1	0x0000fc90 - 0x0000fc9f (0x10) IX[B]
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
	[0] -1	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0xf8000000 - 0xfbffffff (0x4000000) MX[B]
	[6] -1	0xf6000000 - 0xf6ffffff (0x1000000) MX[B](B)
	[7] -1	0xfd000000 - 0xfdffffff (0x1000000) MX[B](B)
	[8] -1	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[9] -1	0x00000000 - 0x000000ff (0x100) IX[B]
	[10] -1	0x0000fcc0 - 0x0000fcff (0x40) IX[B]
	[11] -1	0x0000fca0 - 0x0000fcbf (0x20) IX[B]
	[12] -1	0x0000fc90 - 0x0000fc9f (0x10) IX[B]
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
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
(II) LoadModule: "fbdevhw"
(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 0.0.2
	ABI class: XFree86 Video Driver, version 0.4
(II) LoadModule: "pex5"
(II) Loading /usr/X11R6/lib/modules/extensions/libpex5.a
(II) Module pex5: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension X3D-PEX
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension XFree86-DRI
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Reloading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Loading extension GLX
(II) LoadModule: "pex5"
(II) Reloading /usr/X11R6/lib/modules/extensions/libpex5.a
(II) Loading extension X3D-PEX
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.13.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension RECORD
(II) LoadModule: "xie"
(II) Loading /usr/X11R6/lib/modules/extensions/libxie.a
(II) Module xie: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension XIE
(II) LoadModule: "nv"
(II) Loading /usr/X11R6/lib/modules/drivers/nv_drv.o
(II) Module nv: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.1
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.4
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
	Module class: XFree86 XInput Driver
	ABI class: XFree86 XInput driver, version 0.2
(II) NV: driver for NVIDIA chipsets: RIVA128, RIVATNT, RIVATNT2,
	RIVATNT2 (A), RIVATNT2 (B), RIVATNT2 (Ultra), RIVATNT2 (Vanta),
	RIVATNT2 M64, RIVATNT2 (Integrated), GeForce 256, GeForce DDR,
	Quadro, GeForce2 GTS, GeForce2 GTS (rev 1), GeForce2 ultra,
	Quadro 2 Pro, GeForce2 MX, GeForce2 MX DDR, Quadro 2 MXR,
	GeForce 2 Go, GeForce3, GeForce3 (rev 1), GeForce3 (rev 2),
	GeForce3 (rev 3)
(II) Primary Device is: PCI 01:00:0
(--) Assigning device section with no busID to primary device
(--) Chipset RIVA128 found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0xf8000000 - 0xfbffffff (0x4000000) MX[B]
	[6] -1	0xf6000000 - 0xf6ffffff (0x1000000) MX[B](B)
	[7] -1	0xfd000000 - 0xfdffffff (0x1000000) MX[B](B)
	[8] -1	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[9] -1	0x00000000 - 0x000000ff (0x100) IX[B]
	[10] -1	0x0000fcc0 - 0x0000fcff (0x40) IX[B]
	[11] -1	0x0000fca0 - 0x0000fcbf (0x20) IX[B]
	[12] -1	0x0000fc90 - 0x0000fc9f (0x10) IX[B]
(II) resource ranges after probing:
	[0] -1	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0xf8000000 - 0xfbffffff (0x4000000) MX[B]
	[6] -1	0xf6000000 - 0xf6ffffff (0x1000000) MX[B](B)
	[7] -1	0xfd000000 - 0xfdffffff (0x1000000) MX[B](B)
	[8] 0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[9] 0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[10] 0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[11] -1	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[12] -1	0x00000000 - 0x000000ff (0x100) IX[B]
	[13] -1	0x0000fcc0 - 0x0000fcff (0x40) IX[B]
	[14] -1	0x0000fca0 - 0x0000fcbf (0x20) IX[B]
	[15] -1	0x0000fc90 - 0x0000fc9f (0x10) IX[B]
	[16] 0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[17] 0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.4
(II) NV(0): Initializing int10
(II) NV(0): Primary V_BIOS segment is: 0xc000
(--) NV(0): Chipset: "RIVA128"
(EE) NV(0): The Riva 128 chipset does not support depth 16.  Using depth 15 
instead
(**) NV(0): Depth 15, (--) framebuffer bpp 16
(==) NV(0): RGB weight 555
(==) NV(0): Default visual is TrueColor
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.4
(==) NV(0): Using HW cursor
(--) NV(0): Linear framebuffer at 0xF6000000
(--) NV(0): MMIO registers at 0xFD000000
(--) NV(0): VideoRAM: 4096 kBytes
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.4
(II) Loading sub module "i2c"
(II) LoadModule: "i2c"
(II) Loading /usr/X11R6/lib/modules/libi2c.a
(II) Module i2c: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.2.0
	ABI class: XFree86 Video Driver, version 0.4
(II) NV(0): I2C bus "DDC" initialized.
(II) NV(0): I2C device "DDC:ddc2" registered.
(II) NV(0): I2C device "DDC:ddc2" removed.
(II) NV(0): I2C device "DDC:ddc2" registered.
(II) NV(0): I2C device "DDC:ddc2" removed.
(II) NV(0): DDC Monitor info: 0x8617f18
(II) NV(0): Manufacturer: DEL  Model: 7077  Serial#: 961173079
(II) NV(0): Year: 1999  Week: 11
(II) NV(0): EDID Version: 1.1
(II) NV(0): Analog Display Input,  Input Voltage Level: 0.700/0.300 V
(II) NV(0): Sync:  Separate  Composite
(II) NV(0): Max H-Image Size [cm]: horiz.: 34  vert.: 25
(II) NV(0): Gamma: 2.81
(II) NV(0): DPMS capabilities: StandBy Suspend Off; RGB/Color Display
(II) NV(0): redX: 0.638 redY: 0.325   greenX: 0.276 greenY: 0.596
(II) NV(0): blueX: 0.143 blueY: 0.066   whiteX: 0.281 whiteY: 0.311
(II) NV(0): Supported VESA Video Modes:
(II) NV(0): 720x400@70Hz
(II) NV(0): 640x480@60Hz
(II) NV(0): 640x480@75Hz
(II) NV(0): 800x600@60Hz
(II) NV(0): 800x600@75Hz
(II) NV(0): 1024x768@60Hz
(II) NV(0): 1024x768@75Hz
(II) NV(0): 1280x1024@75Hz
(II) NV(0): Manufacturer's mask: 0
(II) NV(0): Supported Future Video Modes:
(II) NV(0): #0: hsize: 640  vsize 480  refresh: 85  vid: 22833
(II) NV(0): #1: hsize: 800  vsize 600  refresh: 85  vid: 22853
(II) NV(0): #2: hsize: 1024  vsize 768  refresh: 85  vid: 22881
(II) NV(0): #3: hsize: 1280  vsize 1024  refresh: 60  vid: 32897
(II) NV(0): #4: hsize: 1280  vsize 1024  refresh: 85  vid: 39297
(II) NV(0): #5: hsize: 1600  vsize 1200  refresh: 60  vid: 16553
(II) NV(0): #6: hsize: 1600  vsize 1200  refresh: 75  vid: 20393
(II) NV(0): Supported additional Video Mode:
(II) NV(0): clock: 202.0 MHz   Image Size:  340 x 255 mm
(II) NV(0): h_active: 1600  h_sync: 1904  h_sync_end 2096 h_blank_end 2160 
h_border: 0
(II) NV(0): v_active: 1200  v_sync: 1246  v_sync_end 1249 v_blanking: 1250 
v_border: 0
(II) NV(0): Serial No: 59119C9JVW39
(II) NV(0): Monitor name: DELL D1226H
(II) NV(0): Ranges: V min: 50  V max: 160 Hz, H min: 30  H max: 95 kHz, 
PixClock max 2550 MHz
(II) NV(0): end of DDC Monitor info

(==) NV(0): Using gamma correction (1.0, 1.0, 1.0)
(II) NV(0): Monitor0: Using hsync range of 30.00-95.00 kHz
(II) NV(0): Monitor0: Using vrefresh range of 50.00-160.00 Hz
(II) NV(0): Clock range:  12.00 to 256.00 MHz
(II) NV(0): Not using default mode "1600x1200" (hsync out of range)
(II) NV(0): Not using default mode "1792x1344" (insufficient memory for 
mode)
(II) NV(0): Not using default mode "1792x1344" (insufficient memory for 
mode)
(II) NV(0): Not using default mode "1856x1392" (insufficient memory for 
mode)
(II) NV(0): Not using default mode "1856x1392" (insufficient memory for 
mode)
(II) NV(0): Not using default mode "1920x1440" (insufficient memory for 
mode)
(II) NV(0): Not using default mode "1920x1440" (insufficient memory for 
mode)
(--) NV(0): Virtual size is 1152x864 (pitch 1152)
(**) NV(0): Default mode "1152x864": 108.0 MHz, 67.5 kHz, 75.0 Hz
(II) NV(0): Modeline "1152x864"  108.00  1152 1216 1344 1600  864 865 868 
900 +hsync +vsync
(--) NV(0): Display dimensions: (34, 25) cm
(--) NV(0): DPI set to (86, 87)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.1
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.4
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.4
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] 0	0xf6000000 - 0xf6ffffff (0x1000000) MX[B]
	[1] 0	0xfd000000 - 0xfdffffff (0x1000000) MX[B]
	[2] -1	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[3] -1	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[4] -1	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[5] -1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[6] -1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[7] -1	0xf8000000 - 0xfbffffff (0x4000000) MX[B]
	[8] -1	0xf6000000 - 0xf6ffffff (0x1000000) MX[B](B)
	[9] -1	0xfd000000 - 0xfdffffff (0x1000000) MX[B](B)
	[10] 0	0x000a0000 - 0x000affff (0x10000) MS[B](OprD)
	[11] 0	0x000b0000 - 0x000b7fff (0x8000) MS[B](OprD)
	[12] 0	0x000b8000 - 0x000bffff (0x8000) MS[B](OprD)
	[13] -1	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[14] -1	0x00000000 - 0x000000ff (0x100) IX[B]
	[15] -1	0x0000fcc0 - 0x0000fcff (0x40) IX[B]
	[16] -1	0x0000fca0 - 0x0000fcbf (0x20) IX[B]
	[17] -1	0x0000fc90 - 0x0000fc9f (0x10) IX[B]
	[18] 0	0x000003b0 - 0x000003bb (0xc) IS[B](OprU)
	[19] 0	0x000003c0 - 0x000003df (0x20) IS[B](OprU)
(==) NV(0): Write-combining range (0xf6000000,0x400000)
(II) NV(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Lines
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		32 128x128 slots
		7 256x256 slots
(==) NV(0): Backing store disabled
(==) NV(0): Silken mouse enabled
(**) Option "dpms"
(**) NV(0): DPMS enabled
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
(**) Option "Protocol" "PS/2"
(**) Mouse0: Protocol: "PS/2"
(**) Option "CorePointer"
(**) Mouse0: Core Pointer
(**) Option "Device" "/dev/psaux"
(==) Mouse0: Buttons: 3
(**) Option "Emulate3Buttons" "yes"
(**) Mouse0: Emulate3Buttons, Emulate3Timeout: 50
(**) Option "ZAxisMapping" "4 5"
(**) Mouse0: ZAxisMapping: buttons 4 and 5
(II) Keyboard "Keyboard0" handled by legacy driver
(II) XINPUT: Adding extended input device "Mouse0" (type: MOUSE)

Fatal server error:
Caught signal 11.  Server aborting


When reporting a problem related to a server crash, please send
the full server output, not just the last messages.
This can be found in the log file "/var/log/XFree86.0.log".
Please report problems to xfree86@xfree86.org.




Can anyone tell me what this means?

Thanks in advance,

Femitha.



_________________________________________________________________
Join the world’s largest e-mail service with MSN Hotmail. 
http://www.hotmail.com

