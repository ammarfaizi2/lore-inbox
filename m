Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWAFU3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWAFU3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWAFU3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:29:03 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:5345 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932247AbWAFU3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:29:01 -0500
Subject: Re: [patch] latency tracer, 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20051229082217.GA23052@elte.hu>
References: <1135726300.22744.25.camel@mindpipe>
	 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
	 <1135814419.7680.13.camel@mindpipe>  <20051229082217.GA23052@elte.hu>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 15:28:58 -0500
Message-Id: <1136579339.17979.67.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-29 at 09:22 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > I'm not sure how much work it would be to break out 
> > CONFIG_LATENCY_TRACE as a separate patch.
> 
> could you check out the 2.6.15-rc7 version of the latency tracer i 
> uploaded to:
> 
> 	http://redhat.com/~mingo/latency-tracing-patches/
> 
> could test it by e.g. trying to reproduce the same VM latency as in the 
> -rt tree. [the two zlib patches are needed if you are using 4K stacks, 
> mcount increases stack footprint.]

Ingo,

Would you mind submitting this for 2.6.16?  We already have one case
where it would have caught a regression in time for 2.6.15, so IMHO this
would be a great addition to "Kernel hacking".

I have had absolutely no problems running this with 2.6.15-rc7, it works
perfectly, as it has in the -rt tree for ages.

Lee 

