Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269870AbUJTN2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269870AbUJTN2w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 09:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270199AbUJTN0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 09:26:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64691 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269870AbUJTNXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 09:23:42 -0400
Date: Wed, 20 Oct 2004 15:24:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041020132459.GA13666@elte.hu>
References: <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041020145019.176826cb@mango.fruits.de> <20041020125500.GA8693@elte.hu> <20041020152507.3c167ca8@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020152507.3c167ca8@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> > i dont think it's caused by trace_enabled - the trace you sent last time
> > clearly showed erratic behavior. There's one piece of code i suspect in
> > particular - could you try the patch below ontop of -U8? (i have
> > compile- and boot- tested it)
> 
> mango:/usr/src/linux-2.6.9-rc4-mm1-U8# patch -p1 </home/tapas/foo.patch 
> patching file kernel/sched.c
> Hunk #5 succeeded at 3843 with fuzz 1.
> 
> building anyways, reporting later..

never worry about a fuzz when applying patches - as long as you dont get
a reject it should be ok.

	Ingo
