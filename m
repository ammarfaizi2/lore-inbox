Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131376AbRCUNBo>; Wed, 21 Mar 2001 08:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131407AbRCUNBe>; Wed, 21 Mar 2001 08:01:34 -0500
Received: from chiara.elte.hu ([157.181.150.200]:6419 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131376AbRCUNBR>;
	Wed, 21 Mar 2001 08:01:17 -0500
Date: Wed, 21 Mar 2001 13:59:20 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alexander Viro <viro@math.psu.edu>
Cc: Anton Blanchard <anton@linuxcare.com.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pagecache SMP-scalability patch [was: spinlock usage]
In-Reply-To: <Pine.GSO.4.21.0103210751521.739-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0103211356420.6061-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Mar 2001, Alexander Viro wrote:

> > (about lstat(): IMO lstat() should not call into the lowlevel FS code.)
>
> a) revalidation on network filesystems
> b) just about anything layered would win from ability to replace the
> normal stat() behaviour (think of UI/GID replacement, etc.)

sorry, i meant ext2fs - but this was fixed by your VFS scalability changes
already :-)

	Ingo

