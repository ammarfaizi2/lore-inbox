Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289837AbSBEXEN>; Tue, 5 Feb 2002 18:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289839AbSBEXED>; Tue, 5 Feb 2002 18:04:03 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:40708 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289837AbSBEXDm>; Tue, 5 Feb 2002 18:03:42 -0500
Date: Tue, 5 Feb 2002 18:02:48 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Robert Love <rml@tech9.net>
cc: Roland Dreier <roland@topspincom.com>, linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
In-Reply-To: <1012862738.848.95.camel@phantasy>
Message-ID: <Pine.LNX.3.96.1020205175725.3562A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Feb 2002, Robert Love wrote:

> The i8xx and other RNGs are different.  They actually _give_ us the
> random data.  In other words, they generate entropy to just push
> directly into the pool.  The concern is that this data may not be safe,
> and thus we need to run a fitness test on it (i.e. FIPS 190, I
> believe).  All this muck is new code and can exist in userspace --
> therefore it will.

You seem to equate root space with user space, which is a kernel way of
looking at things, particularly if you haven't been noting all the various
hacker attacks lately. Just because it is possible to run in user space
doesn't mean it's desirable to do so, and many sites don't really want
things running as root so they can feed other things to the kernel.

The assumption that power users will know how to fix it and other users
won't notice they have no entropy isn't all that appealing to me, I want
Linux to be as easy to do right as the competition.

Just my read on it.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

