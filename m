Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130397AbRASK5J>; Fri, 19 Jan 2001 05:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130769AbRASK47>; Fri, 19 Jan 2001 05:56:59 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:54546
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130397AbRASK4p>; Fri, 19 Jan 2001 05:56:45 -0500
Date: Fri, 19 Jan 2001 02:55:57 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Roman Zippel <zippel@fh-brandenburg.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        Rogier Wolff <R.E.Wolff@bitwizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.GSO.4.10.10101190951390.23899-100000@zeus.fh-brandenburg.de>
Message-ID: <Pine.LNX.4.10.10101190254140.24118-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2001, Roman Zippel wrote:

> Hi,
> 
> On Thu, 18 Jan 2001, Linus Torvalds wrote:
> 
> > > I agree, it's device dependent, but such hardware exists.
> > 
> > Show me any practical case where the hardware actually exists.
> 
> http://www.augan.com
> 
> > I do not know of _any_ disk controllers that let you map the controller
> > buffers over PCI. Which means that with current hardware, you have to
> > assume that the disk is the initiator of the PCI-PCI DMA requests. Agreed?

Err, first-party DMA devices do this, I think.
I do have some of these on the radar map.

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
