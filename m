Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283760AbRLEFHT>; Wed, 5 Dec 2001 00:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283761AbRLEFHM>; Wed, 5 Dec 2001 00:07:12 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:45071 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S283760AbRLEFG7>; Wed, 5 Dec 2001 00:06:59 -0500
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Over 4-way systems considered harmful :-)
Date: Tue, 4 Dec 2001 21:07:14 -0800
Message-ID: <HBEHIIBBKKNOBLMPKCBBMEPLECAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <2436533899.1007458881@mbligh.des.sequent.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Martin J. Bligh
> Sent: Tuesday, December 04, 2001 9:41 AM
> To: M. Edward Borasky; linux-kernel@vger.kernel.org
> Subject: Re: Over 4-way systems considered harmful :-)
>
> Two things.
>
> 1) If a company (say, IBM) pays people to work on 8 / 16 way scalability
> because that's what they want out of Linux, then stopping development
> on that isn't going to get effort redirected to fixing your
> soundcard (yes,
> I realise you were being flippant, but the point's the same), the
> headcount
> is just going to disappear. AKA your choice isn't "patches for 8 way
> scalablilty, or patches for subsystem X that you're more interested in",
> your choice is "patches for 8-way scalabity, or no patches". Provided that
> those patches don't break anything else, you still win overall by
> getting them.

I don't see how this is a win for me. And it is a win for IBM only if it
gives them some advantage in serving their customers. I can certainly
*conceive* of workloads bursty enough to justify an 8-processor server, but
do they exist in the real world? And if they do, is a single 8-processor
server better than a pair of 4-processor servers when you take graceful
handling of faults into account? IBM has been building high-availability
systems for *decades*, preferring to field *slightly* slower but
*significantly* more reliable gear, which, legend has it, no one has ever
been fired for purchasing. :-)

> 2) Working on scalability for 8 / 16 way machines will show up races,
> performance problems et al that exist on 2 / 4 way machines but don't
> show up as often, or as obviously. I have a 16 way box that shows up
> races in the Linux kernel that might take you years to find on a 2 way.

Perhaps effort should be placed into software development processes and
tools that deny race conditions the right to be born, rather than depending
on testing on a 16-processor system to find them expeditiously :-). And
there is a whole discipline of software performance engineering to build
performance in from the start. Advances like that would be a *huge* win for
the Linux community, given our (relative) freedom from corporate-world
limitations like deadlines, sales quotas, programmer salaries, and
full-color brochures.

> What I'm trying to say is that you still win. Not as much as maybe you'd
> like, but, hey, it's work you're getting for free, so don't complain too
> much about it. The maintainers are very good at beating the message
> into us that we can't make small systems any worse performing whilst
> making the big systems better.

No, but we can release partly-baked VM schemes that have a shelf life on the
order of days :-). Seriously, though, I don't like stepping on someone
else's dream, especially since *my* dream -- a GFLOP dedicated to computer
music -- has been fulfilled for about $1500 US. When I bought that machine,
I thought I was going to need two processors -- one to run the OS and
service the keyboard, mouse and monitor and a second dedicated to generating
audio samples in real time. I had no idea how powerful these chips were
until I started shopping around. And when I loaded the Atlas linear algebra
library up on my Athlon and saw the speeds it was getting, I was in shock
for almost a week!

However, as I said in another post: "Moore's Law: good. Amdahl's Law: bad."
I guess the new generation has to discover Amdahl's Law for itself, and
*this* distinguished but elderly scientist is eager to be proven wrong :-).
--
Take Your Trading to the Next Level!
M. Edward Borasky, Meta-Trading Coach

znmeb@borasky-research.net
http://www.meta-trading-coach.com
http://groups.yahoo.com/group/meta-trading-coach

