Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSGMOeZ>; Sat, 13 Jul 2002 10:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSGMOeY>; Sat, 13 Jul 2002 10:34:24 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:19862 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S314278AbSGMOeX>;
	Sat, 13 Jul 2002 10:34:23 -0400
Date: Sat, 13 Jul 2002 09:31:21 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <1026574295.13885.0.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207130924110.7697-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jul 2002, Alan Cox wrote:

> On Sat, 2002-07-13 at 14:55, Thomas Molina wrote:
> > > So we'd have a legacy driver called oh say 'ide-cd' and a current one
> > > called 'ide-scsi'.
> > > 
> > > How does that change anything ?
> > 
> > It gives us the possibility to create a "clean" design for modern hardware 
> > while maintaining support for "legacy" hardware.  You don't have to carry 
> > around a lot of special cases and distort the design to take into account 
> 
> You missed the point. We -ALREADY- have ide-cd and ide-scsi. We already
> do what is described, and in fact Martin and co want to remove that
> seperation and stuff the gunge into the general atapi layer

I thought part of the issue was a redesign of the scsi mid-layer.  I was 
reacting to the scenario where support for older hardware was removed.  

