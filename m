Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSH1SSC>; Wed, 28 Aug 2002 14:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317743AbSH1SSB>; Wed, 28 Aug 2002 14:18:01 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:21714 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S317101AbSH1SR7>; Wed, 28 Aug 2002 14:17:59 -0400
Date: Wed, 28 Aug 2002 11:15:45 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: "Clemens 'Gullevek' Schwaighofer" <schwaigl@eunet.at>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: still ati fb errors with 2.5.31, thought patch applied
In-Reply-To: <46344979984.20020828090546@eunet.at>
Message-ID: <Pine.LNX.4.33.0208281114420.1459-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> aty128fb.c: In function `aty128_pci_register':
> aty128fb.c:1730: too many arguments to function `aty128find_ROM'
> aty128fb.c:1736: warning: passing arg 1 of `aty128_get_pllinfo' from incompatible pointer type
> aty128fb.c:1749: structure has no member named `mtrr'
> aty128fb.c:1750: structure has no member named `vram_size'
> aty128fb.c:1751: structure has no member named `mtrr'
> aty128fb.c: At top level:
> aty128fb.c:1402: warning: `aty128fb_rasterimg' defined but not used
> make[3]: *** [aty128fb.o] Error 1
> make[3]: Leaving directory `/usr/src/kernel/2.5.32/linux-2.5.32/drivers/video'
> make[2]: *** [video] Error 2
> make[2]: Leaving directory `/usr/src/kernel/2.5.32/linux-2.5.32/drivers'
> make[1]: *** [drivers] Error 2
> make[1]: Leaving directory `/usr/src/kernel/2.5.32/linux-2.5.32'
> make: *** [bzImage] Error 2

This driver has not been ported to the new api.

> I have applied the atifb patch postet earlier (19th august by Paul
> Mackerras), but still get this error ...

The next set of changes for the fbdev layer includes a bunch of fixes
including ones for atifb.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

