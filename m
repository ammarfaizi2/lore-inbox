Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273102AbRI0Odj>; Thu, 27 Sep 2001 10:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273108AbRI0Od3>; Thu, 27 Sep 2001 10:33:29 -0400
Received: from vena.lwn.net ([206.168.112.25]:46600 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S273102AbRI0OdL>;
	Thu, 27 Sep 2001 10:33:11 -0400
Message-ID: <20010927143338.20730.qmail@eklektix.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Question about ioremap and io_remap_page_range 
From: corbet-lk@lwn.net (Jonathan Corbet)
In-Reply-To: Your message of "Thu, 27 Sep 2001 08:52:02 +0200."
             <Pine.LNX.4.33.0109270847070.2745-100000@localhost.localdomain> 
Date: Thu, 27 Sep 2001 08:33:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >      VIRT_ADDR = ioremap(BUS_ADDR); to map a section of PCI memory, and
> >      X_ADDR = virt_to_phys(VIRT_ADDR);
> 
> i'd suggest to read Documentation/DMA-mapping.txt in any recent kernel
> source, the bus_to_virt()/virt_to_phys() interface is obsolete and has
> been replaced by the pci_alloc_*/pci_map_*/pci_free_*() dynamic
> DMA-mapping API.

...or, of course, _Linux_Device_Drivers_, Second Edition, available online
at http://www.xml.com/ldd/chapter/book/index.html.  The DMA chapter covers
this API as well.

</self-promotion>

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
