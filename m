Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbULDWrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbULDWrX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 17:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbULDWrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 17:47:23 -0500
Received: from mx1.elte.hu ([157.181.1.137]:38584 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261186AbULDWrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 17:47:09 -0500
Date: Sat, 4 Dec 2004 23:46:41 +0100
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
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-0
Message-ID: <20041204224641.GA14850@elte.hu>
References: <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <32786.192.168.1.5.1102199522.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32786.192.168.1.5.1102199522.squirrel@192.168.1.5>
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

> Ingo Molnar wrote:
> >
> > i have released the -V0.7.32-0 Real-Time Preemption patch, which can be
> > downloaded from the usual place:
> >
> 
> I have a bug to report, it shows on both of my machines (SMP and UP)
> now running RT-V0.7.32-2. It seems to be present also on previous RT
> releases, and don't even know if it's upstream.
> 
> When one usb-storage flash stick is first time unplugged:

hm, doesnt seem to be directly related to -RT. Could you try the vanilla
-rc2-mm3 kernel, does it trigger there too?

	Ingo
