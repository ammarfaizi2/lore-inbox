Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262161AbREPXzC>; Wed, 16 May 2001 19:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262159AbREPXyw>; Wed, 16 May 2001 19:54:52 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:44549 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262160AbREPXym>; Wed, 16 May 2001 19:54:42 -0400
Date: Wed, 16 May 2001 16:53:55 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Lundell <jlundell@pobox.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B030DDE.B4E7B0CC@transmeta.com>
Message-ID: <Pine.LNX.4.21.0105161652090.8079-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 May 2001, H. Peter Anvin wrote:
> Alan Cox wrote:
> > 
> > > Are FireWire (and USB) disks always detected in the same order? Or does it
> > > behave like ADB, where you never know which mouse/keyboard is which
> > > mouse/keyboard?
> > 
> > USB disks are required (haha etc) to have serial numbers. Firewire similarly
> > has unique disk identifiers.
> 
> How about for other device classes?

Note that this whole decision hinges on a fact that simply isn't _true_.

You simply _cannot_ get the physical location of many devices. Sometimes
the topology of the bus is basically anonymous - there _is_ no location.

People had better just accept this. Don't get hung up about where
something is.

		Linus

