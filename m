Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266717AbTBTSYQ>; Thu, 20 Feb 2003 13:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266718AbTBTSYP>; Thu, 20 Feb 2003 13:24:15 -0500
Received: from packet.digeo.com ([12.110.80.53]:45201 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266717AbTBTSYN>;
	Thu, 20 Feb 2003 13:24:13 -0500
Date: Thu, 20 Feb 2003 10:35:43 -0800
From: Andrew Morton <akpm@digeo.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: andrea@suse.de, t.baetzler@bringe.com, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Subject: Re: filesystem access slowing system to a crawl
Message-Id: <20030220103543.7c2d250c.akpm@digeo.com>
In-Reply-To: <200302201629.51374.m.c.p@wolk-project.de>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR>
	<200302191742.02275.m.c.p@wolk-project.de>
	<20030219174940.GJ14633@x30.suse.de>
	<200302201629.51374.m.c.p@wolk-project.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Feb 2003 18:34:09.0787 (UTC) FILETIME=[A866BCB0:01C2D90E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen <m.c.p@wolk-project.de> wrote:
>
> On Wednesday 19 February 2003 18:49, Andrea Arcangeli wrote:
> 
> Hi Andrea,
> 
> > Marcelo please include this:
> > 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.2
> >1pre4aa3/10_inode-highmem-2
> great. Thanks. Now let's hope Marcelo use this :)
> 
> > other fixes should be included too but they don't apply cleanly yet
> > unfortunately, I (or somebody else) should rediff them against mainline.
> Can you tell me what in special you mean? I'd do this.
> 

Andrea's VM patches, against 2.4.21-pre4 are at

	http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.21-pre4/

The applying order is in the series file.

These have been rediffed, and apply cleanly.  They have not been
tested much though.
