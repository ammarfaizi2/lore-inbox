Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbREUKbD>; Mon, 21 May 2001 06:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262451AbREUKax>; Mon, 21 May 2001 06:30:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2831 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262452AbREUKal>; Mon, 21 May 2001 06:30:41 -0400
Subject: Re: alpha iommu fixes
To: andrea@suse.de (Andrea Arcangeli)
Date: Mon, 21 May 2001 11:17:04 +0100 (BST)
Cc: ak@suse.de (Andi Kleen), davem@redhat.com (David S. Miller),
        andrewm@uow.edu.au (Andrew Morton),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        rth@twiddle.net (Richard Henderson), linux-kernel@vger.kernel.org
In-Reply-To: <20010521120228.J30738@athlon.random> from "Andrea Arcangeli" at May 21, 2001 12:02:28 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151mkK-0003a9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can be really wrong on this because I didn't checked anything about
> the GART yet but I suspect you cannot use the GART for this stuff on
> ia32 in 2.4 because I think I recall it provides not an huge marging of
> mapping entries that so would far too easily trigger the bugs in the
> device drivers not checking for pci_map_* faliures also in a common
> desktop/webserver/fileserver kind of usage of an high end machine.

Not all chipsets support reading through GART address space from PCI either,
it is meant for AGP to use.

