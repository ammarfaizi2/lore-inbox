Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263132AbUKTR5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbUKTR5x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 12:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUKTR5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 12:57:52 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6530 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263132AbUKTR5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 12:57:51 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
In-Reply-To: <20041120125536.GC8091@elte.hu>
References: <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
	 <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
	 <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
	 <20041118164612.GA17040@elte.hu> <1100920963.1424.1.camel@krustophenia.net>
	 <20041120125536.GC8091@elte.hu>
Content-Type: text/plain
Date: Sat, 20 Nov 2004 12:19:00 -0500
Message-Id: <1100971141.6879.18.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-20 at 13:55 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Thu, 2004-11-18 at 17:46 +0100, Ingo Molnar wrote:
> > > i have released the -V0.7.29-0 Real-Time Preemption patch, which can be
> > > downloaded from the usual place:
> > > 
> > > 	http://redhat.com/~mingo/realtime-preempt/
> > 
> > I tried this with CONFIG_PREEMPT_VOLUNTARY (which should theoretically
> > work like the earlier VP patches, right?) to test for regressions. 
> > The boot process hung after initializing my IDE controller.
> 
> which patch did you try? I fixed the 'lower' preemption levels in
> -V0.7.29-4, earlier kernels are broken.
> 

This was the version I tried.  I will try to provide some more info.

Lee

