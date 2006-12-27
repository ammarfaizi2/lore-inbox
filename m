Return-Path: <linux-kernel-owner+w=401wt.eu-S1754747AbWL0Vok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbWL0Vok (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 16:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754777AbWL0Voj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 16:44:39 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:43747 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754747AbWL0Voj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 16:44:39 -0500
Date: Wed, 27 Dec 2006 22:41:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt] update kmap_atomic on !HIGHMEM
Message-ID: <20061227214146.GA19908@elte.hu>
References: <20061227193550.324850000@mvista.com> <20061227212555.GA14947@elte.hu> <20061227213150.GA15638@elte.hu> <1167255457.14081.47.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167255457.14081.47.camel@imap.mvista.com>
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

> On Wed, 2006-12-27 at 22:31 +0100, Ingo Molnar wrote:
> > plus on i386 the fix below is needed as well.
> > 
> 
> We do it on most other arches .. PowerPC , and I think ARM too.

I dont think they currently work with PREEMPT_RT and HIGHMEM enabled, 
but if/once they do they'll need a similar fix.

	Ingo
