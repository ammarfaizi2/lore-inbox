Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbUJ3TQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbUJ3TQm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 15:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbUJ3TQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 15:16:41 -0400
Received: from mx2.elte.hu ([157.181.151.9]:42445 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261284AbUJ3TQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 15:16:28 -0400
Date: Sat, 30 Oct 2004 21:17:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041030191725.GA29747@elte.hu>
References: <20041029172243.GA19630@elte.hu> <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu> <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu> <1099086166.1468.4.camel@krustophenia.net> <20041029214602.GA15605@elte.hu> <1099091566.1461.8.camel@krustophenia.net> <20041030115808.GA29692@elte.hu> <1099158570.1972.5.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099158570.1972.5.camel@krustophenia.net>
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

> No, this cannot be the whole story, because unless verbose mode is
> specified, jackd will only prints anything if there is an xrun.  So
> there is something else going on.
> 
> This _really_ feels like a kernel bug.  Are you saying that this could
> still be a jackd problem, even though T3 works perfectly with the
> exact same jackd binary?

i think you are right - there are too many independent indicators
pointing towards some sort of kernel problem. I'll try Florian's testapp
and see whether i can see the 'window wiggle' problem.

	Ingo
