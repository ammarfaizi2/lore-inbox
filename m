Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRALKVS>; Fri, 12 Jan 2001 05:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129730AbRALKU7>; Fri, 12 Jan 2001 05:20:59 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8977 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129431AbRALKUy>; Fri, 12 Jan 2001 05:20:54 -0500
Subject: Re: 2.4 ate my filesystem on rw-mount
To: tori@tellus.mine.nu (Tobias Ringstrom)
Date: Fri, 12 Jan 2001 10:22:31 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.30.0101120951270.7175-100000@svea.tellus> from "Tobias Ringstrom" at Jan 12, 2001 10:15:45 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14H1Ls-00047Z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is on a 450 MHz AMD-K6 with the following IDE controller:
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)

There are several people who have reported that the 2.4.0 VIA IDE driver
trashes hard disks like that. The 2.2 one also did this sometimes but only
with specific chipset versions and if you have dma autotune on (thats why
currently 2.2 refuses to do tuning on VP3)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
