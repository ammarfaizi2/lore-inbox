Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbUKBTe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbUKBTe6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 14:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbUKBTe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 14:34:58 -0500
Received: from mx2.elte.hu ([157.181.151.9]:4584 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261343AbUKBTet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 14:34:49 -0500
Date: Tue, 2 Nov 2004 20:35:55 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
Message-ID: <20041102193555.GA2987@elte.hu>
References: <1099227269.1459.45.camel@krustophenia.net> <1099324040.3337.32.camel@thomas> <20041102150634.GA24871@elte.hu> <200411021624.45378.norberto+linux-kernel@bensa.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411021624.45378.norberto+linux-kernel@bensa.ath.cx>
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


* Norberto Bensa <norberto+linux-kernel@bensa.ath.cx> wrote:

> Ingo Molnar wrote:
> > i've uploaded a fixed kernel (-V0.6.8) to:
> >
> >   http://redhat.com/~mingo/realtime-preempt/
> 
> Doesn't compile:
> 
>   CC [M]  fs/lockd/svc.o
> fs/lockd/svc.c:49: warning: type defaults to `int' in declaration of 
> `DECLARE_MUTEX_NOCHECK'

ok - the reason was this:

> # CONFIG_PREEMPT_REALTIME is not set

i fixed these build problems in the -V0.6.9 patch i just uploaded.

	Ingo
