Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273793AbRIXEpI>; Mon, 24 Sep 2001 00:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273794AbRIXEpA>; Mon, 24 Sep 2001 00:45:00 -0400
Received: from vitelus.com ([64.81.243.207]:2575 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S273793AbRIXEor>;
	Mon, 24 Sep 2001 00:44:47 -0400
Date: Sun, 23 Sep 2001 21:45:08 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.10 + ext3
Message-ID: <20010923214507.A15014@vitelus.com>
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <1001280620.3540.33.camel@gromit.house> <9om4ed$1hv$1@penguin.transmeta.com>, <9om4ed$1hv$1@penguin.transmeta.com> <20010923193008.A13982@vitelus.com> <3BAEAC52.677C064C@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BAEAC52.677C064C@zip.com.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2001 at 08:45:22PM -0700, Andrew Morton wrote:
> So yes, it would be nice if an ext3-only kernel could drive ext2
> filesystems, but not super-important.

Cool.

> As for the other part of your suggestion: make ext2 "obsolete":
> I don't think so.  ext3 is wickedly complex, and ext2 is the
> reference filesystem for Linux.  It could be argued (at length) that
> the VFS and block layers were designed for, and are almost part of
> ext2.

I didn't mean to imply this. I love ext2 and still use it more than
probably any other filesystem (judging by numbers of partitions).

I simply was hoping for insted of:

 <*> EXT2 fs
 <*> EXT3 fs

(which is required today for most ext3-using people who want to do ext2
mounts)

... there could be:

 <*> EXT2 fs
 <*>   EXT3 journalling extensions

AFAIK this would eliminate a lot of duplicate kernel code for ext3
users.

But anyway, I'm not saying that ext2 should be made obsolete. I only
use ext3 on one machine and I would be much more annoyed if I had to
enable ext3 on the other machines than live with my current situation
of needing both ext2 and ext3 in the kernel on this particular one.

I think you understand ;-).
