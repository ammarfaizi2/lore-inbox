Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbTA0PFJ>; Mon, 27 Jan 2003 10:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267203AbTA0PFJ>; Mon, 27 Jan 2003 10:05:09 -0500
Received: from ns0.cobite.com ([208.222.80.10]:42757 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S267184AbTA0PFI>;
	Mon, 27 Jan 2003 10:05:08 -0500
Date: Mon, 27 Jan 2003 10:14:11 -0500 (EST)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: Andrew Morton <akpm@digeo.com>
cc: piggin@cyberone.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.59mm5 database 'benchmark' results
In-Reply-To: <20030124150340.32e57f19.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0301241749220.32240-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2003, Andrew Morton wrote:

> > kernel           minutes     comment
> > -------------    ----------- ---------------------------------
> > 2.4.20-aa1       134         i consider this 'baseline'
> > 2.5.59           124         woo-hoo
> > 2.4.18-19.7.xsmp 128         not bad for frankenstein's montster
> > 2.5.59-mm5       157         uh-oh
> > 

> > Oracle version 8.1.7 (no aio support in this release) is accessing
> > datafiles on the two megaraid devices via /dev/raw stacked on top of
> > device-mapper 
> 
> Rather impressed that you got all that to work ;)
> 

Me too.  It's still got some rough edges, but 2.5.59 was the first version 
that made it through because of this or that reason.  I'm very impressed 
personally.

> 
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm5/broken-out/anticipatory_io_scheduling-2_5_59-mm3.patch

Ok.  The results are basically the same as 2.5.59 vanilla:

kernel                        minutes
----------------------------- ----------
2.5.59-mm5-no-anticipatory-io 125 

Anything else?

David

-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/


