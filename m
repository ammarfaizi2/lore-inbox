Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbRAVCVm>; Sun, 21 Jan 2001 21:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129998AbRAVCVc>; Sun, 21 Jan 2001 21:21:32 -0500
Received: from nrg.org ([216.101.165.106]:22132 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S129881AbRAVCVP>;
	Sun, 21 Jan 2001 21:21:15 -0500
Date: Sun, 21 Jan 2001 18:21:05 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Paul Barton-Davis <pbd@op.net>
cc: yodaiken@fsmlabs.com, Andrew Morton <andrewm@uow.edu.au>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <200101220150.UAA29623@renoir.op.net>
Message-ID: <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jan 2001, Paul Barton-Davis wrote:
> >Let me just point out that Victor has his own commercial axe to grind in
> >his continual bad-mouthing of IRIX, the internals of which he knows
> >nothing about.
> 
> 1) do you actually disagree with victor ?

Yes, I most emphatically do disagree with Victor!  IRIX is used for
mission-critical audio applications - recording as well playback - and
other low-latency applications.  The same OS scales to large numbers of
CPUs.  And it has the best desktop interactive response of any OS I've
used.  I will be very happy when Linux is as good in all these areas,
and I'm working hard to achieve this goal with negligible impact on the
current Linux "sweet-spot" applications such as web serving.

> this discussion has the hallmarks of turning into a personal
> bash-fest, which is really pointless. what is *not* pointless is a
> considered discussion about the merits of the IRIX "RT" approach over
> possible approaches that Linux might take which are dissimilar to the
> IRIX one. on the other hand, as Victor said, a large part of that
> discussion ultimately comes down to a design style rather than hard
> factual or logical reasoning.

I agree.  I'm not wedded to any particular design - I just want a
low-latency Linux by whatever is the best way of achieving that.
However, I am hearing Victor say that we shouldn't try to make Linux
itself low-latency, we should just use his so-called "RTLinux" environment
for low-latency tasks.  RTLinux is not Linux, it is a separate
environment with a separate, limited set of APIs.  You can't run XMMS,
or any other existing Linux audio app in RTLinux.  I want a low-latency
Linux, not just another RTOS living parasitically alongside Linux.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
