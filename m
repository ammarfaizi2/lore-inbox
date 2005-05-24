Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVEXIWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVEXIWq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 04:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVEXIWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 04:22:20 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60610 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261433AbVEXIPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 04:15:49 -0400
Date: Tue, 24 May 2005 10:15:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Christoph Hellwig <hch@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
Message-ID: <20050524081517.GA22205@elte.hu>
References: <1116890066.13086.61.camel@dhcp153.mvista.com> <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu> <4292DFC3.3060108@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4292DFC3.3060108@yahoo.com.au>
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

> Of course this is weighed off against the improvements added to the
> kernel. I'm personally not too clear on what those improvements are; a
> bit better soft-realtime response? (I don't know) [...]

what the -RT kernel (PREEMPT_RT) offers are guaranteed hard-realtime 
responses. ~15 usecs worst-case latency on a 2GHz Athlon64. On arbitrary 
(SCHED_OTHER) workloads. (I.e. i've measured such worst-case latencies 
when running 1000 hackbench tasks or when swapping the box to death, or 
when running 40 parallel copies of the LTP testsuite.)

so it's well worth the effort, but there's no hurry and all the changes 
are incremental anyway. I can understand Daniel's desire for more action 
(he's got a product to worry about), but upstream isnt ready for this 
yet.

	Ingo
