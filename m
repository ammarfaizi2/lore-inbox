Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270319AbTGRUDy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 16:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270334AbTGRUDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 16:03:54 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:51966 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S270319AbTGRUDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 16:03:53 -0400
Date: Fri, 18 Jul 2003 22:18:00 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: James Simmons <jsimmons@infradead.org>, Amit Shah <shahamit@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1: Framebuffer problem
In-Reply-To: <1058533025.19511.33.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0307182214240.26729-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jul 2003, Alan Cox wrote:
> On Iau, 2003-07-17 at 18:34, James Simmons wrote:
> > > > > > CONFIG_FB_VGA16=y 		<---- to many drivers selected. Please 
> > > > 				<---- pick only one.
> > > > > > CONFIG_FB_VESA=y
> > > 
> > > This is a completely sensible selection and works as expected in 2.4 so
> > > it really wants fixing anyway
> > 
> > It is if you have more than one graphics card. If you only have one card 
> > then you will have problems. 
> 
> Then it still needs to be fixed. This works correctly in 2.4

Since vesafb can detect whether you booted with a graphics mode, vga16fb should
be able to detect you didn't, right?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

