Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbULOQv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbULOQv3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 11:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbULOQv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 11:51:28 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:2268 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262390AbULOQvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 11:51:23 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       linux-kernel@vger.kernel.org, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20041215090900.GC13551@elte.hu>
References: <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu>
	 <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu>
	 <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu>
	 <20041214132834.GA32390@elte.hu>
	 <1103066516.12659.377.camel@cmn37.stanford.edu>
	 <1103072952.17186.0.camel@krustophenia.net>
	 <1103076261.12657.709.camel@cmn37.stanford.edu>
	 <20041215090900.GC13551@elte.hu>
Content-Type: text/plain
Date: Wed, 15 Dec 2004 11:51:21 -0500
Message-Id: <1103129482.18982.41.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 10:09 +0100, Ingo Molnar wrote:
> x64 wont work for now, it needs some work to make threaded timer IRQs
> work.

But the timer IRQ can only be threaded with PREEMPT_RT, right?  Seems
like PREEMPT_DESKTOP should work.  Older VP patches worked on x64 (S7,
T3) IIRC.

Lee

