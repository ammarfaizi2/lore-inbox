Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310153AbSB1WR7>; Thu, 28 Feb 2002 17:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293209AbSB1WQF>; Thu, 28 Feb 2002 17:16:05 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:57618 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S310161AbSB1WMu>; Thu, 28 Feb 2002 17:12:50 -0500
Date: Thu, 28 Feb 2002 17:11:25 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020227135001.I1495@inspiron.school.suse.de>
Message-ID: <Pine.LNX.3.96.1020228165834.2006D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2002, Andrea Arcangeli wrote:

> I would like to have feedback about this VM update, if nobody can find
> any serious issue I'd try to push vm-28 into mainline during 2.4.19pre.
> Please test oom conditions as well.

I have enjoyed using your -aa patches (and run child first) for some time,
and Rik's rmap patches as well. However, I find that for some machines
your stuff works clearly better, particularly larger memory machines, and
for some rmap is clearly more responsive, particularly for small machines
under heavy memory pressure.

The point is that choice is good, and having two solutions two address
various machines is a good thing, even if the convenience isn't all that
great. That being said, I fear that if your solution gets pushed into
mainline that it will preempt other solutions. And my testing tells me
that there is no one solution here, even with all the tuning in your VM,
using the hints you gave me.

I would rather see both systems continue to be available, until there is a
clear winner (ie. no common cases where one is clearly worse than the
other), or until they somehow merge, or even become config options (I
don't really favor that). I suggested that VM would be nice as a module,
but it doesn't see possible.

If others share the thought that it's too early for a preemptive choice
please speak up. And if everyone feels that this is good I will not beat a
dead horse on this one.

I assume you meant "serious issues" with failures, rather than
semi-political timing and choice issues.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

