Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbUKVOrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbUKVOrD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 09:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUKVOob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 09:44:31 -0500
Received: from mx2.elte.hu ([157.181.151.9]:35461 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261400AbUKVOmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 09:42:44 -0500
Date: Mon, 22 Nov 2004 16:45:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Florian Schmidt <mista.tapas@gmx.net>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041122154516.GC2036@elte.hu>
References: <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041122020741.5d69f8bf@mango.fruits.de> <20041122094602.GA6817@elte.hu> <56781.195.245.190.93.1101119801.squirrel@195.245.190.93> <20041122132459.GB19577@elte.hu> <20041122142744.0a29aceb@mango.fruits.de> <65529.195.245.190.94.1101133129.squirrel@195.245.190.94>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65529.195.245.190.94.1101133129.squirrel@195.245.190.94>
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

> > It seems jackd has a limitation to 14 clients atm (don't ask me why). The
> > 15th kills jackd ;)
> >
> 
> So true.

is there any fix for that? Loading 14 jack_test clients only uses up
~33% of CPU time on my testbox. Or should it be possible for me to
trigger xruns using so many clients and 33% CPU utilization already? 

Could you perhaps try 14 instances of jack_test on your box, and see
whether you can generate similar xruns as you could generate with
fluidsynth? jack_test should certainly exclude as much jack-client side
complexity as possible.

	Ingo
