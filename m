Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287539AbSANQR1>; Mon, 14 Jan 2002 11:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287563AbSANQRR>; Mon, 14 Jan 2002 11:17:17 -0500
Received: from [199.217.175.51] ([199.217.175.51]:4237 "EHLO
	core.federated.com") by vger.kernel.org with ESMTP
	id <S287539AbSANQRN>; Mon, 14 Jan 2002 11:17:13 -0500
From: Jim Studt <jim@federated.com>
Message-Id: <200201141614.g0EGEmrj011739@core.federated.com>
Subject: Re: Problem with ServerWorks CNB20LE and lost interrupts
In-Reply-To: <Pine.GSO.3.96.1020114164019.16706H-100000@delta.ds2.pg.gda.pl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Date: Mon, 14 Jan 2002 10:14:48 -0600 (CST)
CC: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Jim Studt <jim@federated.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL94 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  That's exactly why I consider the removal a Good Thing. ;-)  The only
> > > drawback I see is it would require an actively-maintained SMP hw
> > > compatibility list.
> > 
> > And an even more fervishly maintained procmailrc!!! ;)
> 
Maciej W. Rozycki wrote...
>  Why?  Since Linux doesn't work on these boards without the "noapic" 
> workaround anyway, I don't expect the number of mails with an ask for help
> to grow.  Only the answer would be different. 

The machine that started this thread is a single processor Gateway 7450 
1U rackmount server with a two processor option.

Using the slightly better apic routing isn't going to make any
difference to its performance.  I think being able to avoid unstable
hardware/software interractions when they aren't needed is a great
idea and `noapic' should stay in.  This thread should be google-able
shortly and lead people with interrupt problems to the noapic workaround.

I also think that if this is a problem with Gateway's BIOS the best
solution is for them to fix it.  I will contact Gateway and see about
that today.

-- 
                                     Jim Studt, President
                                     The Federated Software Group, Inc.
