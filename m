Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBHSnk>; Thu, 8 Feb 2001 13:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130380AbRBHSnV>; Thu, 8 Feb 2001 13:43:21 -0500
Received: from cmr2.ash.ops.us.uu.net ([198.5.241.40]:5066 "EHLO
	cmr2.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S129098AbRBHSnQ>; Thu, 8 Feb 2001 13:43:16 -0500
Message-ID: <3A82E86C.14217D65@uu.net>
Date: Thu, 08 Feb 2001 13:41:48 -0500
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org, jhartmann@valinux.com
Subject: Re: [OT] Re: 2.4.x, drm, g400 and pci_set_master
In-Reply-To: <14EAB47C173C@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is preliminary support for pcigart in the dri tree.  I believe
some people have had some success with it.

Alex

Petr Vandrovec wrote:
> 
> On  8 Feb 01 at 13:14, Alex Deucher wrote:
> > Jeff Hartmann wrote:
> > > Petr Vandrovec wrote:
> 
> > > It does not use dynamic DMA mapping, because it doesn't do PCI DMA at
> > > all.  It uses AGP DMA.  Actually, it shouldn't be too hard to get it to
> > > work on the Alpha (just a few 32/64 bit issues probably.)  Someone just
> > > needs to get agpgart working on the Alpha, thats the big step.
> >
> > That shouldn't be too hard since many (all?) AGP alpha boards (UP1000's
> > anyway) are based on the AMD 751 Northbridge? And there is already
> > support for that in the kernel for x86.
> 
> My AlphaPC 164LX does not have AGP at all - and I want to get G200/G400 PCI
> working on it with dri, using 21174 features.
>                                                     Petr Vandrovec
>                                                     vandrove@vc.cvut.cz
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
