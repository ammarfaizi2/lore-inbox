Return-Path: <linux-kernel-owner+w=401wt.eu-S936910AbWLKQAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936910AbWLKQAh (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936915AbWLKQAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:00:37 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57633 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936910AbWLKQAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:00:36 -0500
Date: Mon, 11 Dec 2006 16:59:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt][RESEND] spin lock imbalance in ibm emac
Message-ID: <20061211155908.GA31944@elte.hu>
References: <20061210163848.101585000@mvista.com> <20061211092759.GA23041@elte.hu> <1165851624.7764.3.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165851624.7764.3.camel@imap.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> On Mon, 2006-12-11 at 10:27 +0100, Ingo Molnar wrote:
> > * Daniel Walker <dwalker@mvista.com> wrote:
> > 
> > > Sent this a long time ago, still exists. 
> > > 
> > > Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> > 
> > hm, what does this do, and why isnt it upstream?
> 
> AFAIK, those locks are added in -rt . I'm not sure how they got in 
> there, but they fix that driver when running in a thread. The driver 
> has unsafe SMP locking, but the only system it runs on (PPC4xx) is 
> uniprocessor. So it's not broken upstream per se.

ok, i've applied your patch.

	Ingo
