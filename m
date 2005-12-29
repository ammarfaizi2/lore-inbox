Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbVL2WMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVL2WMP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 17:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVL2WMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 17:12:15 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:13746 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751060AbVL2WMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 17:12:15 -0500
Subject: Re: [patch] latency tracer, 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20051229202848.GC29546@elte.hu>
References: <1135726300.22744.25.camel@mindpipe>
	 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
	 <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu>
	 <20051229100233.GA12056@redhat.com> <20051229101736.GA2560@elte.hu>
	 <1135887072.6804.9.camel@mindpipe> <1135887966.6804.11.camel@mindpipe>
	 <20051229202848.GC29546@elte.hu>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 17:18:06 -0500
Message-Id: <1135894687.4577.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-29 at 21:28 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > Still does not quite work for me on i386.  I applied all the patches as
> > > I'm using 4K stacks.
> 
> oops!
> 
> > > LD      .tmp_vmlinux1
> > > init/built-in.o: In function `start_kernel':
> > > : undefined reference to `preempt_max_latency'
> > > make: *** [.tmp_vmlinux1] Error 1
> > > 
> > 
> > This patch fixes the problem.
> 
> thanks, applied - new version uploaded.

OK, this works perfectly.  It would be great to see this in "Kernel
Hacking" for 2.6.16...

Lee

