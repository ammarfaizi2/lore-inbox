Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287320AbRL3Ctv>; Sat, 29 Dec 2001 21:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287321AbRL3Ctm>; Sat, 29 Dec 2001 21:49:42 -0500
Received: from bitmover.com ([192.132.92.2]:27305 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S287319AbRL3CtW>;
	Sat, 29 Dec 2001 21:49:22 -0500
Date: Sat, 29 Dec 2001 18:49:21 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, Benjamin LaHaise <bcrl@redhat.com>,
        Oliver Xymoron <oxymoron@waste.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011229184921.B27114@work.bitmover.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Larry McVoy <lm@bitmover.com>, Benjamin LaHaise <bcrl@redhat.com>,
	Oliver Xymoron <oxymoron@waste.org>,
	Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011229151440.A21760@work.bitmover.com> <E16KVqL-0006dX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E16KVqL-0006dX-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Dec 30, 2001 at 02:36:57AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2001 at 02:36:57AM +0000, Alan Cox wrote:
> > So that means that pretty much 100% of development to any one area is being
> > done by one person?!?   That's cool, but doesn't it limit the speed at which
> 
> It means that pretty much all development in one area is already being
> co-ordinated. It also means that bug fixes tend to be small and not overlap
> other changes.

It also means that your rate of change in a single area is limited to 
the output of one human being.  Either the human doing the work or
the human doing the merging.  So far, it seems more like nobody is 
doing any merging, Dave says someone does but nobody else has spoken
up and I tend to think that merging is not a common process in the
Linux tree, the rate of change sort of indicates that.  I suspect 
that people avoid merge conflicts because they hurt, because of 
the poor tools. 

    "Docter it hurts when I have to merge"
    "So don't do that."

Single threading development is fine, it has benefits, but it also
has costs.  It's a tradeoff.

No commercial software firm would but up with a development process
which caused that to be the case.  They may want it to be the case,
but they want to be able to choose.  We used to have pretty good merge
technology, much better than CVS, and we still got beat up all the time
about it until we made it what it is today.  

The point there is that if commercial firms coordinated the merging by
hand, either by doing it by hand or avoiding it by hand - one of which
has to be true in the Linux development community - then we would have
never heard a word about our merge technology.  In this respect, the
commercial shops are way way ahead of Linux.  They can choose to work
like Linux does, that's an option, and yet they don't.  It's way too
time consuming for little or no gain.  You should think about that.
They learn from you, they're cherry picking your best stuff, what are
you getting from them?

There are others out here who have worked at big OS shops, they can
back this up.  Hey, Pete, what would happen at Sun if they took 
filemerge away?  How long do you think that would last?

I can also tell you that your description does not at all match what
is happening in the Linux/PPC development nor the MySQL development.
They have merge conflicts all the time and we have years of data to prove
it.  If you would like the exact numbers for the PPC tree, for example,
I can give them to you.  I can also give you numbers for BK itself;
we're a small team but we have merge conflicts daily.  We wouldn't
make any progress if we were all waiting on each other all the time.
Nor would we be able to support the code if only one person got to work
on a particular area; that's a dangerous approach, it means that you are
dependent on that one person.  I can see it for Linus, he's sort of Mr
Good Taste, but I can't see it making sense for particular sections of
the code.  Each section should have at least two active experts.

The point is that while you may live in a world where merging is rare,
but I suspect that's almost certainly caused by poor tools.  If that
weren't the case, can you explain why when the PPC team moved over to BK,
we saw lots of merge conflicts?  BK didn't make those up, they reflect
what the people did faithfully.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
