Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946747AbWKJQSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946747AbWKJQSA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946752AbWKJQSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:18:00 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:28069 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1946747AbWKJQR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:17:59 -0500
Date: Fri, 10 Nov 2006 17:16:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 1/5] Fix timeout bug in rtmutex in 2.6.18-rt
Message-ID: <20061110161657.GA19407@elte.hu>
References: <20061001112829.630288000@frodo> <Pine.LNX.4.64.0610011336400.29459@frodo.shire> <20061110144916.GA19152@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061110144916.GA19152@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Esben Nielsen <nielsen.esben@googlemail.com> wrote:
> 
> >  include/linux/init_task.h |    1
> >  include/linux/sched.h     |   62 
> >  kernel/sched.c            |   29 +++++++++++++++++----
> 
> what kernel tree is this supposed to be against? Neither vanilla nor 
> -rt7 2.6.18 works:

ah, whitespace damage ... every line in the patch has an extra space 
character in front of it.

	Ingo
