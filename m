Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbUJ0Aqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbUJ0Aqm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbUJ0Aqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:46:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61870 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261588AbUJ0AnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:43:06 -0400
Date: Wed, 27 Oct 2004 02:44:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.3
Message-ID: <20041027004406.GA2607@elte.hu>
References: <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027001542.GA29295@elte.hu>
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


> i have released the -V0.3 Real-Time Preemption patch, which can be
> downloaded from:
> 
> 	http://redhat.com/~mingo/realtime-preempt/
> 
> this is a fixes-only release, but still experimental.

i've uploaded -V0.3.1, it fixes a trivial procfs oversight (related to
the new TASK_RUNNING_MUTEX state) that just triggered a crash in one of
my stresstests.

	Ingo
