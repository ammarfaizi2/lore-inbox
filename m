Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265686AbTBXI7V>; Mon, 24 Feb 2003 03:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265687AbTBXI7V>; Mon, 24 Feb 2003 03:59:21 -0500
Received: from packet.digeo.com ([12.110.80.53]:14761 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265686AbTBXI7U>;
	Mon, 24 Feb 2003 03:59:20 -0500
Date: Mon, 24 Feb 2003 01:09:38 -0800
From: Andrew Morton <akpm@digeo.com>
To: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Cc: wli@holomorphy.com, lm@work.bitmover.com, mbligh@aracnet.com,
       davidsen@tmr.com, greearb@candelatech.com, linux-kernel@vger.kernel.org,
       billh@gnuppy.monkey.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-Id: <20030224010938.35de6275.akpm@digeo.com>
In-Reply-To: <20030224085617.GA6483@gnuppy.monkey.org>
References: <Pine.LNX.3.96.1030223182350.999E-100000@gatekeeper.tmr.com>
	<33350000.1046043468@[10.10.2.4]>
	<20030224045717.GC4215@work.bitmover.com>
	<20030224074447.GA4664@gnuppy.monkey.org>
	<20030224075430.GN10411@holomorphy.com>
	<20030224080052.GA4764@gnuppy.monkey.org>
	<20030224004005.5e46758d.akpm@digeo.com>
	<20030224085617.GA6483@gnuppy.monkey.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Feb 2003 09:09:26.0441 (UTC) FILETIME=[6E017190:01C2DBE4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (Hui) <billh@gnuppy.monkey.org> wrote:
>
> On Mon, Feb 24, 2003 at 12:40:05AM -0800, Andrew Morton wrote:
> > There is no evidence for any such thing.  Nor has any plausible
> > theory been put forward as to why such an improvement should occur.
> 
> I find what you're saying a rather unbelievable given some of the
> benchmarks I saw when the preempt patch started to floating around.
> 
> If you search linuxdevices.com for articles on preempt, you'll see a
> claim about IO performance improvements with the patch. If somethings
> changed then I'd like to know.
> 
> The numbers are here:
> 	http://kpreempt.sourceforge.net/
> 

That's a 5% difference across five dbench runs.  If it is even 
statistically significant, dbench is notoriously prone to chaotic
effects (less so in 2.5)  It is a long stretch to say that any
increase in dbench numbers can be generalised to "improved IO
performance" across the board.

The preempt stuff is all about *worst-case* latency.  I doubt if
it shifts the average latency (which is in the 50-100 microsecond
range) by more that 50 microseconds.

