Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266224AbTA0Jh3>; Mon, 27 Jan 2003 04:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266637AbTA0Jh3>; Mon, 27 Jan 2003 04:37:29 -0500
Received: from albireo.ucw.cz ([81.27.194.19]:10244 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S266224AbTA0Jh2>;
	Mon, 27 Jan 2003 04:37:28 -0500
Date: Mon, 27 Jan 2003 10:46:45 +0100
From: Martin Mares <mj@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, geert@linux-m68k.org,
       Richard Henderson <rth@twiddle.net>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] VGA IO on systems with multiple PCI IO domains
Message-ID: <20030127094645.GD604@ucw.cz>
References: <20030126181326.A799@localhost.park.msu.ru> <20030126214550.GB6873@ucw.cz> <1043624458.2755.37.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043624458.2755.37.camel@zion.wanadoo.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What about some kind of ioport_remap() that would take a pci_bus and an
> port range as arguments ? If pci_bus is NULL, that would match a
> "legacy" ISA bus (non-PCI machine or default ISA bus for machines where
> that makes sense).
> 
> What do you think ?

Looks good, but maybe we should use some other functions than iob() et al.
to do I/O on the remapped addresses.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Never make any mistaeks.
