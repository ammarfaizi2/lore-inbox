Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbTBEUAK>; Wed, 5 Feb 2003 15:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbTBET7l>; Wed, 5 Feb 2003 14:59:41 -0500
Received: from packet.digeo.com ([12.110.80.53]:18075 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264749AbTBET7h>;
	Wed, 5 Feb 2003 14:59:37 -0500
Date: Wed, 5 Feb 2003 12:09:03 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-Id: <20030205120903.1e84c12e.akpm@digeo.com>
In-Reply-To: <20030205195151.GJ19678@dualathlon.random>
References: <20030205174021.GE19678@dualathlon.random>
	<20030205102308.68899bc3.akpm@digeo.com>
	<20030205184535.GG19678@dualathlon.random>
	<20030205114353.6591f4c8.akpm@digeo.com>
	<20030205195151.GJ19678@dualathlon.random>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Feb 2003 20:09:07.0819 (UTC) FILETIME=[707F2BB0:01C2CD52]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> it might be simply an error in the tarball, maybe Linus's tree isn't in
> full sync with bk head. But something definitely is corrupt between
> tarball and bk.

Well, the 2.5.59 BK tree shows that function using block_truncate_page() as
well.

The question is why did the Jan 9 changeset in the 2.5.55 timeframe not
appear in the tree until post-2.5.59.  Maybe on Jan 9 Linus only part-merged
it by some means (making the web interface claim it is there), and this week
completed the merge and updated the checkin comment?
