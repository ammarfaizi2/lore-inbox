Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbUJZAwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbUJZAwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 20:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbUJZAwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 20:52:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:35516 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261826AbUJZAvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 20:51:45 -0400
Date: Mon, 25 Oct 2004 17:51:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Andrea Arcangeli <andrea@novell.com>, Larry McVoy <lm@work.bitmover.com>,
       Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <Pine.LNX.4.61.0410252350240.17266@scrub.home>
Message-ID: <Pine.LNX.4.58.0410251732500.427@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org>
 <20041023161253.GA17537@work.bitmover.com> <4d8e3fd304102403241e5a69a5@mail.gmail.com>
 <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com>
 <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random>
 <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random>
 <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random>
 <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org>
 <Pine.LNX.4.61.0410252350240.17266@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Oct 2004, Roman Zippel wrote:
> 
> On Mon, 25 Oct 2004, Linus Torvalds wrote:
> 
> > In short, BK isn't the problem. You are.
> 
> I think you're making it yourself way too easy.
>
> Blaming Andrea for this mess is of course easy, but it doesn't solve 
> anything and misses the point

[ Answering these in a different order ]

The only thing I blame Andrea for is _whining_. Don't get me wrong, I 
don't blame him for the bad state of CVS or anything like that.

The fact is, Andrea doesn't actually do anything constructive when it 
comes to SCM. He just complains every time somebody says something 
positive about a product that (a) he didn't do anything for and (b) nobody 
forces him to use, and (c) there are no real alternatives for today (much 
less the three years ago he was whining about).

> The ability to handle big amounts of patches includes also the
> possibility to merge a lot of crap. What keeps up the general quality?

No SCM is _ever_ going to be a quality manager.

And I also claim that people who think that "processes" are quality 
management (see iso9000, or Dilbert) are seriously mistaken too.

The thing that keeps up the general quality is _people_. Good people, who 
take pride in the quality. They end up being maintainers, not because they 
chose the job, but because people ended up chosing them, for better of for 
worse.

And the way to help those people is to make the day-to-day job easy, so
that they can spend as much time as possible on the thing that matters:  
upholding good taste (and in the process keeping quality up). And that's
where an SCM comes in - not as a primary source of quality, but as a way
to keep track of the details, so that people can concentrate on what is
important.

And the SCM doesn't have to be anything really fancy. It can be a few 
scripts to keep track of patches (that tends to grow and become slightly 
more sophisticated over time). I'm not saying that BK is "it". There's a 
number of BK users there, but clearly there are other ways to maintain 
patches too - and people use them.

But complaining when a maintainer uses a tool that suits him is _stupid_. 
It's arrogant to think that you can tell me how to do my work, but it's 
really stupid when you can't give any reasonable alternatives that would 
help me do it as efficiently.

And that's what Andrea is doing. Sure, BK is commercial, but dammit, so is
that 2GHz dual-G5 too and that Shuttle box in my corner. They happen to be
the tools I use for what I do. If Andrea told me that I should use a
slower machine because that's what most people use, I'd consider him a
total idiot. Similarly, when he complains that people use software tools
that clearly _do_ make them more productive, I consider his complaint
stupid.

There are other tools I use to make myself more productive. Many of them
are open source. Some I wrote myself. But I still use "uemacs" and "pine"  
as part of my tool-chest, for example - and last I saw, they weren't open
source either (but I hear that the uemacs author stopped caring, so that
one might have been re-licensed).

Should I (or anybody else) ask Andrea's permission before we start using 
non-opensource tools? No.  If Andrea were complaining about my "pine" 
usage, he'd be laughed off the planet. It may be ass-backwards and old and 
text-only, but the fact is, it's really none of his damn business, even 
though he can see the effects in every email I write in the headers.

Similarly, Andrea can see some of the effects of me using BK when he looks
at the tar-balls and patches - syntactic markers that show that they have
been generated by a person who uses BK. It's really _no_ different from
the fact that I use pine to communicate. And no, neither BK nor pine are
under an open source license.  Deal with it.

Can Andrea point me to open-source tools and ask me politely whether I've 
considered them as alternatives? Hell yes. I encourage him to do so when 
something appears.

		Linus
