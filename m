Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265243AbTBKTiZ>; Tue, 11 Feb 2003 14:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbTBKTiZ>; Tue, 11 Feb 2003 14:38:25 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18448 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265243AbTBKTiY>; Tue, 11 Feb 2003 14:38:24 -0500
Date: Tue, 11 Feb 2003 14:44:54 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Crispin Cowan <crispin@wirex.com>, linux-security-module@wirex.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] LSM changes for 2.5.59
In-Reply-To: <20030211013521.GA23638@codemonkey.org.uk>
Message-ID: <Pine.LNX.3.96.1030211140800.1726A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2003, Dave Jones wrote:

> On Mon, Feb 10, 2003 at 05:14:50PM -0500, Bill Davidsen wrote:
> 
>  > Too radical? After the modules rewrite how could anything short of a
>  > rewrite in another language be too radical.
> 
> The modules rewrite highlighted a *lot* of bugs, which had nothing
> to do with modules whatsoever. It was unfortunate for Rusty that his
> work got merged the same time as a lot of other changes went in
> which broke a lot of stuff (The cli/sti stuff springs to mind).
> It also highlighted another bunch of bugs which were *real problems*
> like using code marked __init after it was freed.

I think I see a knee-jerk reaction here. I commented on the magnitude and
pervasiveness of the change, not the way it was done. I could write an
essay about the way it was done, but that wasn't what I was talking about,
just the low impact of lsm vs. modules.

I also mentioned that lsm would be an understandable major new feature,
encouraging a variety of applications (as iptables did for firewall
generators and load balancers). The new module code only gives rise to
busywork porting drivers and utilities to the new way of doing that same
old same old. If there's some neat new useful capability with modules I
must have missed that post. 

Yes, the idea that lsm is too radical to go into Linux does frost my ass,
and I'm not pretending it doesn't. But don't change the topic to "let's
not pick on Rusty," because I wasn't, at least in that post ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

