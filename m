Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbUL3C6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbUL3C6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 21:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbUL3C6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 21:58:04 -0500
Received: from mail.tmr.com ([216.238.38.203]:54214 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261523AbUL3C57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 21:57:59 -0500
Message-ID: <41D3713D.3010707@tmr.com>
Date: Wed, 29 Dec 2004 22:08:45 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel Benchmarks With P4+SMP+SMT?
References: <Pine.LNX.4.61.0412281914380.11816@p500>
In-Reply-To: <Pine.LNX.4.61.0412281914380.11816@p500>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> Has anyone performed any benchmarks with:
> 
> No SMP w/HT?
> SMP w/HT?
> SMP + SMT w/HT?
> 
> [ ] Symmetric multi-processing support
> [ ]   SMT (Hyperthreading) scheduler support
> 
>   x SMT scheduler support improves the CPU scheduler's decision making
>   x when dealing with Intel Pentium 4 chips with HyperThreading at a
>   x cost of slightly increased overhead in some places. If unsure say
>   x N here.
> 
> I'm tempted to try SMT and benchmark these sometime but I am asking the 
> list if anyone has already done this first.
> 
> Question: "slightly increased overhead in some places."
> 
> What type of workloads would exhibit such overhead?
> 
> Would this option (SMT) be recommended for a desktop or server machine?
> 
> Are there any white papers or documentation I can read about this option?

I run SMT on all my HT uni systems. Depending on what you do it can help 
up to 30% (kernel build) or just enough to measure. This is one of those 
"it depends" things, I bet there are loads which run better without, and 
there is a tad of overhead in the SMP kernel locking.

If you run SMP, you have that overhead anyway, so I doubt it hurts.

YMMV

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
