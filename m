Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbTINIqe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 04:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTINIqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 04:46:34 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:49557 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262351AbTINIqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 04:46:32 -0400
Date: Sun, 14 Sep 2003 10:44:51 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.23-pre4: failed at atyfb_base.c
In-Reply-To: <Pine.LNX.4.44.0309131948230.27449-100000@deadlock.et.tudelft.nl>
Message-ID: <Pine.GSO.4.21.0309141043590.2634-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Sep 2003, [ISO-8859-1] Daniël Mantione wrote:
> On Sat, 13 Sep 2003, Geert Uytterhoeven wrote:
> > --- linux-2.4.23-pre4/drivers/video/aty/atyfb_base.c.orig	Sat Sep 13 16:29:48 2003
> > +++ linux-2.4.23-pre4/drivers/video/aty/atyfb_base.c	Fri Sep 12 12:50:36 2003
> > @@ -313,7 +313,7 @@
> >      int pll, mclk, xclk;
> >      u32 features;
> >  } aty_chips[] __initdata = {
> 
> > -    /* Note to kernel maintainers: Please resfuse any patch to change a clock rate,
> > +    /* Note to kernel maintainers: Please REFUSE any patch to change a clock rate,
> 
> Haha! Was it the spelling error or was the message not strong enough? ;-)

I didn't do that. The capitals were in the latest version you sent me...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

