Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263630AbRFSFMd>; Tue, 19 Jun 2001 01:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263648AbRFSFMN>; Tue, 19 Jun 2001 01:12:13 -0400
Received: from mcp.csh.rit.edu ([129.21.60.9]:37895 "EHLO mcp.csh.rit.edu")
	by vger.kernel.org with ESMTP id <S263630AbRFSFMG>;
	Tue, 19 Jun 2001 01:12:06 -0400
Date: Tue, 19 Jun 2001 01:06:34 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.6-pre3 breaks ReiserFS mount on boot
Message-ID: <20010619010633.G8295@fury.csh.rit.edu>
In-Reply-To: <Pine.LNX.4.30.0106182320510.2168-100000@coredump.sh0n.net> <Pine.LNX.4.30.0106182355500.118-100000@coredump.sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.30.0106182355500.118-100000@coredump.sh0n.net>; from spstarr@sh0n.net on Mon, Jun 18, 2001 at 11:57:16PM -0400
X-Operating-System: SunOS 5.8 (sun4u)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2001 at 11:57:16PM -0400, Shawn Starr wrote:
> 
> read_super_block: can't find a reiserfs filesystem on dev 03:42
> read_old_super_block: try to find super block in old location
> read_old_super_block: can't find a reiserfs filesystem on dev 03:42
> Kernel Panic: VFS: Unable to mount root fs on 03:42
> 
> my super block broke somewhere?

    Out of curiousity, what device are you trying to boot from? 03:42, at least
    according to linux/Documentation/devices.txt, corresponds to /dev/hda42.

    Is that really the disk you're trying to mount? I'm not familiar with how
    some IDE RAID controllers present disks, but it was the first thing I
    noticed.

    -Jeff

-- 
Jeff Mahoney
jeffm@suse.com
jeffm@csh.rit.edu
