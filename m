Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422790AbWCXNxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422790AbWCXNxH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 08:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422846AbWCXNxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 08:53:07 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:23519 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1422790AbWCXNxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 08:53:05 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
Date: Sat, 25 Mar 2006 00:52:39 +1100
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
References: <1143198208.7741.8.camel@homer> <200603242334.19837.kernel@kolivas.org> <1143205342.7741.104.camel@homer>
In-Reply-To: <1143205342.7741.104.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603250052.40235.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 March 2006 00:02, Mike Galbraith wrote:
> On Fri, 2006-03-24 at 23:34 +1100, Con Kolivas wrote:
> > I feel this discussion may degenerate beyond this point. Should we say to
> > agree to disagree at this point? I don't like these changes.
>
> Why should it degenerate?  You express your concerns, I answer them.
> You don't have to agree with me, and I don't have to agree with you.
> That's no reason for the discussion to degenerate.

By degenerate I mean get stuck in an endless loop. I don't have the energy for 
cyclical discussions where no conclusive endpoint can ever be reached. That 
is the nature of what we're discussing. Everything is some sort of compromise 
and you're moving one set of compromises for another which means this can be 
debated forever without a right or wrong.

The merits of throttling seem obvious with a sliding scale between 
interactivity and fairness. These other changes, to me, do not. On the 
interactivity side I only have interbench for hard data, and it is showing me 
regressions consistent with my concerns from these other "cleanups". You'll 
trade some other advantage for these and we'll repeat the discussion all over 
again. Rinse and repeat.

Cheers,
Con
