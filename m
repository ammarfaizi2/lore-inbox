Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbTIAIyM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 04:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTIAIyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 04:54:12 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:53148 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262756AbTIAIyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 04:54:11 -0400
Date: Mon, 1 Sep 2003 10:52:27 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Petr Baudis <pasky@ucw.cz>, linux-fbdev-users@lists.sourceforge.net,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-users] Re: Total radeonfb failure on both 2.6.0-test4
 and 2.6.0-test4-mm4
In-Reply-To: <1062344399.32736.51.camel@gaston>
Message-ID: <Pine.GSO.4.21.0309011051560.5048-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Aug 2003, Benjamin Herrenschmidt wrote:
> >   It appears that the 2.6 driver is essentially the old one, without Ben's
> > patch (which fixed framebuffer for me on 2.4). Is there a version of this
> > updated driver for 2.6 as well? Is there any reason why it is not integrated
> > yet?
> 
> I'm working on a new driver for 2.6 that include my 2.4 updates, a
> slightly reworked version of Kronos and Jon i2c DDC code and some
> more source cleanup (split the driver in separate files actually).
> 
> It's not finished yet though. I'm not yet sure I'll add support for
> dual head in the first version neither, all of this pretty much depends
> on how much time I'll be able to dedicate to it during the upcoming
> week.

What about `release early, release often', and add the dual-head support after
your first release? ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

