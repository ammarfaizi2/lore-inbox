Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261851AbRESQPX>; Sat, 19 May 2001 12:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbRESQPO>; Sat, 19 May 2001 12:15:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2564 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261851AbRESQOz>; Sat, 19 May 2001 12:14:55 -0400
Subject: Re: VIA's Southbridge bug: Latest (pseudo-)patch
To: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Sat, 19 May 2001 17:11:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        doelf@au-ja.de (Au-Ja), YipingChen@via.com.tw (Yiping Chen),
        support@msi.com.tw, info@msi-computer.de, support@via-cyrix.de,
        john@grulic.org.ar (John R Lenton)
In-Reply-To: <20010519110721.A1415@pua.nirvana> from "Axel Thimm" at May 19, 2001 11:07:21 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1519KE-0008Vg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This are the latest suggestions for handling the VIA Southbridge bug as
> derived from the hardware site www.au-ja.de (Many thanks to doelf).

I'd rather people left this except for the obvious fixed that were done for
non VIA northbridge combinations until 2.5. 2.4 is not an appropriate place
to play with possibly disk corrupting PCI hacks without documentation.

What is pathetic is that VIA have yet to place anything in the public domain
giving correct workarounds. People are picking at BIOSes praying to spot all
the changes (which may not be in the PCI registers even) because a vendor 
hasn't got the decency to admit they screwed up and then to issue proper fixes

If it had been a manufacturer in most respectable areas of business they'd be
recalling and reissuing components, and paying for the end resllers to notify
each customer 

Alan

