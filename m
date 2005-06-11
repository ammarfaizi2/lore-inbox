Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVFKOzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVFKOzA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 10:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVFKOzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 10:55:00 -0400
Received: from mx1.elte.hu ([157.181.1.137]:6279 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261718AbVFKOy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 10:54:58 -0400
Date: Sat, 11 Jun 2005 16:52:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
Message-ID: <20050611145240.GA10881@elte.hu>
References: <42AA6A6B.5040907@opersys.com> <20050611070845.GA4609@elte.hu> <42AAF5CE.9080607@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AAF5CE.9080607@opersys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karim Yaghmour <karim@opersys.com> wrote:

> Ingo Molnar wrote:
> > could you send me the .config you used for the PREEMPT_RT tests? Also, 
> > you used -47-08, which was well prior the current round of performance 
> > improvements, so you might want to re-run with something like -48-06 or 
> > better.
> 
> Much to our dislike, we only noticed that we forgot to disable the 
> debug options after posting the results :/ So, in all fairness, we 
> will be redoing the tests on PREEMPT_RT early next week. [...]

yeah, i suspected something like that - the PREEMPT_RT latency numbers 
were so out of whack with anything i've measured on similar boxes. The 
debugging features on PREEMPT_RT are powerful but have a high overhead.

could you send me your PREEMPT_RT .config? (whichever version you have 
handy) That's the easiest way i can tell you which options to watch out 
for.

	Ingo
