Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135251AbRD3Odk>; Mon, 30 Apr 2001 10:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135267AbRD3Oda>; Mon, 30 Apr 2001 10:33:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46856 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135251AbRD3OdL>; Mon, 30 Apr 2001 10:33:11 -0400
Subject: Re: pci/quirks.c - VIA PCI latency in 2.4.4
To: c.p.botha@its.tudelft.nl
Date: Mon, 30 Apr 2001 15:33:49 +0100 (BST)
Cc: kiza@gmx.net, linux-kernel@vger.kernel.org
In-Reply-To: <20010430155844.E8052@dutidad.twi.tudelft.nl> from "Charl P. Botha" at Apr 30, 2001 03:58:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uEkK-00088U-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I should probably clarify.  The fix is *only* valid for the VIA VT8363 host to
> pci bridge, therefore the test for the 686B south bridge only gets done if a
> 8363 is found.  
> 
> No fix is known for intel pci-to-host bridges with the 686B south bridge,
> and in the case of the AMD-761 chipset, there are certain BIOS settings you
> can change.  See: http://home.tiscalinet.de/au-ja/review-kt133a-4-en.html

The -ac tree has the ability to kill IDE DMA across the entire system. It may
be this is what should be done with all hybrid setups where there is no known
fix.

