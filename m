Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbTIMRyE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 13:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbTIMRyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 13:54:04 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:26074 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S261738AbTIMRx5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 13:53:57 -0400
Date: Sat, 13 Sep 2003 19:52:27 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.23-pre4: failed at atyfb_base.c
In-Reply-To: <Pine.GSO.4.21.0309131622000.2634-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.44.0309131948230.27449-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Sep 2003, Geert Uytterhoeven wrote:

> > I now disabled CONFIG_FB_ATY_GENERIC_LCD and it builds.
>
> Apparently Daniël didn't sent the latest version to Marcelo?

Yes, it was my latest version, but the code was still commented out. I
was in believe that I had corrected it, and simply commented out the hack
before sending it to Marcelo (which was stupid of course). I already sent a
fix to him but Marcelo hasn't applied it yet.

> Here are some fixes:
>
> --- linux-2.4.23-pre4/drivers/video/aty/atyfb_base.c.orig	Sat Sep 13 16:29:48 2003
> +++ linux-2.4.23-pre4/drivers/video/aty/atyfb_base.c	Fri Sep 12 12:50:36 2003
> @@ -313,7 +313,7 @@
>      int pll, mclk, xclk;
>      u32 features;
>  } aty_chips[] __initdata = {

> -    /* Note to kernel maintainers: Please resfuse any patch to change a clock rate,
> +    /* Note to kernel maintainers: Please REFUSE any patch to change a clock rate,

Haha! Was it the spelling error or was the message not strong enough? ;-)

Greetings,

Daniël


