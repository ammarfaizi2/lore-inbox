Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbVI1Q3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbVI1Q3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 12:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVI1Q3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 12:29:21 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:3555 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S1751363AbVI1Q3U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 12:29:20 -0400
Subject: Re: jack, PREEMPT_DESKTOP, delayed interrupts?
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, Karsten Wiese <annabellesgarden@yahoo.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050928093846.GA30962@elte.hu>
References: <200509262108.55448.annabellesgarden@yahoo.de>
	 <20050928093846.GA30962@elte.hu>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 09:29:07 -0700
Message-Id: <1127924947.24916.1.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 11:38 +0200, Ingo Molnar wrote:
> * Karsten Wiese <annabellesgarden@yahoo.de> wrote:
> 
> > >  latency: 10852 us, #70/70, CPU#0 | (M:preempt VP:0, KP:1, SP:1 HP:1
> 
> > > softirq--8     0Dnh4 9901us : trace_change_sched_cpu (1 0 0)
> > 
> > Maybe your ethernet device is getting in the way.
> > Do you also get jack dropouts with ethernet chip disabled,
> > it's Module unloaded?
> 
> also, the M:preempt suggests that it's not a PREEMPT_RT kernel but a 
> PREEMPT_DESKTOP kernel. Do the dropouts happen even with a PREEMPT_RT 
> kernel?

Last time I tried a PREEMPT_RT (not that long ago) I was not able to
boot into it, it was failing very very early in the boot sequence. I
could try again if it would be valuable. 

-- Fernando


