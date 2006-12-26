Return-Path: <linux-kernel-owner+w=401wt.eu-S1754676AbWLZJ4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbWLZJ4Q (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 04:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754684AbWLZJ4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 04:56:16 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:39726 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754676AbWLZJ4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 04:56:15 -0500
Date: Tue, 26 Dec 2006 10:53:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -rt] cmpxchg support on ARMv6
Message-ID: <20061226095315.GA8544@elte.hu>
References: <7329685.588011167118307762.JavaMail.weblogic@ep_ml29>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7329685.588011167118307762.JavaMail.weblogic@ep_ml29>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kyungmin Park <kyungmin.park@samsung.com> wrote:

> [PATCH -rt] cmpxchg support on ARMv6
> 
> Current rt patch don't support the cmpxchg on ARMv6. This patch supports cmpxchg in ARMv6.
> It's tested on OMAP2 (apollon board).
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

thanks, applied. I'm curious, did you do any performance testing of 
this?

	Ingo
