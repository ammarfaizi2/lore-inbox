Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311403AbSDDHvO>; Thu, 4 Apr 2002 02:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312453AbSDDHvF>; Thu, 4 Apr 2002 02:51:05 -0500
Received: from mail.sonytel.be ([193.74.243.200]:49398 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S311403AbSDDHuu>;
	Thu, 4 Apr 2002 02:50:50 -0500
Date: Thu, 4 Apr 2002 09:50:09 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new fbdev api.
In-Reply-To: <Pine.LNX.4.10.10204031224280.14670-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0204040949550.28139-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2002, James Simmons wrote:
> This patch is the first in a series to move over to the new fbdev api. It
> is against 2.5.7. The basic goal is remove the tones of redundent code in
> the fbdev layer and make a much simpler api. The main way to accomplish
> this is to reverse the flow of logic for the console system. The fbdev
> system was later developed and we see alot of needless functionality added
> to the fbdev layer. Instead the flow should be functionality in the
> console system to the fbdev layer instead of the reverse. Also
> accomplished is the seperation of the fbdev layer from the console layer.
> This will have a very important impact on linux embedded devices. It has
> been tested and has been in Dave Jones tree for some time. Geert with
> your blessing I like to have it added to Linus tree.

Please go ahead!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

