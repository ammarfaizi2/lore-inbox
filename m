Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbUC3Jjh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 04:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUC3Jjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 04:39:37 -0500
Received: from zero.aec.at ([193.170.194.10]:6153 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263577AbUC3Jje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 04:39:34 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: efocht@hpce.nec.com, linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [Lse-tech] [patch] sched-domain cleanups,
 sched-2.6.5-rc2-mm2-A3
References: <1DF7H-22Y-11@gated-at.bofh.it> <1DL3x-7iG-7@gated-at.bofh.it>
	<1DLGd-7TS-17@gated-at.bofh.it> <1FmNz-72J-73@gated-at.bofh.it>
	<1FnzJ-7IW-15@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 30 Mar 2004 11:39:21 +0200
In-Reply-To: <1FnzJ-7IW-15@gated-at.bofh.it> (Nick Piggin's message of "Tue,
 30 Mar 2004 11:20:11 +0200")
Message-ID: <m34qs665di.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> writes:

> I'm with Martin here, we are just about to merge all this
> sched-domains stuff. So we should at least wait until after
> that. And of course, *nothing* gets changed without at least
> one benchmark that shows it improves something. So far
> nobody has come up to the plate with that.

Hmm? I post numbers all the time.

> There are other things, like java, ervers, etc that use threads.
> The point is that we have never had this before, and nobody
> (until now) has been asking for it. And there are as yet no
> convincing benchmarks that even show best case improvements. And

I don't have hard numbers anymore (Andrea, do you remember the
details?), but I think we had actually better benchmark results
in some java benchmarks with an aggressively balancing scheduler
in 2.4-aa on non NUMA machines.

-Andi

