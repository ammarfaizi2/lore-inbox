Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262846AbREVVf1>; Tue, 22 May 2001 17:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262843AbREVVfR>; Tue, 22 May 2001 17:35:17 -0400
Received: from geos.coastside.net ([207.213.212.4]:48575 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S262846AbREVVfM>; Tue, 22 May 2001 17:35:12 -0400
Mime-Version: 1.0
Message-Id: <p05100316b7308be26265@[207.213.214.37]>
In-Reply-To: <E152JdQ-0002VC-00@the-village.bc.nu>
In-Reply-To: <E152JdQ-0002VC-00@the-village.bc.nu>
Date: Tue, 22 May 2001 14:34:35 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: alpha iommu fixes
Cc: rth@twiddle.net (Richard Henderson), andrea@suse.de (Andrea Arcangeli),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        linux-kernel@vger.kernel.org, davem@redhat.com (David S. Miller)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:24 PM +0100 2001-05-22, Alan Cox wrote:
>  > On the main board, and not just the old ones. These days it's
>>  typically in the chipset's south bridge. "Third-party DMA" is
>>  sometimes called "fly-by DMA". The ISA card is a slave, as is memory,
>>  and the DMA chip reads from one ands writes to the other.
>
>There is also another mode which will give the Alpha kittens I suspect. A
>few PCI cards do SB emulation by snooping the PCI bus. So the kernel writes
>to the ISA DMA controller which does a pointless ISA transfer and the PCI
>card sniffs the DMA controller setup (as it goes to pci, then when nobody
>claims it on to the isa bridge) then does bus mastering DMA of its own to fake
>the ISA dma

That's sick.
-- 
/Jonathan Lundell.
