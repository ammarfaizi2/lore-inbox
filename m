Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130075AbQLLX0P>; Tue, 12 Dec 2000 18:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130265AbQLLX0E>; Tue, 12 Dec 2000 18:26:04 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8329 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130225AbQLLXZ7>;
	Tue, 12 Dec 2000 18:25:59 -0500
Date: Tue, 12 Dec 2000 14:39:31 -0800
Message-Id: <200012122239.OAA05669@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: groudier@club-internet.fr
CC: mj@suse.cz, lk@tantalophile.demon.co.uk, davej@suse.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012122106020.1501-100000@linux.local> (message
	from Gérard Roudier on Tue, 12 Dec 2000 21:28:18 +0100 (CET))
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <Pine.LNX.4.10.10012122106020.1501-100000@linux.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 12 Dec 2000 21:28:18 +0100 (CET)
   From: Gérard Roudier <groudier@club-internet.fr>

   You can be as dump as you want with PCI, but not that much. :-)

Your point is well taken.

   Btw, unlike the person, that proposed it, that will be able to test
   peer-to-peer unability only, my current machine will allow to test
   peer-to-peer ability only between 2 different PCI BUSes. :-)

   For now, my intention is to encapsulate the right interface as seen from
   my brain device in macros and forget about it until a new interface will
   be provided. I will first implement it on SYM-2 and backport changes to
   sym53c8xx later. And since I need the new major driver version to be
   tested on non-Intel platforms, this will make full synergy for the
   testings. :-)

Ok, meanwhile I will try to code up the generic interface.  It will
work like this: 1) I will code up something I know each port can
implement 2) I will show it to those here and everyone can tell me if
they can make use of it at all :-)

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
