Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316355AbSEZUHR>; Sun, 26 May 2002 16:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316360AbSEZUHQ>; Sun, 26 May 2002 16:07:16 -0400
Received: from dsl-213-023-038-154.arcor-ip.net ([213.23.38.154]:27612 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316355AbSEZUHQ>;
	Sun, 26 May 2002 16:07:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Date: Sun, 26 May 2002 22:05:32 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Robert Schwebel <robert@schwebel.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205251025010.6515-100000@home.transmeta.com> <E17BpNE-0003qU-00@starship> <1022441858.11811.127.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17C4Gj-00041o-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 May 2002 21:37, you wrote:
> On Sun, 2002-05-26 at 05:11, Daniel Phillips wrote:
> > The Linux core *is* tiny, and for that reason attractive for this purpose.  
> > I agree that it is still too complex to verify formally, and we've suffered 
> > because of that, i.e., when will we see the last truncate race?  When will we
> 
> The Linux core is -huge- by embedded standards. These people think of
> stuff like vxworks as pretty large too. On truely embedded devices you
> are talking a kernel under 32K in size, probably under 16K if well
> tuned.

You're talking to one of those people.  There are all sizes of embedded 
systems.  I worked with both tiny ones, where the whole 'OS' consisted of 
2,000 lines of code or so, and large ones, with megabyte+ kernels.  There 
are even folks using Windows - all flavors - as an embedded OS.

Given that the world *has* changed and that people do build embedded
systems around what would have been unthinkably large OS kernels, the only
question left is which OS to work with.  Would you rather work with Linux
or Solaris, leaving aside, for the moment, the question of licensing?

> Chasing down obscure truncate races in a PC is irritating but doable,
> you can run huge test sets and you can get answers that it doesn't
> happen under workloads likely to trigger it - but you can't *prove* it.
> 
> The moment you get involved in things that kill people when they go
> wrong, the rules change.

You wish.  Sad to say, they stay much the same.  People remain people,
and budgets remain budgets.  Just as in the business app world, customers
can be much more easily convinced to spend their dollars for features
than for reliability.  They of course eventually pay for the reliability -
after the fact, when something has gone wrong.  It's the same as our game,
which goes something like: do the best job you can within the constraints
of your ability and the time you have available (which is normally none,
since the software for these embedded systems is always developed with
unrealistically tight deadlines) and then track down and fix the problems
that emerge.  The companies that are successful at this - largely through
luck I'd say - make money, and those that don't die.  It has very little
to do with analysis.

> At the point where you get the device back if
> it goes wrong it also becomes very convenient to build extremely small
> OS cores. The problem that is biting people now is that the markets
> demand both complexity plus sophisticated feature sets _and_ they want
> the stability. Software costs for appliances have gone through the roof
> as margins go through the floor.

You remember I wasn't originally talking about appliances, right?  Anyway, 
in the time since I worked in that field, Moore's law hasn't stopped, and
now I have Linux running on the DSL modem under my desk.

> That helps Linux in the sense that part of the strategy is to build a
> system that is shared cost and testing over many vendors and many
> products, but it doesn't alter the basic problem that computer science
> isn't really up to it. Right now we are building cathedrals in the same
> way as a medaeival master mason, by intutition, experience, and testing.
> We have no more idea than they do if any given edifice will come
> crashing down (as several large medaeival ones indeed did).

That is too true, and it is a fact that the stonemasons want to use Linux.
The barons, however, are another matter, and it was the barons who
prevented me from using Linux in any capacity, let alone in the realtime
area.  At the time, the best you could say for Linux was: it doesn't
suck as much as windows.  Since then, there have been some positive
developments, but fundamental obstacles to widespread adoption of Linux
in the realtime space do remain, and yes, and I do believe that the
patent held by Victor is one of them, if not the main one.

-- 
Daniel
