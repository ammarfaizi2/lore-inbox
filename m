Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264144AbTF2Tn4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 15:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbTF2Tn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 15:43:56 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2176 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263782AbTF2Tne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 15:43:34 -0400
Date: Sun, 29 Jun 2003 21:06:22 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306292006.h5TK6MsN000182@81-2-122-30.bradfords.org.uk>
To: jamie@shareable.org, john@grabjohn.com
Subject: Re: File System conversion -- ideas
Cc: linux-kernel@vger.kernel.org, mlmoser@comcast.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > that the only reason to do it would be if you
> > > > could do it on a read-write filesystem without unmounting it.
> > >
> > > IMHO even if it requires the filesystem to be unmounted, it would
> > > still be useful.  More challenging to use - you'd have to boot and run
> > > from ramdisk, but much more useful than not being able to convert at all.
> > 
> > Only if it is the root filesystem, the filesystem of which generally
> > isn't going to affect overall performance that much.
>
> ...now use a single "/" filesystem on most systems, with a tiny
> "/boot" one to ensure booting.  With journalling, this risk of losing
> data this way is much lower than it used to be, and the old reason for
> using multiple partitions - to avoid having to fsck /usr - no longer applies.

Well, I prefer to have separate patitions to reduce fragmentation and
increase flexibility, but I can see there are reasons for having a
single root filesystem.

> > > But useless unless you have a second disk lying around that you don't
> > > use for anything but filesystem conversions.
> > 
> > Not at all.  You can just use unpartitioned space on your existing
> > disk.
>
> So you have as much space unpartitioned on your disks as you are
> actually using to store data?  I generally don't.

I probably average about 20% of the disk partitioned in my single disk
desktop boxes.

John.
