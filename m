Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261453AbTCGIVM>; Fri, 7 Mar 2003 03:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbTCGIVM>; Fri, 7 Mar 2003 03:21:12 -0500
Received: from mx1.elte.hu ([157.181.1.137]:11672 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261453AbTCGIVK>;
	Fri, 7 Mar 2003 03:21:10 -0500
Date: Fri, 7 Mar 2003 09:31:28 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <5.2.0.9.2.20030307092747.00cf64b0@pop.gmx.net>
Message-ID: <Pine.LNX.4.44.0303070930120.5531-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Mar 2003, Mike Galbraith wrote:

> Oh, it's definitely _much_ better than .virgin.  I didn't mean to imply
> that damage was done ;-)  With .virgin, I have a _heck_ of a time
> grabbing the build window to kill it.  With combo, rodent jerkiness
> makes it hard to find/grab, and multisecond stalls are still there, but
> much improved.

ok! [breathing lighter].

could you still try the renice -10 thing with the combo patch, to see how
much of this thing is X actually not getting enough timeslices, vs. other
effects (such as X applications not getting enough timeslices)?

	Ingo

