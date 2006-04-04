Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWDDRBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWDDRBc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 13:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWDDRBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 13:01:32 -0400
Received: from witte.sonytel.be ([80.88.33.193]:37782 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1750756AbWDDRBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 13:01:31 -0400
Date: Tue, 4 Apr 2006 18:49:51 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Ciaran Farrell <ciaranfarrell@babelworx.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       linux-m68k@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove drivers/net/hydra.h
In-Reply-To: <20060404162948.GM6529@stusta.de>
Message-ID: <Pine.LNX.4.62.0604041848040.17208@pademelon.sonytel.be>
References: <200604041528.00142.ciaranfarrell@babelworx.net>
 <20060404162948.GM6529@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2006, Adrian Bunk wrote:
> On Tue, Apr 04, 2006 at 03:27:59PM +0200, Ciaran Farrell wrote:
> > We were discussing this topic again and thought it should be reported here. As 
> > you are probably aware, the file 
> > 
> > linux-2.6.16.tar.bz2/linux-2.6.16/drivers/net/hydra.h
> > 
> > contains a BSD 4 license.
> >...
> 
> The interesting point is that the file seems to be complete unused.

Apparently we forgot to remove it, when hydra.c was rewritten back in 2000 and
started to rely on 8390.h instead.

> Are there any objections against the patch below to simply remove it?

No.

> > cheers
> > 
> > CFarrell 
> 
> cu
> Adrian
> 
> 
> <--  snip  -->
> 
> 
> This patch removes drivers/net/hydra.h that is both unused and covered 
> by a 4 clause BSD licence (not by the UCB).
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-By: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
