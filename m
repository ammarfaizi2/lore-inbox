Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbUKWTyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbUKWTyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbUKWTwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:52:50 -0500
Received: from brown.brainfood.com ([146.82.138.61]:12160 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S261550AbUKWTv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:51:28 -0500
Date: Tue, 23 Nov 2004 13:50:44 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Mark_H_Johnson@raytheon.com
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-9
In-Reply-To: <OF103A6225.8159BCC7-ON86256F55.006A9C20-86256F55.006A9C62@raytheon.com>
Message-ID: <Pine.LNX.4.58.0411231349360.2242@gradall.private.brainfood.com>
References: <OF103A6225.8159BCC7-ON86256F55.006A9C20-86256F55.006A9C62@raytheon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yOn Tue, 23 Nov 2004,  wrote:

> >i have released the -V0.7.30-9 Real-Time Preemption patch,
>
> The profile script (5 second wait, dump data if wait > 10 seconds) was
> stuck for over 300 seconds & when it woke up there were 34 jobs waiting
> to run. A couple excerpts from the data [will send that separately].
> This was with -V0.7.30-7 (PREEMPT_RT) running latencytest & I believe
> the disk write test (comparing date/time modified of log files...) plus
> a pair of data collecting scripts.

Sounds very similiar to the problem I reported with 29-0.  I left work late
saturday night, arrived back sunday around 11am, and found the machine saying
the time was 1:15am.  I've seen other pauses, were nothing runs.  Hitting a
key causes the machine to start responding/running again.
