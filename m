Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267344AbUHWUYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267344AbUHWUYU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267503AbUHWUYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:24:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57785 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267344AbUHWTmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 15:42:18 -0400
Date: Mon, 23 Aug 2004 21:43:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P7
Message-ID: <20040823194330.GA6539@elte.hu>
References: <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <20040820195540.GA31798@elte.hu> <20040821140501.GA4189@elte.hu> <1093160993.817.46.camel@krustophenia.net> <1093282713.826.13.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093282713.826.13.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> to file a bug report.  Traces can be found here:
> 
> http://krustophenia.net/2.6.8.1-P7

re the skb latencies: Mark H Johnson managed to reduce net-input
latencies by decreasing /proc/sys/net/core/netdev_max_backlog to 8 -
could you try this, does it help? (you could try an even more extreme
setting like 4.)

	Ingo
