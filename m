Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUHBHvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUHBHvo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 03:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266347AbUHBHvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 03:51:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:19600 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266344AbUHBHvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 03:51:42 -0400
Date: Mon, 2 Aug 2004 09:52:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Helge Hafting <helge.hafting@hist.no>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2 didn't link
Message-ID: <20040802075225.GD8332@elte.hu>
References: <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <410DE6B3.2040405@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410DE6B3.2040405@hist.no>
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


* Helge Hafting <helge.hafting@hist.no> wrote:

> >here's the latest version of the voluntary-preempt patch:
> > 
> > http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-O2
> > 
> >
> This didn't link:

>  LD      .tmp_vmlinux1
> init/built-in.o(.text+0x1be): In function `init':
> init/main.c:708: undefined reference to `spawn_irq_threads'
> make: *** [.tmp_vmlinux1] Error 1

hm, the -O2 patch doesnt have any spawn_irq_threads() function. Are you
sure your build is correct?

	Ingo
