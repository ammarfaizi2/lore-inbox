Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265311AbRGEPAs>; Thu, 5 Jul 2001 11:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265310AbRGEPAi>; Thu, 5 Jul 2001 11:00:38 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:39184 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265311AbRGEPAX>; Thu, 5 Jul 2001 11:00:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Xavier Bestel <xavier.bestel@free.fr>
Subject: Re: VM Requirement Document - v0.0
Date: Thu, 5 Jul 2001 17:04:00 +0200
X-Mailer: KMail [version 1.2]
Cc: Dan Maas <dmaas@dcine.com>, linux-kernel@vger.kernel.org,
        Tom spaziani <digiphaze@deming-os.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <fa.jprli0v.qlofoc@ifi.uio.no> <0107051502510F.03760@starship> <994341617.2070.1.camel@nomade>
In-Reply-To: <994341617.2070.1.camel@nomade>
MIME-Version: 1.0
Message-Id: <0107051704000H.03760@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 July 2001 16:00, Xavier Bestel wrote:
> On 05 Jul 2001 15:02:51 +0200, Daniel Phillips wrote:
> > Here's an idea I just came up with while I was composing this... along
> > the lines of using unused bandwidth for something that at least has a
> > chance of being useful.  Suppose we come to the end of a period of
> > activity, the general 'temperature' starts to drop and disks fall idle. 
> > At this point we could consult a history of which currently running
> > processes have been historically active and grow their working sets by
> > reading in from disk. Otherwise, the memory and the disk bandwidth is
> > just wasted, right?  This we can do inside the kernel and not require
> > coders to mess up their apps with hints.  Of course, they should still
> > take the time to reengineer them to reduce the cache footprint.
>
> Well, on a laptop memory and disk bandwith are rarely wasted - they cost
> battery life.

Let me comment on this again, having spent a couple of minutes more 
thinking about it.  Would you be happy paying 1% of your battery life to get 
80% less sluggish response after a memory pig exits?

Also, notice that the scenario we were originally discussing, the off-hours 
updatedb, doesn't normally happen on laptops because they tend to be 
suspended at that time.

--
Daniel
