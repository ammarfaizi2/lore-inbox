Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbUKRPKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbUKRPKM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 10:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbUKRPKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 10:10:12 -0500
Received: from mx1.elte.hu ([157.181.1.137]:37000 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262110AbUKRPKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 10:10:05 -0500
Date: Thu, 18 Nov 2004 17:11:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christian Meder <chris@onestepahead.de>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-0
Message-ID: <20041118161129.GD12483@elte.hu>
References: <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <1100773441.3434.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100773441.3434.4.camel@localhost>
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


* Christian Meder <chris@onestepahead.de> wrote:

> On Wed, 2004-11-17 at 13:42 +0100, Ingo Molnar wrote:
> > i have released the -V0.7.28-0 Real-Time Preemption patch, which can be
> > downloaded from the usual place:
> > 
> > 	http://redhat.com/~mingo/realtime-preempt/
> > 
> > this is a fixes & latency-reduction release.
> 
> Hi,
> 
> here's another message log this time on my Dell laptop when removing
> my prism wlan pccard running the hostap driver.

could you try this with the vanilla 2.6.10-rc2-mm1 kernel too? The crash
you got is an escallation of a crash within a critical section, but that
original crash does not seem to be directly related to PREEMPT_RT.

(also, please enable CONFIG_USE_FRAME_POINTER, to make the backtraces
easier to parse.)

	Ingo
