Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266614AbRGOOjd>; Sun, 15 Jul 2001 10:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266621AbRGOOjW>; Sun, 15 Jul 2001 10:39:22 -0400
Received: from weta.f00f.org ([203.167.249.89]:64387 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266614AbRGOOjI>;
	Sun, 15 Jul 2001 10:39:08 -0400
Date: Mon, 16 Jul 2001 02:39:11 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010716023911.A10576@weta.f00f.org>
In-Reply-To: <E15LL3Y-0000yJ-00@the-village.bc.nu> <0107142211300W.00409@starship> <20010715153607.A7624@weta.f00f.org> <01071515442400.05609@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01071515442400.05609@starship>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2001 at 03:44:14PM +0200, Daniel Phillips wrote:

    The only requirement here is that the checksum be correct.  And
    sure, that's not a hard guarantee because, on average, you will
    get a good checksum for bad data once every 4 billion power events
    that mess up the final superblock transfer.  Let me see, if that
    happens once a year, your data should still be good when the
    warrantee on the sun expires.  :-)

the sun will probably last a tad longer than that even contuing to
burn hydrogen, if you allow for helium burning, you will probably get
errors to sneak by

    Surely it can't be that *all* IDE disks can fail in that way?  And
    it seems the jury is still out on SCSI, I'm interested to see
    where that discussion goes.

Alan said *ALL* disks appear to lie, and I'm not going to argue with
him :)

I only have SCSI disks to test with, but they are hot-plug, so I guess
I can write a whole bunch of blocks with different numbers on them,
all over the disk, if I can figure out how to place SCSI barriers and
then pull the drive and see what gives?



   --cw
