Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290421AbSAPLtT>; Wed, 16 Jan 2002 06:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290422AbSAPLtH>; Wed, 16 Jan 2002 06:49:07 -0500
Received: from Expansa.sns.it ([192.167.206.189]:54797 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S290421AbSAPLsv>;
	Wed, 16 Jan 2002 06:48:51 -0500
Date: Wed, 16 Jan 2002 12:48:42 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Amit Gupta <amit.gupta@amd.com>, <linux-kernel@vger.kernel.org>
Subject: Re: arpd not working in 2.4.17 or 2.5.1
In-Reply-To: <E16QZjK-00061Z-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0201161246490.31902-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Jan 2002, Alan Cox wrote:

> > But arp>1024 is Very Important, else linux will never be able to talk to more
> > than 1024 clients !
> >
> > Linux is my favourite and I wonder if this limit will kill linux for the race
> > with Solaris/M$ server market. So pls save me :) and help neighour.c/network
> > layer in new kernel.
>
> ARP applies for local links only. So you need a network you are actively
> talking to 1024 different hosts directly on. Furthermore all the
> config items should now be soft anyway. Want more, enable more.

To have this kind of network is not impossible at all, I received mail
from people at intel who are dealing with around 5000 arp (they say).
In this situation with arpd there was no sensible performance loss, right
now there is a big slowdown.



