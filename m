Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUHaQlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUHaQlW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUHaQlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:41:22 -0400
Received: from mail3.utc.com ([192.249.46.192]:45751 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S262574AbUHaQk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:40:56 -0400
Message-ID: <4134A9D7.9020605@cybsft.com>
Date: Tue, 31 Aug 2004 11:39:51 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q4
References: <20040828194449.GA25732@elte.hu>	 <200408282210.03568.pnambic@unu.nu> <20040828203116.GA29686@elte.hu>	 <1093727453.8611.71.camel@krustophenia.net>	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>	 <1093737080.1385.2.camel@krustophenia.net>	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>	 <1093762642.1348.3.camel@krustophenia.net> <20040829190655.GA8840@elte.hu>	 <4132793C.4030703@cybsft.com> <1093871169.30069.4.camel@localhost.localdomain>
In-Reply-To: <1093871169.30069.4.camel@localhost.localdomain>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2004-08-30 at 01:47, K.R. Foley wrote:
> 
>>Aug 29 09:32:50 daffy kernel: requesting new irq thread for IRQ1...
>>Aug 29 09:32:50 daffy kernel: atkbd.c: Spurious ACK on isa0060/serio1. 
>>Some program, like XFree86, might be trying access hardware directly.
> 
> 
> This is a known bug in the ps/2 driver layer. The printk can be
> triggered by multiple quite valid situations. I've suggested it be
> removed several times. Also XFree86 is a trademark so it should be
> XFree86(tm) ;)
> 

Thanks for pointing this out. It would appear that I get this same 
messages when things are working properly, with the exception of getting 
"serio0" when it works vs. "serio1" when it doesn't.

> The later ones are odd. It might be interesting to try turning off USB
> legacy support in the BIOS, that may be causing real problems in your
> case.
> 
I didn't try this because Ingo's latest patch seems to have resolved it.

> Alan
> 
> 
Thanks,

kr
