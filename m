Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266322AbSK1RfP>; Thu, 28 Nov 2002 12:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266359AbSK1RfP>; Thu, 28 Nov 2002 12:35:15 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:16389 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S266322AbSK1RfO>; Thu, 28 Nov 2002 12:35:14 -0500
Date: Thu, 28 Nov 2002 20:41:54 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Dave Jones <davej@codemonkey.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Sebastian Benoit <benoit-lists@fb12.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: drivers/pci/quirks.c / Re: Linux v2.5.50
Message-ID: <20021128204154.A24030@jurassic.park.msu.ru>
References: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com> <20021128111528.A28437@turing.fb12.de> <1038500743.10021.1.camel@irongate.swansea.linux.org.uk> <20021128200207.A23822@jurassic.park.msu.ru> <1038505301.10168.26.camel@irongate.swansea.linux.org.uk> <20021128173120.GC930@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021128173120.GC930@suse.de>; from davej@codemonkey.org.uk on Thu, Nov 28, 2002 at 05:31:20PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2002 at 05:31:20PM +0000, Dave Jones wrote:
> I would hope no-one has the idea to wire a hammer up to a
> triton/natoma chipset.  The VIA ones are more questionable.

AFAIK, hammers need their own very specific host bridges and
won't work with anything else.

I'm aware of the only one case where x86 northbridges are wired to
non-x86 CPU - AMD-750 and AMD-760 (Irongate) and Alpha ev6.
None of these chips are listed in the quirks though.

Ivan.
