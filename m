Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270875AbUJVI0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270875AbUJVI0C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 04:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270342AbUJVIY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 04:24:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64726 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269837AbUJVIMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 04:12:33 -0400
Date: Fri, 22 Oct 2004 10:13:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: Bill Huey <bhuey@lnxw.com>, Thomas Gleixner <tglx@linutronix.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041022081340.GA14309@elte.hu>
References: <1098352441.26758.30.camel@thomas> <20041021101103.GC10531@suse.de> <20041021195842.GA23864@nietzsche.lynx.com> <20041021201443.GF32465@suse.de> <20041021202422.GA24555@nietzsche.lynx.com> <20041021203350.GK32465@suse.de> <20041021203821.GA24628@nietzsche.lynx.com> <20041022061901.GM32465@suse.de> <20041022072908.GC10908@elte.hu> <20041022080110.GG1820@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022080110.GG1820@suse.de>
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


* Jens Axboe <axboe@suse.de> wrote:

> I fully agree with everything in your mail so far. What annoyed me is
> some people advocating their changes under the false pretense that
> existing use was broken, which it isn't.

yeah, and i have to say that such advocacy mostly comes from the natural
desire to solve those _other_ problems that non-standard locking designs
have with Linux mutexes. But those problems are that of the other trees
alone, not upstream's :) Suggesting that those problems are in any way
upstream's problem, even if well-intentioned, can be quite offensive.

> completions _do_ make cleaner code for the intended case. But your
> writing above is very clear and already explains that very well.
> 
> Lets put the issue to rest and get back to more productive work!

/me rejoices :)

	Ingo
