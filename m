Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261927AbREMVoC>; Sun, 13 May 2001 17:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261922AbREMVnw>; Sun, 13 May 2001 17:43:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23816 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261924AbREMVnu>; Sun, 13 May 2001 17:43:50 -0400
Subject: Re: PROBLEM: IDE dma_intr error on VIA chipset
To: yann.chachkoff@mailandnews.com (gros)
Date: Sun, 13 May 2001 22:39:53 +0100 (BST)
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
In-Reply-To: <01051022565000.01576@Terminus.magellan.fpms.ac.be> from "gros" at May 10, 2001 10:56:50 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14z3aj-0006zE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Whenever a hard disk access is attempted, I get the following messages:
> 
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

That is a cable problem

> This error did not appear under previous versions of the kernel (2.2.x).

2.2.x doesnt attempt UDMA

> The hard disk does not show any sign of hardware failure under other 
> operating systems.

and windows fails down to lower speeds without telling you
