Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVBAUbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVBAUbW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 15:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbVBAUbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 15:31:21 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:20131 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261532AbVBAUbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 15:31:19 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.36-04
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Tom Rini <trini@kernel.crashing.org>, Bill Huey <bhuey@lnxw.com>,
       linux-kernel@vger.kernel.org, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20050201201704.GA32139@elte.hu>
References: <20041124101626.GA31788@elte.hu>
	 <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu>
	 <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu>
	 <20050104064013.GA19528@nietzsche.lynx.com>
	 <20050104094518.GA13868@elte.hu> <20050107192651.GG5259@smtp.west.cox.net>
	 <20050126080952.GC4771@elte.hu> <1107288076.18349.7.camel@krustophenia.net>
	 <20050201201704.GA32139@elte.hu>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 15:31:18 -0500
Message-Id: <1107289878.18349.20.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 21:17 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Assuming it's still available, what is the config option to get the
> > "User-space atomicity debugging" feature?  This feature is extremely
> > useful for debugging complex JACK clients, several Linux audio
> > developers have asked me about it but I can't find the config option
> > anymore.
> 
> it's always-on in the -RT tree (it's a pretty low-overhead thing). I
> havent changed the mechanism so the jackd hacks from a couple of weeks
> ago should still work.
> 

OK.  So for application triggered tracing you need 
LATENCY_TRACING enabled, as described here:

http://lkml.org/lkml/2004/10/29/312

Lee

