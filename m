Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268343AbTBNKML>; Fri, 14 Feb 2003 05:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268349AbTBNKML>; Fri, 14 Feb 2003 05:12:11 -0500
Received: from packet.digeo.com ([12.110.80.53]:38097 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268343AbTBNKMJ>;
	Fri, 14 Feb 2003 05:12:09 -0500
Date: Fri, 14 Feb 2003 02:22:20 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.60-mm2
Message-Id: <20030214022220.30d0ed69.akpm@digeo.com>
In-Reply-To: <20030214101356.GA17155@codemonkey.org.uk>
References: <20030214013144.2d94a9c5.akpm@digeo.com>
	<20030214093856.GC13845@codemonkey.org.uk>
	<20030214015802.66800166.akpm@digeo.com>
	<20030214101356.GA17155@codemonkey.org.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2003 10:21:56.0455 (UTC) FILETIME=[E6AF6770:01C2D412]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> wrote:
>
> On Fri, Feb 14, 2003 at 01:58:02AM -0800, Andrew Morton wrote:
> 
>  > > I'm puzzled that you've had NFS stable enough to test these.
>  > This was just writing out a single 400 megabyte file with `dd'.  I didn't try
>  > anything fancier.
> 
> ok. Can you hold off pushing NFS bits to Linus until this gets
> pinned down ? I really don't want to introduce any more variables
> to this, especially when its so hard to pin down to an exact
> replication scenario.

I wouldn't push any NFS bits.  It has a breathing maintainer ;)

I've been mainly looking at the OOM problems, which need MM help.  Got
distracted.


