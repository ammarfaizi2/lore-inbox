Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135240AbRECVYP>; Thu, 3 May 2001 17:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135249AbRECVYF>; Thu, 3 May 2001 17:24:05 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:46319 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S135245AbRECVXz>; Thu, 3 May 2001 17:23:55 -0400
Date: Thu, 3 May 2001 22:24:42 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ken Brownfield <brownfld@irridia.com>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 Kernel - ASUS CUV4X-DLS Question
In-Reply-To: <E14vPq2-0006B1-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0105032206260.3039-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 May 2001, Alan Cox wrote on APIC problems in 2.4:
> There are five cases I am seeing
> 1.	Serverworks total APIC hose ups.
> 	Fix: remove OSB4 or use -ac tree
> 2.	440BX and similar boards losing interrupts on some drivers
> 	Fix: use -ac
> 3.	APIC errors notably checksum errors. 
> 	Fix: buy properly manufactured hardware
> 4.	Hangs on boot with the CUV4XD and a couple of other boards.
> 	Still a mystery
> 5.	Incorrect PCI IRQ routing
> 	Fix: Mostly get a board with a correct BIOS. There are a couple of 
> 	cases people are looking at - some are fixed in 2.4.4 and -ac
> 	where magic IRQ lines are not visible directly in PCI space

Doesn't 2.4.1-ac1 onwards contain:

o	Workaround code for APIC problems with ne2k	(Maciej Rozycki)
	| this will break original 82489DX devices for now
	| ie _very_ early dual pentium boards

Got good reviews at the time, and I thought it was more general than
ne2k.  I don't remember it going forward to Linus (but I've not looked).

Hugh

