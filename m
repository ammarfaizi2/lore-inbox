Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271644AbRH0DJh>; Sun, 26 Aug 2001 23:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271645AbRH0DJ1>; Sun, 26 Aug 2001 23:09:27 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:54311 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271644AbRH0DJP>; Sun, 26 Aug 2001 23:09:15 -0400
Subject: Re: Updated Linux kernel preemption patches
From: Robert Love <rml@tech9.net>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org, nigel@nrg.org
In-Reply-To: <20010827025934Z16098-32383+1547@humbolt.nl.linux.org>
In-Reply-To: <998877465.801.19.camel@phantasy> 
	<20010827025934Z16098-32383+1547@humbolt.nl.linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 26 Aug 2001 23:09:49 -0400
Message-Id: <998881793.805.30.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-08-26 at 23:06, Daniel Phillips wrote:
> Congratulations on showing evidence that preemption can improve performance 
> under some loads, especially the all-important kernel compile.  Don't be too 
> worried about the dbench 1 results, dbench can vary by a factor of 2 
> depending on the alignment of the planets (ask Tridge).  Try something more 
> stable like bonnie.

I would be happy to run some other tests.  I was happy to see the kernel
compile prove faster, and I fully expected the dbench 16 results to show
an improvement.  But, while I assumed dbench 1 may show a degradation in
performance, I was surprised it was so high.

My main goal in updating Nigel's patches to recent kernels was to
accomplish just this: get some more data points, some more benchmarks,
and more eyes on the code and systems running the patch.

I am not an audio guy or otherwise in need of a lower-latency system,
but the possibility for an overall improvement in the kernel (even at
the expense of some cases) is worthwhile, to me.

> The theory goes that preemption improves performance by cutting down the time 
> between IO completion and user task resume, with only a small cost in extra 
> locking.  It would be nice to see profiling statistics to support this idea.

Anyone running the patch want to profile some situations and reach some
conclusions?

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

