Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269920AbUJHMwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269920AbUJHMwY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 08:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269935AbUJHMwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 08:52:24 -0400
Received: from mail0.lsil.com ([147.145.40.20]:14000 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S269920AbUJHMwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 08:52:15 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BCAD6@exa-atlanta>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Sergey S. Kostyliov'" <rathamahata@ehouse.ru>, comsatcat@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: RE: Megaraid random loss of luns
Date: Fri, 8 Oct 2004 08:51:58 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I _highly_ recommend to replace the default driver with the latest 2.20.4.0
driver and retry.

Thanks
-Atul Mukker
LSI Logic 

> -----Original Message-----
> From: Sergey S. Kostyliov [mailto:rathamahata@ehouse.ru]
> Sent: Friday, October 08, 2004 3:48 AM
> To: comsatcat@earthlink.net
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Megaraid random loss of luns
> 
> On Friday 01 October 2004 03:15, comsatcat wrote:
> > I'm not sure if this is the correct list or not to ask about this, but
> > it seemed proper.  We have a machine running the megaraid module that
> > came with vanilla 2.6.7.  Earlier this morning all the luns suddenly
> > disappeared for no apparent reason.
> >
> > The kernel logged the following messages:
> <cut>
> > Could someone provide an explanation of what exactly went wrong if
> > possible (if the megaraid driver was at fault or the raid controller)?
> > Are there any known bugs with large raid 5 volumes using the megaraid
> > driver?  The volumes are each 325G (4 total) in this situation.  We've
> > experienced other problems with the megaraid driver such as 1TB luns
> > (two per controller) loosing almost all disks in them (I thought this
> > was a controller problem at first, but we have 2 different models of
> > controllers, 1 LSI PCI 320-4x and 2 LSI PCI 320-2x's, on 3 identical
> > hardware configurations and have been experiencing problems on all of
> > them).
> I've got exactly the same issues for four of my machines under heavy IO
> load
> (all are raid1) with megaraid 320-{1,2} and megaraid 160 (Series 475).
> kernel 2.6.8.1. For me it looks like a driver issue rather than  a
> particular
> controller problem ...
> 
> --
> Sergey S. Kostyliov <rathamahata@ehouse.ru>
> Jabber ID: rathamahata@jabber.org
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
