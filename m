Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268762AbRG0DCJ>; Thu, 26 Jul 2001 23:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268761AbRG0DCA>; Thu, 26 Jul 2001 23:02:00 -0400
Received: from [209.226.93.226] ([209.226.93.226]:31992 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S268759AbRG0DBt>; Thu, 26 Jul 2001 23:01:49 -0400
Date: Thu, 26 Jul 2001 23:01:34 -0400
Message-Id: <200107270301.f6R31Y401074@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: aia21@cus.cam.ac.uk (Anton Altaparmakov), linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] 2.4.7 Add support for Dynamic Disks
In-Reply-To: <200107262352.f6QNqbf488387@saturn.cs.uml.edu>
In-Reply-To: <E15Pu2w-0005bt-00@libra.cus.cam.ac.uk>
	<200107262352.f6QNqbf488387@saturn.cs.uml.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Albert D. Cahalan writes:
> > - Patch adds support for Dynamic Disks which are introduced by Windows
> > 2000 and are also used by Windows XP, thus allowing people with dual-boot
> > configurations access to their Windows dynamic disk partitions from Linux.
> ...
> > Note that we just do it for all partitions in order. We perform no special
> > treatment when partitions are part of raid arrays, etc, we just create
> > each member partition as one device (hdb5, etc), handling raid arrays is
> > up to future extensions / user space tools / the users to deal with.
> 
> Linux has long held an interoperability advantage over UNIX and BSD
> due to the use of normal PC disk partitions.
> 
> Now a new standard is here. We must swallow our pride and accept it,
> tossing out our old LVM format. It's time to embrace and extend.

I don't see why we can't have both. It's just another partition
format.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
