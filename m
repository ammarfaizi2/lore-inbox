Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWGJJWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWGJJWM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWGJJWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:22:12 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:28908 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932486AbWGJJWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:22:11 -0400
Date: Mon, 10 Jul 2006 11:16:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
       mingo@redhat.com, Andrew Victor <andrew@sanpeople.com>,
       Alessandro Zummo <alessandro.zummo@towertech.it>,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 2.6.18-rc1] genirq: {en,dis}able_irq_wake() need refcounting too
Message-ID: <20060710091625.GA7840@elte.hu>
References: <200607091458.52298.david-b@pacbell.net> <20060710085849.GA6016@elte.hu> <20060710091340.GA4400@flint.arm.linux.org.uk> <20060710091920.GB4400@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710091920.GB4400@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> Let's first get genirq to a point where it's a direct replacement for 
> my IRQ subsystem before thinking about changing existing APIs (and 
> thereby possibly introducing other breakage.)

note that the API change i suggested was a NOP operation :-) The APIs 
were already shaped that way. No need to worry.

	Ingo
