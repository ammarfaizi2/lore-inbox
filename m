Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129921AbQKQQwS>; Fri, 17 Nov 2000 11:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130038AbQKQQwK>; Fri, 17 Nov 2000 11:52:10 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:11273 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129921AbQKQQwC>; Fri, 17 Nov 2000 11:52:02 -0500
Date: Fri, 17 Nov 2000 08:21:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Russell King <rmk@arm.linux.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        David Woodhouse <dwmw2@infradead.org>,
        David Hinds <dhinds@valinux.com>, tytso@valinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <E13wjAF-0000Ur-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10011170819250.2272-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Nov 2000, Alan Cox wrote:

> > > regardless of what you are doing' since the modules from David Hinds and Linus
> > > pcmcia are not 100% binary compatible for all cases.
> > 
> > However, deleting that code would render a significant number of ARM platforms
> > without PCMCIA support, which would be real bad.
> 
> It would actually have made no difference as said code didnt actually work
> anyway. Dwmw2 seems to have solved that

Alan, Russell is talking about CardBus controllers (it's also PCMCIA, in
fact, these days it's the _only_ pcmcia in any machine made less than five
years ago).

The patches to get i82365 and TCIC up and running again are interesting
mainly for laptops with i486 CPUs and for desktops with pcmcia add-in
cards (which are basically always ISA i82365-clones). They aren't
interesting to ARM, I suspect.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
