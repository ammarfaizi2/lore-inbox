Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272092AbRI3ALR>; Sat, 29 Sep 2001 20:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272122AbRI3ALI>; Sat, 29 Sep 2001 20:11:08 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:25867 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S272092AbRI3AK7>; Sat, 29 Sep 2001 20:10:59 -0400
Message-Id: <200109300011.f8U0BGY58130@aslan.scsiguy.com>
To: ookhoi@dds.nl
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac17 Adaptec AIC7XXX problems (new driver, old one works fine) 
In-Reply-To: Your message of "Sat, 29 Sep 2001 16:22:24 +0200."
             <20010929162224.E9327@humilis> 
Date: Sat, 29 Sep 2001 18:11:16 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi Justin, Alan,
>
>The new driver for the Adaptec 7892B gives me the following problems
>(see dmesg) on a asus a7v mobo with kernel 2.4.9-ac17.
>
>I have to run the system underclocked to make it boot at all. As soon as
>I run it at 1000 or 1200 MHz, it does a Kernel panic: for safety during
>the scsi boot part. It is a 1200MHz processor. The system runs fine
>after the (long) boot.

IIRC, the a7v is an AMD processor with VIA chipset.  If you go into the
MB BIOS and disable all of the "Make my PCI bus go as fast as possible even
if this means violating the spec" options, the "new" aic7xxx driver should
work fine.  I wish VIA would get a clue.

--
Justin
