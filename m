Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVAGTkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVAGTkm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVAGTjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:39:46 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:13713 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261545AbVAGTgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:36:31 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-mm1-V0.7.34-00
From: Lee Revell <rlrevell@joe-job.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, Bill Huey <bhuey@lnxw.com>,
       linux-kernel@vger.kernel.org, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20050107192651.GG5259@smtp.west.cox.net>
References: <20041118164612.GA17040@elte.hu>
	 <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu>
	 <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu>
	 <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu>
	 <20041214132834.GA32390@elte.hu>
	 <20050104064013.GA19528@nietzsche.lynx.com>
	 <20050104094518.GA13868@elte.hu>  <20050107192651.GG5259@smtp.west.cox.net>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 14:36:27 -0500
Message-Id: <1105126587.20278.23.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 12:26 -0700, Tom Rini wrote:
> Here's a handful of little things to fix issues in the patch for when
> you try and use the patchset on an architecture that doesn't (yet) work.

Speaking of which, I guess no one ever stepped up & fixed the patch for
x86_64?  AFAICT it should not be too hard to get PREEMPT_DESKTOP
working, as the previous VP patch sets worked, then the timer interrupt
threading changes broke it.  But you can't thread the timer irq with
PREEMPT_DESKTOP anyway.

Unfortunately I can only offer moral support as I don't have the
hardware...

Lee 

