Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267265AbTAGAUn>; Mon, 6 Jan 2003 19:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267268AbTAGAUn>; Mon, 6 Jan 2003 19:20:43 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:54283
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267265AbTAGAUm>; Mon, 6 Jan 2003 19:20:42 -0500
Date: Mon, 6 Jan 2003 16:28:05 -0800 (PST)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
In-Reply-To: <3E19B401.7A9E47D5@linux-m68k.org>
Message-ID: <Pine.LNX.4.10.10301061625150.421-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2003, Roman Zippel wrote:

> Hi,
> 
> > If you know anything about iSCSI RFC draft and how storage truly works.
> > Cisco gets it wrong, they do not believe in supporting the full RFC.
> > So you get ERL=0, and now they turned of the "Header and Data Digests",
> > this is equal to turning off the iCRC in ATA, or CRC in SCSI between the
> > controller and the device.  For those people who think removing the
> > checksum test for the integrity of the data and command operations, you
> > get what you deserve.
> 
> Ever heard of TCP checksums? Ever heard of ethernet checksums? Which
> transport doesn't use checksums nowadays? The digest makes only sense if
> you can generate it for free in hardware or for debugging, otherwise
> it's only a waste of cpu time. This makes the complete ERL 1 irrelevant
> for a software implementation. With block devices you can even get away
> with just ERL 0 to implement transparent recovery.

Please continue to think of TCP checksums as valid for a data transport,
you data will be gone soon enough.

Initiator == Controller
Target == Disk
iSCSI == cable or ribbon

Please turn off the CRC on your disk drive and see if you still have data.

Cheers,

Andre Hedrick, CTO & Founder 
iSCSI Software Solutions Provider
http://www.PyXTechnologies.com/

