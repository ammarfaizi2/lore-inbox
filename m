Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266056AbUBCTZb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266051AbUBCTYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:24:01 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:12419 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266109AbUBCSoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 13:44:07 -0500
Date: Tue, 3 Feb 2004 18:53:01 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402031853.i13Ir1e0003202@81-2-122-30.bradfords.org.uk>
To: Martin =?iso-8859-2?Q?Povoln=FD?= <xpovolny@aurora.fi.muni.cz>
Cc: M?ns Rullg?rd <mru@kth.se>, linux-kernel@vger.kernel.org, axboe@suse.de,
       alan@redhat.com
In-Reply-To: <20040203174606.GG3967@aurora.fi.muni.cz>
References: <20040203131837.GF3967@aurora.fi.muni.cz>
 <Pine.LNX.4.53.0402030839380.31203@chaos>
 <401FB78A.5010902@zvala.cz>
 <Pine.LNX.4.53.0402031018170.31411@chaos>
 <200402031602.i13G2NFi002400@81-2-122-30.bradfords.org.uk>
 <yw1xsmhsf882.fsf@kth.se>
 <200402031635.i13GZJ9Q002866@81-2-122-30.bradfords.org.uk>
 <20040203174606.GG3967@aurora.fi.muni.cz>
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > I.E.
> > > >
> > > > mount disc
> > > > view contents
> > > > unmount disc
> > > > erase disc - but don't erase the CD-R drive's cache of the media
> > > > mount disc
> > > > view old contents of the media from the CD-R drive's cache
> 
> That's it exactly.
> 

[snip]
> > > 
> > > If that's the case, the drive is broken.  We can't help that.
> 
> That's possible, it's a cheap combo from LG. I have even seen it on the
> list of droken drives (the ones that died trying to install mandrake)
> [http://archives.mandrakelinux.com/expert/2003-10/msg02116.php], even
> though it's a CDRW.
> 
> It that case sorry for bothering you with crappy hw problem.
> 
> > 
> > Is it actually a requirement for drives to support anything other than
> > a full erase properly?  Is the 'fast' erase valid per spec, or does it
> > just happen to work on 99% of devices?  Is this problem reproducable
> > if a full erase is done instead of a fast erase?
> 
> Yes, it is:

[snip]

> Could it be also cdrecord problem? Couldn't cdrecord execute some command
> to flush the cdrom's cache after erasing?

Jens said there was no specific command to do this in another post,
although I would have thought that a generic device reset command
should clear the cache, but be sub-optimal for devices which clear the
cache themselves on an erase.

Regardless of specs, I don't know what the majority of devices in the
real world actually do.  Maybe Jens and Alan, (cc'ed), can help.

John.
