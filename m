Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSGBOt5>; Tue, 2 Jul 2002 10:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSGBOt4>; Tue, 2 Jul 2002 10:49:56 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:14096 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316512AbSGBOt4>; Tue, 2 Jul 2002 10:49:56 -0400
Date: Tue, 2 Jul 2002 10:46:56 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Tom Rini <trini@kernel.crashing.org>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] O(1) scheduler in 2.4
In-Reply-To: <20020701181228.GF20920@opus.bloom.county>
Message-ID: <Pine.LNX.3.96.1020702103924.27954A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2002, Tom Rini wrote:

> On Mon, Jul 01, 2002 at 01:52:54PM -0400, Bill Davidsen wrote:
> 
> > What's the issue?
> 
> a) We're at 2.4.19-rc1 right now.  It would be horribly
> counterproductive to put O(1) in right now.
> b) 2.4 is the _stable_ tree.  If every big change in 2.5 got back ported
> to 2.4, it'd be just like 2.5 :)
> c) I also suspect that it hasn't been as widley tested on !x86 as the
> stuff currently in 2.4.  And again, 2.4 is the stable tree.

Since 2.5 feature freeze isn't planned until fall, I think you can assume
there will be releases after 2.4.19... Since it has been as heavily tested
as any feature not in a stable release kernel can be, there seems little
reason to put it off for a year, assuming 2.6 releases within six months
of feature freeze.

Stable doesn't mean moribund, we are working Andrea's VM stuff in, and
that's a LOT more likely to behave differently on hardware with other word
length. Keeping inferior performance for another year and then trying to
separate 2.5 other unintended features from any possible scheduler issues
seems like a reduction in stability for 2.6.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

