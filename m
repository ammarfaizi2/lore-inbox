Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131048AbRALPEo>; Fri, 12 Jan 2001 10:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131072AbRALPEd>; Fri, 12 Jan 2001 10:04:33 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:16422 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S131048AbRALPEU>; Fri, 12 Jan 2001 10:04:20 -0500
Date: Fri, 12 Jan 2001 10:03:59 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: "V.P." <vpedro@individual.EUnet.pt>
cc: linux-kernel@vger.kernel.org
Subject: Re: APIC ERRor on CPU0: 00(02) ...
In-Reply-To: <3A5F172D.8C77E17@individual.EUnet.pt>
Message-ID: <Pine.LNX.4.10.10101120957190.23554-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a Motherboard BP6 with two Celeron 500 (Not overclocked) and
...
> APIC error on CPU1: 00(08)
...
> What wrongs ?

Abit designed the board wrong.  there are things you can do to reduce 
the incidence of this error: upgrading the bios, better cooling, more
powerful power supply, replacing an out-of-spec capacitor (if v1.1).
jeez, it's almost like a 12-step program for recovering from BP6ing ;)

>  This message doesn 't  appears in Kernel-2.2.17 only in Kernel-2.4

indeed: the error still happens in 2.2, but is simply not reported.
note also that this message is a *warning* - an inter-apic message 
was corrupted, and automatically retried.

regards, mark hahn.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
