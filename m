Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310483AbSCKRQM>; Mon, 11 Mar 2002 12:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310458AbSCKRPx>; Mon, 11 Mar 2002 12:15:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39691 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310443AbSCKRPh>; Mon, 11 Mar 2002 12:15:37 -0500
Subject: Re: [PATCH] 2.5.6 IDE 19
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Mon, 11 Mar 2002 17:30:56 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3C8CE34B.4030800@evision-ventures.com> from "Martin Dalecki" at Mar 11, 2002 06:03:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kTdQ-0001AB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, so there is no f*cking magic utility from IBM to do suspend
> of MicroDrives under linux through the TASKFILE interface at all
> as you have climed!

I wrote some bits for the PC110 to work around the APM problem.

> > No because Microsoft implement the bloody standard in the first place. It
> Hack, then tell me what I'm at?

I'd hope implementing the bloody standard. 

> Andre Hedrick will may kill you... However apparently we agree that
> there is something wrong with the current driver.

Yes. There is an awful lot wrong

> It wasn't a claim but just a suspiction. So this is cleared.
> But apparently there is no special IBM command using taskfile
> to do magic things to it. So therefore it's still valid:
> your example was indeed a mock-up.

There are standard commands for power management, and for cache flush.

> to them. But the application notes from IBM and actual code
> from different operating systems gives a much better formal
> description of what is needed anyway. Or are you going to claim
> that narrative languaue is more precise then actual C code?

That depends if the C code is right.

Understand - I really appreciate the fact you are planning to tackle this
its just the way it comes across on correctness or lack thereof I find a
little alarming. Maybe I am misjudging you - if so I certainly apologise

Alan
