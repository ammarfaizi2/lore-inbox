Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267650AbRIFWCA>; Thu, 6 Sep 2001 18:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267852AbRIFWBv>; Thu, 6 Sep 2001 18:01:51 -0400
Received: from Expansa.sns.it ([192.167.206.189]:12049 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S267650AbRIFWBe>;
	Thu, 6 Sep 2001 18:01:34 -0400
Date: Fri, 7 Sep 2001 00:01:50 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Nicholas Knight <tegeran@home.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: K7/Athlon optimizations again. (The sacrifices worked??) (VIA
 KT133A chipset)
In-Reply-To: <01090613553103.00465@c779218-a>
Message-ID: <Pine.LNX.4.33.0109062352130.26515-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On KT133A based MBs, I came trought at less 4 bios upgrades, and no
problems at all. Usually I do not oveclock CPUs, so i keep 1.725 volts for
vcore instead of 1.75, and system are just STABLE. In the reality setting
1.725 volts in the bios gives to my CPUs on abit MBs the right 1.75 volts,
and setting 1.75 gives them 1.78/9. So I would suggest also to investigate
if this light overvolt could be involved to create instabilities.
I just made a test, and saw that on athlon 1.33 Ghz this volts diffecence
creates a 5 degres difference when CPU is idle, and 7/8 when it is full
loaded. And belive me, actually i am keeping thos CPU in a 18 degrees
environment, using delta's fan to dissipate the eath.

I know that a light overvolt should increase stability, and not generate
instability, but maybe if CPUs and north bridge get too hot, (not
so hot to destroy the HW, but anyway hotter in front of the optimal
temperature), that could generate instability on loaded systems.

just my 2 cents

Luigi



On Thu, 6 Sep 2001, Nicholas Knight wrote:

> Thanks to Charles Cazabon, I now have a new theory.
> to quote, I'm the one he quoted here:
>
> ----Begin Quote---
> > And I CAN nail it down to a particular chipset. It only occurs on VIA
> > KT133A chipsets so far, unfortunitely it doesn't occur 100% of the time
> > on that chipset.
>
>
> I'd be curious if it's an issue with only one brand or release of BIOS
> then.
> ----End Quote----
>
> And thus begins a new round, I started by slapping myself.
>
> I've seen two instances so far of someone mentioning that one BIOS
> release caused problems while another did not. One was mentioned on the
> list, one was part of the reports sent to me. I completely passed over
> this information and I have no idea why.
>
> Everyone having problems, here's what you could try:
> Upgrade to the latest BIOS version for your board.
> If you are at the latest BIOS version, go back a version or two.
>
> For those NOT having problems, and who would like to help test/live
> dangerously, could you also try the previously mentioned upgrades or
> downgrades?
>
> And be sure to have a non-K7 optimized kernel installed as a backup
> incase you forget to make TWO diskettes for upgrading your BIOS and it's
> your only system :)
>
> This problem doesn't even affect me, I'm not a developer, and any system
> I buy in the future will be long after the KT133A is "outdated", I don't
> know why I'm hammering at this so much.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

