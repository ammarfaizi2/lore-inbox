Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267114AbSK2Qyk>; Fri, 29 Nov 2002 11:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267118AbSK2Qyk>; Fri, 29 Nov 2002 11:54:40 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:26544 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267114AbSK2Qy2>; Fri, 29 Nov 2002 11:54:28 -0500
Message-Id: <4.3.2.7.2.20021129175124.00b57430@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 29 Nov 2002 18:01:43 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: Linux 2.4.20-rc4-ac1
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

X freezes up/blows with radeon driver. OK in 2.4.19/2.4.20
Messages and X log below

Margit

-- snip 1 ---
Nov 29 17:35:12 roglinux kernel: Linux agpgart interface v0.99 (c) Jeff 
Hartmann
Nov 29 17:35:12 roglinux kernel: agpgart: Maximum main memory to use for 
agp memory: 439M
Nov 29 17:35:12 roglinux kernel: agpgart: Detected Intel i845G chipset
Nov 29 17:35:12 roglinux kernel: agpgart: AGP aperture is 64M @ 0xf8000000
Nov 29 17:35:12 roglinux kernel: [drm] AGP 0.99 on Unknown @ 0xf8000000 64MB
Nov 29 17:35:12 roglinux kernel: [drm] Initialized radeon 1.7.0 20020828 on 
minor 0
Nov 29 17:35:12 roglinux kernel: Linux video capture interface: v1.00
Nov 29 17:35:12 roglinux kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Nov 29 17:35:12 roglinux kernel:  printing eip:
Nov 29 17:35:12 roglinux kernel: Linux agpgart interface v0.99 (c) Jeff 
Hartmann
Nov 29 17:35:12 roglinux kernel: agpgart: Maximum main memory to use for 
agp memory: 439M
Nov 29 17:35:12 roglinux kernel: agpgart: Detected Intel i845G chipset
Nov 29 17:35:12 roglinux kernel: agpgart: AGP aperture is 64M @ 0xf8000000
Nov 29 17:35:12 roglinux kernel: [drm] AGP 0.99 on Unknown @ 0xf8000000 64MB
Nov 29 17:35:12 roglinux kernel: [drm] Initialized radeon 1.7.0 20020828 on 
minor 0
Nov 29 17:35:12 roglinux kernel: Linux video capture interface: v1.00
Nov 29 17:35:12 roglinux kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Nov 29 17:35:12 roglinux kernel:  printing eip:
Nov 29 17:35:12 roglinux kernel: e0941a8d
Nov 29 17:35:12 roglinux kernel: *pde = 0222a067
Nov 29 17:35:12 roglinux kernel: *pte = 00000000
Nov 29 17:35:12 roglinux kernel: Oops: 0002
Nov 29 17:35:12 roglinux kernel: CPU:    0
Nov 29 17:35:12 roglinux kernel: EIP:    0010:[<e0941a8d>]    Not tainted
Nov 29 17:35:12 roglinux kernel: EFLAGS: 00013246
Nov 29 17:35:12 roglinux kernel: eax: e49591d0   ebx: f8000000   ecx: 
00000011   edx: 00000000
Nov 29 17:35:12 roglinux kernel: esi: dfb1dd80   edi: dc735efc   ebp: 
def6f800   esp: dc735ec4
Nov 29 17:35:12 roglinux kernel: ds: 0018   es: 0018   ss: 0018
Nov 29 17:35:12 roglinux kdm[1012]: IO Error in XOpenDisplay
Nov 29 17:35:12 roglinux kernel: Process X (pid: 966, stackpage=dc735000)
Nov 29 17:35:12 roglinux kernel: Stack: 00020000 00200000 000000f8 00000000 
dceb7d00 dceb7ac0 dc735efc def6f800
Nov 29 17:35:12 roglinux kernel:        dd2acf00 c2490400 e0941f0d def6f800 
dc735efc 00000054 00000001 00000898
Nov 29 17:35:12 roglinux kdm[950]: Server for display :0 terminated 
unexpectedly
Nov 29 17:35:12 roglinux kdm[950]: Display :0 cannot be opened
Nov 29 17:35:12 roglinux kernel:        00000000 40000000 00800000 00100000 
00002710 00000010 00000000 00000a00
Nov 29 17:35:12 roglinux kernel: Call Trace:    [<e0941f0d>] [<e093c34d>] 
[sys_ioctl+201/592] [system_call+51/56]
Nov 29 17:35:12 roglinux kernel: Call Trace:    [<e0941f0d>] [<e093c34d>] 
[<c014ef09>] [<c0108fd7>]
Nov 29 17:35:12 roglinux kernel:
Nov 29 17:35:12 roglinux kernel: Code: 89 02 89 34 24 e8 d9 f2 ff ff 89 74 
24 04 89 2c 24 e8 0df8
-- end snip --

-- snip --
II) PCI: Probing config type using method 1
(II) PCI: Config type is 1
(II) PCI: stages = 0x03, oldVal1 = 0x00000000, mode1Res1 = 0x80000000
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 8086,2560 card 8086,2560 rev 02 class 06,00,00 hdr 00
(II) PCI: 00:01:0: chip 8086,2561 card 0000,0000 rev 02 class 06,04,00 hdr 01
(II) PCI: 00:1d:0: chip 8086,24c2 card 8086,5356 rev 02 class 0c,03,00 hdr 80
(II) PCI: 00:1d:1: chip 8086,24c4 card 8086,5356 rev 02 class 0c,03,00 hdr 00
(II) PCI: 00:1d:2: chip 8086,24c7 card 8086,5356 rev 02 class 0c,03,00 hdr 00
(II) PCI: 00:1d:7: chip 8086,24cd card 8086,5356 rev 02 class 0c,03,20 hdr 00
(II) PCI: 00:1e:0: chip 8086,244e card 0000,0000 rev 82 class 06,04,00 hdr 01
(II) PCI: 00:1f:0: chip 8086,24c0 card 0000,0000 rev 02 class 06,01,00 hdr 80
(II) PCI: 00:1f:1: chip 8086,24cb card 8086,5356 rev 02 class 01,01,8a hdr 00
(II) PCI: 00:1f:3: chip 8086,24c3 card 8086,5356 rev 02 class 0c,05,00 hdr 00
(II) PCI: 00:1f:5: chip 8086,24c5 card 8086,0106 rev 02 class 04,01,00 hdr 00
(II) PCI: 01:00:0: chip 1002,5157 card 17af,2002 rev 00 class 03,00,00 hdr 00
(II) PCI: 02:01:0: chip 9005,00c0 card 9005,f620 rev 01 class 01,00,00 hdr 80
(II) PCI: 02:01:1: chip 9005,00c0 card 9005,f620 rev 01 class 01,00,00 hdr 80
(II) PCI: 02:04:0: chip 1244,0a00 card 1244,0a00 rev 02 class 02,80,00 hdr 00
(II) PCI: 02:05:0: chip 9004,6178 card 9004,7861 rev 03 class 01,00,00 hdr 00
(II) PCI: 02:08:0: chip 8086,1039 card 8086,3015 rev 82 class 02,00,00 hdr 00
(II) PCI: End of PCI scan
(II) LoadModule: "scanpci"
(II) Loading /usr/X11R6/lib/modules/libscanpci.a
(II) Module scanpci: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 0.1.0
         ABI class: XFree86 Video Driver, version 0.5
(II) UnloadModule: "scanpci"
(II) Unloading /usr/X11R6/lib/modules/libscanpci.a
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (-1,0,0), BCTRL: 0x08 (VGA_EN is set)
(II) Bus 0 I/O range:
         [0] -1  0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
         [0] -1  0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
         [0] -1  0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:1:0), (0,1,1), BCTRL: 0x08 (VGA_EN is set)
(II) Bus 1 I/O range:
         [0] -1  0x0000c000 - 0x0000cfff (0x1000) IX[B]
(II) Bus 1 non-prefetchable memory range:
         [0] -1  0xff800000 - 0xff8fffff (0x100000) MX[B]
(II) Bus 1 prefetchable memory range:
         [0] -1  0xe6900000 - 0xf69fffff (0x10100000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 2: bridge is at (0:30:0), (0,2,2), BCTRL: 0x02 (VGA_EN is cleared)
(II) Bus 2 I/O range:
         [0] -1  0x0000d000 - 0x0000dfff (0x1000) IX[B]
(II) Bus 2 non-prefetchable memory range:
         [0] -1  0xff900000 - 0xff9fffff (0x100000) MX[B]
(II) Bus 2 prefetchable memory range:
         [0] -1  0xf6a00000 - 0xf6afffff (0x100000) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:31:0), (0,-1,0), BCTRL: 0x08 (VGA_EN is set)
(II) Bus -1 I/O range:
(II) Bus -1 non-prefetchable memory range:
(II) Bus -1 prefetchable memory range:
(--) PCI:*(1:0:0) ATI Radeon 7500 QW rev 0, Mem @ 0xe8000000/27, 
0xff8f0000/16, I/O @ 0xc800/8, BIOS @ 0xff8c0000/17
(II) Addressable bus resource ranges are
         [0] -1  0x00000000 - 0xffffffff (0x0) MX[B]
         [1] -1  0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
         [0] -1  0xffe00000 - 0xffffffff (0x200000) MX[B](B)
         [1] -1  0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
         [2] -1  0x000f0000 - 0x000fffff (0x10000) MX[B]
         [3] -1  0x000c0000 - 0x000effff (0x30000) MX[B]
         [4] -1  0x00000000 - 0x0009ffff (0xa0000) MX[B]
         [5] -1  0x0000ffff - 0x0000ffff (0x1) IX[B]
         [6] -1  0x00000000 - 0x000000ff (0x100) IX[B]
(II) Active PCI resource ranges:
         [0] -1  0xff9fb000 - 0xff9fbfff (0x1000) MX[B]
         [1] -1  0xff9fc000 - 0xff9fcfff (0x1000) MX[B]
         [2] -1  0xff9fdc00 - 0xff9fdc1f (0x20) MX[B]
         [3] -1  0xffaff400 - 0xffaff4ff (0x100) MX[B]
         [4] -1  0xffaff800 - 0xffaff9ff (0x200) MX[B]
         [5] -1  0xffaffc00 - 0xffafffff (0x400) MX[B]
         [6] -1  0xf8000000 - 0xfbffffff (0x4000000) MX[B]
         [7] -1  0xff8c0000 - 0xff8dffff (0x20000) MX[B](B)
         [8] -1  0xff8f0000 - 0xff8fffff (0x10000) MX[B](B)
         [9] -1  0xe8000000 - 0xefffffff (0x8000000) MX[B](B)
         [10] -1 0x0000df00 - 0x0000df3f (0x40) IX[B]
         [11] -1 0x0000d000 - 0x0000d0ff (0x100) IX[B]
         [12] -1 0x0000dc00 - 0x0000dc1f (0x20) IX[B]
         [13] -1 0x0000d800 - 0x0000d8ff (0x100) IX[B]
         [14] -1 0x0000d400 - 0x0000d4ff (0x100) IX[B]
         [15] -1 0x0000e080 - 0x0000e0bf (0x40) IX[B]
         [16] -1 0x0000e400 - 0x0000e4ff (0x100) IX[B]
         [17] -1 0x0000e000 - 0x0000e01f (0x20) IX[B]
         [18] -1 0x0000ec00 - 0x0000ec1f (0x20) IX[B]
         [19] -1 0x0000e880 - 0x0000e89f (0x20) IX[B]
         [20] -1 0x0000e800 - 0x0000e81f (0x20) IX[B]
         [21] -1 0x0000c800 - 0x0000c8ff (0x100) IX[B](B)
(II) Inactive PCI resource ranges:
         [0] -1  0x20000000 - 0x200003ff (0x400) MX[B]
         [1] -1  0x0000ffa0 - 0x0000ffaf (0x10) IX[B]
(II) Active PCI resource ranges after removing overlaps:
         [0] -1  0xff9fb000 - 0xff9fbfff (0x1000) MX[B]
         [1] -1  0xff9fc000 - 0xff9fcfff (0x1000) MX[B]
         [2] -1  0xff9fdc00 - 0xff9fdc1f (0x20) MX[B]
         [3] -1  0xffaff400 - 0xffaff4ff (0x100) MX[B]
         [4] -1  0xffaff800 - 0xffaff9ff (0x200) MX[B]
         [5] -1  0xffaffc00 - 0xffafffff (0x400) MX[B]
         [6] -1  0xf8000000 - 0xfbffffff (0x4000000) MX[B]
         [7] -1  0xff8c0000 - 0xff8dffff (0x20000) MX[B](B)
         [8] -1  0xff8f0000 - 0xff8fffff (0x10000) MX[B](B)
         [9] -1  0xe8000000 - 0xefffffff (0x8000000) MX[B](B)
         [10] -1 0x0000df00 - 0x0000df3f (0x40) IX[B]
         [11] -1 0x0000d000 - 0x0000d0ff (0x100) IX[B]
         [12] -1 0x0000dc00 - 0x0000dc1f (0x20) IX[B]
         [13] -1 0x0000d800 - 0x0000d8ff (0x100) IX[B]
         [14] -1 0x0000d400 - 0x0000d4ff (0x100) IX[B]
         [15] -1 0x0000e080 - 0x0000e0bf (0x40) IX[B]
         [16] -1 0x0000e400 - 0x0000e4ff (0x100) IX[B]
         [17] -1 0x0000e000 - 0x0000e01f (0x20) IX[B]
         [18] -1 0x0000ec00 - 0x0000ec1f (0x20) IX[B]
         [19] -1 0x0000e880 - 0x0000e89f (0x20) IX[B]
         [20] -1 0x0000e800 - 0x0000e81f (0x20) IX[B]
         [21] -1 0x0000c800 - 0x0000c8ff (0x100) IX[B](B)
(II) Inactive PCI resource ranges after removing overlaps:
         [0] -1  0x20000000 - 0x200003ff (0x400) MX[B]
         [1] -1  0x0000ffa0 - 0x0000ffaf (0x10) IX[B]
(II) OS-reported resource ranges after removing overlaps with PCI:
         [0] -1  0xffe00000 - 0xffffffff (0x200000) MX[B](B)
         [1] -1  0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
         [2] -1  0x000f0000 - 0x000fffff (0x10000) MX[B]
         [3] -1  0x000c0000 - 0x000effff (0x30000) MX[B]
         [4] -1  0x00000000 - 0x0009ffff (0xa0000) MX[B]
         [5] -1  0x0000ffff - 0x0000ffff (0x1) IX[B]
         [6] -1  0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
         [0] -1  0xffe00000 - 0xffffffff (0x200000) MX[B](B)
         [1] -1  0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
         [2] -1  0x000f0000 - 0x000fffff (0x10000) MX[B]
         [3] -1  0x000c0000 - 0x000effff (0x30000) MX[B]
         [4] -1  0x00000000 - 0x0009ffff (0xa0000) MX[B]
         [5] -1  0xff9fb000 - 0xff9fbfff (0x1000) MX[B]
         [6] -1  0xff9fc000 - 0xff9fcfff (0x1000) MX[B]
         [7] -1  0xff9fdc00 - 0xff9fdc1f (0x20) MX[B]
         [8] -1  0xffaff400 - 0xffaff4ff (0x100) MX[B]
         [9] -1  0xffaff800 - 0xffaff9ff (0x200) MX[B]
         [10] -1 0xffaffc00 - 0xffafffff (0x400) MX[B]
         [11] -1 0xf8000000 - 0xfbffffff (0x4000000) MX[B]
         [12] -1 0xff8c0000 - 0xff8dffff (0x20000) MX[B](B)
         [13] -1 0xff8f0000 - 0xff8fffff (0x10000) MX[B](B)
         [14] -1 0xe8000000 - 0xefffffff (0x8000000) MX[B](B)
         [15] -1 0x20000000 - 0x200003ff (0x400) MX[B]
         [16] -1 0x0000ffff - 0x0000ffff (0x1) IX[B]
         [17] -1 0x00000000 - 0x000000ff (0x100) IX[B]
         [18] -1 0x0000df00 - 0x0000df3f (0x40) IX[B]
         [19] -1 0x0000d000 - 0x0000d0ff (0x100) IX[B]
         [20] -1 0x0000dc00 - 0x0000dc1f (0x20) IX[B]
         [21] -1 0x0000d800 - 0x0000d8ff (0x100) IX[B]
         [22] -1 0x0000d400 - 0x0000d4ff (0x100) IX[B]
         [23] -1 0x0000e080 - 0x0000e0bf (0x40) IX[B]
         [24] -1 0x0000e400 - 0x0000e4ff (0x100) IX[B]
         [25] -1 0x0000e000 - 0x0000e01f (0x20) IX[B]
         [26] -1 0x0000ec00 - 0x0000ec1f (0x20) IX[B]
         [27] -1 0x0000e880 - 0x0000e89f (0x20) IX[B]
         [28] -1 0x0000e800 - 0x0000e81f (0x20) IX[B]
         [29] -1 0x0000c800 - 0x0000c8ff (0x100) IX[B](B)
         [30] -1 0x0000ffa0 - 0x0000ffaf (0x10) IX[B]
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 1.0.1
         Module class: XFree86 Font Renderer
         ABI class: XFree86 Font Renderer, version 0.3
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 1.0.0
         Module class: XFree86 Server Extension
         ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 1.1.10
         Module class: XFree86 Font Renderer
         ABI class: XFree86 Font Renderer, version 0.3
(II) Loading font FreeType
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 1.0.0
         ABI class: XFree86 Server Extension, version 0.1
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 1.0.0
         ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension GLX
(II) LoadModule: "v4l"
(II) Loading /usr/X11R6/lib/modules/drivers/linux/v4l_drv.o
(II) Module v4l: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 0.0.1
         ABI class: XFree86 Video Driver, version 0.5
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 1.0.0
         ABI class: XFree86 Server Extension, version 0.1
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 1.0.0
         ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension XFree86-DRI
(II) LoadModule: "speedo"
(II) Loading /usr/X11R6/lib/modules/fonts/libspeedo.a
(II) Module speedo: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 1.0.1
         Module class: XFree86 Font Renderer
         ABI class: XFree86 Font Renderer, version 0.3
(II) Loading font Speedo
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 1.0.0
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
(II) LoadModule: "radeon"
(II) Loading /usr/X11R6/lib/modules/drivers/radeon_drv.o
(II) Module radeon: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 4.0.1
         Module class: XFree86 Video Driver
         ABI class: XFree86 Video Driver, version 0.5
(II) LoadModule: "ati"
(II) Loading /usr/X11R6/lib/modules/drivers/ati_drv.o
(II) Module ati: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 6.4.8
         Module class: XFree86 Video Driver
         ABI class: XFree86 Video Driver, version 0.5
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 1.0.0
         Module class: XFree86 XInput Driver
         ABI class: XFree86 XInput driver, version 0.3
(II) v4l driver for Video4Linux
(II) ATI: ATI driver (version 6.4.8) for chipsets: ati, ativga
(II) R128: Driver for ATI Rage 128 chipsets: ATI Rage 128 RE (PCI),
         ATI Rage 128 RF (AGP), ATI Rage 128 RG (AGP), ATI Rage 128 RK (PCI),
         ATI Rage 128 RL (AGP), ATI Rage 128 SM (AGP),
         ATI Rage 128 Pro PD (PCI), ATI Rage 128 Pro PF (AGP),
         ATI Rage 128 Pro PP (PCI), ATI Rage 128 Pro PR (PCI),
         ATI Rage 128 Pro ULTRA TF (AGP), ATI Rage 128 Pro ULTRA TL (AGP),
         ATI Rage 128 Pro ULTRA TR (AGP), ATI Rage 128 Mobility LE (PCI),
         ATI Rage 128 Mobility LF (AGP), ATI Rage 128 Mobility MF (AGP),
         ATI Rage 128 Mobility ML (AGP)
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
         ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP),
         ATI Radeon VE QY (AGP), ATI Radeon VE QZ (AGP),
         ATI Radeon Mobility LW (AGP), ATI Radeon Mobility LX (AGP),
         ATI Radeon Mobility LY (AGP), ATI Radeon Mobility LZ (AGP),
         ATI FireGL 8700/8800 (AGP), ATI Radeon 8500 QL (AGP),
         ATI Radeon 8500 QN (AGP), ATI Radeon 8500 QO (AGP),
         ATI Radeon 8500 Ql (AGP), ATI Radeon 8500 BB (AGP),
         ATI Radeon 7500 QW (AGP), ATI Radeon 9000 Pro (AGP)
(II) Primary Device is: PCI 01:00:0
(--) Chipset ATI Radeon 7500 QW (AGP) found
(II) resource ranges after xf86ClaimFixedResources() call:
         [0] -1  0xffe00000 - 0xffffffff (0x200000) MX[B](B)
         [1] -1  0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
         [2] -1  0x000f0000 - 0x000fffff (0x10000) MX[B]
         [3] -1  0x000c0000 - 0x000effff (0x30000) MX[B]
         [4] -1  0x00000000 - 0x0009ffff (0xa0000) MX[B]
         [5] -1  0xff9fb000 - 0xff9fbfff (0x1000) MX[B]
         [6] -1  0xff9fc000 - 0xff9fcfff (0x1000) MX[B]
         [7] -1  0xff9fdc00 - 0xff9fdc1f (0x20) MX[B]
         [8] -1  0xffaff400 - 0xffaff4ff (0x100) MX[B]
         [9] -1  0xffaff800 - 0xffaff9ff (0x200) MX[B]
         [10] -1 0xffaffc00 - 0xffafffff (0x400) MX[B]
         [11] -1 0xf8000000 - 0xfbffffff (0x4000000) MX[B]
         [12] -1 0xff8c0000 - 0xff8dffff (0x20000) MX[B](B)
         [13] -1 0xff8f0000 - 0xff8fffff (0x10000) MX[B](B)
         [14] -1 0xe8000000 - 0xefffffff (0x8000000) MX[B](B)
         [15] -1 0x20000000 - 0x200003ff (0x400) MX[B]
         [16] -1 0x0000ffff - 0x0000ffff (0x1) IX[B]
         [17] -1 0x00000000 - 0x000000ff (0x100) IX[B]
         [18] -1 0x0000df00 - 0x0000df3f (0x40) IX[B]
         [19] -1 0x0000d000 - 0x0000d0ff (0x100) IX[B]
         [20] -1 0x0000dc00 - 0x0000dc1f (0x20) IX[B]
         [21] -1 0x0000d800 - 0x0000d8ff (0x100) IX[B]
         [22] -1 0x0000d400 - 0x0000d4ff (0x100) IX[B]
         [23] -1 0x0000e080 - 0x0000e0bf (0x40) IX[B]
         [24] -1 0x0000e400 - 0x0000e4ff (0x100) IX[B]
         [25] -1 0x0000e000 - 0x0000e01f (0x20) IX[B]
         [26] -1 0x0000ec00 - 0x0000ec1f (0x20) IX[B]
         [27] -1 0x0000e880 - 0x0000e89f (0x20) IX[B]
         [28] -1 0x0000e800 - 0x0000e81f (0x20) IX[B]
         [29] -1 0x0000c800 - 0x0000c8ff (0x100) IX[B](B)
         [30] -1 0x0000ffa0 - 0x0000ffaf (0x10) IX[B]
(II) Loading sub module "radeon"
(II) LoadModule: "radeon"
(II) Reloading /usr/X11R6/lib/modules/drivers/radeon_drv.o
(II) resource ranges after probing:
         [0] -1  0xffe00000 - 0xffffffff (0x200000) MX[B](B)
         [1] -1  0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
         [2] -1  0x000f0000 - 0x000fffff (0x10000) MX[B]
         [3] -1  0x000c0000 - 0x000effff (0x30000) MX[B]
         [4] -1  0x00000000 - 0x0009ffff (0xa0000) MX[B]
         [5] -1  0xff9fb000 - 0xff9fbfff (0x1000) MX[B]
         [6] -1  0xff9fc000 - 0xff9fcfff (0x1000) MX[B]
         [7] -1  0xff9fdc00 - 0xff9fdc1f (0x20) MX[B]
         [8] -1  0xffaff400 - 0xffaff4ff (0x100) MX[B]
         [9] -1  0xffaff800 - 0xffaff9ff (0x200) MX[B]
         [10] -1 0xffaffc00 - 0xffafffff (0x400) MX[B]
         [11] -1 0xf8000000 - 0xfbffffff (0x4000000) MX[B]
         [12] -1 0xff8c0000 - 0xff8dffff (0x20000) MX[B](B)
         [13] -1 0xff8f0000 - 0xff8fffff (0x10000) MX[B](B)
         [14] -1 0xe8000000 - 0xefffffff (0x8000000) MX[B](B)
         [15] -1 0x20000000 - 0x200003ff (0x400) MX[B]
         [16] 0  0x000a0000 - 0x000affff (0x10000) MS[B]
         [17] 0  0x000b0000 - 0x000b7fff (0x8000) MS[B]
         [18] 0  0x000b8000 - 0x000bffff (0x8000) MS[B]
         [19] -1 0x0000ffff - 0x0000ffff (0x1) IX[B]
         [20] -1 0x00000000 - 0x000000ff (0x100) IX[B]
         [21] -1 0x0000df00 - 0x0000df3f (0x40) IX[B]
         [22] -1 0x0000d000 - 0x0000d0ff (0x100) IX[B]
         [23] -1 0x0000dc00 - 0x0000dc1f (0x20) IX[B]
         [24] -1 0x0000d800 - 0x0000d8ff (0x100) IX[B]
         [25] -1 0x0000d400 - 0x0000d4ff (0x100) IX[B]
         [26] -1 0x0000e080 - 0x0000e0bf (0x40) IX[B]
         [27] -1 0x0000e400 - 0x0000e4ff (0x100) IX[B]
         [28] -1 0x0000e000 - 0x0000e01f (0x20) IX[B]
         [29] -1 0x0000ec00 - 0x0000ec1f (0x20) IX[B]
         [30] -1 0x0000e880 - 0x0000e89f (0x20) IX[B]
         [31] -1 0x0000e800 - 0x0000e81f (0x20) IX[B]
         [32] -1 0x0000c800 - 0x0000c8ff (0x100) IX[B](B)
         [33] -1 0x0000ffa0 - 0x0000ffaf (0x10) IX[B]
         [34] 0  0x000003b0 - 0x000003bb (0xc) IS[B]
         [35] 0  0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 0.1.0
         ABI class: XFree86 Video Driver, version 0.5
(II) RADEON(0): PCI bus 1 card 0 func 0
(**) RADEON(0): Depth 16, (--) framebuffer bpp 16
(II) RADEON(0): Pixel depth = 16 bits stored in 2 bytes (16 bpp pixmaps)
(==) RADEON(0): Default visual is TrueColor
(**) RADEON(0): Option "AGPMode" "4"
(==) RADEON(0): RGB weight 565
(II) RADEON(0): Using 6 bits per RGB (8 bit DAC)
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 1.0.0
         ABI class: XFree86 Video Driver, version 0.5
(II) RADEON(0): initializing int10
(WW) RADEON(0): Bad V_BIOS checksum
(II) RADEON(0): Primary V_BIOS segment is: 0xc000
(--) RADEON(0): Chipset: "ATI Radeon 7500 QW (AGP)" (ChipID = 0x5157)
(--) RADEON(0): Linear framebuffer at 0xe8000000
(--) RADEON(0): MMIO registers at 0xff8f0000
(--) RADEON(0): BIOS at 0xff8c0000
(--) RADEON(0): VideoRAM: 65536 kByte (64-bit DDR SDRAM)
(II) RADEON(0): Primary Display == Type 1
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 1.0.0
         ABI class: XFree86 Video Driver, version 0.5
(II) Loading sub module "i2c"
(II) LoadModule: "i2c"
(II) Loading /usr/X11R6/lib/modules/libi2c.a
(II) Module i2c: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 1.2.0
         ABI class: XFree86 Video Driver, version 0.5
(II) RADEON(0): I2C bus "DDC" initialized.
(II) RADEON(0): I2C device "DDC:ddc2" registered.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) Loading sub module "vbe"
(II) LoadModule: "vbe"
(II) Loading /usr/X11R6/lib/modules/libvbe.a
(II) Module vbe: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 1.0.0
         ABI class: XFree86 Video Driver, version 0.5
(II) RADEON(0): VESA BIOS detected
(II) RADEON(0): VESA VBE Version 2.0
(II) RADEON(0): VESA VBE Total Mem: 65536 kB
(II) RADEON(0): VESA VBE OEM: ATI RADEON 7500
(II) RADEON(0): VESA VBE OEM Software Rev: 1.0
(II) RADEON(0): VESA VBE OEM Vendor: ATI Technologies Inc.
(II) RADEON(0): VESA VBE OEM Product: V200
(II) RADEON(0): VESA VBE OEM Product Rev: 01.00
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Reloading /usr/X11R6/lib/modules/libddc.a
(II) RADEON(0): VESA VBE DDC supported
(II) RADEON(0): VESA VBE DDC Level none
(II) RADEON(0): VESA VBE DDC transfer in appr. 2 sec.
(II) RADEON(0): VESA VBE DDC read failed
(II) RADEON(0): PLL parameters: rf=2700 rd=12 min=20000 max=35000; xclk=19000
(==) RADEON(0): Using gamma correction (1.0, 1.0, 1.0)
(II) RADEON(0): Monitor[0]: Using hsync range of 27.00-96.00 kHz
(II) RADEON(0): Monitor[0]: Using vrefresh range of 50.00-160.00 Hz
(II) RADEON(0): Clock range:  20.00 to 350.00 MHz
(II) RADEON(0): Not using default mode "320x175" (bad mode 
clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "320x200" (bad mode 
clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "360x200" (bad mode 
clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "320x240" (bad mode 
clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "320x240" (bad mode 
clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "320x240" (bad mode 
clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "320x240" (bad mode 
clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "400x300" (bad mode 
clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "1792x1344" (hsync out of range)
(II) RADEON(0): Not using default mode "896x672" (hsync out of range)
(II) RADEON(0): Not using default mode "1856x1392" (hsync out of range)
(II) RADEON(0): Not using default mode "928x696" (hsync out of range)
(II) RADEON(0): Not using default mode "1920x1440" (hsync out of range)
(II) RADEON(0): Not using default mode "960x720" (hsync out of range)
(--) RADEON(0): Virtual size is 1280x1024 (pitch 1280)
(**) RADEON(0): Mode "1280x1024": 159.7 MHz, 92.0 kHz, 86.0 Hz
(II) RADEON(0): Modeline "1280x1024"  159.74  1280 1296 1552 1736  1024 
1024 1039 1070
(**) RADEON(0): Mode "1024x768": 127.5 MHz, 91.1 kHz, 113.5 Hz
(II) RADEON(0): Modeline "1024x768"  127.49  1024 1040 1216 1400  768 768 
783 802
(**) RADEON(0): Mode "800x600": 87.4 MHz, 78.6 kHz, 125.5 Hz
(II) RADEON(0): Modeline "800x600"   87.36  800 816 928 1112  600 600 615 626
(**) RADEON(0): Mode "640x480": 55.9 MHz, 61.8 kHz, 123.4 Hz
(II) RADEON(0): Modeline "640x480"   55.91  640 656 720 904  480 480 491 501
(==) RADEON(0): DPI set to (75, 75)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 1.0.0
         ABI class: XFree86 ANSI C Emulation, version 0.1
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 0.1.0
         ABI class: XFree86 Video Driver, version 0.5
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 1.0.0
         ABI class: XFree86 Video Driver, version 0.5
(**) RADEON(0): Using AGP 4x mode
(II) RADEON(0): Depth moves disabled by default
(!!) RADEON(0): For information on using the multimedia capabilities
  of this adapter, please see http://gatos.sf.net.
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
         [0] 0   0xff8f0000 - 0xff8fffff (0x10000) MX[B]
         [1] 0   0xe8000000 - 0xefffffff (0x8000000) MX[B]
         [2] -1  0xffe00000 - 0xffffffff (0x200000) MX[B](B)
         [3] -1  0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
         [4] -1  0x000f0000 - 0x000fffff (0x10000) MX[B]
         [5] -1  0x000c0000 - 0x000effff (0x30000) MX[B]
         [6] -1  0x00000000 - 0x0009ffff (0xa0000) MX[B]
         [7] -1  0xff9fb000 - 0xff9fbfff (0x1000) MX[B]
         [8] -1  0xff9fc000 - 0xff9fcfff (0x1000) MX[B]
         [9] -1  0xff9fdc00 - 0xff9fdc1f (0x20) MX[B]
         [10] -1 0xffaff400 - 0xffaff4ff (0x100) MX[B]
         [11] -1 0xffaff800 - 0xffaff9ff (0x200) MX[B]
         [12] -1 0xffaffc00 - 0xffafffff (0x400) MX[B]
         [13] -1 0xf8000000 - 0xfbffffff (0x4000000) MX[B]
         [14] -1 0xff8c0000 - 0xff8dffff (0x20000) MX[B](B)
         [15] -1 0xff8f0000 - 0xff8fffff (0x10000) MX[B](B)
         [16] -1 0xe8000000 - 0xefffffff (0x8000000) MX[B](B)
         [17] -1 0x20000000 - 0x200003ff (0x400) MX[B]
         [18] 0  0x000a0000 - 0x000affff (0x10000) MS[B]
         [19] 0  0x000b0000 - 0x000b7fff (0x8000) MS[B]
         [20] 0  0x000b8000 - 0x000bffff (0x8000) MS[B]
         [21] 0  0x0000c800 - 0x0000c8ff (0x100) IX[B]
         [22] -1 0x0000ffff - 0x0000ffff (0x1) IX[B]
         [23] -1 0x00000000 - 0x000000ff (0x100) IX[B]
         [24] -1 0x0000df00 - 0x0000df3f (0x40) IX[B]
         [25] -1 0x0000d000 - 0x0000d0ff (0x100) IX[B]
         [26] -1 0x0000dc00 - 0x0000dc1f (0x20) IX[B]
         [27] -1 0x0000d800 - 0x0000d8ff (0x100) IX[B]
         [28] -1 0x0000d400 - 0x0000d4ff (0x100) IX[B]
         [29] -1 0x0000e080 - 0x0000e0bf (0x40) IX[B]
         [30] -1 0x0000e400 - 0x0000e4ff (0x100) IX[B]
         [31] -1 0x0000e000 - 0x0000e01f (0x20) IX[B]
         [32] -1 0x0000ec00 - 0x0000ec1f (0x20) IX[B]
         [33] -1 0x0000e880 - 0x0000e89f (0x20) IX[B]
         [34] -1 0x0000e800 - 0x0000e81f (0x20) IX[B]
         [35] -1 0x0000c800 - 0x0000c8ff (0x100) IX[B](B)
         [36] -1 0x0000ffa0 - 0x0000ffaf (0x10) IX[B]
         [37] 0  0x000003b0 - 0x000003bb (0xc) IS[B]
         [38] 0  0x000003c0 - 0x000003df (0x20) IS[B]
(==) RADEON(0): Write-combining range (0xe8000000,0x4000000)
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 6, (OK)
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 6, (OK)
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 6, (OK)
drmGetBusid returned 'PCI:1:0:0'
drmOpenDevice: minor is 1
drmOpenDevice: node name is /dev/dri/card1
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 2
drmOpenDevice: node name is /dev/dri/card2
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 3
drmOpenDevice: node name is /dev/dri/card3
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 4
drmOpenDevice: node name is /dev/dri/card4
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 5
drmOpenDevice: node name is /dev/dri/card5
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 6
drmOpenDevice: node name is /dev/dri/card6
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 7
drmOpenDevice: node name is /dev/dri/card7
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 8
drmOpenDevice: node name is /dev/dri/card8
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 9
drmOpenDevice: node name is /dev/dri/card9
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 10
drmOpenDevice: node name is /dev/dri/card10
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 11
drmOpenDevice: node name is /dev/dri/card11
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 12
drmOpenDevice: node name is /dev/dri/card12
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 13
drmOpenDevice: node name is /dev/dri/card13
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 14
drmOpenDevice: node name is /dev/dri/card14
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenByBusid: busid is PCI:1:0:0
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 6, (OK)
drmOpenByBusid: drmOpenMinor returns 6
drmOpenByBusid: drmGetBusid reports PCI:1:0:0
(II) RADEON(0): [drm] drmSetBusid failed (6, PCI:1:0:0), Device or resource 
busy
(EE) RADEON(0): [dri] DRIScreenInit failed.  Disabling DRI.
(II) RADEON(0): Memory manager initialized to (0,0) (1280,8191)
(II) RADEON(0): Reserved area from (0,1024) to (1280,1026)
(II) RADEON(0): Largest offscreen area available: 1280 x 7165
(==) RADEON(0): Backing store disabled
(==) RADEON(0): Silken mouse enabled
(II) RADEON(0): Using XFree86 Acceleration Architecture (XAA)
         Screen to screen bit blits
         Solid filled rectangles
         8x8 mono pattern filled rectangles
         Indirect CPU to Screen color expansion
         Solid Lines
         Dashed Lines
         Scanline Image Writes
         Offscreen Pixmaps
         Setting up tile and stipple cache:
                 32 128x128 slots
                 32 256x256 slots
                 16 512x512 slots
(II) RADEON(0): Acceleration enabled
(II) RADEON(0): Using hardware cursor (scanline 2052)
(II) RADEON(0): Largest offscreen area available: 1280 x 7163
(**) Option "dpms"
(**) RADEON(0): DPMS enabled
(II) RADEON(0): Dotclock is 159.74 Mhz, setting ecp_div to 0
(WW) RADEON(0): Option "CalcAlgorithm" is not used
(II) RADEON(0): Direct rendering disabled
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
(II) Keyboard "Keyboard[0]" handled by legacy driver
(**) Option "Protocol" "imps/2"
(**) Mouse[1]: Protocol: "imps/2"
(**) Option "CorePointer"
(**) Mouse[1]: Core Pointer
(**) Option "Device" "/dev/psaux"
(**) Mouse[1]: Emulate3Buttons, Emulate3Timeout: 50
(**) Option "ZAxisMapping" "4 5"
(**) Mouse[1]: ZAxisMapping: buttons 4 and 5
(**) Mouse[1]: Buttons: 5
(II) XINPUT: Adding extended input device "Mouse[1]" (type: MOUSE)
-- end snip --

