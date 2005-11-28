Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVK1LoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVK1LoJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 06:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVK1LoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 06:44:09 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:57486 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751259AbVK1LoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 06:44:08 -0500
Date: Mon, 28 Nov 2005 12:44:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rt15: cannot build with !PREEMPT_RT
Message-ID: <20051128114429.GA2868@elte.hu>
References: <1132987928.4896.1.camel@mindpipe> <20051126122332.GA3712@elte.hu> <1133031912.5904.12.camel@mindpipe> <1133034406.32542.308.camel@tglx.tec.linutronix.de> <20051127123052.GA22807@elte.hu> <1133121442.19202.13.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133121442.19202.13.camel@mindpipe>
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

> -rt19 still does not boot for me with PREEMPT_DESKTOP and the latency 
> debugging options enabled (same .config I sent previously).  I get 
> endless screenfuls of "=============" on boot.  grep shows that these 
> most likely come from kernel/rt.c.

yeah - i can reproduce it with your .config. It goes away if i go from 
PREEMPT_DESKTOP to PREEMPT_RT. Investigating.

	Ingo
