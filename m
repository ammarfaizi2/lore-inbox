Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbULAVah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbULAVah (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 16:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbULAVag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 16:30:36 -0500
Received: from mx1.elte.hu ([157.181.1.137]:4570 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261455AbULAVab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 16:30:31 -0500
Date: Wed, 1 Dec 2004 22:30:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
Message-ID: <20041201213023.GA23470@elte.hu>
References: <48590.195.245.190.94.1101810584.squirrel@195.245.190.94> <20041130131956.GA23451@elte.hu> <17532.195.245.190.94.1101829198.squirrel@195.245.190.94> <20041201103251.GA18838@elte.hu> <32831.192.168.1.5.1101905229.squirrel@192.168.1.5> <20041201154046.GA15244@elte.hu> <20041201160632.GA3018@elte.hu> <20041201162034.GA8098@elte.hu> <33059.192.168.1.5.1101927565.squirrel@192.168.1.5> <20041201212925.GA23410@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041201212925.GA23410@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > Guess what? No XRUNs, not even one to show you a single latency trace.
> > 
> > I'll keep you posted, if anything goes less right than it is :).
> 
> great - it seems the ACPI fix made a difference. If there are no xruns
> then you might want to try the # of engines at which point xruns show
                            ^-- to increase

> up. (can the soundcard period size / buffering be reduced further, to
> make it more sensitive to scheduling latencies?)
