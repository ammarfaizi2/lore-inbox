Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129208AbQKUKS0>; Tue, 21 Nov 2000 05:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQKUKSQ>; Tue, 21 Nov 2000 05:18:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:65155 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129691AbQKUKSD>;
	Tue, 21 Nov 2000 05:18:03 -0500
Date: Tue, 21 Nov 2000 01:32:49 -0800
Message-Id: <200011210932.BAA02049@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: kloczek@rudy.mif.pg.gda.pl
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, viro@math.psu.edu
In-Reply-To: <Pine.LNX.4.21.0011210831200.22444-200000@rudy.mif.pg.gda.pl>
	(message from Tomasz K³oczko on Tue, 21 Nov 2000 08:36:59 +0100 (CET))
Subject: Re: Linux 2.2.18pre22
In-Reply-To: <Pine.LNX.4.21.0011210831200.22444-200000@rudy.mif.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Tue, 21 Nov 2000 08:36:59 +0100 (CET)
   From: Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl>

Czesc,

   Seems in this place was introduced small bug.
   Linking kernel with disabled CONFIG_SYSCTL fails with:

   kernel/kernel.o(__ksymtab+0x5f8): undefined reference to `sysctl_jiffies'

   Patch with fix included.

Already fixed in the current 2.2.18pre

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
