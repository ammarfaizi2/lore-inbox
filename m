Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280956AbRKGUXK>; Wed, 7 Nov 2001 15:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280959AbRKGUXA>; Wed, 7 Nov 2001 15:23:00 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:38651 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280956AbRKGUWu>;
	Wed, 7 Nov 2001 15:22:50 -0500
Date: Wed, 7 Nov 2001 13:21:25 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
Message-ID: <20011107132125.I5922@lynx.no>
Mail-Followup-To: Anton Altaparmakov <aia21@cam.ac.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111071558090.29292-100000@mustard.heime.net> <E161UYR-0004S5-00@the-village.bc.nu> <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Wed, Nov 07, 2001 at 06:40:21PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 07, 2001  18:40 +0000, Anton Altaparmakov wrote:
> Hm, while still on the default RH7.2 kernel using ext3 on all partitions I 
> flicked the reset switch accidentally (wrong reset switch it was...) and 
> when coming back up it fscked (I didn't touch anything - didn't even notice 
> any 5 second thing but I wasn't looking at this screen) and it found two 
> lost inodes (I got two entries in lost and found). So it still needs to 
> fsck by the looks of it?

Well, e2fsck will always run if the filesystem has an error marked in it.
When was the last time you ran e2fsck on the fs before you converted to
ext3?  It is possible that these lost inodes were in the fs before you
converted?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

