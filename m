Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130658AbQLKWff>; Mon, 11 Dec 2000 17:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131010AbQLKWfZ>; Mon, 11 Dec 2000 17:35:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2186 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130658AbQLKWfN>;
	Mon, 11 Dec 2000 17:35:13 -0500
Date: Mon, 11 Dec 2000 13:48:34 -0800
Message-Id: <200012112148.NAA24830@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: groudier@club-internet.fr
CC: mj@suse.cz, lk@tantalophile.demon.co.uk, davej@suse.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012112116250.2023-100000@linux.local> (message
	from Gérard Roudier on Mon, 11 Dec 2000 21:49:52 +0100 (CET))
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <Pine.LNX.4.10.10012112116250.2023-100000@linux.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Mon, 11 Dec 2000 21:49:52 +0100 (CET)
   From: Gérard Roudier <groudier@club-internet.fr>

   If now, the PCI stuff is claimed to be cleaned up, then _all_ the
   hacks have to be removed definitely.  As a result, the driver will
   not work anymore on Sparc64, neither on PPC and I am not sure it
   will still work on Alpha, in my opinion.

Actually Gerard, in your current 2.4.x NCR53c8xx and SYM53c8XX drivers
only real ifdefs for sparc64 are printf format strings for PCI interrupt
numbers :-)

Really, in 2.4.x sparc64 requires PCI config space hackery no longer.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
