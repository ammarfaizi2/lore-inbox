Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVDBVDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVDBVDc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVDBVDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:03:32 -0500
Received: from witte.sonytel.be ([80.88.33.193]:52709 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261243AbVDBVDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:03:30 -0500
Date: Sat, 2 Apr 2005 23:03:14 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove all kernel bugs
In-Reply-To: <20050401091750.GS21175@lug-owl.de>
Message-ID: <Pine.LNX.4.62.0504022301190.812@numbat.sonytel.be>
References: <20050401090744.GD15453@waste.org> <20050401091750.GS21175@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2005, Jan-Benedict Glaw wrote:
> On Fri, 2005-04-01 01:07:44 -0800, Matt Mackall <mpm@selenic.com>
> wrote in message <20050401090744.GD15453@waste.org>:
> > I've been sitting on this patch for a while, figured it's high time I
> > shared it with the world. This patch eliminates all kernel bugs, trims
> > about 35k off the typical kernel, and makes the system slightly
> > faster. The patch is against the latest bk snapshot, please apply.
> > 
> > Signed-off-by: Matt Mackall <mpm@selenic.com>
> 
> Well, the patch looks fine, but you forgot to also do the VAX-specific
> part. Withoug the BUGs, maybe the VAX kernel would be even faster?

Perhaps it's a good idea to get Linux/VAX merged in mainline first? After that
people will start fixing all your bugs automagically ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
