Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVFPJ0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVFPJ0a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 05:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVFPJ0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 05:26:30 -0400
Received: from extgw-uk.mips.com ([62.254.210.129]:2828 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S261246AbVFPJ0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 05:26:22 -0400
Date: Thu, 16 Jun 2005 10:22:57 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux/m68k <linux-m68k@vger.kernel.org>,
       Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
       Linux MIPS <linux-mips@vger.kernel.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] Jazzsonic driver updates
Message-ID: <20050616092257.GE5202@linux-mips.org>
References: <200503070210.j272ARii023023@hera.kernel.org> <Pine.LNX.4.62.0503221807160.20753@numbat.sonytel.be> <20050323100139.GB8813@linux-mips.org> <Pine.LNX.4.61.0506121454410.1470@loopy.telegraphics.com.au> <20050615114158.GA9411@linux-mips.org> <Pine.LNX.4.61.0506152220460.22046@loopy.telegraphics.com.au> <20050615142717.GD9411@linux-mips.org> <Pine.LNX.4.61.0506160218310.24328@loopy.telegraphics.com.au> <Pine.LNX.4.61.0506160336410.24908@loopy.telegraphics.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506160336410.24908@loopy.telegraphics.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 03:45:54AM +1000, Finn Thain wrote:

> > ... the chip then decides where in that area the recieved packet gets 
> > buffered ... and that is why I was asking for an alternative to 
> > vdma_log2phys...
> 
> But I forgot that it is possible to have the sonic chip store no more than 
> one packet in each buffer before moving to the next one in the ring 
> (though this isn't the case at present). So, as you say, vdma_log2phys 
> isn't really required.

Using that option doesn't really seem a good idea anyway.

  Ralf
