Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbSL3WsI>; Mon, 30 Dec 2002 17:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbSL3WsH>; Mon, 30 Dec 2002 17:48:07 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:56335 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265936AbSL3WsH>;
	Mon, 30 Dec 2002 17:48:07 -0500
Date: Mon, 30 Dec 2002 14:51:34 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jaroslav Kysela <perex@suse.cz>,
       Adam Belay <ambx1@neo.rr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pnp & pci structure cleanups
Message-ID: <20021230225134.GD814@kroah.com>
References: <Pine.LNX.4.33.0212291228200.532-100000@pnote.perex-int.cz> <20021230221212.GE32324@kroah.com> <1041289960.13684.180.camel@irongate.swansea.linux.org.uk> <20021230225012.GA19633@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021230225012.GA19633@gtf.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2002 at 05:50:12PM -0500, Jeff Garzik wrote:
> On Mon, Dec 30, 2002 at 11:12:40PM +0000, Alan Cox wrote:
> > On Mon, 2002-12-30 at 22:12, Greg KH wrote:
> > > Yeah!  Thanks for taking these fields out of pci.h, I really appreciate
> > > it.  I'll send this on to Linus in a bit.
> > 
> > Argh I was using those to implement a test "pci_compatible" driver so
> > that you could feed new pci idents to old drivers. Oh well 
> 
> Note that we need a way to do field replacement of PCI id tables.
> 
> I've been harping on that to various ears for years :)

And USB id tables.  A number of usb drivers are slowly adding module
paramater hacks to get around this, but it would be really nice to do
this "correctly" for all drivers.  Somehow...

> <tangent>
> I also want to add PCI revision id and mask to struct pci_device_id.
> </tangent>

Do any drivers need that today?  It shouldn't be that hard to do it, and
now is the time :)

thanks,

greg k-h
