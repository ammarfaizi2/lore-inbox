Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268130AbTBSAyP>; Tue, 18 Feb 2003 19:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268132AbTBSAyP>; Tue, 18 Feb 2003 19:54:15 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9355
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268130AbTBSAyN>; Tue, 18 Feb 2003 19:54:13 -0500
Subject: Re: PATCH: make the sl82c105 work again
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1045601367.570.56.camel@zion.wanadoo.fr>
References: <E18lCZa-0006Ec-00@the-village.bc.nu>
	 <20030218185309.C9785@flint.arm.linux.org.uk>
	 <1045601367.570.56.camel@zion.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045620358.25795.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 19 Feb 2003 02:05:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-18 at 20:49, Benjamin Herrenschmidt wrote:
> and when setting xfer mode. Not on hdparm -d1. I'm still wondering
> what is the best fix for that. For ide-pmac, I did the later
> (only do the job in check()), but I also think we should change
> ide.c to actually call hwif->ide_dma_check() when DMA is turned
> ON with hdparm instead of ide_dma_on().

I think thats the right change for 2.5 at least

