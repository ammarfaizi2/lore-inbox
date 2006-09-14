Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWINLgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWINLgK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 07:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWINLgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 07:36:10 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:33760 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751199AbWINLgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 07:36:09 -0400
Date: Thu, 14 Sep 2006 13:27:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914112718.GA7065@elte.hu>
References: <20060914033826.GA2194@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060914033826.GA2194@Krystal>
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


* Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:

> Following an advice Christoph gave me this summer, submitting a 
> smaller, easier to review patch should make everybody happier. Here is 
> a stripped down version of LTTng : I removed everything that would 
> make the code review reluctant (especially kernel instrumentation and 
> kernel state dump module). I plan to release this "core" version every 
> few LTTng releases and post it to LKML.
> 
> Comments and reviews are very welcome.

i have one very fundamental question: why should we do this 
source-intrusive method of adding tracepoints instead of the dynamic, 
unintrusive (and thus zero-overhead) KProbes+SystemTap method?

	Ingo
