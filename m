Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267771AbTBYOUu>; Tue, 25 Feb 2003 09:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267878AbTBYOUu>; Tue, 25 Feb 2003 09:20:50 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43651
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267771AbTBYOUt>; Tue, 25 Feb 2003 09:20:49 -0500
Subject: Re: Minutes from Feb 21 LSE Call
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: yodaiken@fsmlabs.com, William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@digeo.com>, lm@work.bitmover.com,
       mbligh@aracnet.com, davidsen@tmr.com, greearb@candelatech.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030225021736.GB4507@gnuppy.monkey.org>
References: <33350000.1046043468@[10.10.2.4]>
	 <20030224045717.GC4215@work.bitmover.com>
	 <20030224074447.GA4664@gnuppy.monkey.org>
	 <20030224075430.GN10411@holomorphy.com>
	 <20030224080052.GA4764@gnuppy.monkey.org>
	 <20030224004005.5e46758d.akpm@digeo.com>
	 <20030224085031.GP10411@holomorphy.com>
	 <20030224091758.A11805@hq.fsmlabs.com>
	 <20030224231341.GQ10411@holomorphy.com>
	 <20030224162754.A24766@hq.fsmlabs.com>
	 <20030225021736.GB4507@gnuppy.monkey.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046187058.4096.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 25 Feb 2003 15:30:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-25 at 02:17, Bill Huey wrote:
> You don't need data. It's conceptually obvious. If you have a higher
> priority thread that's not running because another thread of lower priority
> is hogging the CPU for some unknown operation in the kernel, then you're
> going be less able to respond to external events from the IO system and
> other things with respect to a Unix style priority scheduler.

Nothing is conceptually obvious. Thats the difference between 'science'
and engineering. Our bridges have to stay up.

> It's about getting relationship inside the kernel to respect and be
> controllable by the scheduler in some formal manner, not some random
> not-so-well-though-out hack of the day.

Prove it, compute the bounded RT worst case. You can't do it. Linux, NT,
VMS and so on are all basically "armwaved real time". Now for a lot of
things armwaved realtime is ok, one 'click' an hour on a phone call
from a DSP load miss isnt a big deal. Just don't try the same with
precision heavy machinery.

Its not a lack of competence, we genuinely don't yet have the understanding
in computing to solve some of the problems people are content to armwave
about.

If I need extremely high provable precision, Victor's approach is right, if
I want armwaved realtimeish behaviour with a more convenient way of working
then Victor's approach may not be the best.

Its called engineering. There are multiple ways to build most things, each
with different advantages, there are multiple ways to model it each with
more accuracy in some areas. Knowing how to use the right tool is a lot 
more important than having some religion about it.

Alan

