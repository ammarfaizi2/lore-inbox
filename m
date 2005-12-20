Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVLTEE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVLTEE3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 23:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVLTEE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 23:04:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:40667 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750777AbVLTEE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 23:04:28 -0500
Date: Tue, 20 Dec 2005 15:02:26 +1100
From: Nathan Scott <nathans@sgi.com>
To: Aaron Kulbe <akulbe@gmail.com>
Cc: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com,
       linux-xfs@oss.sgi.com, hch@xfs.org
Subject: Re: PROBLEM: Page allocation failure
Message-ID: <20051220040226.GE1355@frodo>
References: <4a10e1350512191355t5c0abe18k4269e0ebbabc147e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a10e1350512191355t5c0abe18k4269e0ebbabc147e@mail.gmail.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 03:55:56PM -0600, Aaron Kulbe wrote:
> [1.] SUMMARY:  During rsync and heavy I/O operations, we experienced
> abnormally slow response times on the file server.
> ...
> [4.] Kernel version (from /proc/version): Linux version 2.6.8-24.14-bigsmp (

Try a recent kernel, both XFS and the VM have moved on in leaps
and bounds since 2.6.8 timeframe.

> I tried Christoph Hellwig's suggestion from
> http://oss.sgi.com/bugzilla/show_bug.cgi?id=345 of increasing the value of
> /proc/sys/vm/min_free_kbytes.  I set the value to 1024.  The results were
> the same.  No change in performance, and errors persisted.

There were older kernel versions where that parameter was not
being honoured particularly well, I can't recall anymore if it
was 2.6.8 or not though - it may well have been.

cheers.

-- 
Nathan
