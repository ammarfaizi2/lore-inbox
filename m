Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbTAYXcK>; Sat, 25 Jan 2003 18:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbTAYXcK>; Sat, 25 Jan 2003 18:32:10 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:37641
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S265037AbTAYXcJ>; Sat, 25 Jan 2003 18:32:09 -0500
Date: Sat, 25 Jan 2003 15:36:17 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
cc: stesmi@stesmi.com, aebr@win.tue.nl,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BIOS setup needed for LBA48?
In-Reply-To: <200301252120.h0PLKMnA001974@green.mif.pg.gda.pl>
Message-ID: <Pine.LNX.4.10.10301251501430.1744-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well doors may know this but the door-stop does not.  The driver has no
clue currently and so we are back to a pig in a poke.  I have never run
48-bit on AMD, and iirc NFORCE is a step-child of AMD.

It has everything to do with the DMA engine in the ASIC going south.

Cheers,


On Sat, 25 Jan 2003, Andrzej Krzysztofowicz wrote:

> 
> > Yes, if the host controller can not handle the double pump for dma
> > operations.  Disable DMA int it has to work.  If it does not, you have a
> > nice pile of junk, and it should be come a door.
> 
> Shouldn't the driver disable DMA automatically (not allow to enable it) ?
> Driver knows the controller type, knows the disk size ...
> 
> Or is it not so simple ?
> 
> 
> > On Sat, 25 Jan 2003, Stefan Smietanowski wrote:
> > 
> > > >>Can the Linux Kernel use the full drive (160GB/250GB/whatever)
> > > >>even though the BIOS doesn't? (LBA48)
> > > > 
> > > > Usually, yes.
> > > 
> > > Is there anything that could make "usually, yes" become a "no"?
> 
> -- 
> =======================================================================
>   Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
>   phone (48)(58) 347 14 61
> Faculty of Applied Phys. & Math.,   Gdansk University of Technology
> 

Andre Hedrick
LAD Storage Consulting Group

