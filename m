Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130067AbQLKXHq>; Mon, 11 Dec 2000 18:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130436AbQLKXHg>; Mon, 11 Dec 2000 18:07:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:19584 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130067AbQLKXHa>;
	Mon, 11 Dec 2000 18:07:30 -0500
Date: Mon, 11 Dec 2000 14:21:13 -0800
Message-Id: <200012112221.OAA01081@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: groudier@club-internet.fr
CC: mj@suse.cz, lk@tantalophile.demon.co.uk, davej@suse.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012112207400.2144-100000@linux.local> (message
	from Gérard Roudier on Mon, 11 Dec 2000 22:30:59 +0100 (CET))
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <Pine.LNX.4.10.10012112207400.2144-100000@linux.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Mon, 11 Dec 2000 22:30:59 +0100 (CET)
   From: Gérard Roudier <groudier@club-internet.fr>

   On Mon, 11 Dec 2000, David S. Miller wrote:

   > Really, in 2.4.x sparc64 requires PCI config space hackery no longer.

   Really?

   I was thinking about the pcivtophys() alias bus_dvma_to_mem() hackery used
   to retrieve the actual BAR address from the so-called pcidev bar cookies.

Really :-)  This conversation was about drivers making modifications
to PCI config space areas which are being argued to be only modified
by arch-specific PCI support layers.  That is the context in which
I made my statements.

Interpreting physical BAR values is another issue altogether.  Kernel
wide interfaces for this may be easily added to include/asm/pci.h
infrastructure, please just choose some sane name for it and I will
compose a patch ok? :-)

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
