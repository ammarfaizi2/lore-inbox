Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267528AbSLLWRc>; Thu, 12 Dec 2002 17:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267530AbSLLWRc>; Thu, 12 Dec 2002 17:17:32 -0500
Received: from chopper.slackworks.com ([64.244.30.42]:43534 "EHLO
	chopper.slackworks.com") by vger.kernel.org with ESMTP
	id <S267528AbSLLWRb>; Thu, 12 Dec 2002 17:17:31 -0500
Date: Thu, 12 Dec 2002 15:12:03 -0500 (EST)
From: Zac Hansen <xaxxon@chopper.slackworks.com>
To: "J.A. Magallon" <jamagallon@able.es>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <20021212205655.GA1658@werewolf.able.es>
Message-ID: <Pine.LNX.4.44.0212121455490.5270-100000@chopper.slackworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (chopper.slackworks.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> No. The situation is just black. Each day Intel processors are a bigger
> pile of crap and less intelligent

My hyper-threaded xeons beg to argue with you -- all 4 (2) of them.

, but MHz compensate for the average
> office user. Think of what could a P4 do if the same effort put on
> Hz was put on getting cheap a cache of 4Mb or 8Mb like MIPSes have. Or
> closer, 1Mb like G4s.

Err, syscalls are still going to take the same amount of time no matter 
how much cache the chip has on it.  And, IMHO, adding more cache to make a 
processor faster is just as "dumb" as bumping the MHz.  

> If syscalls take 300% time but processor is also 300% faster 'nobody
> notices'. 
> 

The point many are forgetting is that processors do a lot more than system 
calls.  And P4's are quite quick at doing this.. especially those new 
3+GHz ones (with hyperthreading).

By the way, did everyone see the test on Tom's Hardware Guide comparison 
between the p4 3.06 with hyperthreading on and a p4 3.6 without 
hyperthreading.. 

http://www17.tomshardware.com/cpu/20021114/index.html

For those of you who just want the info -- here's the spoiler -- when 
running multiple apps, the 3.06 can torch the 3.6.  Check out the second 
benchmark on this page

http://www17.tomshardware.com/cpu/20021114/p4_306ht-16.html

25% faster.  Most of the other benchmarks don't show off hyperthreading, 
as they're running a single process, but from personal experience, it's 
nice.  I don't know why they give you the option to turn it off in the 
bios.  I have 2 xeons, and even then I leave HT on on both.  I'd not even 
think about considering turning it off if I only had 1 processor..

--Zac
xaxxon@slackworks.com

