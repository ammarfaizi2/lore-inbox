Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbULOJJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbULOJJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 04:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbULOJJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 04:09:39 -0500
Received: from mx2.elte.hu ([157.181.151.9]:47793 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262277AbULOJJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 04:09:25 -0500
Date: Wed, 15 Dec 2004 10:09:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
Message-ID: <20041215090900.GC13551@elte.hu>
References: <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <1103066516.12659.377.camel@cmn37.stanford.edu> <1103072952.17186.0.camel@krustophenia.net> <1103076261.12657.709.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103076261.12657.709.camel@cmn37.stanford.edu>
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


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> On Tue, 2004-12-14 at 17:09, Lee Revell wrote:
> > On Tue, 2004-12-14 at 15:21 -0800, Fernando Lopez-Lezcano wrote:
> > > I don't know which change did it, but I have network connectivity in my
> > > athlon64 test box with 0.7.33-0! Woohoo! [*]
> > 
> > Wait, this works on x84-64 now?  There was a recent report on LAU that
> > it didn't compile.
> 
> The machine has an athlon64 but it is running 32 bit fc2. I have not
> tried to build (yet) on 64 bit fcx.

x64 wont work for now, it needs some work to make threaded timer IRQs
work.

	Ingo
