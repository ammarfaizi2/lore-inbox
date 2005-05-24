Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVEXKV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVEXKV7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbVEXKVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 06:21:06 -0400
Received: from mx1.elte.hu ([157.181.1.137]:47490 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262018AbVEXKOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 06:14:31 -0400
Date: Tue, 24 May 2005 12:13:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Christoph Hellwig <hch@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
Message-ID: <20050524101343.GA23984@elte.hu>
References: <1116890066.13086.61.camel@dhcp153.mvista.com> <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu> <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu> <4292E559.3080302@yahoo.com.au> <20050524090240.GA13129@elte.hu> <4292F074.7010104@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4292F074.7010104@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Oh? I thought the idea of the voluntary-preempt thing was to stick 
> cond_rescheds into might_sleep. At least that was the part I think I 
> objected to... but I don't think I was one of the participants in that 
> flamewar :)

the VP patchset consisted of dozens of latency-breakers, of the 
->break_lock mechanism, of the might_sleep()s (which were placed based 
on latency tracing tools) and on the cond_resched()s too, (and other 
stuff i forget). Most of this is upstream now. To put a cond_resched() 
into might_sleep() is now a 5-liner :-)

	Ingo
