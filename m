Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbUJ1OWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUJ1OWA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbUJ1OTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:19:00 -0400
Received: from mx1.elte.hu ([157.181.1.137]:65183 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261305AbUJ1OQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:16:55 -0400
Date: Thu, 28 Oct 2004 16:18:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: DaMouse <damouse@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.5.2
Message-ID: <20041028141802.GA27382@elte.hu>
References: <20041027205126.GA25091@elte.hu> <20041027211957.GA28571@elte.hu> <33083.192.168.1.5.1098919913.squirrel@192.168.1.5> <20041028063630.GD9781@elte.hu> <20668.195.245.190.93.1098952275.squirrel@195.245.190.93> <20041028085656.GA21535@elte.hu> <26253.195.245.190.93.1098955051.squirrel@195.245.190.93> <20041028093215.GA27694@elte.hu> <20041028135706.GA25849@elte.hu> <1a56ea3904102807101147e561@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a56ea3904102807101147e561@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* DaMouse <damouse@gmail.com> wrote:

> >     echo 0 > /proc/sys/kernel/preempt_max_latency
> > 
> > this will switch back to critical-section timing/tracing:
> > 
> >     echo 0 > /proc/sys/kernel/preempt_wakeup_timing
> 
> What kind of benchmarking tools about from the inkernel timing/tracing
> do you use for testing REALTIME_PREEMPT?

amlat's 'realfeel' with the patch i posted yesterday.

	Ingo
