Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264948AbTLFFOQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 00:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbTLFFOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 00:14:16 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:59869 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S264948AbTLFFOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 00:14:15 -0500
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
From: Stian Jordet <liste@jordet.nu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Colin Coe <colin@coesta.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031206050908.GL8039@holomorphy.com>
References: <3350.192.168.1.3.1070677965.squirrel@www.coesta.com>
	 <20031206024251.GG8039@holomorphy.com> <3FD14396.5070205@cyberone.com.au>
	 <20031206030755.GI8039@holomorphy.com>
	 <1070684918.7934.2.camel@chevrolet.hybel>
	 <20031206043757.GJ8039@holomorphy.com>
	 <1070686126.1166.0.camel@chevrolet.hybel>
	 <20031206045409.GK8039@holomorphy.com>
	 <1070686634.1166.3.camel@chevrolet.hybel>
	 <20031206050908.GL8039@holomorphy.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1070687655.1166.6.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 06:14:15 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lør, 06.12.2003 kl. 06.09 skrev William Lee Irwin III:
> l?r, 06.12.2003 kl. 05.54 skrev William Lee Irwin III:
> >> Okay, irqbalance has gaffed (as predicted). Could you send in
> >> /proc/cpuinfo and /var/log/dmesg?
> 
> On Sat, Dec 06, 2003 at 05:57:14AM +0100, Stian Jordet wrote:
> > Here they are. Thanks for looking into this :)
> 
> This tells me you're not being mistaken for HT.
> 
> It also suggests it's the policy not doing what you want it to. If your
> interrupt rate isn't high (according to what metric I have no idea;
> presumably it should depend on the expense of handling it, which is
> driver-dependent but about which the code has no knowledge), it won't
> rebalance the irq's.
> 
> If you actually manage to get interrupt rates exceeding its thresholds,
> you should see interrupts migrated, but only dynamically and on-demand,
> not under light usage.

I really don't know the definition of "light usage", but I'm beating the
aic7xxx and eth0 quite hard at times, without any interrupts being
migrated. Anyway, thanks :) This haven't been a problem for me so far,
and I doubt it ever will :)

Stian

