Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288212AbSACFz7>; Thu, 3 Jan 2002 00:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288211AbSACFzt>; Thu, 3 Jan 2002 00:55:49 -0500
Received: from w147.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.147]:11985 "EHLO
	funky.gghcwest.COM") by vger.kernel.org with ESMTP
	id <S288212AbSACFzk>; Thu, 3 Jan 2002 00:55:40 -0500
Date: Wed, 2 Jan 2002 21:54:49 -0800 (PST)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@windmill.gghcwest.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kswapd etc hogging machine
In-Reply-To: <E16M0kC-00012Q-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0201022151470.31459-100000@windmill.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Jan 2002, Daniel Phillips wrote:

> On January 3, 2002 06:15 am, Andrew Morton wrote:
> > And we, the kernel developers, should hang our heads over this.  A
> > vendor-released, stable kernel is performing terribly with such a
> > simple workload.  One year after the release of 2.4.0!
>
> To be fair, in the year leading up to 2.4.0 much energy was expended on
> getting the bugs out of the unified and heaviliy threaded page+buffer
> cache[1], at the expense of work on the memory manager, so 2001 ended up
> being like a whole new kernel cycle.  Anyway, the saving grace is that 2.2
> managed to metamorphose from ugly duckling to... quite a nice duck, with
> almost all the features of 2.4 from the user's point of view.  So everybody
> has something to run.
>
> With 20 20 hindsight, the VM work could have been managed better but I don't
> see why anybody's head needs to be hung.  It was a bumpy road, we had to
> change a few tires, but we got to the other side of the mountain.

We did?  I'm running the last released kernel and today I got an OOM event
when 1.4 GB main memory was used for buffer cache.  I have to babysit any
Linux 2.4 machines that have interesting workloads.  2.4 may have reached
a local maximum, but the ascent to the peak is still in front of us.

-jwb

