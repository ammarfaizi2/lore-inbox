Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265947AbSL3Wly>; Mon, 30 Dec 2002 17:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbSL3Wly>; Mon, 30 Dec 2002 17:41:54 -0500
Received: from havoc.daloft.com ([64.213.145.173]:8421 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S265947AbSL3Wlx>;
	Mon, 30 Dec 2002 17:41:53 -0500
Date: Mon, 30 Dec 2002 17:50:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Jaroslav Kysela <perex@suse.cz>,
       Adam Belay <ambx1@neo.rr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pnp & pci structure cleanups
Message-ID: <20021230225012.GA19633@gtf.org>
References: <Pine.LNX.4.33.0212291228200.532-100000@pnote.perex-int.cz> <20021230221212.GE32324@kroah.com> <1041289960.13684.180.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041289960.13684.180.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2002 at 11:12:40PM +0000, Alan Cox wrote:
> On Mon, 2002-12-30 at 22:12, Greg KH wrote:
> > Yeah!  Thanks for taking these fields out of pci.h, I really appreciate
> > it.  I'll send this on to Linus in a bit.
> 
> Argh I was using those to implement a test "pci_compatible" driver so
> that you could feed new pci idents to old drivers. Oh well 

Note that we need a way to do field replacement of PCI id tables.

I've been harping on that to various ears for years :)

<tangent>
I also want to add PCI revision id and mask to struct pci_device_id.
</tangent>

	Jeff



