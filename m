Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262168AbRFHPvO>; Fri, 8 Jun 2001 11:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264023AbRFHPvE>; Fri, 8 Jun 2001 11:51:04 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:1540 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S264021AbRFHPuz>;
	Fri, 8 Jun 2001 11:50:55 -0400
Date: Wed, 6 Jun 2001 21:42:22 +0000
From: Pavel Machek <pavel@suse.cz>
To: Nick Urbanik <nicku@vtc.edu.hk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Cannot mount old ext2 cdrom, but e2fsck shows no problems
Message-ID: <20010606214222.C38@toy.ucw.cz>
In-Reply-To: <3B1C8C1B.E3946FE1@vtc.edu.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B1C8C1B.E3946FE1@vtc.edu.hk>; from nicku@vtc.edu.hk on Tue, Jun 05, 2001 at 03:36:59PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HIi!

> I made 18 ext2 cdroms in October 1998 using an old (new at the time) Red
> Hat system.  Now I can't mount them.  e2fsck shows no problems.  I also
> can dd them to a file, then mount the file.  But I want to be able to
> simply access them directly.  Current system: RH 7.1 with all updates.
> 
> Sorry, I can't remember the exact command I used to create the images.
> 
> I also want to better understand the output of dumpe2fs, and how to
> relate this to mount.
> 
> I will be very grateful for any help that increases my understanding of
> what is going on.
> 
> $ sudo mount -t ext2 /dev/scd0 /cdrom -o ro
> mount: wrong fs type, bad option, bad superblock on /dev/scd0,
>        or too many mounted file systems

Try -o loop.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

