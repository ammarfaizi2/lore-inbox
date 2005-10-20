Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVJTJGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVJTJGE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 05:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbVJTJGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 05:06:03 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:4493 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750765AbVJTJGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 05:06:01 -0400
Date: Thu, 20 Oct 2005 05:05:50 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: john stultz <johnstul@us.ibm.com>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
In-Reply-To: <Pine.LNX.4.58.0510200503470.27683@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0510200505230.27683@localhost.localdomain>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
 <1129734626.19559.275.camel@tglx.tec.linutronix.de>
 <1129747172.27168.149.camel@cog.beaverton.ibm.com>
 <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain> <20051020073416.GA28581@elte.hu>
 <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain> <20051020080107.GA31342@elte.hu>
 <Pine.LNX.4.58.0510200443130.27683@localhost.localdomain> <20051020085955.GB2903@elte.hu>
 <Pine.LNX.4.58.0510200503470.27683@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Oct 2005, Steven Rostedt wrote:

> > isnt cycle_t 64 bits?
> >
>
> Not anymore.
>
> include/linux/time.h:
>
> /* timeofday base types */
> typedef s64 nsec_t;
> typedef unsigned long cycle_t;
>

At least not on a 32 bit machine.

-- Steve

