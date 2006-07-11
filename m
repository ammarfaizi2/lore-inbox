Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWGKPyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWGKPyL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWGKPyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:54:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16347 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750989AbWGKPyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:54:10 -0400
Subject: Re: [patch] let CONFIG_SECCOMP default to n
From: Arjan van de Ven <arjan@infradead.org>
To: andrea@cpushare.com
Cc: Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060711153117.GJ7192@opteron.random>
References: <20060629192121.GC19712@stusta.de>
	 <1151628246.22380.58.camel@mindpipe>
	 <20060629180706.64a58f95.akpm@osdl.org> <20060630014050.GI19712@stusta.de>
	 <20060630045228.GA14677@opteron.random> <20060630094753.GA14603@elte.hu>
	 <20060630145825.GA10667@opteron.random> <20060711073625.GA4722@elte.hu>
	 <20060711141709.GE7192@opteron.random>
	 <1152628374.3128.66.camel@laptopd505.fenrus.org>
	 <20060711153117.GJ7192@opteron.random>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 17:54:02 +0200
Message-Id: <1152633242.3128.81.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 17:31 +0200, andrea@cpushare.com wrote:
> On Tue, Jul 11, 2006 at 04:32:53PM +0200, Arjan van de Ven wrote:
> > as far as I can see Fedora has SECCOMP off for a long time already
> 
> Well, I didn't know about it... Long time can't be more than a few
> months because I was sure in older releases it was enabled because I had
> people running seccomp code on fedora.

hmm I checked my laptop which runs a quite old version

> I never expect it was easy thing to startup the CPUShare project, but
> one thing that I didn't expect however was this kind of behaviour from
> the leading linux vendor, I didn't get a single email of questions and I
> wasn't informed about this, despite they know me perfectly. 

Ehm I wasn't aware all linux vendors in the world owe that to you, or
that you own their kernel configuration

> > if there is overhead, and there is no general use for it (which there
> > isn't really) then it should be off imo.
> 
> I hope the reason was the lack of my last patch. But even in such case
> RH could have turned off the tsc thing immediately themself (they know
> how to patch the kernel no?) or they could have asked me a single
> question about it before turning it off, no?
> 

I have no idea; I don't work there. Also I checked Fedora, not RHEL, and
Fedora is done by the Fedora project, not by Red Hat the company. If you
want to ask them to enable it, you should do so on the fedora-devel
mailing list



