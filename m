Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266150AbUBCWks (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 17:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUBCWks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 17:40:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54681 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266150AbUBCWkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 17:40:46 -0500
Date: Tue, 3 Feb 2004 23:40:21 +0100
From: Jens Axboe <axboe@suse.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       John Bradford <john@grabjohn.com>,
       Martin =?iso-8859-1?Q?Povoln=FD?= <xpovolny@aurora.fi.muni.cz>,
       linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Message-ID: <20040203224021.GK11683@suse.de>
References: <Pine.LNX.4.53.0402030839380.31203@chaos> <401FB78A.5010902@zvala.cz> <Pine.LNX.4.53.0402031018170.31411@chaos> <200402031602.i13G2NFi002400@81-2-122-30.bradfords.org.uk> <yw1xsmhsf882.fsf@kth.se> <200402031635.i13GZJ9Q002866@81-2-122-30.bradfords.org.uk> <20040203174606.GG3967@aurora.fi.muni.cz> <200402031853.i13Ir1e0003202@81-2-122-30.bradfords.org.uk> <yw1xn080m1d2.fsf@kth.se> <Pine.LNX.4.53.0402031509100.32547@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0402031509100.32547@chaos>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03 2004, Richard B. Johnson wrote:
> On Tue, 3 Feb 2004, [iso-8859-1] Måns Rullgård wrote:
> 
> > John Bradford <john@grabjohn.com> writes:
> >
> > > Regardless of specs, I don't know what the majority of devices in the
> > > real world actually do.  Maybe Jens and Alan, (cc'ed), can help.
> >
> > Just tested with an ASUS SCB-2408 in my laptop.  It gives read errors
> > after doing a fast erase, just like it should.
> >
> > --
> > Måns Rullgård
> > mru@kth.se
> > -
> 
> I had to borrow a R/W CDROM because most everybody uses CR-R only
> here. That's why it took so long to check. With SCSI, Linux 2.4.24,
> cdrecord fails to umount the drive before it burns it. The result
> is that the previous directory still remains at the mount-point.
> This, even though cdrecord ejected the drive to "re-read" its
> status.
> 
> Bottom line: If the CDROM isn't umounted first, you can still
> get a directory entry even though the CDROM has been written with
> about 500 magabytes of new data.

So what? Just because you can do it, doesn't mean it's a valid thing to
do. You can literally come up with thousands of similar weird things, if
you wanted to.

This whole discussion is silly and pointless.

-- 
Jens Axboe

