Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbWJTU5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWJTU5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 16:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbWJTU5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 16:57:18 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:678 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030334AbWJTU5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 16:57:17 -0400
Date: Fri, 20 Oct 2006 22:56:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, teunis <teunis@wintersgift.com>,
       linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>
Subject: Re: various laptop nagles - any suggestions?   (note: 2.6.19-rc2-mm1 but applies to multiple kernels)
Message-ID: <20061020205651.GA26801@elte.hu>
References: <4537A25D.6070205@wintersgift.com> <20061019194157.1ed094b9.akpm@osdl.org> <4538F9AD.8000806@wintersgift.com> <20061020110746.0db17489.akpm@osdl.org> <1161368034.5274.278.camel@localhost.localdomain> <20061020112627.04a4035a.akpm@osdl.org> <1161370015.5274.282.camel@localhost.localdomain> <20061020121537.dea13469.akpm@osdl.org> <20061020203731.GA22407@elte.hu> <20061020135450.6794a2bb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020135450.6794a2bb.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> Oh.  I thought the problem was that the timer stops when the CPU is 
> idle. Maybe I misremembered.  I'll try `idle=poll'.

hm, wouldnt in that case the box not boot at all? But yeah, idle=poll 
would be nice.

could you also boot with apic=verbose and send us the full bootlog?

	Ingo
