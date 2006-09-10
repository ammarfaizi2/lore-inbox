Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWIJMGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWIJMGj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 08:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWIJMGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 08:06:39 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:215 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750899AbWIJMGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 08:06:38 -0400
Date: Sun, 10 Sep 2006 13:58:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes + nodemgr patches -- INFO: trying to register non-static key (the code is fine but needs lockdep annotation).
Message-ID: <20060910115824.GB15356@elte.hu>
References: <a44ae5cd0609072006p627fb127g62949c62a5bfc6c2@mail.gmail.com> <tkrat.ae0a49a0374e41e2@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tkrat.ae0a49a0374e41e2@s5r6.in-berlin.de>
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


* Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> > INFO: trying to register non-static key.
> > the code is fine but needs lockdep annotation.
> > turning off the locking correctness validator.

> From: Stefan Richter <stefanr@s5r6.in-berlin.de>
> Subject: SCSI: lockdep annotation in scsi_send_eh_cmnd
> 
> Fixup for lockdep enabled kernels: Annotate an on-stack completion.
> 
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

thanks.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
