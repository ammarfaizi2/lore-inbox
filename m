Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBHScK>; Thu, 8 Feb 2001 13:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbRBHScB>; Thu, 8 Feb 2001 13:32:01 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:16144 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129098AbRBHSby>;
	Thu, 8 Feb 2001 13:31:54 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alex Deucher <adeucher@UU.NET>
Date: Thu, 8 Feb 2001 19:30:36 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: [OT] Re: 2.4.x, drm, g400 and pci_set_master
CC: linux-kernel@vger.kernel.org, jhartmann@valinux.com
X-mailer: Pegasus Mail v3.40
Message-ID: <14EAB47C173C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Feb 01 at 13:14, Alex Deucher wrote:
> Jeff Hartmann wrote:
> > Petr Vandrovec wrote:

> > It does not use dynamic DMA mapping, because it doesn't do PCI DMA at
> > all.  It uses AGP DMA.  Actually, it shouldn't be too hard to get it to
> > work on the Alpha (just a few 32/64 bit issues probably.)  Someone just
> > needs to get agpgart working on the Alpha, thats the big step.
> 
> That shouldn't be too hard since many (all?) AGP alpha boards (UP1000's
> anyway) are based on the AMD 751 Northbridge? And there is already
> support for that in the kernel for x86. 

My AlphaPC 164LX does not have AGP at all - and I want to get G200/G400 PCI 
working on it with dri, using 21174 features.
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
