Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276247AbRJYUlq>; Thu, 25 Oct 2001 16:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276248AbRJYUlh>; Thu, 25 Oct 2001 16:41:37 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:55512 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S276247AbRJYUlZ>;
	Thu, 25 Oct 2001 16:41:25 -0400
Date: Thu, 25 Oct 2001 22:40:49 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Benjamin LaHaise <bcrl@redhat.com>, Samium Gromoff <_deepfire@mail.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.12-ac4 10Mbit NE2k interrupt load kills p166
In-Reply-To: <E15wr1E-00068I-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0110252234270.27907-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2001, Alan Cox wrote:

> > On Thu, Oct 25, 2001 at 11:30:18PM +0400, Samium Gromoff wrote:
> > >        Hello folks...
> > > 
> > > 	Host A: p166, ISA NE2K, linux-2.4.12-ac4
> > > 	Host B: p2-400, rtl-8129, WinXP (heh, not my box though ;)
> > > 
> > > 	Load: smbmount connection from host A to the host B, and getting
> > >      large files.
> > 
> > Solution: replace NE2K with a decent network card.
> 
> The ne2k driver goes to great pains to keep interrupts enabled it isnt the
> culprit as far as I can tell

I had an AMD K6 200 with an ISA NE2K card whan I started using Linux...
I started using kernel 2.0 and that card worked very nice.
I could even play quake while sending out data at 10Mbit/s, I didn't even
notice that the transfer had started.

Then I upgraded to kernel 2.2 and I was no longer able to play quake while
tranmitting at 10Mbit/s with the exact same hardware. Sometimes I could
hardly even play mp3's :(

Then a friend of mine that also upgraded to kernel 2.2 began complaining
that his machine also became extremely slow and unresponsive while
transitting at 10Mbit/s, in fact that machine was even slower than mine
during the transfers and his cpu was a bit faster than mine (also AMD).

Then I upgraded that machine to pIII 700 and even that machine slows to a
crawl while transmitting with that bloody ISA NE2K. It's the same thing in
kernel 2.4 too. These days I simply don't use that card anymore...

So something seems to have taken a wrong turn between 2.0 and 2.2
I don't think this is a problem intruduced in 2.4.

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

