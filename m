Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266965AbTBTVda>; Thu, 20 Feb 2003 16:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbTBTVd3>; Thu, 20 Feb 2003 16:33:29 -0500
Received: from packet.digeo.com ([12.110.80.53]:25503 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266965AbTBTVd2>;
	Thu, 20 Feb 2003 16:33:28 -0500
Date: Thu, 20 Feb 2003 13:41:04 -0800
From: Andrew Morton <akpm@digeo.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: andrea@suse.de, t.baetzler@bringe.com, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Subject: Re: filesystem access slowing system to a crawl
Message-Id: <20030220134104.0b37683a.akpm@digeo.com>
In-Reply-To: <200302202232.27433.m.c.p@wolk-project.de>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR>
	<200302201629.51374.m.c.p@wolk-project.de>
	<20030220103543.7c2d250c.akpm@digeo.com>
	<200302202232.27433.m.c.p@wolk-project.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Feb 2003 21:43:27.0282 (UTC) FILETIME=[19FEF120:01C2D929]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen <m.c.p@wolk-project.de> wrote:
>
> On Thursday 20 February 2003 19:35, Andrew Morton wrote:
> 
> Hi Andrew,
> 
> > Andrea's VM patches, against 2.4.21-pre4 are at
> > 	http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.21-pre4/
> > The applying order is in the series file.
> I am afraid Marcelo will never accept these or some of them.
> 

The most important one is inode-highmem.  It's a safe patch, and the risk of
it causing problems due to not having other surrounding -aa stuff is low.

It's a matter of someone getting down, testing it and sending it.

Ho hum.  It'll take an hour.  I shall try.
