Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133053AbRBRROk>; Sun, 18 Feb 2001 12:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133063AbRBRROa>; Sun, 18 Feb 2001 12:14:30 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:54282 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S133053AbRBRROO>; Sun, 18 Feb 2001 12:14:14 -0500
Message-Id: <200102181714.f1IHE8O94912@aslan.scsiguy.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Peter Samuelson <peter@cadcamlab.org>
cc: Nathan Black <NBlack@md.aacisd.com>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx (and sym53c8xx) plans 
In-Reply-To: Your message of "Sat, 17 Feb 2001 18:05:47 CST."
             <20010217180547.B28785@cadcamlab.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 18 Feb 2001 10:14:08 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Have you any idea the breadth of cards and chips that aic7xxx supports?
>Sure, Justin's driver does great with your shiny new 7899, but can you
>verify that it also drives the 8-year-old EISA AHA-2740 I still have
>sitting around (actually retired to the parts pile, but that's beside
>the point, I'm sure some still exist in the wild)?  How about the VLB
>card I have in my 486 at home?

I use a Dual Pentium-90 with PCI/EISA slots to test a 2742T and a 2740W.
I haven't tested a 284X card for some time just for lack of a VLB machine
(I have a card), but since it uses the aic7770 just like the 274X does,
I'd be very surprised if it didn't just work.

Version 6.1.2 of the driver has been tested on a G3 PowerMac, a Compaq
Blazer IA64 machine, and about 14 different PC motherboards.  We have an
AS1200 on the way from Compaq too so we can test EISA and PCI support on
the Alpha.  I've verified the driver's functionality on 25 different cards
thus far covering the full range of chips from aic7770->aic7899.  Lots of
people here at Adaptec look at me funny when I pull a PC from the scrap-heap,
or pull an old, discontinued card from an unused marketing display for use
in my lab, but I'm well aware of how these cards get used in 386sx
routers/firewalls etc, and those configurations will be supported.

--
Justin
