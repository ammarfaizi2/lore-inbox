Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265397AbRF0UCZ>; Wed, 27 Jun 2001 16:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbRF0UCF>; Wed, 27 Jun 2001 16:02:05 -0400
Received: from mail.aslab.com ([205.219.89.194]:13945 "EHLO mail.aslab.com")
	by vger.kernel.org with ESMTP id <S265395AbRF0UBx>;
	Wed, 27 Jun 2001 16:01:53 -0400
Date: Wed, 27 Jun 2001 13:01:46 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Gunther Mayer <Gunther.Mayer@t-online.de>, linux-kernel@vger.kernel.org,
        dhinds@zen.stanford.edu
Subject: Re: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards)
In-Reply-To: <E15FJ0p-0005XC-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.04.10106271244130.21460-100000@mail.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PARANIOA.

Remember that ATAPI is generally screwed beyond reality, so adjusting the
probe code in general (global) is a bad thing.

Andre Hedrick
ASL Kernel Development
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

On Wed, 27 Jun 2001, Alan Cox wrote:

> > obsoleting ATA-2 did their attention at CFA become alarmed.  I agree that
> > there needs to be a fix, but not at the price of locking the rest of the
> > driver.  Since we now the identity of the device prior to assigned the
> > interrupt we can handle the execption, but you do not go around blanket
> > wacking the control register of all devices.
> 
> I dont see why it locks up the driver ?
> 
> 

