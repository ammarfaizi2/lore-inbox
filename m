Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264757AbTE1OrL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 10:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264758AbTE1OrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 10:47:09 -0400
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:37644 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264757AbTE1OrC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 10:47:02 -0400
Date: Wed, 28 May 2003 16:59:46 +0200 (CEST)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.70
In-Reply-To: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.51L.0305281627460.24008@piorun.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finally - I've started to worry if this kernel will be ever released :)

When building framebuffer driver for my new Matrox G400 I get this error:

scripts/fixdep drivers/video/logo/.logo_linux_clut224.o.d drivers/video/logo/logo_linux_clut224.o 'gcc -Wp,-MD,drivers/video/logo/.logo_linux_clut224.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=logo_linux_clut224 -DKBUILD_MODNAME=logo_linux_clut224 -c -o drivers/video/logo/.tmp_logo_linux_clut224.o drivers/video/logo/logo_linux_clut224.c' > drivers/video/logo/.logo_linux_clut224.o.tmp; rm -f drivers/video/logo/.logo_linux_clut224.o.d; mv -f drivers/video/logo/.logo_linux_clut224.o.tmp drivers/video/logo/.logo_linux_clut224.o.cmd
  LD      drivers/video/logo/built-in.o
  CC      drivers/video/matrox/matroxfb_base.o
In file included from drivers/video/matrox/matroxfb_base.c:105:
drivers/video/matrox/matroxfb_base.h:52: video/fbcon.h: No such file or directory
drivers/video/matrox/matroxfb_base.h:53: video/fbcon-cfb4.h: No such file or directory
drivers/video/matrox/matroxfb_base.h:54: video/fbcon-cfb8.h: No such file or directory
drivers/video/matrox/matroxfb_base.h:55: video/fbcon-cfb16.h: No such file or directory
drivers/video/matrox/matroxfb_base.h:56: video/fbcon-cfb24.h: No such file or directory
drivers/video/matrox/matroxfb_base.h:57: video/fbcon-cfb32.h: No such file or directory
In file included from drivers/video/matrox/matroxfb_base.c:105:
drivers/video/matrox/matroxfb_base.h:341: warning: `struct display' declared inside parameter list
drivers/video/matrox/matroxfb_base.h:341: warning: its scope is only this definition or declaration, which is probably not what you want.
drivers/video/matrox/matroxfb_base.h:342: warning: `struct display' declared inside parameter list
drivers/video/matrox/matroxfb_base.h:558: field `dispsw' has incomplete type
drivers/video/matrox/matroxfb_base.h: In function `mxinfo':
drivers/video/matrox/matroxfb_base.h:633: dereferencing pointer to incomplete 
typedrivers/video/matrox/matroxfb_base.c: At top level:
drivers/video/matrox/matroxfb_base.c:148: warning: braces around scalar initializer
drivers/video/matrox/matroxfb_base.c:148: warning: (near initialization for `vesafb_defined.rotate')
drivers/video/matrox/matroxfb_base.c:148: warning: excess elements in scalar initializer
drivers/video/matrox/matroxfb_base.c:148: warning: (near initialization for `vesafb_defined.rotate')
drivers/video/matrox/matroxfb_base.c:148: warning: excess elements in scalar initializer
drivers/video/matrox/matroxfb_base.c:148: warning: (near initialization for `vesafb_defined.rotate')
drivers/video/matrox/matroxfb_base.c:148: warning: excess elements in scalar initializer
drivers/video/matrox/matroxfb_base.c:148: warning: (near initialization for `vesafb_defined.rotate')
drivers/video/matrox/matroxfb_base.c:148: warning: excess elements in scalar initializer
drivers/video/matrox/matroxfb_base.c:148: warning: (near initialization for `vesafb_defined.rotate')
drivers/video/matrox/matroxfb_base.c:148: warning: excess elements in scalar initializer
drivers/video/matrox/matroxfb_base.c:148: warning: (near initialization for `vesafb_defined.rotate')
drivers/video/matrox/matroxfb_base.c: In function `my_install_cmap':
drivers/video/matrox/matroxfb_base.c:158: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c: In function `matrox_pan_var':
drivers/video/matrox/matroxfb_base.c:186: warning: implicit declaration of function `fontheight'
drivers/video/matrox/matroxfb_base.c:186: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:186: warning: implicit declaration of function `fontwidth'
drivers/video/matrox/matroxfb_base.c:169: warning: `pos' might be used uninitialized in this function
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_remove':
drivers/video/matrox/matroxfb_base.c:238: structure has no member named `disp'
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_pan_display':
drivers/video/matrox/matroxfb_base.c:279: `fb_display' undeclared (first use in this function)
drivers/video/matrox/matroxfb_base.c:279: (Each undeclared identifier is reported only once
drivers/video/matrox/matroxfb_base.c:279: for each function it appears in.)
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_updatevar':
drivers/video/matrox/matroxfb_base.c:303: `fb_display' undeclared (first use in this function)
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_set_var':
drivers/video/matrox/matroxfb_base.c:688: `fb_display' undeclared (first use in this function)
drivers/video/matrox/matroxfb_base.c:690: structure has no member named `disp'
drivers/video/matrox/matroxfb_base.c:700: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:701: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:702: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:703: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:704: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:705: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:706: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:707: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:711: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:721: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:725: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:728: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:729: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:735: structure has no member named `changevar'
drivers/video/matrox/matroxfb_base.c:736: structure has no member named `changevar'
drivers/video/matrox/matroxfb_base.c:802: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:678: warning: `display' might be used uninitialized in this function
drivers/video/matrox/matroxfb_base.c:738: warning: `pos' might be used uninitialized in this function
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_get_cmap':
drivers/video/matrox/matroxfb_base.c:866: structure has no member named `disp'
drivers/video/matrox/matroxfb_base.c:867: `fb_display' undeclared (first use in this function)
drivers/video/matrox/matroxfb_base.c:876: warning: implicit declaration of function `fb_get_cmap'
drivers/video/matrox/matroxfb_base.c:877: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:878: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:880: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_set_cmap':
drivers/video/matrox/matroxfb_base.c:890: structure has no member named `disp'
drivers/video/matrox/matroxfb_base.c:890: `fb_display' undeclared (first use in this function)
drivers/video/matrox/matroxfb_base.c:899: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:900: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:903: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:910: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_ioctl':
drivers/video/matrox/matroxfb_base.c:1009: structure has no member named `switch_con'
drivers/video/matrox/matroxfb_base.c: At top level:
drivers/video/matrox/matroxfb_base.c:1188: unknown field `fb_set_var' specified in initializer
drivers/video/matrox/matroxfb_base.c:1188: warning: initialization from incompatible pointer type
drivers/video/matrox/matroxfb_base.c:1189: unknown field `fb_get_cmap' specified in initializer
drivers/video/matrox/matroxfb_base.c:1189: warning: initialization from incompatible pointer type
drivers/video/matrox/matroxfb_base.c:1190: unknown field `fb_set_cmap' specified in initializer
drivers/video/matrox/matroxfb_base.c:1190: warning: initialization from incompatible pointer type
drivers/video/matrox/matroxfb_base.c:1192: warning: initialization from incompatible pointer type
drivers/video/matrox/matroxfb_base.c:1194: warning: initialization from incompatible pointer type
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_switch':
drivers/video/matrox/matroxfb_base.c:1207: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:1222: structure has no member named `disp'
drivers/video/matrox/matroxfb_base.c:1224: `fb_display' undeclared (first use in this function)
drivers/video/matrox/matroxfb_base.c:1226: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:1235: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:1200: warning: `cmap' might be used uninitialized in this function
drivers/video/matrox/matroxfb_base.c:1201: warning: `p' might be used uninitialized in this function
drivers/video/matrox/matroxfb_base.c: In function `initMatrox2':
drivers/video/matrox/matroxfb_base.c:1741: structure has no member named `fontname'
drivers/video/matrox/matroxfb_base.c:1742: structure has no member named `fontname'
drivers/video/matrox/matroxfb_base.c:1753: structure has no member named `modename'
drivers/video/matrox/matroxfb_base.c:1754: structure has no member named `changevar'
drivers/video/matrox/matroxfb_base.c:1756: structure has no member named `disp'
drivers/video/matrox/matroxfb_base.c:1757: structure has no member named `switch_con'
drivers/video/matrox/matroxfb_base.c:1758: structure has no member named `updatevar'
drivers/video/matrox/matroxfb_base.c:1874: structure has no member named `modename'
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_probe':
drivers/video/matrox/matroxfb_base.c:2015: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:2027: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:2027: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:2027: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:2027: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:2027: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:2027: dereferencing pointer to incomplete type
drivers/video/matrox/matroxfb_base.c:2034: structure has no member named `fontname'
drivers/video/matrox/matroxfb_base.c:2034: structure has no member named `fontname'
drivers/video/matrox/matroxfb_base.c:2034: structure has no member named `fontname'
drivers/video/matrox/matroxfb_base.c:2034: structure has no member named `fontname'
drivers/video/matrox/matroxfb_base.c:2034: structure has no member named `fontname'
make[3]: *** [drivers/video/matrox/matroxfb_base.o] Error 1
make[2]: *** [drivers/video/matrox] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2
Command exited with non-zero status 2



-- 
pozdr.  Pawe? Go?aszewski 
---------------------------------
worth to see: http://www.againsttcpa.com/
CPU not found - software emulation...
