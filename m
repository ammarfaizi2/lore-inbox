Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWGEWEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWGEWEp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 18:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWGEWEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 18:04:45 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:39298 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965020AbWGEWEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 18:04:43 -0400
Date: Thu, 6 Jul 2006 00:00:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
Message-ID: <20060705220009.GB32040@elte.hu>
References: <20060705113054.GA30919@elte.hu> <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <20060705145826.fc549c7f.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705145826.fc549c7f.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Randy.Dunlap <rdunlap@xenotime.net> wrote:

> > well, the allnoconfig thing is artificial (and the uninteresting) for a 
> > number of reasons:
> 
> hm, I'd have to say that allyesconfig is also artificial and the 
> savings numbers are somewhat uninteresting in that case too.

well the 'allyesconfig' isnt the true allyesconfig but one with most 
debugging options disabled. It is quite close to a typical distro config 
- hence very much relevant. (I wanted to use something that is easy to 
reproduce.) Believe me, for large configs the savings are real.

	Ingo
