Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262213AbRETUOJ>; Sun, 20 May 2001 16:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262216AbRETUN7>; Sun, 20 May 2001 16:13:59 -0400
Received: from hood.tvd.be ([195.162.196.21]:159 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S262213AbRETUNt>;
	Sun, 20 May 2001 16:13:49 -0400
Date: Sun, 20 May 2001 22:11:41 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: const __init
In-Reply-To: <3B0823DF.E99BD0F8@mandrakesoft.com>
Message-ID: <Pine.LNX.4.05.10105202210370.1667-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 May 2001, Jeff Garzik wrote:
> Geert Uytterhoeven wrote:
> > Since a while include/linux/init.h contains the line
> > 
> >     * Also note, that this data cannot be "const".
> > 
> > Why is this? Because const data will be put in a different section?
> 
> Causes a "section type conflict" build error, at least on x86.

On m68k I only saw section type conflict errors when using __init while it
should have been __initdata.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

