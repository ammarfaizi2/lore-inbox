Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbUKVMYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbUKVMYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 07:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUKVMSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 07:18:12 -0500
Received: from mx1.elte.hu ([157.181.1.137]:25736 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262076AbUKVMRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 07:17:19 -0500
Date: Mon, 22 Nov 2004 14:19:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: Christian Meder <chris@onestepahead.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-1
Message-ID: <20041122131935.GA19577@elte.hu>
References: <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <49222.195.245.190.94.1100789179.squirrel@195.245.190.94> <20041118210517.GA8703@elte.hu> <1100818448.3476.17.camel@localhost> <20041119095451.GC27642@elte.hu> <1101115860.4182.7.camel@localhost> <20041122094401.GA7271@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122094401.GA7271@nietzsche.lynx.com>
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


* Bill Huey <bhuey@lnxw.com> wrote:

> Also, CC the Sun/Blackdown folks about this. It could very well be
> some kind of NPTL glue problem triggering.

i'd suggest to not yet bother any upstream folks at this point, this
could easily be an -RT related bug. Hard kernel lockups are almost
always -RT's fault.

	Ingo
