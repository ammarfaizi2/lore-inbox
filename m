Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268143AbUHKSHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268143AbUHKSHC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 14:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268142AbUHKSHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 14:07:02 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:19904 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268153AbUHKSCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 14:02:45 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Wed, 11 Aug 2004 11:02:10 -0700
User-Agent: KMail/1.6.2
Cc: Jon Smirl <jonsmirl@yahoo.com>, Martin Mares <mj@ucw.cz>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20040806211413.77833.qmail@web14926.mail.yahoo.com> <200408111004.02995.jbarnes@engr.sgi.com> <20040811172800.GB14979@kroah.com>
In-Reply-To: <20040811172800.GB14979@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408111102.10689.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 11, 2004 10:28 am, Greg KH wrote:
> On Wed, Aug 11, 2004 at 10:04:02AM -0700, Jesse Barnes wrote:
> > On Friday, August 6, 2004 2:14 pm, Jon Smirl wrote:
> > > Please check the code out and give it some testing. It will probably
> > > needs some adjustment for other platforms.
> >
> > Jon, this works on my machine too.  Greg, if it looks ok can you pull it
> > in? And can you add:
> >
> >  * (C) Copyright 2004 Silicon Graphics, Inc.
> >  *       Jesse Barnes <jbarnes@sgi.com>
> >
> > to pci-sysfs.c if you do?
>
> Care to send me a new patch?  Oh, and that copyright line needs to look
> like:
> * Copyright (c) 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
>
> to make it legal, or so my lawyers say :)

But I'm not the copyright holder, Silicon Graphics is, I just wanted people to 
know who to harass if something breaks :).

> > Greg was a little worried that your comment
> > 	/* .size is set individually for each device, sysfs copies it into
> > dentry */ might not be correct.
>
> I looked at the code, and he's right.  But it's pretty scary that it
> works correctly so I'd prefer to do it the way your patch did it (create
> a new attribute for every entry.)

Ok.  Jon?

Thanks,
Jesse
