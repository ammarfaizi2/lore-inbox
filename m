Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVGGPmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVGGPmc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 11:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVGGPmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 11:42:31 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:45199 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261296AbVGGPmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 11:42:25 -0400
Date: Thu, 7 Jul 2005 11:42:17 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-45
In-Reply-To: <20050707153103.GA22782@elte.hu>
Message-ID: <Pine.LNX.4.58.0507071139220.12711@localhost.localdomain>
References: <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu>
 <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu>
 <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu>
 <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org>
 <20050706100451.GA7336@elte.hu> <Pine.LNX.4.58.0507071047540.12711@localhost.localdomain>
 <20050707153103.GA22782@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Darn subversion! I just started a massive commit, and I can't leave work
till it's done. So you still got me here ;-)

On Thu, 7 Jul 2005, Ingo Molnar wrote:
>
> > Anyway, I also want to let you know that the e100 does not work.  It's
> > detected, but it wont bring up DHCP, and when I manually configued it,
> > it just froze (the process not the machine). But when I did a sysrq-t,
> > the machine froze up after it completed with some RT yeilding bug.
> > Here's what was last to spit out:
>
> is PCI_MSI enabled by any chance? That is known to break level-triggered
> IOAPIC irqs and devices.
>

As a matter of fact it is...   I'll turn it off now and try it out.
If the commit is still going, I'll get you a response about the result.

-- Steve

