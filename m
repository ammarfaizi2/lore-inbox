Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbULMATO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbULMATO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 19:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbULMATN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 19:19:13 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:13279 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S262179AbULMAS6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 19:18:58 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: ngo Molnar <mingo@elte.hu>, Mark_H_Johnson@raytheon.com
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <OF8AB2B6D9.572374AA-ON86256F66.0061EFA8-86256F66.0061F00A@raytheon.com>
References: <OF8AB2B6D9.572374AA-ON86256F66.0061EFA8-86256F66.0061F00A@raytheon.com>
Content-Type: text/plain
Organization: 
Message-Id: <1102897004.31218.8.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 Dec 2004 16:16:47 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

logOn Fri, 2004-12-10 at 09:49, Mark_H_Johnson@raytheon.com wrote:
> >The -32-15 kernel can be downloaded from the
> >usual place:
> >
> > http://redhat.com/~mingo/realtime-preempt/
> 
> By the time I started today, the directory had -18 so that is what I built
> with. Here are some initial results from running cpu_delay (the simple
> RT test / user tracing) on a -18 PREEMPT_RT kernel. Have not started
> any of the stress tests yet.

Something that just happened to me: running 0.7.32-14 (PREEMPT_DESKTOP)
and trying to install 0.7.32-19 from a custom built rpm package
completely hangs the machine (p4 laptop - I tried twice). No clues left
behind. If I boot into 0.7.32-9 I can install 0.7.32-19 with no
problems. 

-- Fernando


