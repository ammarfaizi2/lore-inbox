Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbTFMOHD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 10:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265401AbTFMOHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 10:07:02 -0400
Received: from windsormachine.com ([206.48.122.28]:1041 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S265398AbTFMOHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 10:07:00 -0400
Date: Fri, 13 Jun 2003 10:20:46 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 3ware and two drive hardware raid1
In-Reply-To: <1055494998.5162.26.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0306131017010.16766-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jun 2003, Alan Cox wrote:

> On Iau, 2003-06-12 at 16:56, Mike Dresser wrote:
> > If i have a hardware raid1 array of two 120 gig Maxtor DiamondMax 9 drives
> > on a 3ware 7000-2.  Failure of one disk should not go all the way up to
> > the OS and cause the OS to report hard errors, and remount the drive as
> > read-only, right?
>
> Yes, but that won't help you if you lost both drives, which does happen
> now and again - overheating, bad PSU, using two drives from the same
> batch together and so on.
>
> The trace looks like you may have lost both drives.
>
> Alan
>

I'm heading out there today to take a look at the machine and see what
happened.  I'm rather dissappointed in the 3ware utility, it alternately
claims both drives are ok(./tw_cli info c1 is different from ./tw_cli
info c1 u0)

I was relying on that too much, and ignored the possiblity of two drive
failure.  Looks like both drives would have failed at exactly the same
time, which sounds like a power spike.

I just got a report that another Windows98 workstation is randomly
rebooting after an hour of uptime at the same facility, so I'm suspecting
hardware failure like you did.

I'll see what's up when I get there.  Powermax will tell me what's up.

Luckily the damage is contained to the data drive, I will be able to copy
everything over to a new set of drives and not lose anything that's not
trivially replaceable.

Thank you Alan,

Mike

