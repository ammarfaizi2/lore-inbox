Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261912AbREUH4W>; Mon, 21 May 2001 03:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261919AbREUH4M>; Mon, 21 May 2001 03:56:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24846 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261912AbREUHzz>; Mon, 21 May 2001 03:55:55 -0400
Subject: Re: alpha iommu fixes
To: davem@redhat.com (David S. Miller)
Date: Mon, 21 May 2001 08:47:40 +0100 (BST)
Cc: andrewm@uow.edu.au (Andrew Morton), andrea@suse.de (Andrea Arcangeli),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        rth@twiddle.net (Richard Henderson), linux-kernel@vger.kernel.org
In-Reply-To: <15112.26793.768442.418184@pizda.ninka.net> from "David S. Miller" at May 20, 2001 06:00:25 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151kPk-0003S9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew Morton writes:
>  > Well this is news to me.  No drivers understand this.
>  > How long has this been the case?  What platforms?
> 
> The DMA interfaces may never fail and I've discussed this over and
> over with port maintainers a _long_ time ago.

And how do you propose to implemnt cache coherent pci allocations on machines
which lack the ability to have pages coherent between I/O and memory space ?
