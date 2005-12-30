Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbVL3SvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbVL3SvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 13:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVL3SvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 13:51:04 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:59373 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751282AbVL3SvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 13:51:03 -0500
Subject: Re: [patch] latency tracer, 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20051230080032.GA26152@elte.hu>
References: <1135726300.22744.25.camel@mindpipe>
	 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
	 <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu>
	 <20051229100233.GA12056@redhat.com> <20051229101736.GA2560@elte.hu>
	 <1135887072.6804.9.camel@mindpipe> <1135887966.6804.11.camel@mindpipe>
	 <20051229202848.GC29546@elte.hu> <1135908980.4568.10.camel@mindpipe>
	 <20051230080032.GA26152@elte.hu>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 13:51:01 -0500
Message-Id: <1135968661.31111.13.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 09:00 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > It seems that debug_smp_processor_id is being called a lot, even 
> > though I have a UP config, which I didn't see with the -rt kernel:
> 
> do you have CONFIG_DEBUG_PREEMPT enabled? (if yes then disable it)

Ah, thanks, I had assumed that the latency tracing depended on this.

Lee

