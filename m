Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130008AbRAJWlh>; Wed, 10 Jan 2001 17:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132114AbRAJWl1>; Wed, 10 Jan 2001 17:41:27 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:47624 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S130008AbRAJWlL>;
	Wed, 10 Jan 2001 17:41:11 -0500
Date: Wed, 10 Jan 2001 23:40:56 +0100
From: Frank de Lange <frank@unternet.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010110234056.C20535@unternet.org>
In-Reply-To: <20010110223015.B18085@unternet.org> <3A5CE07D.BD36D71C@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5CE07D.BD36D71C@colorfullife.com>; from manfred@colorfullife.com on Wed, Jan 10, 2001 at 11:21:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 11:21:49PM +0100, Manfred Spraul wrote:
> > which should work, they are
> > NON-busmastering cards after all...),
> third line in w840_probe1():
> 
> 	pci_set_master().
> 
> And the documentation begins with
> W89C840F
> 	PCI Bus Master Fast Ethernet LAN Controller.

...in addition to my previous reply, your cards use the Winbond 840 series,
while my cards use the 940 series. Higher number, but a less capabpe chipset or
so it seems...

Hm, but that reminds me not to get 840's to solve my problems :-)

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
