Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUFERjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUFERjW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 13:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUFERjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 13:39:22 -0400
Received: from witte.sonytel.be ([80.88.33.193]:22712 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261763AbUFERjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 13:39:20 -0400
Date: Sat, 5 Jun 2004 19:39:00 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Peter Korsgaard <jacmet@sunsite.dk>,
       James Simmons <jsimmons@infradead.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Rusty Trivial Russell <trivial@rustcorp.com.au>
Subject: Re: [PATCH] Typo in Documentation/fb/framebuffer.txt
In-Reply-To: <87zn7k4aw9.fsf@p4.48ers.dk>
Message-ID: <Pine.GSO.4.58.0406051938320.12190@waterleaf.sonytel.be>
References: <87zn7k4aw9.fsf@p4.48ers.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2004, Peter Korsgaard wrote:
> Vertical retrace is in lines, not pixels.

That's correct. James, please apply.

> --- Documentation/fb/framebuffer.txt.orig       2004-06-03 22:43:06.000000000 +0200
> +++ Documentation/fb/framebuffer.txt    2004-06-03 22:43:50.000000000 +0200
> @@ -190,7 +190,7 @@ We'll say that the horizontal scanrate i
>      1/(32.141E-6 s) = 31.113E3 Hz
>
>  A full screen counts 480 (yres) lines, but we have to consider the vertical
> -retrace too (e.g. 49 `pixels'). So a full screen will take
> +retrace too (e.g. 49 `lines'). So a full screen will take
>
>      (480+49)*32.141E-6 s = 17.002E-3 s
>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
