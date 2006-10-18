Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWJRHpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWJRHpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 03:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWJRHpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 03:45:30 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53700 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751337AbWJRHp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 03:45:29 -0400
Date: Wed, 18 Oct 2006 09:37:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rt5 1/1] ARM: Use IRQF_NODELAY for XScale oprofile interrupt
Message-ID: <20061018073742.GB31552@elte.hu>
References: <20061009230146.234622000@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009230146.234622000@mvista.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Kevin Hilman <khilman@mvista.com> wrote:

> Convert XScale performance monitor unit (PMU) interrupt used by 
> oprofile to IRQF_NODELAY.  PMU results not useful if ISR is run as 
> thread.

thanks, applied.

	Ingo
