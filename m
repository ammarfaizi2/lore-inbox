Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946549AbWKJNPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946549AbWKJNPf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 08:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946597AbWKJNPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 08:15:35 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:14519 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1946549AbWKJNPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 08:15:34 -0500
Date: Fri, 10 Nov 2006 14:14:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, Andi Kleen <ak@suse.de>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
Message-ID: <20061110131422.GB27251@elte.hu>
References: <20061109233030.915859000@cruncher.tec.linutronix.de> <20061109233035.569684000@cruncher.tec.linutronix.de> <1163121045.836.69.camel@localhost> <200611100610.13957.ak@suse.de> <1163146206.8335.183.camel@localhost.localdomain> <20061110005020.4538e095.akpm@osdl.org> <20061110085728.GA14620@elte.hu> <20061110111231.GB3291@elf.ucw.cz> <20061110114806.GA6780@elte.hu> <20061110120038.GB3385@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061110120038.GB3385@elf.ucw.cz>
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


* Pavel Machek <pavel@ucw.cz> wrote:

> > we could, but it would have to be almost empty right now :-) Reason:
> 
> Well, if it would contain at least 50% of the UP machines... that 
> would be reasonably long list for a start.

which 50%? Does it include those where the TSC slows down due a thermal 
event SMM?

	Ingo
