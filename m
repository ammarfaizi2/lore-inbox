Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319123AbSHTAlu>; Mon, 19 Aug 2002 20:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319124AbSHTAlu>; Mon, 19 Aug 2002 20:41:50 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:64516
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319123AbSHTAlt>; Mon, 19 Aug 2002 20:41:49 -0400
Date: Mon, 19 Aug 2002 17:45:22 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Kevin P. Fleming" <kpfleming@cox.net>
cc: Stanislav Brabec <utx@penguin.cz>, Paul Bristow <paul@paulbristow.net>,
       linux-kernel@vger.kernel.org
Subject: Re: ide-floppy & devfs - /dev entry not created if drive is empty
In-Reply-To: <3D618789.7040408@cox.net>
Message-ID: <Pine.LNX.4.10.10208191744570.458-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch is welcome here.

Drop it on AC and myself please. 

On Mon, 19 Aug 2002, Kevin P. Fleming wrote:

> There are patches at http://members.cox.net/kpfleming/ide-floppy to 
> resolve this.
> 
> Stanislav Brabec wrote:
> > Hallo Paul Bristow,
> > 
> > I have tested ide-floppy on my Linux 2.4.19 with ATAPI ZIP 100. I am
> > using devfs.
> > 
> > I found following problem:
> > 
> > If module ide-floppy is loaded and no disc is present in the drive,
> > /dev/ide/host0/bus1/target1/lun0/disc entry is not created. Later
> > inserted media cannot be checked in any way, because no /dev entry
> > exists.
> > 
> > Older kernels have also this behavior.
> > 
> > Fix: Create .../disc entry in all cases, even if no disc is present.
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

