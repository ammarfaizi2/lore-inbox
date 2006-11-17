Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755668AbWKQK2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755668AbWKQK2R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 05:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755670AbWKQK2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 05:28:17 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:2478 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1755668AbWKQK2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 05:28:16 -0500
Date: Fri, 17 Nov 2006 10:22:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.19-rc6-rt0, -rt YUM repository
Message-ID: <20061117092249.GA11102@elte.hu>
References: <20061116153553.GA12583@elte.hu> <1163721972.3109.6.camel@monteirov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163721972.3109.6.camel@monteirov>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0018]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> wrote:

> On Thu, 2006-11-16 at 16:35 +0100, Ingo Molnar wrote:
> >    cd /etc/yum.repos.d
> >    wget http://people.redhat.com/~mingo/realtime-preempt/rt.repo
> >    yum update kernel 
> 
> I follow the instructions on my x86_64 with FC6, that you already know
> (http://bugzilla.kernel.org/show_bug.cgi?id=6419#c47),
> hangs on boot with or without notsc.

hm - could you try the -rt1 package i just uploaded? It fixes a boot 
crash, amongst other bugfixes.

	Ingo
