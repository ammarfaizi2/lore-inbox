Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAZMGP>; Fri, 26 Jan 2001 07:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135654AbRAZMFz>; Fri, 26 Jan 2001 07:05:55 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1796 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129562AbRAZMFw>;
	Fri, 26 Jan 2001 07:05:52 -0500
Message-ID: <20010126101422.A124@bug.ucw.cz>
Date: Fri, 26 Jan 2001 10:14:22 +0100
From: Pavel Machek <pavel@suse.cz>
To: yodaiken@fsmlabs.com, Jay Ts <jay@toltec.metran.cx>
Cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        lad <linux-audio-dev@ginette.musique.umontreal.ca>, xpert@xfree86.org,
        "mcrichto@mpp.ecs.umass.edu" <mcrichto@mpp.ecs.umass.edu>
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <3A5D994A.1568A4D5@uow.edu.au> <200101130245.TAA02910@toltec.metran.cx> <20010120171045.B15918@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010120171045.B15918@hq.fsmlabs.com>; from yodaiken@fsmlabs.com on Sat, Jan 20, 2001 at 05:10:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > And making the kernel preemptive might be the best way to do that
> > (and I'm saying "might"...).
> 
> Keep in mind that Ken Thompson & Dennis Ritchie did not decide on a 
> non-preemptive strategy for UNIX because they were unaware of such 
> methods or because they were stupid. And when Rob Pike redesigned a new
> "unix" Plan9  note there is no-preemptive kernel, and the core Linux
> designers have rejected preemptive kernels too. Now it is certainly possible
> that things have change and/or all these folks are just plain wrong. But
> I wouldn't bet too much on it.

Wrong. It was linus who suggested how to do preemptive kernel nicely. I
guess he counts as core Linux designer ;-).
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
