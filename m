Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261729AbSJEAUU>; Fri, 4 Oct 2002 20:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261790AbSJEAUU>; Fri, 4 Oct 2002 20:20:20 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:51188 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261729AbSJEAUT>;
	Fri, 4 Oct 2002 20:20:19 -0400
Date: Fri, 04 Oct 2002 17:21:42 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] 2.6 not 3.0 - (NUMA)
Message-ID: <515070000.1033777302@flay>
In-Reply-To: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The main thing that I think is lacking is any relevance to any significant 
> user base, thanks to lack of interesting hardware. So even if Linux itself 
> was doing everything perfectly, as long as there is no wide hw base and 
> users, it's all pretty much academic, the same way SMP was during the 
> early 1.x days.
> 
> And I'm not trying to put you or any of the Linux NuMA work down here, I'm 
> just saying that what makes it not important as a "3.0 feature" is just 
> that deployment doesn't merit it yet.

Fair enough, I appreciate it's not a wide market segment right now.
It's not a quick and easy project though, so there's a long-ish ramp up time.
It would be nice to have it all working and in place by the time Hammer arrives 
and makes this much more widespread ;-) 

Just an order of magnitude figure for you ... number of seconds spent in kernel
space across all CPUs during a kernel compile on a 16-way NUMA-Q ... 

2.4 with every patch I had (including O(1) sched + NUMA mods) ... 120s. 
On 2.5.40-mm1 with one small NUMA scheduler patch ... 38s. 

Personally, I think that's pretty impressive - lots of very good things have been
happening, from Andrew in particular, the NUMA people, and VM people in general.
IMHO, the NUMA code is also much more readable and less buggy ;-)

M.

