Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131047AbQKIOxs>; Thu, 9 Nov 2000 09:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131076AbQKIOxi>; Thu, 9 Nov 2000 09:53:38 -0500
Received: from chiara.elte.hu ([157.181.150.200]:20748 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131047AbQKIOxY>;
	Thu, 9 Nov 2000 09:53:24 -0500
Date: Thu, 9 Nov 2000 17:03:12 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Larry McVoy <lm@bitmover.com>
Cc: Christoph Rohland <cr@sap.com>,
        Michael Rothwell <rothwell@holly-springs.nc.us>,
        richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <20001108235312.H22781@work.bitmover.com>
Message-ID: <Pine.LNX.4.21.0011091654030.2995-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Nov 2000, Larry McVoy wrote:

> smart about that stuff, are least it seems so to me; he seems to be
> well aware that 99.9999% of the hardware in the world isn't big iron
> and never will be, so something approximating 99% of the effort should
> be going towards the common platforms, not the uncommon ones.

yep, this is true. Still Linux appears to perform remarkably well on
so-called 'big iron'.

IMO it's a big misconception that 'big iron is different'. Yes, patches
and bad design can make source trees very different. But IMO big iron is
not more different from a normal PIII workstation than a PDA is different.
We doing a bad job if we cannot support them all - or at least we must
always be able to keep clean interfaces so keeping a forked sub-project
for a less known or less understood feature is easy and straightforward.
In fact i believe a PDA is much harder to do right than high-end systems.
Making something faster, given endless resources, is almost always easy.
But maximizing performance on a fundamentally and intentionally limited
platform is much less trivial and takes alot of clout.

in the 2.4 kernel we have all the features that is needed for 'enterprise
scalability', in fact i believe we have some scalability features (eg. big
reader spinlocks) that are not available on other systems.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
