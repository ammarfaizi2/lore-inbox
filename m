Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbTH0WRL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 18:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbTH0WRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 18:17:11 -0400
Received: from gw.lowendale.com.au ([203.26.242.120]:4358 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id S262378AbTH0WRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 18:17:07 -0400
Date: Thu, 28 Aug 2003 08:27:16 +1000 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Marc-Christian Petersen <m.c.p@wolk-project.de>, adefacc@tin.it,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ruben =?ISO-8859-1?Q?P=FCttmann?= <ruben@puettmann.net>,
       Ville Herva <vherva@niksula.hut.fi>
Subject: Re: linux-2.2 future?
In-Reply-To: <1061910188.20846.39.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.05.10308280810210.11587-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Aug 2003, Alan Cox wrote:

> On Llu, 2003-08-25 at 17:42, Marc-Christian Petersen wrote:
> > like .21 and .22 IDE code is, but it works very very smooth and nice and rock 
> > solid. We use the 2.2-secure tree for almost all customers in my company. 
> > Biggest harddisk is a 160GB Maxtor IDE disk.
> 
> The problem is that change breaks stuff. a lot of the 2.2 users will
> happily trade lack of LBA48 support for stability and predictability.
> Thats why I took a basically "if its not a serious bugfix its not going
> in" approach

As a 2.2 user, I have to agree with this sentiment.

Just as Rome wasn't built in a day, 2.2 didn't get as stable as it is
overnight.  Unfortunately, any change now risks subtley destabilizing 2.2
for some obscure case somewhere.  Such destabilization could literally
happen overnight {:-(

OTOH, some users may find that the stability of 2.2 combined with some
other feature(s) (be it LBA48/IPSec/whatever (in my case it's MPPE from
-secure + a timer hack)) works just fine for them.

I.e. we can be well-served by a very stable "official" 2.2 tree which is
supplemented by the likes of MCP's -secure patchset, and others.

Perhaps the middle ground is to keep the 2.2 kernel pretty much as-is
(modulo bugfixes) and include pointers to optional patch(sets)?  That's
certainly more palatable than people maintaining patch-reversions to
retain their stability!

Worse still, as is too often the case, feature updates may provoke some
2.2 users to NOT upgrade (and hence miss security fixes) lest they
compromise stability.

HTH and many thanks for your contributions,
Neale.

