Return-Path: <linux-kernel-owner+w=401wt.eu-S932307AbXARNI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbXARNI6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbXARNI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:08:58 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:45364 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932307AbXARNIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:08:45 -0500
Date: Thu, 18 Jan 2007 14:07:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Pierre Peiffer <pierre.peiffer@bull.net>
Cc: Daniel Walker <dwalker@mvista.com>, tglx@linutronix.de, khilman@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] futex null pointer timeout
Message-ID: <20070118130725.GA14782@elte.hu>
References: <20070118002503.418478415@mvista.com> <20070118073816.GA28486@elte.hu> <45AF6790.8010000@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45AF6790.8010000@bull.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -3.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.8 required=5.9 tests=ALL_TRUSTED,BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-0.5 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.0765]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pierre Peiffer <pierre.peiffer@bull.net> wrote:

> Ingo Molnar a écrit :
> >* Daniel Walker <dwalker@mvista.com> wrote:
> >
> [...]
> >>The patch reworks do_futex, and futex_wait* so a NULL pointer in the 
> >>timeout position is infinite, and anything else is evaluated as a real 
> >>timeout.
> >
> >thanks, applied.
> >
> 
> On top of this patch, you will need the following patch: futex_lock_pi 
> is also involved.

thanks, applied. (FYI, your mailer added an extra space to every context 
line in the patch and thus corrupted it, i fixed it up by hand.)

	Ingo
