Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUHMLeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUHMLeY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 07:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUHMLeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 07:34:23 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57309 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262605AbUHMLeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 07:34:10 -0400
Date: Fri, 13 Aug 2004 13:35:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc4-O7
Message-ID: <20040813113546.GA17394@elte.hu>
References: <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu> <20040813134101.06568416@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813134101.06568416@mango.fruits.de>
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

> > in -O7 i've added a runtime flag to disable/enable tracing without
> > having to recompile the kernel:
> > 
> >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O7
> 
> I have one question: Are kernel frame pointers required for the
> latency traces? I had frame pointers on in my kernel config but wonder
> if they are nessecary or if i can save the cycles and kb [i'm not too
> big on kernel internals, so forgive the possibly stupid question]?..

-pg requires frame pointers, yes. The Kconfig change i did forces
framepointers on so it's automatic. (gcc bails out with an error on -pg
-fomit-frame-pointer)

> The other thing i wanted to say is: way to go man!! These patches rock
> my linux audio world. A big thank you from me and [probably] the whole
> linux audio community for the work you put into this!

you are welcome!

	Ingo
