Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261360AbTCGFmU>; Fri, 7 Mar 2003 00:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261361AbTCGFmU>; Fri, 7 Mar 2003 00:42:20 -0500
Received: from mx2.elte.hu ([157.181.151.9]:39811 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261360AbTCGFmT>;
	Fri, 7 Mar 2003 00:42:19 -0500
Date: Fri, 7 Mar 2003 06:52:36 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <20030306124257.4bf29c6c.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303070649140.2662-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Andrew Morton wrote:

> This improves the X interactivity tremendously.  I went back to 2.5.64
> base just to verify, and the difference was very noticeable.
> 
> The test involved doing the big kernel compile while moving large xterm,
> mozilla and sylpheed windows about.  With this patch the mouse cursor
> was sometimes a little jerky (0.1 seconds, perhaps) and mozilla redraws
> were maybe 0.5 seconds laggy.
> 
> So.  A big thumbs up on that one.  It appears to be approximately as
> successful as sched-2.5.64-a5.
> 
> Ingo's combo patch is better still - that is sched-2.5.64-a5 and your
> patch combined (yes?).  The slight mouse jerkiness is gone and even when
> doing really silly things I cannot make it misbehave at all.  I'd
> handwavingly describe both your patch and sched-2.5.64-a5 as 80%
> solutions, and the combo 95%.

great! Ie. both approaches go in the same (good) direction, and the fact
that the combined effect is even better than either patch (although it's
hard to improve something that is 'good' already), shows that there's no
conflict between the two concepts.

> So I'm a happy camper, and will be using Ingo's combo patch.  But I do
> not use XMMS and xine and things like that - they may be running like
> crap with these patches.  I do not know, and I do not have a base to
> compare against even if I could work out how to get them going.

these always used to be problematic to a certain degree, so they are the
next on the list.

	Ingo

