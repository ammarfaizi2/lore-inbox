Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVBAURs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVBAURs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 15:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVBAURs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 15:17:48 -0500
Received: from mx2.elte.hu ([157.181.151.9]:27553 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262118AbVBAURj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 15:17:39 -0500
Date: Tue, 1 Feb 2005 21:17:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Tom Rini <trini@kernel.crashing.org>, Bill Huey <bhuey@lnxw.com>,
       linux-kernel@vger.kernel.org, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.36-04
Message-ID: <20050201201704.GA32139@elte.hu>
References: <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <20050104064013.GA19528@nietzsche.lynx.com> <20050104094518.GA13868@elte.hu> <20050107192651.GG5259@smtp.west.cox.net> <20050126080952.GC4771@elte.hu> <1107288076.18349.7.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107288076.18349.7.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> Assuming it's still available, what is the config option to get the
> "User-space atomicity debugging" feature?  This feature is extremely
> useful for debugging complex JACK clients, several Linux audio
> developers have asked me about it but I can't find the config option
> anymore.

it's always-on in the -RT tree (it's a pretty low-overhead thing). I
havent changed the mechanism so the jackd hacks from a couple of weeks
ago should still work.

	Ingo
