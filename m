Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311839AbSDSIJa>; Fri, 19 Apr 2002 04:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311841AbSDSIJa>; Fri, 19 Apr 2002 04:09:30 -0400
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:59088 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S311839AbSDSIJ2>; Fri, 19 Apr 2002 04:09:28 -0400
Date: Fri, 19 Apr 2002 10:09:35 +0200 (CEST)
From: Erich Focht <focht@ess.nec.de>
X-X-Sender: focht@beast.local
To: William Lee Irwin III <wli@holomorphy.com>
cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>,
        Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>,
        <torvalds@transmeta.com>
Subject: Re: [PATCH] migration thread fix
In-Reply-To: <20020419023015.GQ23767@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0204190857400.2593-100000@beast.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bill,

> Sounds fairly thoroughly tested; this is actually more systems than I
> myself have access to. Just to sort of doublecheck the references, is
> there a mailing list archive where I can find reports of this problem
> and/or successes of others using it?

there is some email exchange with Jesse Barnes from SGI on the LSE and
linux-ia64 mailing lists.
  Date: 1.-5. March, 2002
  Subject: Re: [Linux-ia64] O(1) scheduler K3+ for IA64
The success report was a personal email.

On LSE and linux-kernel there were some emails related to the node affine
scheduler which contains the same migration mechanism (but a different
load balancer):
  Date: 13. March and later
  Subject: Node affine NUMA scheduler

Besides, Matt Dobson from IBM adapted the node affine scheduler to work
on NUMA-Q and tested it quite a bit, that email exchange was direct, too.

The testing on our side wasn't publicized, either, but our production
kernel for AzusA (which contains these patches) is about to be sent out to
customers and has undergone quite some testing.


It's a pity that there's so much duplicated effort in the Linux community,
but that's how it goes, you probably know it better than I do.

Best regards,
Erich



