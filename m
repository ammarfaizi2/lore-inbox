Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbTE1XCD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 19:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbTE1XCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 19:02:03 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:2053 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261566AbTE1XBo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 19:01:44 -0400
Date: Wed, 28 May 2003 19:08:54 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Willy Tarreau <willy@w.ods.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, gibbs@scsiguy.com
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
In-Reply-To: <1053786998.1793.31.camel@mulgrave>
Message-ID: <Pine.LNX.3.96.1030528185013.21414E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 May 2003, James Bottomley wrote:

> The argument isn't about size, it's about safety.  No company that wants
> to stay in business accepts code into release stabilisation unless it's
> clearly justifiable.  Trying to buck the system by including five
> features plus one critical bug fix is one of the oldest tricks in the
> Software Engineers book---do this and you get hauled before the release
> committee whose job will be to pare the addition back to just the bug
> fix (and send you away with a flea in your ear to boot).

That's nice when someone is working for you. In this case I believe there
were multiple bugs, and the viable choices were to ship with the old known
bugs or do testing on the new version until it is accepted as tested.
Given that the release schedule seems to be measures in generations these
days, shipping a driver known to be bad is probably worse than doing one
more rc and asking people to beat hell out of the driver.

> 
> > I wish Justin would have proposed a little patch to fix only the locking bugs
> > in -rc1, but honnestly, why should he fix only these bugs when he knows about
> > others that must be fixed too ? I can understand he gives up. -rc is for bug
> > fixes, and his bug fixes are reverted !
> 
> Marcelo reacted exactly as the release committee would at Adaptec:
> either provide the bug fix for assessment or we'll push it out into the
> next release.  This is industry standard practice, so I don't see any
> problem.

I bet your release schedule is more frequent, too. There comes a time when
doing a whole new QA is better than trying to be sure a fix works without
doing full QA anyway. As in both faster and more likely to result in a
correct result.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

