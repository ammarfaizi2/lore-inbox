Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbULNLfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbULNLfy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 06:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbULNLfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 06:35:54 -0500
Received: from mx2.elte.hu ([157.181.151.9]:64966 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261487AbULNLft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 06:35:49 -0500
Date: Tue, 14 Dec 2004 12:35:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: "K.R. Foley" <kr@cybsft.com>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       mark_h_johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>, Shane Shrybman <shrybman@aei.ca>,
       Esben Nielsen <simlo@phys.au.dk>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
Message-ID: <20041214113519.GA21790@elte.hu>
References: <OF8AB2B6D9.572374AA-ON86256F66.0061EFA8-86256F66.0061F00A@raytheon.com> <1102897004.31218.8.camel@cmn37.stanford.edu> <20041213064719.GA3681@elte.hu> <1102985171.10967.713.camel@cmn37.stanford.edu> <41BE6F48.3030006@cybsft.com> <58442.195.245.190.94.1103014076.squirrel@195.245.190.94>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58442.195.245.190.94.1103014076.squirrel@195.245.190.94>
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

> Isn't this tightly related to mkinitrd sometimes hanging while on
> mount -o loop, that I've been reporting a couple of times before? It
> used to hang on any other time I do a new kernel install, but latetly
> it seems to be OK (RT-V0.9.32-19 and -20).

yeah, i've added Thomas Gleixner's earlier semaphore->completion
conversion to the loop device, to -19 or -18.

	Ingo
