Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262785AbSITPte>; Fri, 20 Sep 2002 11:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262787AbSITPte>; Fri, 20 Sep 2002 11:49:34 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:9235 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262785AbSITPtd>; Fri, 20 Sep 2002 11:49:33 -0400
Date: Fri, 20 Sep 2002 11:47:22 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 100,000 threads? [was: [ANNOUNCE] Native POSIX Thread Library 0.1]
In-Reply-To: <Pine.LNX.4.44.0209200942030.27825-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1020920114403.29079B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002, Ingo Molnar wrote:


> the extreme high-end of threading typically uses very controlled
> applications and very small user level stacks.
> 
> as to the question of why so many threads, the answer is because we can :)
> This, besides demonstrating some of the recent scalability advances, gives
> us the warm fuzzy feeling that things are right in this area. I mean,
> there are architectures where Linux could map a petabyte of RAM just fine,
> even though that might not be something we desperately need today.

I think testing at these high numbers is a good proof of scalability,
although response and stability are also important. Before I went to NGPT
I had a fair bit of problem with learning experiences after threads got
beyond 200 or so.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

