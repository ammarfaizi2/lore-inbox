Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264090AbSIQMZg>; Tue, 17 Sep 2002 08:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264112AbSIQMZf>; Tue, 17 Sep 2002 08:25:35 -0400
Received: from mail.pixelwings.com ([194.152.163.212]:43015 "EHLO
	pixelwings.com") by vger.kernel.org with ESMTP id <S264090AbSIQMZc> convert rfc822-to-8bit;
	Tue, 17 Sep 2002 08:25:32 -0400
Date: Tue, 17 Sep 2002 14:30:28 +0200 (CEST)
From: Clemens Schwaighofer <cs@pixelwings.com>
X-X-Sender: gullevek@lynx.piwi.intern
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.35 ... ati patches still missing
Message-ID: <Pine.LNX.4.44.0209171429440.2696-100000@lynx.piwi.intern>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


System RH 7.3.94 ((null)) out of the box

  gcc -Wp,-MD,./.aty128fb.o.d -D__KERNEL__ 
-I/usr/src/kernel/2.5.35/linux-2.5.35/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix 
include    -DKBUILD_BASENAME=aty128fb   -c -o aty128fb.o aty128fb.c
aty128fb.c:419: unknown field `fb_get_fix' specified in initializer
aty128fb.c:419: warning: initialization from incompatible pointer type
aty128fb.c:420: unknown field `fb_get_var' specified in initializer
aty128fb.c:420: warning: initialization from incompatible pointer type
aty128fb.c: In function `aty128fb_set_var':
aty128fb.c:1379: structure has no member named `visual'
aty128fb.c:1380: structure has no member named `type'
aty128fb.c:1381: structure has no member named `type_aux'
aty128fb.c:1382: structure has no member named `ypanstep'
aty128fb.c:1383: structure has no member named `ywrapstep'
aty128fb.c:1384: structure has no member named `line_length'
make[2]: *** [aty128fb.o] Error 1
make[2]: Leaving directory 
`/usr/src/kernel/2.5.35/linux-2.5.35/drivers/video'
make[1]: *** [video] Error 2
make[1]: Leaving directory `/usr/src/kernel/2.5.35/linux-2.5.35/drivers'
make: *** [drivers] Error 2

I still get this errors, and I have to apply the FB / aty patches ...

-- 
"Der Krieg ist ein Massaker von Leuten, die sich nicht kennen, zum
Nutzen von Leuten, die sich kennen, aber nicht massakrieren"
- Paul Valéry (1871-1945)
mfg, Clemens Schwaighofer                       PIXELWINGS Medien GMBH
Kandlgasse 15/5, A-1070 Wien                      T: [+43 1] 524 58 50
JETZT NEU! MIT FEWA GEWASCHEN       -->      http://www.pixelwings.com

