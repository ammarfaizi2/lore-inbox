Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbUKQMIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbUKQMIQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 07:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbUKQMGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 07:06:42 -0500
Received: from mx2.elte.hu ([157.181.151.9]:48800 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262285AbUKQMF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 07:05:59 -0500
Date: Wed, 17 Nov 2004 14:02:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: john cooper <john.cooper@timesys.com>, "K.R. Foley" <kr@cybsft.com>,
       Mark_H_Johnson@raytheon.com, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Stefan Schweizer <sschweizer@gmail.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Message-ID: <20041117130236.GA28240@elte.hu>
References: <20041116212401.GA16845@elte.hu> <20041116222039.662f41ac@mango.fruits.de> <20041116223243.43feddf4@mango.fruits.de> <20041116224257.GB27550@elte.hu> <20041116230443.452497b9@mango.fruits.de> <20041116231145.GC31529@elte.hu> <20041116235535.6867290d@mango.fruits.de> <20041117002926.32a4b26f@mango.fruits.de> <419A961A.2070005@timesys.com> <20041117122318.479805fa@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117122318.479805fa@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> > Was this random or under some particular stress/load?
> 
> I had rtc_wakeup running with a rtc frequency of 8192 hz at the time
> plus some general usage (reading mails, etc..) In earlier kernels it
> seemed that the lock fell together with the rtc IRQ being piggy. will
> try to reproduce now with the freshest RP kernel.

could you send me the latest .config you are using on this box?

	Ingo
