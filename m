Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314583AbSEFQ54>; Mon, 6 May 2002 12:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314595AbSEFQ5z>; Mon, 6 May 2002 12:57:55 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:27920 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S314583AbSEFQ5x>; Mon, 6 May 2002 12:57:53 -0400
Date: Mon, 6 May 2002 12:54:09 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Russell Leighton <russ@elegant-software.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 as a router, when is it appropriate?
In-Reply-To: <3CD28FB8.40204@elegant-software.com>
Message-ID: <Pine.LNX.3.96.1020506124655.26135A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002, Russell Leighton wrote:

> 
> Could someone please tell me (or refer me to docs) on when
> using the Linux on PC hardware as a router is an appropriate
> solution and when one should consider a "real" router (e.g., Cisco)?
> 
> I have heard that performance wise, if you have a fast CPU,
> much memory and good NICs that Linux can be as good
> all but the high end routers. Are there important missing
> features or realiability issues that make using Linux not
> suitable for "enterprise" use?

  Professional routers may support non-IP protocols which Linux doesn't,
and the non-IP protocols which are in Linux are far less less used than
IP. That does not mean they don't work, but somewhat untrodden ground.

  For IP, particularly for tricky, messy, nasty stuff, I do prefer
Linux/iptables. I'm looking forward to having time to see how well UML and
iptables play, so I can have a whole DMZ full of "machines" to test some
challenging setups.

  Throughput and latency are pretty competitive with any commercial
router, given good hardware. I believe preempt does improve latency, but I
really haven't had a case where I needed to worry about it, Linux is fast
as-is.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

