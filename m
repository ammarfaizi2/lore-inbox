Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVAOT3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVAOT3b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 14:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVAOT3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 14:29:30 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:38319 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S262309AbVAOT3U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 14:29:20 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None, usuallly detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc1-V0.7.35-01
Date: Sat, 15 Jan 2005 14:29:18 -0500
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Steven Rostedt <rostedt@goodmis.org>, Bill Huey <bhuey@lnxw.com>
References: <20041118164612.GA17040@elte.hu> <20050104094518.GA13868@elte.hu> <20050115133454.GA8748@elte.hu>
In-Reply-To: <20050115133454.GA8748@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501151429.18707.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [141.153.92.6] at Sat, 15 Jan 2005 13:29:19 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 January 2005 08:34, Ingo Molnar wrote:
>i have released the -V0.7.35-00 Real-Time Preemption patch, which
> can be downloaded from the usual place:
>
>  http://redhat.com/~mingo/realtime-preempt/
>
By the time I got there is was 35-01 :-)

I have 1 squawk and one question.

The squawk is the extra "-RT" in the Makefiles Extra-Version, I made 
it 3 times and failed to boot to it with my script before that light 
came on.

And, what happened to drivers/ieee1394/amdtp?  Its not even in the 
xconfig choices now.  And I use it with my Sony Digital8 camera.

Also, and this is a more general squawk, I have to unload all those 
ieee1394 stuffs, turn on the camera, and then reload it all before 
the camera is recognized and usable.  Ditto if I have it working, 
then turn the camera off, before I can access the camera again I have 
to  rmmod all that stuff and reload it again. This is probably 
something that can be done with hotplug, but the last time I played 
with that it was lockup the whole machine disaster.

This was true with 2.6.11-rc1, but I haven't checked that stuff yet 
after getting this to boot just now.

>The two dozen split out latency patches (including PREEMPT_BKL) that
>were in -mm are in BK now, so i've rebased the -RT patchset to
>2.6.11-rc1. It would be nice to check for regressions (or the lack
> of them), to make sure everything latency-related has been properly
> merged upstream from -mm. (so that a new splitup cycle can start.)
>
>to create a -V0.7.34-00 tree from scratch, the patching order is:
>
>  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.10.tar.bz2
> 
> http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.11-rc1.bz
>2
> http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.11-r
>c1-V0.7.35-00
>
> Ingo
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.32% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
