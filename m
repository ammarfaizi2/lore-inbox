Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282685AbRLDIxh>; Tue, 4 Dec 2001 03:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282343AbRLDIx1>; Tue, 4 Dec 2001 03:53:27 -0500
Received: from mx2.elte.hu ([157.181.151.9]:12974 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S279814AbRLDIxP>;
	Tue, 4 Dec 2001 03:53:15 -0500
Date: Tue, 4 Dec 2001 11:50:36 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Victor Yodaiken <yodaiken@fsmlabs.com>,
        Andrew Morton <akpm@zip.com.au>, Larry McVoy <lm@bitmover.com>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Rik van Riel <riel@conectiva.com.br>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <Pine.LNX.4.33.0112022102150.19739-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0112041148420.6249-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 2 Dec 2001, Daniel Phillips wrote:

> One fact that is often missed by armchair evolutionists is that
> evolution is not random. It's controlled by a mechanism (most
> obviously: gene shuffling) and the mechanism *itself* evolves. That is
> why evolution speeds up over time. There's a random element, yes, but
> it's not the principle element.

claiming that the randomness is not the principle element of evolution is
grossly incorrect.

there are two components to the evolution of species: random mutations and
a search of the *existing* gene space called gene shuffling. (to be more
exact gene shuffling is only possible for species that actually do it -
bacteria dont.)

In fact gene shuffling in modern species is designed to 'search for useful
features rewarded by the environment to combine them in one specimen'. Ie.
the combination of useful features such as 'feathers' or 'wings',
introduced as random mutations of dinosaurs. Gene shuffling does not
result in radically new features.

gene shuffling is just the following rule: 'combine two successful DNA
chains more or less randomly to find out whether we can get the better
genes of the two.'. Since most species reproduce more than once, random
gene shuffling has a chance of combining the best possible genes. Risking
oversimplification, i'd say that genes are in essence invariant 'modules'
of a species' genetic plan, which can be intermixed between entities
without harming basic functionality. A requirement of the gene shuffling
process is that the resulting entity has to remain compatible enough with
the source entities to be able to reproduce itself and intermix its genes
with the original gene pool.

in terms of Linux, various new genes are similar to various patches that
improve the kernel. Some of them produce a kernel that crashes trivially,
those are obviously incorrect. Some of them might or might not be useful
in the future. We dont know how the environment will evolve in the future,
so we better keep all our options open and have a big enough 'gene pool'.
The development of individual patches is 'directed' and 'engineered' in
the sense that they produce a working kernel and they are derived from
some past experience and expectations of future. They might be correct or
incorrect, but judging them is always a function of the 'environment'.
Some patches become 'correct' over time. Eg. the preemptable kernel
patches are gaining significance these days - it was clearly a no-no 3
years ago. This is because the environment has changed, and certain
patches predicted or guessed the direction of technology environment
correctly.

if you look at patches on the micro-level, it has lots of structure, and
most of it is 'engineered'. If you look at it on the macro-level, the
Linux kernel as a whole has

(and gene shuffling itself has another random component as well, it's the
imperfectness of it that is one of the sources of random mutations.)

saying that the randomness of evolution is not the principle element is
like claiming that the current Linux code is sufficient and we only have
to shuffle around existing functions to make it better.

> > So *once* we have something that is better, it does not matter how long it
> > took to get there.
>
> Sure, once you are better than the other guy you're going to eat his
> lunch.  But time does matter: a critter that fails to get its
> evolutionary tail in gear before somebody eats its lunch isn't going
> to get a second chance.

this is another interesting detail: the speed of being able to adopt to a
changing environment does matter.

But the original claim which i replied to was that the cost of developing
a new 'feature' matters. Which i said is not true - evolution does not
care about time of development if the environment is relatively stable, or
is changing slowly. The speed of evolution/development only matters once
the environment changes fast.

So to draw the analogy with Linux - as long as the environment (chip
technology, etc.) changes rapidly, what matters most is the ability to
evolve. But once the environment 'cools down' a bit, we can freely search
for the most perfect features in a stable environment, and we'll end up
being 99.9% perfect (or better). [ The original claim which i replied to
said that we'll end up being 95% perfect and stop there, because further
development is too expensive - this claim i took issue with. ]

In fact this happened a number of times during Linux's lifetime. Eg. the
prospect of SMP unsettled the codebase alot and the (relative) quality of
uniprocessor Linux perhaps even decreased. Once the external environment
has settled down, other aspects of Linux caught up as well.

believe me, there was no 'grand plan'. Initially (5 years ago) Linus said
that SMP does not matter much at the moment, and that nothing should be
done in SMP space that hurts uniprocessors. Today it's exactly the other
way around. And i think it's perfectly possible that there will be a new
paradigm in 5 years.

	Ingo

