Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265171AbUA0VrP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 16:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265595AbUA0VrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 16:47:15 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:23488 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S265171AbUA0VrL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 16:47:11 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Jfs-discussion] md raid + jfs + jfs_fsck
Date: Tue, 27 Jan 2004 16:47:08 -0500
User-Agent: KMail/1.6
References: <1075230933.11207.84.camel@suprafluid> <1075236185.21763.89.camel@shaggy.austin.ibm.com> <20040127205324.A19913@infradead.org>
In-Reply-To: <20040127205324.A19913@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401271647.08026.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.53.166] at Tue, 27 Jan 2004 15:47:10 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 January 2004 15:53, Christoph Hellwig wrote:
>On Tue, Jan 27, 2004 at 02:43:05PM -0600, Dave Kleikamp wrote:
>> My guess is that software raid is stealing a few blocks from the
>> end of the partition,
>
>Yes, it does.  But JFS should get the right size from the gendisk
> anyway. Or did you create the raid with the filesystem already
> existant?  While that appears to work for a non-full ext2/ext3
> filesystem it's not something you should do because it makes the
> filesystem internal bookkeeping wrong and you'll run into trouble
> with any filesystem sooner or later.
>
I wonder if this discussion has anything to do with what we perceive 
as an excruciatingly long resync time?  Should the array be 
reformatted after startup with a new mkreiserfs in the event thats 
what we are running on a raid5?

If it exists, please point me to a good, maybe better than that which 
comes with mdtools, discussion, web site or whatever please.

>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
