Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbTAYPuQ>; Sat, 25 Jan 2003 10:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTAYPuP>; Sat, 25 Jan 2003 10:50:15 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:22025
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261337AbTAYPuP>; Sat, 25 Jan 2003 10:50:15 -0500
Date: Sat, 25 Jan 2003 07:54:38 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Stefan Smietanowski <stesmi@stesmi.com>
cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: BIOS setup needed for LBA48?
In-Reply-To: <3E32A97A.4060105@stesmi.com>
Message-ID: <Pine.LNX.4.10.10301250753001.1744-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, if the host controller can not handle the double pump for dma
operations.  Disable DMA int it has to work.  If it does not, you have a
nice pile of junk, and it should be come a door.

On Sat, 25 Jan 2003, Stefan Smietanowski wrote:

> >>Can the Linux Kernel use the full drive (160GB/250GB/whatever)
> >>even though the BIOS doesn't? (LBA48)
> > 
> > Usually, yes.
> 
> Is there anything that could make "usually, yes" become a "no"?
> 
> // Stefan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

