Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289839AbSBEXHX>; Tue, 5 Feb 2002 18:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289850AbSBEXHN>; Tue, 5 Feb 2002 18:07:13 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:34208 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S289839AbSBEXHH>; Tue, 5 Feb 2002 18:07:07 -0500
Date: Tue, 5 Feb 2002 15:06:49 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Andre Hedrick <andre@linuxdiskcert.org>
cc: Russell King <rmk@arm.linux.org.uk>, Patrick Mochel <mochel@osdl.org>,
        Pavel Machek <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driverfs support for motherboard devices
In-Reply-To: <Pine.LNX.4.10.10202051445400.6350-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0202051505040.15039-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2002, Andre Hedrick wrote:

> On Tue, 5 Feb 2002, Russell King wrote:
> 
> > On Tue, Feb 05, 2002 at 10:43:14AM -0800, Patrick Mochel wrote:
> > > I think that ide should get its own bus, as a child of the ide controller. 
> > > I haven't looked at ide yet at all. But, on most modern systems, the ide 
> > > controller is a function of the southbridge, so ide devices should go 
> > > under that. Like what the usb stuff does now...
> > 
> > What about, say, a Promise PCI IDE card?  You really need to reference
> > the parent PCI device when the is one.
> 
> LOL, how about ones that are quad-channel with a DEC-Bridge to slip the
> local BUSS?
> 
> Cheers,

or an i960rp and 3 promise 20276's, I've got two of those...

joelja
 
> 
> Andre Hedrick
> Linux Disk Certification Project                Linux ATA Development
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
The accumulation of all powers, legislative, executive, and judiciary, in 
the same hands, whether of one, a few, or many, and whether hereditary, 
selfappointed, or elective, may justly be pronounced the very definition of
tyranny. - James Madison, Federalist Papers 47 -  Feb 1, 1788


