Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310170AbSCADfX>; Thu, 28 Feb 2002 22:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310338AbSCADdR>; Thu, 28 Feb 2002 22:33:17 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:4627 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S310341AbSCAD2t>; Thu, 28 Feb 2002 22:28:49 -0500
Date: Thu, 28 Feb 2002 22:26:48 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020301013056.GD2711@matchmail.com>
Message-ID: <Pine.LNX.3.96.1020228221750.3310D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, Mike Fedyk wrote:

> The problem here is that currently the mainline kernel makes some bad
> dicesions in the VM, and -aa is the solution in this case.  When -aa is
> merged, you will still have both solutions; one in mainline, one as a patch
> (rmap).
> 
> Linus has already changed the VM once in 2.4, and I don't really see another
> large VM change (rmap in 2.4) happening again.
> 
> Rmap looks promising for a 2.5 merge after several issues are overcome
> (pte-highmem, etc).

I do understand what happens in the VM currently... And as noted I run
both -aa kernels and rmap on different machines. But -aa runs better on
large machines and rmap better on small machines with memory pressure (my
experience), so blessing one and making the other "only a patch" troubles
me somewhat. I hate to say "compete" as VM solution, but they both solve
the same problem with more success in one field or another.

If either is adopted the pressure will be off to improve in the areas
where one or the other is weak, Once the decision is made that won't
happen, And if rmap is a large VM change, what then is Ardrea's code?
Large isn't just the size of the patch, it is to some extent the size of
the behaviour change.

For me it makes little difference, I like to play with kernels, and I'm
hoping for the source which needs only numbers in /proc/sys to tune,
rather than patches. But there are a lot more small machines (which I feel
are better served by rmap) than large. I would like to leave the jury out
a little longer on this.

I was looking for opinions, thak you for sharing yours.!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

