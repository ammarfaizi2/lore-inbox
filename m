Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265995AbSK1RCk>; Thu, 28 Nov 2002 12:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265998AbSK1RCk>; Thu, 28 Nov 2002 12:02:40 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:40087 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265995AbSK1RCj>; Thu, 28 Nov 2002 12:02:39 -0500
Subject: Re: drivers/pci/quirks.c / Re: Linux v2.5.50
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Sebastian Benoit <benoit-lists@fb12.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20021128200207.A23822@jurassic.park.msu.ru>
References: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com>
	<20021128111528.A28437@turing.fb12.de>
	<1038500743.10021.1.camel@irongate.swansea.linux.org.uk> 
	<20021128200207.A23822@jurassic.park.msu.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Nov 2002 17:41:41 +0000
Message-Id: <1038505301.10168.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-28 at 17:02, Ivan Kokshaysky wrote:
> Actually a LOT of fixups in drivers/pci/quirks.c are 100% x86 specific
> and therefore don't belong in there.
> What about this patch?
> It moves most obvious stuff (northbridges quirks) to the proper
> place (arch/i386/pci/fixups.c).

What about x86_64 ?

Can the x86_64 folks verify these are not going to appear in x86_64
systems at all ?
