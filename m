Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292181AbSBTSvG>; Wed, 20 Feb 2002 13:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292188AbSBTSu4>; Wed, 20 Feb 2002 13:50:56 -0500
Received: from web10502.mail.yahoo.com ([216.136.130.152]:60084 "HELO
	web10502.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292181AbSBTSup>; Wed, 20 Feb 2002 13:50:45 -0500
Message-ID: <20020220185044.31163.qmail@web10502.mail.yahoo.com>
Date: Wed, 20 Feb 2002 10:50:44 -0800 (PST)
From: S W <egberts@yahoo.com>
Subject: Re: Dlink DSL PCI Card
To: Andrew Hatfield <lkml@secureone.com.au>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <007b01c1b9a6$ab4351b0$0f01000a@brisbane.hatfields.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having observed Linux driver development on Efficient
3060 and Efficient 3061 DSL PCI products, I've also
managed to track other competitor's Linux DSL
developments as well.  Now that I'm out of DSL
industry forever... I can speak my opinion on this
Linux DSL driver quagmire.

The basic problem of DSL (and Winmodem) PCI adapter
and getting to produce open source drivers is: 
Manufacturer Non-Disclosure Agreement (aka N.D.A. or
NDA).

NDA basically prevents its resultant driver code from
becoming open-source (GNU, GPL, LGPL, much less public
domain).

I've struggled with various industry chipset
manufacturers in getting them to release us from such
NDAs for three years, tactfully0.  It is not only
their marketing decision, but a legal one as well
(i.e., how to undo a group of already-signed NDAs). 
The only clean break is to manufacture a DSL chipset
and distribute them without having a single NDA signed
(this prevents unlevel competitions and future
lawsuits from other NDA signers).

The closest I've seen to getting the DSL chipset to be
un-NDA'd is Alcatel Microelectronics.  But Alcatel
legal team shut them down to protect Alcatel
Networking division (Sting Ray DSL modem) from losing
future sales (an oxymoron, if I've seen any).

So, to summarized it best.  Don't buy PCI adapters
that have microcodes loaded to them NOR require
proprietary microcodes accessed to memory by DMA.  In
other word, don't buy winmodem nor DSL PCI adapters,
until those chipset manufacturers publish those
datasheets.

It staggers my mind that chipset marketing groups are
missing a huge revenues streams by having those
product supported on multiple O/S platforms.  I've
already computed (many times) the cost of development
as trivial to the sales of such products (even
low-margin PCI adapters).  It is more than
self-sustaining.  NDA is the primary blocker here.

Safest bet is to buy external DSL modem with Ethernet
(or ATM-25) interface(s).

Direct further threads to the ummm, oh... there isn't
a linux-driver thread...
http://vger.kernel.org/vger-lists.html

Steve Egbert
mailto:egberts@yahoo.com

BTW:  ENI 3060/3061 driver is in binary-only driver
and built only to work with Linux-2.3.99-something (snicker).

__________________________________________________
Do You Yahoo!?
Yahoo! Sports - Coverage of the 2002 Olympic Games
http://sports.yahoo.com
