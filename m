Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267994AbTAIVQz>; Thu, 9 Jan 2003 16:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267997AbTAIVQz>; Thu, 9 Jan 2003 16:16:55 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:42244 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267994AbTAIVQy>; Thu, 9 Jan 2003 16:16:54 -0500
Date: Thu, 9 Jan 2003 21:25:30 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Antonino Daplas <adaplas@pol.net>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, <davidm@redhat.com>
Subject: Re: [Linux-fbdev-devel] [PATCH][FBDEV]: fb_putcs() and fb_setfont()
 methods
In-Reply-To: <Pine.GSO.4.21.0301092153150.8130-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.44.0301092124350.5660-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This I have no problem with. I'm willing to accept this. As long as data 
> > from the console layer is not touched. As for loadtiles one thing I like 
> > to address is memory allocation. It probable is good idea to do things 
> > like place the tile data in buffers allocated by pci_alloc_consistent.
> > The other fear is it will only support so many tiles. 
> 
> I think it's best to let the driver allocate it. That way the driver can put it
> where it's best suited. pci_alloc_consistent() is meant for PCI only.

Sorry about the confusiing. I was meaning things like pci_alloc_consistent 
of course would be handled for each driver that needed it.

