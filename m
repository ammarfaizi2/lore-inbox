Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131316AbRCNGvm>; Wed, 14 Mar 2001 01:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131327AbRCNGvd>; Wed, 14 Mar 2001 01:51:33 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:43936 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131316AbRCNGvX>;
	Wed, 14 Mar 2001 01:51:23 -0500
Date: Wed, 14 Mar 2001 01:50:41 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <200103140605.f2E65tS06714@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0103140146590.2506-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Mar 2001, Andreas Dilger wrote:

> On AIX, it is possible to import a volume group, and it automatically
> builds /etc/fstab entries from information stored in the fs.  Having the
> "last mounted on" would have the mount point info, and of course LVM
> would hold the device names.

Wait a minute. What happens if you bring /home from one box to another,
that already has /home? Corrupted /etc/fstab?

Let me put it that way: I don't understand why (if it is useful at all)
it is done in the fs. Looks like a wrong level...
							Cheers,
								Al

