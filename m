Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262155AbREPXxC>; Wed, 16 May 2001 19:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262149AbREPXww>; Wed, 16 May 2001 19:52:52 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:38149 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262155AbREPXwn>; Wed, 16 May 2001 19:52:43 -0400
Date: Wed, 16 May 2001 16:52:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Lundell <jlundell@pobox.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E150AgG-0004bb-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0105161650010.8079-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 May 2001, Alan Cox wrote:
>
> > Are FireWire (and USB) disks always detected in the same order? Or does it
> > behave like ADB, where you never know which mouse/keyboard is which
> > mouse/keyboard?
> 
> USB disks are required (haha etc) to have serial numbers. Firewire similarly
> has unique disk identifiers.  

Well, as that doesn't actually work out in practice, the good news is that
USB at least _tries_ to always walk the tree the same way when detecting
devices, so if you don't change where your devices are in the topologu
they should show up in similar places.

Of course, "not changing topology" also means things like not powering off
devices with external power supplies etc..

The serial numbers are probably not that reliable.

		Linus

