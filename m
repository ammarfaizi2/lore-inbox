Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279163AbRJZUq6>; Fri, 26 Oct 2001 16:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279169AbRJZUqs>; Fri, 26 Oct 2001 16:46:48 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:23027 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S279163AbRJZUqp>; Fri, 26 Oct 2001 16:46:45 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 26 Oct 2001 14:46:42 -0600
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Looking for bsd file system tools under linux .
Message-ID: <20011026144642.V23590@turbolinux.com>
Mail-Followup-To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
	Linux Kernel Maillist <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110261427220.5754-100000@filesrv1.baby-dragons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110261427220.5754-100000@filesrv1.baby-dragons.com>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 26, 2001  14:58 -0400, Mr. James W. Laferriere wrote:
> 	Hello All ,  I am looking for pointers to bsd file system tools
> 	for use under Linux .  A couple of searchs left me empty .
> 	I am hoping someone here has a pointer or two .
> 	What this is for is ,  I have a disk drive off of a bsd4.2 system
> 	that may have been used in a penetration of another system .
> 	The fstab file points at there having been a /var file system but
> 	when I do a 'fdisk -l' a partition for /var does not exist .  Only
> 	two partitions are there for / & /usr .  I am looking for some
> 	tools to see if the partiton was removed or if 'parted' may have
> 	been been used to squeese it out .  Thank you for any pointers .

You may need to have BSD partition support enabled in the kernel in order
to access the partition.  I would think fdisk would be able to show the
right data in all cases, but I've never used BSD partitions before either.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

