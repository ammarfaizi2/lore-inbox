Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285156AbRLMUao>; Thu, 13 Dec 2001 15:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285159AbRLMUae>; Thu, 13 Dec 2001 15:30:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:29828 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285156AbRLMUa1> convert rfc822-to-8bit;
	Thu, 13 Dec 2001 15:30:27 -0500
Date: Thu, 13 Dec 2001 12:30:08 -0800 (PST)
Message-Id: <20011213.123008.21927765.davem@redhat.com>
To: groudier@free.fr
Cc: andrea@suse.de, axboe@suse.de, gibbs@scsiguy.com, LB33JM16@yahoo.com,
        linux-kernel@vger.kernel.org
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011213165932.L1871-100000@gerard>
In-Reply-To: <20011212.162603.28785873.davem@redhat.com>
	<20011213165932.L1871-100000@gerard>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gérard Roudier <groudier@free.fr>
   Date: Thu, 13 Dec 2001 17:17:22 +0100 (CET)
   
   PS: Don't take the wrong way my statements against Sun stuff. In fact, I
       dislike almost everything that comes and came from them. :)

Unfortunately the things you complain about are anything but Sun or
Sparc specific.  PPC64, MIPS64, Alpha, HPPA, and probably others I
have forgotten (oh yes and IA64 in the future if Intel gets their
heads out of their asses) all have IOMMU mechanisms in their PCI
controllers.

This disease may even some day infect x86 systems.  In fact
technically it already has, most AMD chipsets use a slightly modified
Alpha PCI controller which does have an IOMMU hidden deep down inside
of it :-)

Like I said before, the fact that PCI allows this to work is a feature
that is actually better for PCI's relevance and longevity, not worse.

Or do you suggest that it is wiser to use bounce buffering to handle
32-bit cards on systems with more than 4GB of ram? :-)  Using all
64-bit capable cards is not an answer, especially when the big
advantage of PCI is how commoditized and flooded the market is with
32-bit cards.
