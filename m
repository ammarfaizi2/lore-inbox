Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267451AbUHDWHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbUHDWHg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 18:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267453AbUHDWHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 18:07:36 -0400
Received: from relay.pair.com ([209.68.1.20]:24333 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267451AbUHDWHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 18:07:31 -0400
X-pair-Authenticated: 68.42.66.6
Subject: Re: Scheduler policies for staircase
From: Daniel Gryniewicz <dang@fprintf.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <cone.1091601947.196990.9775.502@pc.kolivas.org>
References: <34840234.20040804074326@dns.toxicfilms.tv>
	 <cone.1091601947.196990.9775.502@pc.kolivas.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Aug 2004 18:07:28 -0400
Message-Id: <1091657248.19988.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-04 at 16:45 +1000, Con Kolivas wrote:
> Maciej Soltysiak writes:
> 
> > Con,
> > 
> > I have been using SCHED_BATCH on two machines now with expected
> > results. So this you might consider this as another success report :-)
> 
> Great. Thanks for the report. I too use them all day every day on each 
> machine I have with distributed computing clients so they're pretty well 
> tested.
> 
> > Do you think that these schedulers could come into the mainline
> > soon? Would you submit them to Linus without the staircase scheduler
> > or would you rather wait for the whole bunch of changes to get
> > rock-stable ?
> 
> It could easily be modified to suit the current scheduler. Obviously I want 
> my scheduler to be considered for mainline at some stage in the future but 
> there needs to be a good reason for that to occur, and the 12 other 
> schedulers out there need to also be tested (we better hurry up or it could 
> be twice that soon :P). At this stage I'll hold onto these patches and see 
> what happens. I'd rather not have to rewrite it to suit the current 
> scheduler and go through all the bugtesting again since there isn't a 
> burning need for this scheduler policy in mainline at the moment. The 
> lack of a large amount of feedback about staircase shows that most people 
> aren't really interested in the cpu scheduler at the moment anyway.
> 

I've been using CK for a while, and I've felt that the staircase was
better.  I have some machines with staircase, and some (work machines)
with mainline, and the staircase "feels" better.  However, I have no
hard numbers, so I haven't spoken up.  I suspect I'm far from alone.  I
understand the lack of a pressing need to replace the mainline
scheduler, but I'll personally continue using staircase as long as
you're putting it out.

(I breifly tried Nick's as well, and it seemed the same as mainline.
But, again, no numbers, and that was a while ago.)

Daniel
