Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUKRXCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUKRXCo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 18:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUKRXCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 18:02:41 -0500
Received: from mail.onestepahead.de ([62.96.100.59]:46570 "EHLO
	mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S263005AbUKRWyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 17:54:16 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-1
From: Christian Meder <chris@onestepahead.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
In-Reply-To: <20041118210517.GA8703@elte.hu>
References: <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu>
	 <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu>
	 <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu>
	 <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu>
	 <20041118123521.GA29091@elte.hu>
	 <49222.195.245.190.94.1100789179.squirrel@195.245.190.94>
	 <20041118210517.GA8703@elte.hu>
Content-Type: text/plain
Date: Thu, 18 Nov 2004 23:54:08 +0100
Message-Id: <1100818448.3476.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-18 at 22:05 +0100, Ingo Molnar wrote:
> * Rui Nuno Capela <rncbc@rncbc.org> wrote:
> 
> > I'm still seeing this sometimes (not everytime) on my P4/UP laptop
> > while shutting down ALSA modules. This isn't the same as the lockup
> > I've been reporting lately (that happens on my P4/SMT desktop) but may
> > be remotely related.
> 
> could you (and Christian) try the patch below, ontop of a current-ish
> tree - does the unload crash still occur? (this is an earlier cleanup
> patch from Thomas Gleixner, but it could fix a real PREEMPT_RT bug in
> this particular case.)

This patch on top of 0.7.29-0 fixes the prism pccard unload crash on my
Dell laptop.

This just leaves me with the mysterious traceless jvm related crash.
I'll do my best to get a trace ;-)

Thanks,


				Christian

-- 
Christian Meder, email: chris@onestepahead.de

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

