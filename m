Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131660AbRAOVvF>; Mon, 15 Jan 2001 16:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131674AbRAOVuz>; Mon, 15 Jan 2001 16:50:55 -0500
Received: from mail.digitalme.com ([193.97.97.75]:51725 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S131660AbRAOVuk>;
	Mon, 15 Jan 2001 16:50:40 -0500
Subject: Re: Total loss with 2.4.0 (release)
From: Trever Adams <vichu@digitalme.com>
CC: linux-kernel@vger.kernel.org
Date: Mon, 15 Jan 2001 21:50:29 GMT
MIME-Version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20010115215047Z131660-403+523@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a similar experience.  All I can say is windows 98 
and ME seem to have it out for Linux drives running late 
2.3.x and 2.4.0 test and release.  I had windows completely 
fry my Linux drive and I lost everything.  I had some old 
backups and was able to restore at least the majority of 
older stuff.

Sorry and good luck.

> Hi all,
> 
> I managed to kill my dear files and if anyone can help 
I'd be very
> thankful. The events leading to this were something like:
> Happy system with 2.4.0-test9 -> update to 2.4.0 
(release) -> works
> nicely; no complaints of any kind (no crc errors or dma-
disabling) ->
> reboot -> play Diablo II for some time (win98) -> restart 
linux ->
> VFS: cannot mount root. 
> I have two ext2 partitions plus root and one of them is 
on another disk
> (same ide lead, however) and it survived with no errors.
> 
> When I ran e2fsck (1.18) on root partition, in addition 
to having to
> run it many times before succeeding (segfaulted 
sometimes), nothing was
> left in the partition except lost+found with lots of
> files. Valid superblock wasn't found at 0, but at 8193.
> 
> I really don't get what would have caused this or how to 
cure it. I still
> have my /home in need of repairing, but I won't be 
running fsck on it with
> this good expectancy-of-recovery (I actually tried once 
with a backup on
> another disk and it resulted two VERY old directoried, 
everything else was
> lost...and found(?)).
> 
> I also updated my machine from VIA MVP3 based K6II to VIA 
KT133 (with 868B
> southbridge - ATA100, that is) based Duron, but linux 
(2.4.0-test9) worked
> fine with both configurations. I think this might be some 
sort of DMA
> problem.  
> 
> I read from kernel notes that ac1 fixes root umount 
handling. Might that
> be connected with the symptoms I had? If anyone has any 
suggestions,
> please post them. I would, at least, like to know how 
could I verify if
> the filesystem is really messed (for example, overwritten 
with something
> at the bus at the time) or if it's just some minor issue 
that confuses
> fsck totally.
> 
> -- Heikki Lindholm
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
