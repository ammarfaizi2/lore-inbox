Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbTBEUXv>; Wed, 5 Feb 2003 15:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbTBEUXu>; Wed, 5 Feb 2003 15:23:50 -0500
Received: from packet.digeo.com ([12.110.80.53]:45212 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264686AbTBEUXt>;
	Wed, 5 Feb 2003 15:23:49 -0500
Message-ID: <3E41750C.56F7165@digeo.com>
Date: Wed, 05 Feb 2003 12:33:16 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
References: <20030205174021.GE19678@dualathlon.random> <20030205102308.68899bc3.akpm@digeo.com> <20030205184535.GG19678@dualathlon.random> <20030205114353.6591f4c8.akpm@digeo.com> <20030205195151.GJ19678@dualathlon.random> <20030205120903.1e84c12e.akpm@digeo.com> <20030205201810.GM19678@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Feb 2003 20:33:19.0753 (UTC) FILETIME=[D1EAB790:01C2CD55]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Wed, Feb 05, 2003 at 12:09:03PM -0800, Andrew Morton wrote:
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >
> > > it might be simply an error in the tarball, maybe Linus's tree isn't in
> > > full sync with bk head. But something definitely is corrupt between
> > > tarball and bk.
> >
> > Well, the 2.5.59 BK tree shows that function using block_truncate_page() as
> > well.
> >
> > The question is why did the Jan 9 changeset in the 2.5.55 timeframe not
> > appear in the tree until post-2.5.59.  Maybe on Jan 9 Linus only part-merged
> > it by some means (making the web interface claim it is there), and this week
> > completed the merge and updated the checkin comment?
> 
> I don't know how it is supposed to work, but this sounds quite messy, if
> this is the case, how can you order the changesets?
> 

Dave says that the Jan 9 date was when he committed it locally.  It
was pushed to Linus this week, and the tracking shows Dave's date,
not Linus's.

I didn't know Dave was using bitkeeper.  Sorry noise.
