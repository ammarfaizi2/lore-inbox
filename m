Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbVLaAU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVLaAU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 19:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVLaAU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 19:20:27 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:14021 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750830AbVLaAUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 19:20:25 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: gcoady@gmail.com, Lee Revell <rlrevell@joe-job.com>,
       Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] latency tracer, 2.6.15-rc7
Date: Sat, 31 Dec 2005 11:20:06 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <v3ibr1ddh00abk9p67t22vufg8prch24ba@4ax.com>
References: <1135726300.22744.25.camel@mindpipe> <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com> <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu> <20051229100233.GA12056@redhat.com> <20051229101736.GA2560@elte.hu> <1135887072.6804.9.camel@mindpipe> <1135887966.6804.11.camel@mindpipe> <20051229202848.GC29546@elte.hu> <u8u8r1ttmtubpvd87sf9mq4fi2of0l6js4@4ax.com> <20051230080914.GA26643@elte.hu>
In-Reply-To: <20051230080914.GA26643@elte.hu>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Dec 2005 09:09:14 +0100, Ingo Molnar <mingo@elte.hu> wrote:

>
>* Grant Coady <grant_lkml@dodo.com.au> wrote:
>
>> On Thu, 29 Dec 2005 21:28:48 +0100, Ingo Molnar <mingo@elte.hu> wrote:
>> 
>> >
>> >thanks, applied - new version uploaded.
>> 
>> I just booted with latency tracer, it died with (copy by hand):
>> {   40} [<c012e74a>] debug_stackoverflow+0x6a/0xc0
>> 
>> Much unusual stuff (several screenfuls) scrolled up prior to lockup.
>
>have you applied the zlib patches too? In particular this one should 
>make a difference:
>
>    http://redhat.com/~mingo/latency-tracing-patches/patches/reduce-zlib-stack-hack.patch

Yes, that was applied (well, trying to apply it asks me to reverse it :)

>If you didnt have this applied, could you apply it and retry with 
>stack-footprint-debugging again?

Silly question: where is stack-footprint-debugging?

Cheers,
Grant.
