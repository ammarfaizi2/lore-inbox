Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265665AbSJSTKG>; Sat, 19 Oct 2002 15:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265666AbSJSTKG>; Sat, 19 Oct 2002 15:10:06 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:30983 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265665AbSJSTKF>; Sat, 19 Oct 2002 15:10:05 -0400
Date: Sat, 19 Oct 2002 15:14:47 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Jeff Dike <jdike@karaya.com>, Andi Kleen <ak@muc.de>,
       john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
In-Reply-To: <20021019041019.GI23930@dualathlon.random>
Message-ID: <Pine.LNX.3.96.1021019151308.29078D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Oct 2002, Andrea Arcangeli wrote:

> So I would go with:
> 
> 1) global sysctl to turn off vgettimeofday/vtime
> 2) if 1) is unacceptable then per-task turnoff of vsyscalls would be the
>    next viable solution
> 
> Comments?

I think (2) is a more general solution. Let UML handle any cases it
wishes, not limited to just this particular vsyscall.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

