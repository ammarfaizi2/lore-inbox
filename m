Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129688AbRBEOv5>; Mon, 5 Feb 2001 09:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129775AbRBEOvi>; Mon, 5 Feb 2001 09:51:38 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:50950 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S129688AbRBEOv0>;
	Mon, 5 Feb 2001 09:51:26 -0500
Date: Mon, 5 Feb 2001 15:51:14 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.1-ac1: W89c840 -- printout inconsistency?
Message-ID: <20010205155114.A13338@se1.cogenit.fr>
In-Reply-To: <Pine.GSO.3.96.1010205145202.18067L-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.GSO.3.96.1010205145202.18067L-100000@delta.ds2.pg.gda.pl>
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki <macro@ds2.pg.gda.pl> écrit :
[...]
>  While working on the CPU capabilities changes I noticed the W89c840
> driver prints a different cache alignment from what it really sets.  It's
> possible that it's the intended behaviour, but I really doubt it.  I don't
> have such a board and I haven't ever used the driver. 

Wouldn't this ("work around broken '486 PCI boards") fit better in
drivers/pci/quirks.c, somewhere around pci_fixup_device ?

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
