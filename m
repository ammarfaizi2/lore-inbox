Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVAONhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVAONhZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 08:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVAONhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 08:37:19 -0500
Received: from mx2.elte.hu ([157.181.151.9]:44008 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262282AbVAONfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 08:35:24 -0500
Date: Sat, 15 Jan 2005 14:34:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>, Bill Huey <bhuey@lnxw.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.11-rc1-V0.7.35-00
Message-ID: <20050115133454.GA8748@elte.hu>
References: <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <20050104064013.GA19528@nietzsche.lynx.com> <20050104094518.GA13868@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104094518.GA13868@elte.hu>
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


i have released the -V0.7.35-00 Real-Time Preemption patch, which can be
downloaded from the usual place:

  http://redhat.com/~mingo/realtime-preempt/

The two dozen split out latency patches (including PREEMPT_BKL) that
were in -mm are in BK now, so i've rebased the -RT patchset to
2.6.11-rc1. It would be nice to check for regressions (or the lack of
them), to make sure everything latency-related has been properly merged
upstream from -mm. (so that a new splitup cycle can start.)

to create a -V0.7.34-00 tree from scratch, the patching order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.10.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.11-rc1.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.11-rc1-V0.7.35-00

	Ingo
