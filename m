Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUIOLwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUIOLwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 07:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUIOLwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 07:52:11 -0400
Received: from mx2.elte.hu ([157.181.151.9]:4260 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265222AbUIOLwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 07:52:06 -0400
Date: Wed, 15 Sep 2004 13:17:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040915111756.GA5150@elte.hu>
References: <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au> <20040914150316.GN4180@dualathlon.random> <1095210126.2406.70.camel@krustophenia.net> <20040915013925.GF9106@holomorphy.com> <1095214289.2406.101.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095214289.2406.101.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Ingo, if you want to send me a patch set without the more
> controversial changes, I can compare the performance.  A diff against
> the latest VP patch would be OK.

just undo the tty.c changes. (i.e. manually remove the tty.c chunks from
the -S0 patch and apply the result.)

	Ingo
