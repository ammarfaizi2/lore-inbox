Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281483AbRLBQxB>; Sun, 2 Dec 2001 11:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281488AbRLBQwv>; Sun, 2 Dec 2001 11:52:51 -0500
Received: from mx2.elte.hu ([157.181.151.9]:36511 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S281483AbRLBQwe>;
	Sun, 2 Dec 2001 11:52:34 -0500
Date: Sun, 2 Dec 2001 19:49:27 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>,
        Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        Larry McVoy <lm@bitmover.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <Pine.LNX.4.33.0111302048200.1459-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0112021910480.18232-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Nov 2001, Linus Torvalds wrote:

> It's "directed mutation" on a microscopic level, but there is very
> little macroscopic direction. There are lots of individuals with some
> generic feeling about where they want to take the system (and I'm
> obviously one of them), but in the end we're all a bunch of people
> with not very good vision.

the fundamental reasons why this happens are the following, special
conditions of our planet:

 - the human brain has a limited capacity, both in terms of 'storage'
   and 'computational power'.

 - the world itself, at least how we understand it currently, is
   inherently random. (Such randomness is the main driving force of
   'structure' as well, it seems.)

 - this planet has limited resources, so 'survival of the fittest' is
   still the main driving force of 'life'.

 - we do not know and understand the rules of our world yet, and chip
   technology (which drives and enables operating systems) is right at the
   edge (and often beyond the edge) of what physics is capable of
   explaining today. We simply do not know what breakthrough (or brick
   wall of performance) might happen in 1, 2 or 5 years. We did not know
   50 years ago that something like 'SMP' would happen and be commonplace
   these days. I mean, often we dont even know what might happen in the
   next minute.

due to these fundamental issues the development of 'technology' becomes
very, very unpredictable. We only have 5 billion brain cells, and there's
no upgrade path for the time being. Software projects such as Linux are
already complex enough to push this limit. And the capacity limits of the
human brain, plus the striving towards something better (driven by human
needs) cause thousands of ambitios people working on parts of Linux in
parallel.

a few things are clear:

- if we knew the rules of this world and knew how to apply them to every
  detail then we'd be building the 'perfect chip' by this christmas, and
  there would probably be no need for anything else, ever.

- if the human brain (and human fingers) had no limits then we'd be
  designing the 'perfect OS' from grounds up and write it in 2 minutes.

- and if the world wasnt random then there would probably be nothing
  on this planet, ever.

but the reality is that we humans have severe limits, and we do not
understand this random world yet, so we'll unevitably have lots of fun
writing random pieces of Linux (or other) code in many many years to come.

in fact, most computer science books are a glaring example of how limited
the human brain is, and how small and useless part of the world we are
able to explain exactly ;-)

and frankly, i'd *very* disappointed if it was possible to predict the
future beyond our lifetime, and if it was possible to design a perfect
enough OS that does not need any changing in the foreseable future. I'd be
a pretty disappointed and bored person, because someone would predict what
happens and we'd only be dumbly following that grand plan. But the reality
is that such grand plan does not exist. One of the exciting things about
developing an OS is that we almost never know what's around the next
corner.

This whole effort called Linux might look structured on the micro-level
(this world *does* appear to have some rules apart of chaos), but it
simply *cannot* be anything better than random on the macro (longterm)
level. So we better admit this to ourselves and adapt to it.

And anyone who knows better knows something that is worth a dozen Nobel
prizes.

	Ingo

