Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129273AbRBURTV>; Wed, 21 Feb 2001 12:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129281AbRBURTL>; Wed, 21 Feb 2001 12:19:11 -0500
Received: from ns.caldera.de ([212.34.180.1]:3601 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129273AbRBURTF>;
	Wed, 21 Feb 2001 12:19:05 -0500
Date: Wed, 21 Feb 2001 18:18:24 +0100
Message-Id: <200102211718.SAA25997@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: andrea@suse.de (Andrea Arcangeli)
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andreas Dilger <adilger@turbolinux.com>,
        Linux LVM Development list <lvm-devel@sistina.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Heinz Mauelshagen <mauelshagen@sistina.com>
Subject: Re: [lvm-devel] *** ANNOUNCEMENT *** LVM 0.9.1 beta5 available at www.sistina.com
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010221180035.N25927@athlon.random>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010221180035.N25927@athlon.random> you wrote:
> On Wed, Feb 21, 2001 at 02:49:17PM +1100, Richard Gooch wrote:
>> You definately can mknod(2) on devfs. [..]

> So then why don't we simply create the VG ourself with the right minor number
> and use it as we do without devfs? We'll still have a global 256 VG limit this
> way but that's not a minor issue.

Yes - that's how I did it in my inital LVM & devfs patches.
It would be really good to have something devfs-like just for LVM in
setups that don't use LVM, so we could avoid mounting root read/write
for device-creation.
One of the stronger points for a per-driver devfs, IHMO.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
