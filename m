Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbVL2IWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbVL2IWg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 03:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbVL2IWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 03:22:36 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:14784 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965053AbVL2IWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 03:22:35 -0500
Date: Thu, 29 Dec 2005 09:22:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [patch] latency tracer, 2.6.15-rc7
Message-ID: <20051229082217.GA23052@elte.hu>
References: <1135726300.22744.25.camel@mindpipe> <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com> <1135814419.7680.13.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135814419.7680.13.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> I'm not sure how much work it would be to break out 
> CONFIG_LATENCY_TRACE as a separate patch.

could you check out the 2.6.15-rc7 version of the latency tracer i 
uploaded to:

	http://redhat.com/~mingo/latency-tracing-patches/

could test it by e.g. trying to reproduce the same VM latency as in the 
-rt tree. [the two zlib patches are needed if you are using 4K stacks, 
mcount increases stack footprint.]

	Ingo
