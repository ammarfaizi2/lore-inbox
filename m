Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318920AbSH1SbP>; Wed, 28 Aug 2002 14:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318926AbSH1SbP>; Wed, 28 Aug 2002 14:31:15 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:43658 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S318920AbSH1SbN>; Wed, 28 Aug 2002 14:31:13 -0400
Date: Wed, 28 Aug 2002 11:28:46 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: James Simmons <jsimmons@transvirtual.com>, <geert@linux-m68k.org>,
       <linux-kernel@vger.kernel.org>, <trivial@rustcorp.com.au>
Subject: Re: [PATCH] Makefile typo
In-Reply-To: <20020828025328.CDF062C134@lists.samba.org>
Message-ID: <Pine.LNX.4.33.0208281128320.1459-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks. It is in the next set of changes for the fbdev layer.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

On Wed, 28 Aug 2002, Rusty Russell wrote:

> s/cfbimgblit/cfbimgblt/
>
> Rusty.
>
> --- working-2.5.32-hotcpu-cpudown-ppc/drivers/video/Makefile.~1~	2002-08-28 09:29:47.000000000 +1000
> +++ working-2.5.32-hotcpu-cpudown-ppc/drivers/video/Makefile	2002-08-28 17:28:23.000000000 +1000
> @@ -60,7 +60,7 @@
>  obj-$(CONFIG_FB_3DFX)             += tdfxfb.o
>  obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
>  obj-$(CONFIG_FB_HP300)            += hpfb.o cfbfillrect.o cfbimgblt.o
> -obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblit.o cfbcopyarea.o
> +obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
>  obj-$(CONFIG_FB_IMSTT)            += imsttfb.o
>  obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
>  obj-$(CONFIG_FB_CLGEN)            += clgenfb.o
>
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

