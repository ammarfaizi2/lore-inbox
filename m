Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946531AbWKJNOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946531AbWKJNOH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 08:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946553AbWKJNOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 08:14:06 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:40076 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1946531AbWKJNOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 08:14:03 -0500
Date: Fri, 10 Nov 2006 14:12:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
Message-ID: <20061110131248.GA27251@elte.hu>
References: <20061109233030.915859000@cruncher.tec.linutronix.de> <20061110111231.GB3291@elf.ucw.cz> <20061110114806.GA6780@elte.hu> <200611101256.35306.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611101256.35306.ak@suse.de>
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


* Andi Kleen <ak@suse.de> wrote:

> > we could, but it would have to be almost empty right now :-) Reason: 
> > even on systems that have (hardware-initialized) 'perfect' TSCs and 
> > which do not support any frequency scaling or power-saving mode, our 
> > current TSC initialization on SMP systems introduces a small (1-2 usecs) 
> > skew.
> 
> On Intel we don't sync the TSC anymore [...]

yeah, after i reported this a few months ago ;-)

	Ingo
