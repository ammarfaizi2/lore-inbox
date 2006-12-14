Return-Path: <linux-kernel-owner+w=401wt.eu-S932776AbWLNUUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932776AbWLNUUb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932778AbWLNUUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:20:31 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46178 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932776AbWLNUUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:20:30 -0500
Date: Thu, 14 Dec 2006 21:18:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Pierre Peiffer <pierre.peiffer@bull.net>
Cc: LKML <linux-kernel@vger.kernel.org>, suresh.b.siddha@intel.com
Subject: Re: [PATCH 2.6.19-rt14][BUG] kernel/sched.c:4135: error: 'notick' undeclared
Message-ID: <20061214201836.GA32177@elte.hu>
References: <458173D5.5050008@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458173D5.5050008@bull.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0014]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pierre Peiffer <pierre.peiffer@bull.net> wrote:

> Hi,
> 
> The kernel (sched.c) does not compile if CONFIG_HZ and CONFIG_SMP are 
> set, and CONFIG_NO_HZ isn't.

oops - indeed.

> Is this patch correct ?

yeah. (FYI, i had to hand-apply it because it had whitespace damage, all 
tabs where spaces)

	Ingo
