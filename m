Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbUKRQln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbUKRQln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 11:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbUKRQln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 11:41:43 -0500
Received: from mail.onestepahead.de ([62.96.100.59]:51367 "EHLO
	mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S261866AbUKRQlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 11:41:40 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-0
From: Christian Meder <chris@onestepahead.de>
To: Ingo Molnar <mingo@elte.hu>
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
In-Reply-To: <20041118161129.GD12483@elte.hu>
References: <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu>
	 <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
	 <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
	 <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <1100773441.3434.4.camel@localhost>
	 <20041118161129.GD12483@elte.hu>
Content-Type: text/plain
Date: Thu, 18 Nov 2004 17:39:24 +0100
Message-Id: <1100795964.3699.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-18 at 17:11 +0100, Ingo Molnar wrote:
> * Christian Meder <chris@onestepahead.de> wrote:
> 
> > On Wed, 2004-11-17 at 13:42 +0100, Ingo Molnar wrote:
> > > i have released the -V0.7.28-0 Real-Time Preemption patch, which can be
> > > downloaded from the usual place:
> > > 
> > > 	http://redhat.com/~mingo/realtime-preempt/
> > > 
> > > this is a fixes & latency-reduction release.
> > 
> > Hi,
> > 
> > here's another message log this time on my Dell laptop when removing
> > my prism wlan pccard running the hostap driver.
> 
> could you try this with the vanilla 2.6.10-rc2-mm1 kernel too? The crash
> you got is an escallation of a crash within a critical section, but that
> original crash does not seem to be directly related to PREEMPT_RT.

Ok, tried it now. The output from 2.6.10-rc2-mm1 on removal of the prism
pccard is pretty innocuous and everything works fine:

Nov 18 17:29:27 localhost kernel: hostap_cs: CS_EVENT_CARD_REMOVAL
Nov 18 17:29:27 localhost kernel: wifi0: card already removed or not
configured during shutdown
Nov 18 17:29:27 localhost kernel: wifi0: Interrupt, but dev not OK
Nov 18 17:29:27 localhost kernel: hostap_cs: Driver unloaded


				Christian

-- 
Christian Meder, email: chris@onestepahead.de

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

