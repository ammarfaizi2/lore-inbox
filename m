Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273129AbRIOXvk>; Sat, 15 Sep 2001 19:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273123AbRIOXvf>; Sat, 15 Sep 2001 19:51:35 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:56565 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S273130AbRIOXuy>; Sat, 15 Sep 2001 19:50:54 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Sat, 15 Sep 2001 17:51:00 -0600
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2fs corruption again
Message-ID: <20010915175100.D1541@turbolinux.com>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BA3156C.9050704@korseby.net> <20010915144236.V26627@khan.acc.umu.se> <20010916001943.A984@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010916001943.A984@bug.ucw.cz>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 16, 2001  00:19 +0200, Pavel Machek wrote:
> Install crc loop device, and if disk does silent errors, you'll know.

Where do you store the CRCs?  It appears that they are written to another
block device.  Also, how do you initialize the CRC table for an existing
filesystem?

What would make this considerably more useful is to be able to write the
CRCs into a regular file, as it would be a bit of a pain to have a partition
for each CRC loop device to store the CRCs in.

Otherwise, it looks very useful, and could be handy in tracking down
reports like this where it is unclear where the data corruption is.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

