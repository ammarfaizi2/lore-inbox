Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751871AbWITRGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbWITRGf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWITRGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:06:35 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:33261 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751871AbWITRGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:06:35 -0400
Date: Wed, 20 Sep 2006 18:58:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.18-rt1
Message-ID: <20060920165846.GA31522@elte.hu>
References: <20060920141907.GA30765@elte.hu> <200609201250.03750.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609201250.03750.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gene Heskett <gene.heskett@verizon.net> wrote:

>   LD      .tmp_vmlinux1
> kernel/built-in.o(.text+0x16f25): In function `hrtimer_start':
> : undefined reference to `hrtimer_update_timer_prio'
> make: *** [.tmp_vmlinux1] Error 1

yeah, the !hrt build broke in the last minute, i've uploaded -rt2 with 
the fix.

	Ingo
