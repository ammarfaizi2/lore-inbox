Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261277AbSJUITO>; Mon, 21 Oct 2002 04:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261278AbSJUITO>; Mon, 21 Oct 2002 04:19:14 -0400
Received: from packet.digeo.com ([12.110.80.53]:18820 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261277AbSJUITK>;
	Mon, 21 Oct 2002 04:19:10 -0400
Message-ID: <3DB3B9E5.6452076B@digeo.com>
Date: Mon, 21 Oct 2002 01:25:09 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: landley@trommello.org
CC: Andreas Dilger <adilger@clusterfs.com>, karim@opersys.com,
       linux-kernel@vger.kernel.org, boissiere@nl.linux.org
Subject: Re: Crunch time -- Final merge candidates for 3.0 (the list).
References: <200210201849.23667.landley@trommello.org> <200210202037.54370.landley@trommello.org> <20021021064308.GA17430@clusterfs.com> <200210202147.23712.landley@trommello.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2002 08:25:09.0645 (UTC) FILETIME=[5E620BD0:01C278DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> 
> Query: is the stuff in -mm guaranteed to make it into Linus's tree?

Nope.

It's mainly there for the other VM/MM/IO developers to
integrate against.

Also for getting their more experimental work more testing and exposure.  

Also for getting external testing of the performance work
which is going into it.

Also for maintainers of other architectures to pick up breakage
before things break.

I prefer to only send things which I understand and have tested.
So that excludes, say, dcache-rcu and the EA/xattr patches.  I
did send ext3-htree, but it had big "I haven't tested this" labels
all over it.
