Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262734AbUJ0VDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbUJ0VDP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbUJ0Uzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:55:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:31442 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262619AbUJ0UuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:50:16 -0400
Date: Wed, 27 Oct 2004 22:51:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
Message-ID: <20041027205126.GA25091@elte.hu>
References: <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <5225.195.245.190.94.1098880980.squirrel@195.245.190.94> <20041027135309.GA8090@elte.hu> <12917.195.245.190.94.1098890763.squirrel@195.245.190.94>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12917.195.245.190.94.1098890763.squirrel@195.245.190.94>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> On RT-V0.4.1, xruns seems slighly reduced, but plenty enough for my
> taste.
> 
> Running jackd -R with 6 fluidsynth instances gives me 0 (zero) xruns
> on RT-U3, but more than 20 (twenty) on RT-V0.4.1, under a 5 minute
> time frame. It was 30 (thirty something) on RT-V0.4, but overall
> "feel" is about the same.

ok, i've uploaded RT-V0.4.2 which has more of the same: it fixes other
missed preemption checks. Does it make any difference to the xruns on
your UP box?

	Ingo
