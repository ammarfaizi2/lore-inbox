Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbULPQXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbULPQXr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 11:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbULPQXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 11:23:47 -0500
Received: from witte.sonytel.be ([80.88.33.193]:44764 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261479AbULPQXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 11:23:42 -0500
Date: Thu, 16 Dec 2004 16:23:38 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "H. Peter Anvin" <hpa@zytor.com>, "J.A. Magallon" <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What if?
In-Reply-To: <1103203426.3804.16.camel@localhost.localdomain>
Message-ID: <Pine.GSO.4.61.0412161622060.15893@waterleaf.sonytel.be>
References: <41AE5BF8.3040100@gmail.com> <20041202044034.GA8602@thunk.org>
 <1101976424l.5095l.0l@werewolf.able.es> <1101984361.28965.10.camel@tara.firmix.at>
 <cpkc5i$84f$1@terminus.zytor.com> <1102972125l.7475l.0l@werewolf.able.es>
 <1103158646.3585.35.camel@localhost.localdomain> <41C0F67D.4000506@zytor.com>
 <1103203426.3804.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004, Alan Cox wrote:
> On Iau, 2004-12-16 at 02:44, H. Peter Anvin wrote:
> > Yes, but there is also no really big deal compiling C code with a C++ 
> > compiler.  Yes, it was a disaster in 0.99.14, but that was 10 years ago.
> 
> g++ is still much slower. We don't know how many bugs it would show up
> in the compiler and tools either, especially on embedded platforms.

Interesting to find out, anyway (for the g++-developers :-)

> Finally the current kernel won't go through a C++ compiler because we
> use variables like "new" quite often.

Not something that can't be worked around using a simple #define...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
