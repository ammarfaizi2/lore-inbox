Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263342AbUJ2QrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263342AbUJ2QrU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 12:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbUJ2QnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 12:43:16 -0400
Received: from mx2.elte.hu ([157.181.151.9]:43476 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263386AbUJ2Qax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 12:30:53 -0400
Date: Fri, 29 Oct 2004 18:31:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029163155.GA9005@elte.hu>
References: <20041029090957.GA1460@elte.hu> <200410291101.i9TB1uhp002490@localhost.localdomain> <20041029111408.GA28259@elte.hu> <20041029161433.GA6717@elte.hu> <20041029183256.564897b2@mango.fruits.de> <20041029162316.GA7743@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029162316.GA7743@elte.hu>
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

> > > the BKL can generate arbitrary latencies. Anything up to 100-200
> > > milliseconds. Rui, Florian, could you try the quick hack below?
> > 
> > sure, with a fully REALTIME_PREEMPTION kernel?
> 
> correct, and with the changeall-tree hack in addition. And keep your
> finger near the reset button, just in case ...

it wont even boot ...

let me try some more hacks to make this a little bit safer.

	Ingo
