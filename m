Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155579AbQEPUZF>; Tue, 16 May 2000 16:25:05 -0400
Received: by vger.rutgers.edu id <S155368AbQEPUTp>; Tue, 16 May 2000 16:19:45 -0400
Received: from aeon.tvd.be ([195.162.196.20]:28233 "EHLO aeon.tvd.be") by vger.rutgers.edu with ESMTP id <S155926AbQEPUM1>; Tue, 16 May 2000 16:12:27 -0400
Date: Tue, 16 May 2000 22:25:08 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@acsu.buffalo.edu>
Cc: FrameBuffer List <linux-fbdev@vuser.vu.union.edu>, Linux Kernel Mailing List <linux-kernel@vger.rutgers.edu>
Subject: Re: [PATCH] updated Mips Magnum frame buffer device
In-Reply-To: <Pine.LNX.4.10.10005161109590.796-100000@maxwell.futurevision.com>
Message-ID: <Pine.LNX.4.05.10005162223490.17982-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Tue, 16 May 2000, James Simmons wrote:
> Yet another frame buffer driver updated to the new API. I don't know 
> the author's email address. Please test since I lack this hardware. It
> does compile. 

Forwarded to tsbogend@alpha.franken.de (see CREDITS :-), who's probably busy
with the PA-RISC port.

BTW, drivers that conform to the new API can have fb_ops->fb_get_{var,fix,cmap}
== NULL as well, if fbmem.c takes care of that.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
