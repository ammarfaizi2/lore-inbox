Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbUKRWi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUKRWi3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262975AbUKRWiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 17:38:10 -0500
Received: from mail.onestepahead.de ([62.96.100.59]:21737 "EHLO
	mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S261170AbUKRWgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 17:36:18 -0500
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
In-Reply-To: <20041118155411.GB12483@elte.hu>
References: <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu>
	 <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
	 <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
	 <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <1100732223.3472.10.camel@localhost>
	 <20041118155411.GB12483@elte.hu>
Content-Type: text/plain
Date: Thu, 18 Nov 2004 23:33:59 +0100
Message-Id: <1100817239.3476.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-18 at 16:54 +0100, Ingo Molnar wrote:
> * Christian Meder <chris@onestepahead.de> wrote:
> 
> > after successfully running the last couple of rt patches on my Dell
> > Inspiron laptop I thought I'd give it a try on my combined vdr/router
> > box which is probably more interesting from a rt point of view. This
> > box is bridging wireless/ADSL and working as a digital vdr using the
> > kernel DVB-S drivers.
> > 
> > I got the appended logging messages with the appended config.  Is
> > there anything else I should provide for debugging purposes or are the
> > messages just harmless ?
> 
> the messages mean that i havent converted the bridge code's RCU locking
> to PREEMPT_RT yet. I've done this in the -V0.7.28-2 patch that i've just
> uploaded to:
> 
>         http://redhat.com/~mingo/realtime-preempt/
> 
> does bridging work fine with this patch, and if yes, do you get any
> (other) warning messages?

I'm running 0.7.29 now on the vdr/router box and bridging is working
fine and there are no new warning messages.

Thanks,



				Christian

-- 
Christian Meder, email: chris@onestepahead.de

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

