Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284160AbRLARWw>; Sat, 1 Dec 2001 12:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284159AbRLARWm>; Sat, 1 Dec 2001 12:22:42 -0500
Received: from hq2.fsmlabs.com ([209.155.42.199]:3345 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S284160AbRLARW2>;
	Sat, 1 Dec 2001 12:22:28 -0500
Date: Sat, 1 Dec 2001 10:16:03 -0700
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@zip.com.au>, Davide Libenzi <davidel@xmailserver.org>,
        Larry McVoy <lm@bitmover.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <20011201101603.A504@hq2>
In-Reply-To: <3C082FEB.98D8BE9B@zip.com.au> <E16A71v-0006h9-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16A71v-0006h9-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 10:05:55AM +0000, Alan Cox wrote:
> > sufficient for development of a great 1-to-4-way kernel, and
> > that the biggest force against that is the introduction of
> > fine-grained locking.   Are you sure about this?  Do you see
> > ways in which the uniprocessor team can improve?
> 
> ccCluster seems a sane idea to me. I don't by Larry's software engineering
> thesis but ccCluster makes sense simply because when you want an efficient
> system in computing you get it by not pretending one thing is another.
> SMP works best when the processors are not doing anything that interacts
> with another CPU.

Careful Alan. That sounds suspiciously like a "design principle", and
true macho Linux developers don't need no theoretical stuff like that.
They just slop that code together and see what explodes - pulling their
alchemists hats over their eyes for protection.

> 
> > key people get atracted into mm/*.c, fs/*.c, net/most_everything
> > and kernel/*.c while other great wilderness of the tree (with
> > honourable exceptions) get moldier.  How to address that?
> 
> Actually there are lots of people who work on the driver code nowdays
> notably the janitors. The biggest problem there IMHO is that when it comes
> to driver code Linus has no taste, so he keeps accepting driver patches
> which IMHO are firmly at the hamburger end of "taste"

"Taste" ? Now you want aesthetics as well as theory. I'm horrified.

Technical content: does anyone know the max spinlock depth in Linux 2.5
?

