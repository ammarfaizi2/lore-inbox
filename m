Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbUK3IQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbUK3IQZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 03:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUK3IQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 03:16:25 -0500
Received: from mx2.elte.hu ([157.181.151.9]:8413 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262012AbUK3IQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 03:16:22 -0500
Date: Tue, 30 Nov 2004 09:15:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Remi Colinet <remi.colinet@free.fr>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
Message-ID: <20041130081548.GA8707@elte.hu>
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <20041129111634.GB10123@elte.hu> <41ACB846.40400@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ACB846.40400@free.fr>
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


* Remi Colinet <remi.colinet@free.fr> wrote:

> Hi Ingo,
> 
> I'm getting this error with V0.7.31-13

> CC kernel/latency.o
> kernel/latency.c: In function `check_critical_timing':
> kernel/latency.c:730: too few arguments to function `___trace'
> kernel/latency.c:730: warning: too few arguments passed to inline 

fixed this in -V0.7.31-14.

	Ingo
