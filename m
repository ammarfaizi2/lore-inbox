Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132686AbRDQOr0>; Tue, 17 Apr 2001 10:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132693AbRDQOrQ>; Tue, 17 Apr 2001 10:47:16 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2575 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132686AbRDQOrE>; Tue, 17 Apr 2001 10:47:04 -0400
Subject: Re: Possible problem with zero-copy TCP and sendfile()
To: kas@informatics.muni.cz (Jan Kasprzak)
Date: Tue, 17 Apr 2001 15:48:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010417151007.F916@informatics.muni.cz> from "Jan Kasprzak" at Apr 17, 2001 03:10:07 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pWmr-0002UK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	The long story: My server is Athlon 850 on ASUS A7V, 256M RAM.
> Seven IDE discs, one SCSI disc. The controllers and NIC are as follows
> (output of lspci):

See the VIA chipset report on www.theregister.co.uk about corruption problems
with VIA chipsets. The cases seen on Linux included short and also sometimes
stale/corrupted DMA transfers.

Nothing in your report says it is or isnt going to be a VIA chipset problem
but once a fixed BIOS is out for your board that would be a good first step.
If it still does it then, its worth digging for kernel naughties

