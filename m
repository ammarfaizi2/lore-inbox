Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289776AbSBFIbT>; Wed, 6 Feb 2002 03:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289802AbSBFIbK>; Wed, 6 Feb 2002 03:31:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:62348 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289776AbSBFIa5>;
	Wed, 6 Feb 2002 03:30:57 -0500
Date: Wed, 06 Feb 2002 00:29:06 -0800 (PST)
Message-Id: <20020206.002906.94555802.davem@redhat.com>
To: hch@caldera.de
Cc: davidm@hpl.hp.com, mmadore@turbolinux.com, linux-ia64@linuxia64.org,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [Linux-ia64] Proper fix for sym53c8xx_2 driver and dma64_addr_t
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020206092129.A8739@caldera.de>
In-Reply-To: <20020205223804.A22012@caldera.de>
	<15456.21030.840746.209377@napali.hpl.hp.com>
	<20020206092129.A8739@caldera.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@caldera.de>
   Date: Wed, 6 Feb 2002 09:21:29 +0100

   On Tue, Feb 05, 2002 at 01:44:06PM -0800, David Mosberger wrote:
   >   Christoph> IA64 needs to define dma64_addr_t.
   > 
   > Not before the driver writers understand when to use it.
   
   Architecture maintainers are not supposed to decide whether driver
   writers understand APIs.  The dma64_addr_t type is part of the PCI
   DMA interface and IA64 needs to defines it.

You do have a point, but so does David.

What driver wants to get at this type and what are they using it
for?  dma_addr_t should be used by every driver I am aware of
except the clustering PCI cards I've been told about and that
driver isn't in the kernel at this time.

So who needs it? :-)

