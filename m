Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274558AbRITQVi>; Thu, 20 Sep 2001 12:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274559AbRITQV3>; Thu, 20 Sep 2001 12:21:29 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:31243 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S274558AbRITQVL>;
	Thu, 20 Sep 2001 12:21:11 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200109201612.RAA14175@gw.chygwyn.com>
Subject: Re: IBMs LVM?
To: adilger@turbolabs.com (Andreas Dilger)
Date: Thu, 20 Sep 2001 17:12:47 +0100 (BST)
Cc: hch@ns.caldera.de (Christoph Hellwig), linux-kernel@vger.kernel.org
In-Reply-To: <20010920100557.Z14526@turbolinux.com> from "Andreas Dilger" at Sep 20, 2001 10:05:57 AM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a quick update on whats going on with the new LVM stuff.... Joe had
announced a release a little while ago with some initial code which he
has been working on for a while. I've been continuing that (along with
various other Sistina people doing testing) to make the initial code more
robust and finalise the kernel/user interface.

I hope that by the end of next week we'll have the new filesystem based
interface finished and tested at which point we'll announce it again as
a suitable time for interested parties to have a look. Feel free to check
out the CVS in the mean time though :-)

In order for the driver to be useful, we need code to read metadata from
disks and write suitable tables to drive the device mapper. We are already
working on this next step but will focus more upon it when the driver is
finished.

Please send any comments or patches to the linux-lvm list,

Thanks,

Steve.

> 
> On Sep 20, 2001  13:57 +0200, Christoph Hellwig wrote:
> > Anyway, I will get my design for improved block device stacking and unified
> > partition discovery back from the attic and implement a protopy ontop of
> > the bio patchset.  I'll Cc my ennouncement to evms-devel, you're free to
> > layer ontop if you want.
> 
> Just FYI (in case you haven't seen it) the LVM folks are working on
> something like this in their "LVM2" repository.  I've been seeing
> the CVS commit messages, but have not actually taken a look at the
> code yet, so I can't comment on it but it may save you some effort.
> 
> Cheers, Andreas
> --
> Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
>                  \  would they cancel out, leaving him still hungry?"
> http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

