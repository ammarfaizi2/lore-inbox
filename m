Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282671AbRK0ATD>; Mon, 26 Nov 2001 19:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282668AbRK0ASv>; Mon, 26 Nov 2001 19:18:51 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:4870 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S282666AbRK0ASc>; Mon, 26 Nov 2001 19:18:32 -0500
Date: Mon, 26 Nov 2001 16:16:12 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Martin Eriksson <nitrax@giron.wox.org>,
        Steve Brueggeman <xioborg@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
In-Reply-To: <20011126170631.O730@lynx.no>
Message-ID: <Pine.LNX.4.10.10111261614190.9508-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Andreas Dilger wrote:

> On Nov 27, 2001  00:49 +0100, Martin Eriksson wrote:
> > I sure think the drives could afford the teeny-weeny cost of a power failure
> > detection unit, that when a power loss/sway is detected, halts all
> > operations to the platters except for the writing of the current sector.
> 
> What happens if you have a slightly bad power supply?  Does it immediately
> go read only all the time?  It would definitely need to be able to
> recover operations as soon as the power was "normal" again, even if this
> caused basically "sync" I/O to the disk.  Maybe it would be able to
> report this to the user via SMART, I don't know.

ATA/SCSI SMART is already DONE!

To bad most people have not noticed.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project


