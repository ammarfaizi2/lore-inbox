Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131099AbRARPeI>; Thu, 18 Jan 2001 10:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131949AbRARPd5>; Thu, 18 Jan 2001 10:33:57 -0500
Received: from adsl-nrp10-C8B0F87C.sao.terra.com.br ([200.176.248.124]:31731
	"EHLO thor.gds-corp.com") by vger.kernel.org with ESMTP
	id <S131907AbRARPdj> convert rfc822-to-8bit; Thu, 18 Jan 2001 10:33:39 -0500
Date: Thu, 18 Jan 2001 13:34:40 -0200 (BRST)
From: Joel Franco Guzmán <joel@gds-corp.com>
To: Stefan Ring <e9725446@student.tuwien.ac.at>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: 128M memory OK, but with 192M sound card es1391 trouble
In-Reply-To: <Pine.HPX.4.10.10101181050260.3561-100000@stud3.tuwien.ac.at>
Message-ID: <Pine.LNX.4.30.0101181330390.1017-100000@thor.gds-corp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2001, Stefan Ring wrote:

> On Wed, 17 Jan 2001, Joel Franco Guzmán wrote:
>
> > With 128M the problem is not present, but with 192M it is. The only
> > difference is the memory quantity, or in other words, the additional slot
> > occupied by the new memory card.
>
> >    - ASUS P299 (Chipset i440ZX). Note: the i440ZX don't support officially
> > the coppermine processor at 133Mhz FSB.
>
> I know that increasing the number of DIMMs on your board will require
> speedier RAMs on ASUS boards with some sort of an i440 chipset. This may
> well be the case for just about every other MB, it's only that I don't
> know specifically about these other boards.

This means that a modules will work at more high MHZ?

>
> 133MHz is damn fast, and you need really good RAMs to keep up to that.
> In fact, most of the cheap modules sold as "PC133" can't cope with it,
> and you just got PC100. That's asking for trouble! As you add more
> modules, it gets even more critical.

OK. the 2 modules are PC100.
But why the system works with the 2.2.18 kernel perfectly?
It's by this, that i think that the problem is in new kernel.

>
> Do extensive testing before actually using such a system. The best testing
> that I know of is compiling large source trees with 2.2.x (I don't know
> about 2.4.x -- I DO know that 2.0.x won't turn up problems as easily
> because the buffer cache grows out of bounds) for hours and hours (10h
> minimum, 48h or more desirable). Make sure that there is enough "free"
> memory at all time (not cached, but really "free"). Also make sure that
> the temperature inside your computer is slightly higher than in actual use
> to put maximum stress on the RAMs.
>
> You may be able to get away by just increasing the SDRAM timings if you
> are running 2-2-2.

I use 3-3-3 to have security that i'm not forcing the memory modules.
with 2-2-2 i've troubles.

thank you.


>

-- 
    Joel Franco Guzmán
GDS - Global Dynamic Systems
   joelfranco@bigfoot.com
ICQ 19354050 | (16) 270-6867

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
