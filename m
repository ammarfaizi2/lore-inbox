Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313562AbSDRGtI>; Thu, 18 Apr 2002 02:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314233AbSDRGtH>; Thu, 18 Apr 2002 02:49:07 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:4616 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313562AbSDRGtH>; Thu, 18 Apr 2002 02:49:07 -0400
Date: Wed, 17 Apr 2002 23:47:13 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Kent Borg <kentborg@borg.org>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nick@snowman.net,
        Baldur Norddahl <bbn-linux-kernel@clansoft.dk>,
        Mike Dresser <mdresser_l@windsormachine.com>,
        linux-kernel@vger.kernel.org
Subject: Re: IDE/raid performance
In-Reply-To: <20020417232634.GC574@matchmail.com>
Message-ID: <Pine.LNX.4.10.10204172344150.14953-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Already there ...

It is called "specific configuration".
I will add support for it in 2.4 soon enough, once I have satatisfied it
functionally works.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Wed, 17 Apr 2002, Mike Fedyk wrote:

> On Wed, Apr 17, 2002 at 01:47:16PM -0400, Kent Borg wrote:
> > 
> > On Wed, Apr 17, 2002 at 10:27:22AM -0700, Jeff V. Merkey wrote:
> > > From my analysis with 3Ware at 32 drive configurations, you really
> > > need to power the drives from a separate power supply is you have 
> > > more than 16 devices.  They really suck the power during initial 
> > > spinup.
> > 
> > It seems an obvious help would be to have the option of spinning up
> > the drives one at a time at 2-3 second intervals.  I know a fast drive
> > doesn't get up to speed in 3 seconds, but the nastiest draw is going
> > to be over by then.
> > 
> > A machine with 32 drives is pretty serious stuff and probably isn't
> > booting in a few seconds anyway--another 60-some seconds might be a
> > desirable option.
> > 
> > Does this exist anywhere?  Would it have to be a BIOS feature?
> 
> I doubt it.
> 
> All of the IDE drives I have used spin up when power is applied.  Most of
> the scsi (except for some really old ones) have a jumper that tells the
> drive to wait until it receives a message from the scsi controller to spin up.
> 
> I'd imagine that IDE would need some protocol spec changes before this could
> be supported (at least a "spin the drive up" message...).
> 
> Mike
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

