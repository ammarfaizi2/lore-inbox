Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946694AbWKJOtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946694AbWKJOtw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 09:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946696AbWKJOtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 09:49:52 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:26551 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1946694AbWKJOtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 09:49:51 -0500
Date: Fri, 10 Nov 2006 15:49:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 1/5] Fix timeout bug in rtmutex in 2.6.18-rt
Message-ID: <20061110144916.GA19152@elte.hu>
References: <20061001112829.630288000@frodo> <Pine.LNX.4.64.0610011336400.29459@frodo.shire>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610011336400.29459@frodo.shire>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <nielsen.esben@googlemail.com> wrote:

>  include/linux/init_task.h |    1
>  include/linux/sched.h     |   62 
>  kernel/sched.c            |   29 +++++++++++++++++----

what kernel tree is this supposed to be against? Neither vanilla nor 
-rt7 2.6.18 works:

 Hunk #1 FAILED at 91.
 1 out of 1 hunk FAILED -- rejects in file include/linux/init_task.h
 patching file include/linux/sched.h
 Hunk #1 FAILED at 928.
 Hunk #2 FAILED at 1330.
 2 out of 2 hunks FAILED -- rejects in file include/linux/sched.h
 patching file kernel/sched.c
 Hunk #1 succeeded at 157 with fuzz 2 (offset -7 lines).
 Hunk #2 FAILED at 700.
 Hunk #3 FAILED at 774.
 Hunk #4 FAILED at 792.
 Hunk #5 FAILED at 1475.
 4 out of 5 hunks FAILED -- rejects in file kernel/sched.c

	Ingo
