Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbVL2U3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbVL2U3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 15:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbVL2U3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 15:29:12 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:62953 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750960AbVL2U3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 15:29:11 -0500
Date: Thu, 29 Dec 2005 21:28:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] latency tracer, 2.6.15-rc7
Message-ID: <20051229202848.GC29546@elte.hu>
References: <1135726300.22744.25.camel@mindpipe> <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com> <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu> <20051229100233.GA12056@redhat.com> <20051229101736.GA2560@elte.hu> <1135887072.6804.9.camel@mindpipe> <1135887966.6804.11.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135887966.6804.11.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> > Still does not quite work for me on i386.  I applied all the patches as
> > I'm using 4K stacks.

oops!

> > LD      .tmp_vmlinux1
> > init/built-in.o: In function `start_kernel':
> > : undefined reference to `preempt_max_latency'
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> 
> This patch fixes the problem.

thanks, applied - new version uploaded.

	Ingo
