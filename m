Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269744AbUJWAcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269744AbUJWAcs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269318AbUJWAKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:10:44 -0400
Received: from holomorphy.com ([207.189.100.168]:35783 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269297AbUJWAKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:10:08 -0400
Date: Fri, 22 Oct 2004 17:09:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: espenfjo@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041023000956.GI17038@holomorphy.com>
References: <7aaed09104102213032c0d7415@mail.gmail.com> <7aaed09104102214521e90c27c@mail.gmail.com> <20041022225703.GJ19761@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022225703.GJ19761@alpha.home.local>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 11:52:50PM +0200, Espen Fjellv?r Olsen wrote:
>> I think that 2.6 should be frozen from now on, just security related
>> stuff should be merged.
>> This would strengthen Linux's reputation as a stable and secure
>> system, not a unstable and a system just used for fun.

On Sat, Oct 23, 2004 at 12:57:03AM +0200, Willy Tarreau wrote:
> Linux already got its reputation of a stable system from its production
> kernels, 2.0, 2.2 and 2.4 which are largely used in sensible environments.
> 2.6 is stable enough for most desktop usage and for end-users distros to
> ship it by default. This will encourage many more people to test it, send
> reports back and finally stabilize it so that one day it can finally be
> used in production environments. At first I was a bit angry that it had
> been declared "stable" a bit too early, but now, judging by the amount of
> people who use it only because their distros ship with it, I realise that
> indeed, it should have been declared "stable" earlier so that all the bug
> fixes you see now would be fixed by now.

The freezes from kernels past led to gross redundancy. Distros all
froze at different points in time with numerous patches atop the
then-mainline release. The mainline freeze was meaningless because
the distros were all completely divorced from it, resulting in numerous
simultaneously frozen trees with no outlet for forward progress.


On Fri, Oct 22, 2004 at 11:52:50PM +0200, Espen Fjellv?r Olsen wrote:
>> A 2.7 should be created where all new experimental stuff is merged
>> into it, and where people could begin to think new again.

On Sat, Oct 23, 2004 at 12:57:03AM +0200, Willy Tarreau wrote:
> This could be true if the release cycle was shorter. But once 2.7 comes
> out, many developpers will only focus on their development and not on
> stabilizing 2.6 as much as today.

We aren't just stabilizing 2.6. We're moving it forward. Part of moving
forward is preventing backportmania depravity. Backporting is the root
of all evil.


-- wli
