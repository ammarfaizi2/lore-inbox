Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129234AbQKAIV0>; Wed, 1 Nov 2000 03:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129119AbQKAIVR>; Wed, 1 Nov 2000 03:21:17 -0500
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:38895 "EHLO
	vaio.greennet") by vger.kernel.org with ESMTP id <S129069AbQKAIVC>;
	Wed, 1 Nov 2000 03:21:02 -0500
Date: Wed, 1 Nov 2000 03:23:38 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, pavel rabel <pavel@web.sajt.cz>,
        linux-net@vger.kernel.org, netdev@oss.sgi.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] NE2000
In-Reply-To: <39FFAA94.4D389E85@yahoo.com>
Message-ID: <Pine.LNX.4.10.10011010315070.11540-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Paul Gortmaker wrote:

> Jeff Garzik wrote:
> > Paul Gortmaker wrote:
> > > There is no urgency in trying to squeeze a patch like this in the back
> > > door of a 2.4.0 release.  For example, there are people out there now
> > > who are using the ne.c driver to run both ISA and PCI cards in the same
> > > box without having to use 2 different drivers.  We can wait until 2.5.0
> > > to break their .config file.
> > 
> > IMNSHO this is a bug, though...
..
> If you want to roll it into the merge (and can get it past Linus) then
> please feel free to do so - I'll be glad to cross it off my list sooner
> as opposed to later.

If the ne* drivers are going to be updated, you might want to add in the
full-duplex support of the latest ne2k-pci.c driver at
    ftp://www.scyld.com/pub/network/ne2k-pci.c

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
