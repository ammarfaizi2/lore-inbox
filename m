Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUBAKgd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 05:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUBAKgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 05:36:33 -0500
Received: from witte.sonytel.be ([80.88.33.193]:18374 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265256AbUBAKga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 05:36:30 -0500
Date: Sun, 1 Feb 2004 11:36:23 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Timothy Miller <miller@techsource.com>
cc: John Bradford <john@grabjohn.com>, chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
In-Reply-To: <40195AE0.2010006@techsource.com>
Message-ID: <Pine.GSO.4.58.0402011123010.20933@waterleaf.sonytel.be>
References: <4017F2C0.4020001@techsource.com> <200401291211.05461.chakkerz@optusnet.com.au>
 <40193136.4070607@techsource.com> <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk>
 <40193A67.7080308@techsource.com> <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk>
 <4019472D.70604@techsource.com> <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk>
 <40195AE0.2010006@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jan 2004, Timothy Miller wrote:
> Ok, so, how about this idea:
>
> - Small Xilinx FPGA, 16M of RAM, and a DAC on a board.
> - AGP 2X
> - Up to 2048x2048 resolution at 8, 16, and 32 bpp.
> - Acceleration ONLY for solid fills and bitblts on-screen.

Sounds OK to me.

> Given that so little is accelerated, there is no point in putting more
> than the viewable framebuffer on the card, hense the 16 megs.  It would
> probably actually HURT performance to cache pixmaps on the card.
>
>
> Oh, there's one thing I forgot.  It would have to support VGA.  There is
> a VGA core on opencores.org that we could use, but its logic area would
> probably push up the FPGA cost so that the board was in the $100 range.
>   Probably more.

Why support legacy VGA? It makes things more complex and expensive, and doesn't
give us much, especially for a SoC.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
