Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266040AbUBCQ2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 11:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUBCQ0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 11:26:33 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:57986 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266041AbUBCQ0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 11:26:19 -0500
Date: Tue, 3 Feb 2004 16:35:19 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402031635.i13GZJ9Q002866@81-2-122-30.bradfords.org.uk>
To: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Cc: xpovolny@aurora.fi.muni.cz
In-Reply-To: <yw1xsmhsf882.fsf@kth.se>
References: <20040203131837.GF3967@aurora.fi.muni.cz>
 <Pine.LNX.4.53.0402030839380.31203@chaos>
 <401FB78A.5010902@zvala.cz>
 <Pine.LNX.4.53.0402031018170.31411@chaos>
 <200402031602.i13G2NFi002400@81-2-122-30.bradfords.org.uk>
 <yw1xsmhsf882.fsf@kth.se>
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=):
> John Bradford <john@grabjohn.com> writes:
> 
> >> That's not what he said and, I assure you that if he unmounted
> >> it there would not be any buffers to flush. Execute `man umount`.
> >
> > I think the original poster was referring to the cache on the device.
> >
> > I.E.
> >
> > mount disc
> > view contents
> > unmount disc
> > erase disc - but don't erase the CD-R drive's cache of the media
> > mount disc
> > view old contents of the media from the CD-R drive's cache
> 
> If that's the case, the drive is broken.  We can't help that.

Is it actually a requirement for drives to support anything other than
a full erase properly?  Is the 'fast' erase valid per spec, or does it
just happen to work on 99% of devices?  Is this problem reproducable
if a full erase is done instead of a fast erase?

I've added the original poster to the CC list.

John.
