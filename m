Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbULNAsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbULNAsE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 19:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbULNAsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 19:48:04 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:64189 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S261362AbULNArw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 19:47:52 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <20041213064719.GA3681@elte.hu>
References: <OF8AB2B6D9.572374AA-ON86256F66.0061EFA8-86256F66.0061F00A@raytheon.com>
	 <1102897004.31218.8.camel@cmn37.stanford.edu>
	 <20041213064719.GA3681@elte.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1102985171.10967.713.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Dec 2004 16:46:11 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-12 at 22:47, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > Something that just happened to me: running 0.7.32-14
> > (PREEMPT_DESKTOP) and trying to install 0.7.32-19 from a custom built
> > rpm package completely hangs the machine (p4 laptop - I tried twice).
> > No clues left behind. If I boot into 0.7.32-9 I can install 0.7.32-19
> > with no problems. 
> 
> does 0.7.32-19 work better if you reverse (patch -R) the loop.h and
> loop.c bits (see below)?

Running 0.7.32-19 (no changes) I managed to install 0.7.32-20 with no
problems... probably a problem in -14 that was somehow fixed in later
releases. 

-- Fernando


