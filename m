Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbVHIXHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbVHIXHM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 19:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbVHIXHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 19:07:12 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:36527
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S1750957AbVHIXHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 19:07:11 -0400
Date: Tue, 9 Aug 2005 19:05:30 -0400
From: Sonny Rao <sonny@burdell.org>
To: Phil Dier <phil@icglink.com>
Cc: linux-kernel@vger.kernel.org, ziggy <ziggy@icglink.com>,
       Scott Holdren <scott@icglink.com>, Jack Massari <jack@icglink.com>
Subject: Re: Dual 2.8ghz xeon, software raid, lvm, jfs
Message-ID: <20050809230530.GA22211@kevlar.burdell.org>
References: <20050809094456.3feca1ef.phil@icglink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050809094456.3feca1ef.phil@icglink.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 09:44:56AM -0500, Phil Dier wrote:
> Hi,
> 
> I have 2 identical dual 2.8ghz xeon machines with 4gb ram, using
> software raid 10 with lvm layered on top, formatted with JFS (though
> at this point any filesystem with online resizing support will do). I
> have the boxes stable using 2.6.10, and they pass my stress test. I was
> trying to update to 2.6.12 so I can use the new ionice utility, but I'm
> experiencing oopses again. Can someone take a look at my info and give
> me an idea of what is causing my problems. I'm willing to test patches
> if anyone cares to work with me on a fix.  All the details can be found
> here:
> 
> http://www.icglink.com/cluster-debug-2.6.12.3.html
> 
> Please CC me on replies, as I am not subscribed to l-k.
> 
> Thanks for your help.

Generally on lkml, you want to post at least the output of an oops or
panic into your post.

Now, try running 2.6.13-rc6 and see if it fixes your problem, IIRC
there have been a number of changes to the MPT driver between those two
kernel versions.

Sonny
