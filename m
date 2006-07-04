Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWGDKEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWGDKEE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 06:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWGDKED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 06:04:03 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:31671 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932200AbWGDKDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 06:03:44 -0400
Date: Tue, 4 Jul 2006 11:58:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Duncan Sands <duncan.sands@math.u-psud.fr>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [patch] fix AB-BA deadlock inversion at cs46xx_dsp_remove_scb
Message-ID: <20060704095859.GA22458@elte.hu>
References: <200607041115.35997.duncan.sands@math.u-psud.fr> <1152005720.3109.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152005720.3109.30.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> which is an obvious AB-BA deadlock
> 
> fix is to just take the lock with _irqsafe
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
