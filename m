Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266157AbSK1RZe>; Thu, 28 Nov 2002 12:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbSK1RZe>; Thu, 28 Nov 2002 12:25:34 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:58345 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266157AbSK1RZd>;
	Thu, 28 Nov 2002 12:25:33 -0500
Date: Thu, 28 Nov 2002 17:30:07 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Sebastian Benoit <benoit-lists@fb12.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: drivers/pci/quirks.c / Re: Linux v2.5.50
Message-ID: <20021128173007.GB930@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Sebastian Benoit <benoit-lists@fb12.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
References: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com> <20021128111528.A28437@turing.fb12.de> <1038500743.10021.1.camel@irongate.swansea.linux.org.uk> <20021128200207.A23822@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021128200207.A23822@jurassic.park.msu.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2002 at 08:02:07PM +0300, Ivan Kokshaysky wrote:

 > +static void __devinit quirk_ati_exploding_mce(struct pci_dev *dev)
 > +{
 > +	printk(KERN_INFO "ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb.\n");
 > +	/* Mae rhaid in i beidio a edrych ar y lleoliad I/O hyn */

You gotta be kidding me ?  Amusing as the welsh language may be,
comments really should be readable to more than 0.01% of those likely
to be looking at them.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
