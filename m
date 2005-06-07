Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVFGTFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVFGTFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 15:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVFGTFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 15:05:43 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43706 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261958AbVFGTFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 15:05:38 -0400
Date: Tue, 7 Jun 2005 21:05:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-20
Message-ID: <20050607190506.GB9904@elte.hu>
References: <20050607110409.GA14613@elte.hu> <Pine.OSF.4.05.10506071638130.28240-100000@da410.phys.au.dk> <20050607160400.GA9904@elte.hu> <1118165405.13708.57.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118165405.13708.57.camel@twins>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> On Tue, 2005-06-07 at 18:04 +0200, Ingo Molnar wrote:
> 
> > thanks - i've applied it and have released the -47-27 patch with this 
> > fix included.
> 
> In how bad a shape is ALL_TASKS_PI in that patch?

it hasnt been used with the plist code at all.

> And is your TASK_NONINTERACTIVE patch needed with -RT kernels?; it 
> doesn't apply cleanly but I guess I can manage to get it in; it's only 
> a few lines of code anyway ;-)

the delayed-preemption feature in the -RT kernel has a similar effect, 
so it should not be needed.

	Ingo
