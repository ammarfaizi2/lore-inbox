Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130420AbQLIAlP>; Fri, 8 Dec 2000 19:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131200AbQLIAlH>; Fri, 8 Dec 2000 19:41:07 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2308 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130420AbQLIAku>; Fri, 8 Dec 2000 19:40:50 -0500
Subject: Re: question about tulip patch to set CSR0 for pci 2.0 bus
To: becker@scyld.com (Donald Becker)
Date: Sat, 9 Dec 2000 00:12:07 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012081558000.797-100000@vaio.greennet> from "Donald Becker" at Dec 08, 2000 04:09:47 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144XcX-0004gd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just in case you didn't catch it: this is not a PCI v2.0 vs. v2.1 issue.
> The older Tulips work great with PCI v2.0 and v2.1.  The bug is with longer
> bursts and a specific i486 chipset/motherboard.

Which chipset. I can then add it to the PCI quirks and we can do it nicely
in 2.4 so that drivers can test the pci quirk list
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
