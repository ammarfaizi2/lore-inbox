Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWIUNWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWIUNWX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 09:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWIUNWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 09:22:23 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:47830 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751214AbWIUNWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 09:22:22 -0400
Date: Thu, 21 Sep 2006 15:14:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.19 -mm merge plans
Message-ID: <20060921131433.GA4182@elte.hu>
References: <20060920135438.d7dd362b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060920135438.d7dd362b.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4989]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> ntp-move-all-the-ntp-related-code-to-ntpc.patch
> ntp-move-all-the-ntp-related-code-to-ntpc-fix.patch
> ntp-add-ntp_update_frequency.patch
> ntp-add-ntp_update_frequency-fix.patch
> ntp-add-time_adj-to-tick-length.patch
> ntp-add-time_freq-to-tick-length.patch
> ntp-prescale-time_offset.patch
> ntp-add-time_adjust-to-tick-length.patch
> ntp-remove-time_tolerance.patch
> ntp-convert-time_freq-to-nsec-value.patch
> ntp-convert-to-the-ntp4-reference-model.patch
> ntp-cleanup-defines-and-comments.patch
> kernel-time-ntpc-possible-cleanups.patch
> kill-wall_jiffies.patch
> 
>  Will merge.

would be nice to merge the -hrt queue that goes right ontop this queue. 
Even if HIGH_RES_TIMERS is "default n" in the beginning. That gives us 
high-res timers and dynticks which are both very important features to 
certain classes of users/devices.

The current queue is at:

  http://tglx.de/projects/hrtimers/2.6.18/

Hm?

	Ingo
