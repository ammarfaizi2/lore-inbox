Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVADKtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVADKtU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 05:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVADKtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 05:49:20 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:12298 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S261731AbVADKtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 05:49:07 -0500
Date: Tue, 4 Jan 2005 02:48:30 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-mm1-V0.7.34-00
Message-ID: <20050104104830.GA20393@nietzsche.lynx.com>
References: <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <20050104064013.GA19528@nietzsche.lynx.com> <20050104094518.GA13868@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104094518.GA13868@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 10:45:18AM +0100, Ingo Molnar wrote:
> this is mainly a straight port from 2.6.10-rc3-mm1 to 2.6.10-mm1, plus i
> picked up a post-2.6.10-mm1 audio-driver buildsystem fix-patch. Please
> (re-)report any new or old regressions.

Build failure.

  LD      arch/i386/kernel/cpu/mcheck/built-in.o
  kernel/time.c: In function `sys_gettimeofday':
  kernel/time.c:164: error: parse error before ')' token
  distcc[2235] ERROR: compile kernel/time.c on localhost failed
  make[1]: *** [kernel/time.o] Error 1
  make[1]: *** Waiting for unfinished jobs....
    CC      mm/truncate.o

bill

