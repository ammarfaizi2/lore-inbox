Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270314AbRIRMk6>; Tue, 18 Sep 2001 08:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270577AbRIRMks>; Tue, 18 Sep 2001 08:40:48 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15664 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S270314AbRIRMk2>; Tue, 18 Sep 2001 08:40:28 -0400
Date: Tue, 18 Sep 2001 14:40:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Helge Hafting <helgehaf@idb.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918144054.G2723@athlon.random>
In-Reply-To: <20010918115713.C2723@athlon.random> <Pine.GSO.4.21.0109180558150.25323-100000@weyl.math.psu.edu> <20010918121716.D2723@athlon.random> <3BA72A8F.2C9CF506@idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA72A8F.2C9CF506@idb.hist.no>; from helgehaf@idb.hist.no on Tue, Sep 18, 2001 at 01:05:51PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 01:05:51PM +0200, Helge Hafting wrote:
> Andrea Arcangeli wrote:
> 
> > very clear now, thanks. I though the fs you were talking about was
> > mounted on the blkdev, while it is instead the one where the blkdev
> > inode cames from. Usually people keeps bldkev in /dev and nobody
> > unmounts /dev that's why I didn't noticed and thought about it, sorry.
> > 
> Don't assume "nobody does..."  There is always someone that do.
> 
> This particular one will easily come up for anybody who
> develop boot floppies:
> 
> 1.  Mount the boot floppy at /mnt
> 2.  Test the device files in /mnt/dev, _perhaps by using them
>     in every way imaginable_
> 3.  Umount the boot floppy. - There goes /mnt/dev and a bunch
>     of block devices.  
> 
> Umounting some dev/ is common enough.

Of course, that's a bug and it must be fixed.

Andrea
