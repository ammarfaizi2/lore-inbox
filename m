Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVDEIKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVDEIKK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVDEIHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 04:07:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10630 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261619AbVDEH73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:59:29 -0400
Date: Tue, 5 Apr 2005 09:59:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050405075901.GA26401@elte.hu>
References: <20050405000524.592fc125.akpm@osdl.org> <42523F5D.7020201@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42523F5D.7020201@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Andrew Morton wrote:
> 
> >+sched-remove-unnecessary-sched-domains.patch
> >+sched-improve-pinned-task-handling-again.patch
> [snip]
> >
> > CPU scheduler updates
> >
> 
> It is no problem that you picked these up for testing. But
> don't merge them yet, please.

almost all current scheduler patches in -mm are post-2.6.12 items and
are conditional on testing feedback from the big boxes, but otherwise
have my conceptual ack. The only trivial one that would be fine for
2.6.12 is sched-uninline-task_timeslice.patch.

	Ingo
