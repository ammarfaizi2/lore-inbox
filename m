Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbUKWM6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbUKWM6O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 07:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUKWM4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 07:56:51 -0500
Received: from mx2.elte.hu ([157.181.151.9]:34211 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261227AbUKWM4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 07:56:08 -0500
Date: Tue, 23 Nov 2004 14:58:40 +0100
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
Message-ID: <20041123135840.GA14674@elte.hu>
References: <20041122005411.GA19363@elte.hu> <20041122020741.5d69f8bf@mango.fruits.de> <20041122094602.GA6817@elte.hu> <56781.195.245.190.93.1101119801.squirrel@195.245.190.93> <20041122132459.GB19577@elte.hu> <20041122142744.0a29aceb@mango.fruits.de> <65529.195.245.190.94.1101133129.squirrel@195.245.190.94> <20041122154516.GC2036@elte.hu> <9182.195.245.190.93.1101142412.squirrel@195.245.190.93> <20041123135508.GA13786@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123135508.GA13786@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> the max CPU load i get here is 46% (your laptop is faster), but no
> xruns. The result of a 5-minute run is:
> 
>  ************* SUMMARY RESULT ****************
>  Timeout Count . . . . . . . . :(    0)
>  XRUN Count  . . . . . . . . . :     0
>  Delay Count (>spare time) . . :     0
>  Delay Count (>1000 usecs) . . :     0
>  Delay Maximum . . . . . . . . :     0   usecs
>  Cycle Maximum . . . . . . . . :  1016   usecs
>  Average DSP Load. . . . . . . :    46.4 %
>  Average CPU System Load . . . :    40.5 %
>  Average CPU User Load . . . . :     2.3 %
>  Average CPU Nice Load . . . . :     0.0 %
>  Average CPU I/O Wait Load . . :     0.0 %
>  Average CPU IRQ Load  . . . . :     0.0 %
>  Average CPU Soft-IRQ Load . . :     0.0 %
>  Average Interrupt Rate  . . . :  2374.1 /sec
>  Average Context-Switch Rate . : 19172.8 /sec

here are the settings i used:

 JACKD_PRIO=20
 JACKD_RATE=44100
 JACKD_PERIOD=64
 JACKD_SECONDS=300
 CLIENT_MAX=14

 jackd 0.99.0

	Ingo
