Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWFRSdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWFRSdV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 14:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWFRSdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 14:33:21 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:6123 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751212AbWFRSdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 14:33:20 -0400
Date: Sun, 18 Jun 2006 20:28:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: tglx@timesys.com, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and dynamic HZ
Message-ID: <20060618182820.GA32765@elte.hu>
References: <1150643426.27073.17.camel@localhost.localdomain> <449580CA.2060704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449580CA.2060704@gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5007]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> WARNING: /lib/modules/2.6.17-hrt-dyntick1/kernel/sound/pci/ac97/snd-ac97-codec.ko needs unknown symbol msecs_to_jiffies
> WARNING: /lib/modules/2.6.17-hrt-dyntick1/kernel/drivers/net/skge.ko needs unknown symbol jiffies_to_msecs
> WARNING: /lib/modules/2.6.17-hrt-dyntick1/kernel/drivers/cpufreq/cpufreq_ondemand.ko needs unknown symbol jiffies_to_usecs
> etc...
> 
> warnings.
> 
> Here is fix small fix.

thanks. I've uploaded the current combo patch to:

  http://redhat.com/~mingo/high-res-timers-dyntick/hres-dyntick-combo-2.6.17-2.patch

(this also includes work-in-progress x86_64 bits - the .config options 
are offered by dynticks are not yet functional there.)

	Ingo
