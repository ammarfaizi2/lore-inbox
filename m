Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264327AbSIQQt4>; Tue, 17 Sep 2002 12:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264371AbSIQQt4>; Tue, 17 Sep 2002 12:49:56 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:16555 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S264327AbSIQQtz>; Tue, 17 Sep 2002 12:49:55 -0400
Date: Tue, 17 Sep 2002 09:49:20 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Clemens Schwaighofer <cs@pixelwings.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.35 ... ati patches still missing
In-Reply-To: <Pine.LNX.4.44.0209171429440.2696-100000@lynx.piwi.intern>
Message-ID: <Pine.LNX.4.33.0209170948020.16312-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Sep 2002, Clemens Schwaighofer wrote:

>
> System RH 7.3.94 ((null)) out of the box
>
>   gcc -Wp,-MD,./.aty128fb.o.d -D__KERNEL__
> -I/usr/src/kernel/2.5.35/linux-2.5.35/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix
> include    -DKBUILD_BASENAME=aty128fb   -c -o aty128fb.o aty128fb.c
> aty128fb.c:419: unknown field `fb_get_fix' specified in initializer
> aty128fb.c:419: warning: initialization from incompatible pointer type
> aty128fb.c:420: unknown field `fb_get_var' specified in initializer
> aty128fb.c:420: warning: initialization from incompatible pointer type
> aty128fb.c: In function `aty128fb_set_var':
> aty128fb.c:1379: structure has no member named `visual'
> aty128fb.c:1380: structure has no member named `type'
> aty128fb.c:1381: structure has no member named `type_aux'
> aty128fb.c:1382: structure has no member named `ypanstep'
> aty128fb.c:1383: structure has no member named `ywrapstep'
> aty128fb.c:1384: structure has no member named `line_length'
> make[2]: *** [aty128fb.o] Error 1
> make[2]: Leaving directory
> `/usr/src/kernel/2.5.35/linux-2.5.35/drivers/video'
> make[1]: *** [video] Error 2
> make[1]: Leaving directory `/usr/src/kernel/2.5.35/linux-2.5.35/drivers'
> make: *** [drivers] Error 2
>
> I still get this errors, and I have to apply the FB / aty patches ...

Sorry. As well as being out of work I injured myself and was out of
business for awhile. I have recovered now so I can get back to work.
I still have the console patches I wanted to push since the future fbdev
changes depend on them.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

