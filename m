Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262370AbSKDJm3>; Mon, 4 Nov 2002 04:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262441AbSKDJm3>; Mon, 4 Nov 2002 04:42:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8860 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262370AbSKDJm2>;
	Mon, 4 Nov 2002 04:42:28 -0500
Date: Mon, 4 Nov 2002 10:48:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE BUG REPORT: 2.5.45 killed my / partition -- partially recovered
Message-ID: <20021104094847.GH13587@suse.de>
References: <3DC5C3A9.3060608@nortelnetworks.com> <3DC5E744.9020508@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC5E744.9020508@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03 2002, Chris Friesen wrote:
> Well, it turns out that the reason I couldn't boot was a conflict 
> between the boot time checks and devfs (with devfs on /dev/hdb9 didn't 
> exist...).  If I turned off devfs loading at boot everything went okay.
> 
> However, there *were* those problems that fsck.ext3 found and I'm still 
> kind of suspicious about them.

Be sure not to tell us what hard drive you have, if you used dma or not,
etc. These kinds of clues might help us understand what the problem is.

Usually, a boot log at the least is needed.

-- 
Jens Axboe

