Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWINR4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWINR4e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 13:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWINR4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 13:56:34 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:51936 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750856AbWINR4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 13:56:33 -0400
Date: Thu, 14 Sep 2006 19:48:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914174830.GA19720@elte.hu>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <1158247596.5068.19.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158247596.5068.19.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4819]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michel Dagenais <michel.dagenais@polymtl.ca> wrote:

> This is the crucial point. Using an INT3 at each dynamic tracepoint is 
> both costly and is a larger perturbation on the system under study. 
> [...]

have you measured this?

	Ingo
