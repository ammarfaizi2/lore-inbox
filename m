Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSAUWZO>; Mon, 21 Jan 2002 17:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288752AbSAUWYz>; Mon, 21 Jan 2002 17:24:55 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:44443 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S288748AbSAUWYd>; Mon, 21 Jan 2002 17:24:33 -0500
Message-Id: <200201212218.g0LMI8BQ002150@tigger.cs.uni-dortmund.de>
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable 
In-Reply-To: Message from Robert Love <rml@tech9.net> 
   of "21 Jan 2002 16:22:58 EST." <1011648179.850.473.camel@phantasy> 
Date: Mon, 21 Jan 2002 23:18:08 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> said:

[...]

> It doesn't have to run mostly in the kernel.  It just has to be in the
> kernel when the I/O-bound tasks awakes.  Further, there are plenty of
> what we consider CPU-bound tasks that are interactive and/or
> graphics-oriented and this adds much to their time in the kernel.

Look, I don't know about you, but system (kernel) tieme around here is
rarely very high as a %. Perhaps 5% could be called "typical". And it is
during those 5% (i.e., something like 5% of the time) any of this stuff
will make a difference at all. This will be _hard_ to "feel" (if it is
possible to feel at all).

For the mostly positive (subjective) responses you see, there is something
called "psycology", which would predict that for _exactly_ the same "feel"
(whatever that may be) somebody who just made an effort downloading
patches, applying them, reconfiguring ad building a kernel "to make it feel
better" _will_ feel it better. I.e., nobody wants to have to say "Okay,
lots of work down the drain". Besides, those who see no difference will
shut up, those that delude themselves most will be vocal about it.

There was a famous experiment in determining productivity of people under
various circumstances. Whatever they changed, the productivity went
up. They finally had to conclude their results weren't due to the
environmental changes, but to the fact that the subjects felt important
(and motivated). Something similar might be happening here.

I'm not saying it _is_ like this, but as long as there are no reproducible
ways to put numbers to the "feel", and make controlled experiments, no one
will know for sure.

> In a given period of time, [...]

Yes, yes, we all know the theory, and it is obviously true. Question is
just, _how much_ is the change? Is it large enough to compensate for the
pain it causes?

[...]

> While we certainly need tangible empirical benefits, users finding their
> desktop experience smoother and thus more enjoyable is just about the
> best thing we can ask for.

It just isn't enough justification for wholesale redesign on basic
assumptions in the kernel, sorry.
-- 
Horst von Brand			     http://counter.li.org # 22616
