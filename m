Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317324AbSGDDrL>; Wed, 3 Jul 2002 23:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317325AbSGDDrK>; Wed, 3 Jul 2002 23:47:10 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51216 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317324AbSGDDrK>; Wed, 3 Jul 2002 23:47:10 -0400
Date: Wed, 3 Jul 2002 23:44:45 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave Jones <davej@suse.de>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Kernel release management
In-Reply-To: <20020703173421.B8934@suse.de>
Message-ID: <Pine.LNX.3.96.1020703233710.2248D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2002, Dave Jones wrote:

> Unfortunatly, there's the possibility of people thinking
> "I'll fix it properly in 2.7, and backport", during which time,
> 2.6 doesn't get fixed any faster.  People diving into 2.7 development
> and leaving 2.6 to those that actually care about stabilising it was
> Linus' concern if I understood correctly at the summit.

Dave, it's not that I can't see your point, but looking at the way stuff
is being backported to 2.4, and 2.2, and even 2.0 as an example, and how
many new features went into early 2.2 and 2.4 which really should have
been functional before they went in, we have a long track record of
maintainers doing the backports and problems from not having a test series
to use for new features.

I don't see the case you mentioned of fix it in 2.7 and backport as
necessarily a bad idea. You can make progress faster when people aren't
afraid to try stuff, and can itterate until the feature works or the
problem is fixed, then backport understanding the problem.

I don't regard easing features back into the stable release after they are
shaken down as a bad thing, either. A development kernel may not even
compile (biy does 2.5 prove that), a stable series should mean the old
features don't break and the new ones are tested, and it does run a lot
slower than the development series.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

