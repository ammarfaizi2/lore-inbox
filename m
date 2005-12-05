Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbVLESop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbVLESop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVLESop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:44:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27154 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750885AbVLESoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:44:44 -0500
Date: Mon, 5 Dec 2005 19:44:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Rob Landley <rob@landley.net>
Cc: David Ranson <david@unsolicited.net>, Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel@vger.kernel.org, Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051205184442.GI9973@stusta.de>
References: <20051203135608.GJ31395@stusta.de> <4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de> <200512042131.13015.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512042131.13015.rob@landley.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 09:31:12PM -0600, Rob Landley wrote:
> On Saturday 03 December 2005 11:53, Adrian Bunk wrote:
> > On Sat, Dec 03, 2005 at 05:17:41PM +0000, David Ranson wrote:
> > > Steven Rostedt wrote:
> > > >udev ;)
> > > >
> > > >http://seclists.org/lists/linux-kernel/2005/Dec/0180.html
> > >
> > > Ahh OK .. I don't use it, so wouldn't have been affected. That's one
> > > userspace interface broken during the series, does anyone have any more?
> >
> > - support for ipfwadm and ipchains was removed during 2.6
> > - devfs support was removed during 2.6
> > - removal of kernel support for pcmcia-cs is pending
> > - ip{,6}_queue removal is pending
> > - removal of the RAW driver is pending
> 
> So what you're upset about is the feature removal scheduling mechanism, which 
> usually gives a full year's warning, and the removal patch can be reversed 
> into a feature addition patch you can maintain outside the tree if you really 
> care?

I'm not upset about is the feature removal scheduling mechanism.

Please check who has most entries in 
Documentation/feature-removal-schedule.txt ...

The removal of features within the 2.6 series is an essential part of 
the current development model.

The problem is the lack of a long-living relatively stable series within 
the development model.

> Rob

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

