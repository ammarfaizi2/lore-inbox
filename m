Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312991AbSEXXWb>; Fri, 24 May 2002 19:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313016AbSEXXWa>; Fri, 24 May 2002 19:22:30 -0400
Received: from bitmover.com ([192.132.92.2]:28367 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S312991AbSEXXW2>;
	Fri, 24 May 2002 19:22:28 -0400
Date: Fri, 24 May 2002 16:22:28 -0700
From: Larry McVoy <lm@bitmover.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020524162228.D28795@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Karim Yaghmour <karim@opersys.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
	Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
	Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205241440210.28644-100000@home.transmeta.com> <3CEEC729.74625C2B@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 07:05:13PM -0400, Karim Yaghmour wrote:
> This matter remained unchanged until the FSF came out later and
> declared publicly that the patent was violating the GPL. At that
> time, Eben Moglen came out and publicly explained the implications
> of the patent and the "corrected" patent license. Here is Eben's
> explanation:
> http://www.aero.polimi.it/~rtai/documentation/articles/moglen.html

Eben Moglen is the lawyer for the FSF, right?  So he's hardly objective
about this topic, right?  Isn't his point to try and get everything to
be GPLed?

> All would have been fine if things had ended there, but Victor then
> came out and threw more uncertainty about the matter:
> http://linuxdevices.com/articles/AT6164867514.html
> 
> Just when Eben Moglen was saying that real-time applications were
> not subject to the patent, Victor Yodaiken came out and said:
> "If you want to make, use, sell, distribute, import,
> etc. non-GPL software -- regardless of whether such software is labeled as
> an "application," "module," or anything else -- please make sure you have
> obtained competent legal advice regarding whether your software and its use
> is an approved use under the Open RTLinux Patent License or whether a
> license under the RTLinux patent must be secured to authorize your software
> and its use."

So?  Eben is not objective on the topic, FSMlabs holds the patents, if you
listen to what Eben says, that's meaningless.  He is not a judge, he is not
objective, he's got a particular ax to grind.  That's fine, except for one
thing: he doesn't hold the patent.  So if you are going to listen to anyone,
I'd be listening to FSMlabs.

> At this point in time, all the bleeding-edge development being
> done in RTLinux is not available in GPL and must be purchased for
> a fee.
> 
> This isn't really a problem, since RTAI has now surpassed RTLinux
> in terms of capabilities, ports and support. The problem, however,
> is that the rtlinux patent is being used to wage an FUD campaign
> against RTAI.

Doesn't the RTAI 
    a) make use of the patent and
    b) allow for parts that aren't GPLed?

> One last thing: Clearly, if non-GPL applications were not allowed
> with Linux, we wouldn't be talking today. The same holds for non-GPL
> RT apps.

Ahh, I get it.  I think I see the problem.  You are applying GPL rules
to the RTLinux patent.  You're saying that the boundary where the patent
applies stops at the same place as the boundary where the GPL stops.
I'll bet that is the cause of all the confusion.  The patent and the 
GPL have no correlation.  It's completely up to FSMlabs to define what
is an application and what is not.  And it's a very reasonable thing
for them to consider everything which runs on top of the RTLinux substrate
to be required to be covered by the GPL.  That's certainly within their
rights.  You can't take the GPL rules and impose that on his patent
license, the two have nothing to do with each other.  He who holds
the patent makes the rules.

I think the bottom line is that the RT idea that Victor came up with is
pretty cool, it is obviously something that you want, and so you get to
live with those rules.  Listening to a lawyer's opinion, when that 
lawyer works for the FSF and is charged with furthering the cause of
the FSF, that's just asking for trouble.  He isn't going to give you
an unbiased view.  I think Victor's suggestion is good - if you want to
know what the rules are, consult your own lawyer.

As someone who's been down this path pretty extensively, I do not think
that you are seeing it clearly, you are mixing the patent and the GPL
and you are not entitled to do that.  FSMlabs has to play by the GPL
rules for any modifications they make to the kernel, but you have to 
play by their rules if you use their patent.  You can't apply the GPL
rules and expect those to override the patent rules, it doesn't work
like that.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
