Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288382AbSACXWp>; Thu, 3 Jan 2002 18:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288379AbSACXWf>; Thu, 3 Jan 2002 18:22:35 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:14281 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S288377AbSACXWX>;
	Thu, 3 Jan 2002 18:22:23 -0500
Date: Fri, 4 Jan 2002 00:21:52 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <swsnyder@home.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "APIC error on CPUx" - what does this mean?
In-Reply-To: <E16MGVH-0001Jl-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.30.0201040020040.25886-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


But what do these messages mean?

Are they some kind of retryable errors?
Do they have any consequences?

Thanks.

On Thu, 3 Jan 2002, Alan Cox wrote:

> > I just noticed the following events in my system log:
> >
> >   Jan  3 14:03:39 mercury kernel: APIC error on CPU1: 00(02)
> >   Jan  3 14:03:39 mercury kernel: APIC error on CPU0: 00(02)
> >
> > Please let me know if I can provide any additional info needed to diagnose
> > this error.
>
> The occasional APIC error is fine (its logging a hardware event - probably
> something that caused enough noise to lose a message and retry it). The
> APIC bus is designed to stand these occasional errors
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
Balazs Pozsar

