Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131715AbRCUSPL>; Wed, 21 Mar 2001 13:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRCUSPC>; Wed, 21 Mar 2001 13:15:02 -0500
Received: from smtp.primusdsl.net ([209.225.164.93]:19464 "EHLO
	mailhost.digitalselect.net") by vger.kernel.org with ESMTP
	id <S131707AbRCUSOx>; Wed, 21 Mar 2001 13:14:53 -0500
Date: Wed, 21 Mar 2001 13:15:59 -0500
From: James Lewis Nance <jlnance@intrex.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: spinlock usage - ext2_get_block, lru_list_lock
Message-ID: <20010321131559.A28454@bessie.dyndns.org>
In-Reply-To: <99am8l$8mk$1@penguin.transmeta.com> <Pine.GSO.4.21.0103211203090.739-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0103211203090.739-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Mar 21, 2001 at 12:16:47PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2001 at 12:16:47PM -0500, Alexander Viro wrote:

> Obext2: <plug>
> Guys, help with testing directories-in-pagecache patch. It works fine
> here and I would really like it to get serious beating.
> Patch is on ftp.math.psu.edu/pub/viro/ext2-dir-patch-b-S2.gz (against
> 2.4.2, but applies to 2.4.3-pre* too).
> </plug>

I would love to test this patch, but I really dont want it touching my other
ext2 file systems (like /).  I assume it would be possible to copy the ext2
code over to something like linux/fs/extnew, patch that, and then mount my
scratch partitions as extnew.  I can try an cook something like this up, but
I thought you might already have it, so I am posting here to see.

Thanks,

Jim
