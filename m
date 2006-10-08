Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWJHStM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWJHStM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWJHStL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:49:11 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38636 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751336AbWJHStK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:49:10 -0400
Date: Sun, 8 Oct 2006 20:40:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@osdl.org, dwalker@mvista.com, johnstul@us.ibm.com,
       zippel@linux-m68k.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: + clocksource-add-generic-sched_clock.patch added to -mm tree
Message-ID: <20061008184028.GA16437@elte.hu>
References: <200610070153.k971ruEZ020872@shell0.pdx.osdl.net> <1160301340.22911.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160301340.22911.27.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 2006-10-06 at 18:53 -0700, akpm@osdl.org wrote:
> > Adds a generic sched_clock, along with a boot time override for the 
> > scheduler clocksource (sched_clocksource).  Hopefully the config 
> > option would eventually be removed.
> 
> Again, this belongs into the clocksource code and not into sched.c
> 
> Your patch series scatters clock source related code snippets all over 
> the place. This becomes simply a maintenance nightmare.

seconded.

	Ingo
