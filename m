Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129920AbQKQQrs>; Fri, 17 Nov 2000 11:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129921AbQKQQri>; Fri, 17 Nov 2000 11:47:38 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:1033 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129920AbQKQQra>; Fri, 17 Nov 2000 11:47:30 -0500
Date: Fri, 17 Nov 2000 08:17:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        David Woodhouse <dwmw2@infradead.org>,
        David Hinds <dhinds@valinux.com>, tytso@valinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <200011170051.eAH0pvr18387@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10011170814440.2272-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Nov 2000, Russell King wrote:

> Alan Cox writes:
> > >From a practical point of view that currently means 'delete Linus tree pcmcia
> > regardless of what you are doing' since the modules from David Hinds and Linus
> > pcmcia are not 100% binary compatible for all cases.
> 
> However, deleting that code would render a significant number of ARM platforms
> without PCMCIA support, which would be real bad.

Right now, I suspect that the in-kernel pcmcia code is actually at the
point where it _is_ possible to use it. David Hinds has been keeping the
cs layer in synch with the external versions, and tons of people have
helped make the low-level drivers stable again.

If somebody still has a problem with the in-kernel stuff, speak up. 

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
