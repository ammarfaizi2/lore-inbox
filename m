Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267409AbTA1Q7l>; Tue, 28 Jan 2003 11:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267411AbTA1Q7l>; Tue, 28 Jan 2003 11:59:41 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:57097 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267409AbTA1Q7l>; Tue, 28 Jan 2003 11:59:41 -0500
Date: Tue, 28 Jan 2003 12:06:11 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andi Kleen <ak@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [PATCH] page coloring for 2.5.59 kernel, version 1
In-Reply-To: <p73k7gpz0vu.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.3.96.1030128120205.32466B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jan 2003, Andi Kleen wrote:

> The main advantage of cache coloring normally is that benchmarks 
> should get stable results. Without it a benchmark result can vary based on 
> random memory allocation patterns.
> 
> Just having stable benchmarks may be worth it.

I have noted in ctxbench that the SMP results have a vast performance
range while the uni (and nosmp) don't. Not clear if this would improve
that, but I sure would like to try.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

