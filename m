Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316847AbSFQIfA>; Mon, 17 Jun 2002 04:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316848AbSFQIe7>; Mon, 17 Jun 2002 04:34:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:52624 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316847AbSFQIev>;
	Mon, 17 Jun 2002 04:34:51 -0400
Date: Mon, 17 Jun 2002 10:32:10 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Robert Love <rml@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
In-Reply-To: <Pine.LNX.4.44.0206170946360.1263-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0206171028040.9220-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Jun 2002, Zwane Mwaikambo wrote:

> > i have planned to submit the irqbalance patch for 2.4-ac real soon, which
> > needs this function - current IRQ distribution on P4 SMP boxes is a
> > showstopper.
> 
> Can we add a config time option for irqbalance? I consider it extra
> overhead for setups which can do the interrupt distribution via hardware
> properly, [...]

What x86 hardware do you have in mind?

My main issue with irqbalance is the lack of testing it has - eg. a
showstopper SMP-on-UP bug was found just two days ago.

> [...] also irqbalance breaks NUMAQ horribly seeing as it assumes a
> number of things like addressing modes.

exactly what does it assume that breaks NUMAQ?

	Ingo

