Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUBZLT1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 06:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbUBZLT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 06:19:27 -0500
Received: from server2.netdiscount.de ([217.13.198.2]:41381 "EHLO
	server2.netdiscount.de") by vger.kernel.org with ESMTP
	id S262772AbUBZLTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 06:19:24 -0500
Date: Thu, 26 Feb 2004 12:19:12 +0100
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.25 - large inode_cache
Message-ID: <20040226111912.GB4554@core.home>
References: <20040226013313.GN29776@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20040226013313.GN29776@unthought.net>
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 02:33:14AM +0100, Jakob Oestergaard wrote:
> Besides, after a few days of running, the machine will use about 100MB
> of memory for cache, 100MB for buffers, about 100MB for userspace, and
> the remaining 600-700 MB of memory for inode_cache and dentry_cache.

I have the same problem (it's an dual PIII NFS fileserver with promise sx6000
raid, 320 GB ext3 filesystem and only 512 MB Ram).

After only 2 days running the bloatmeter output looks like:
   inode_cache:   336585KB   357234KB   94.21
  dentry_cache:    50305KB    56523KB   88.99
       size-32:     1516KB     1695KB   89.46

free output is this:
             total       used       free     shared    buffers  cached
Mem:        515980     506464       9516          0    2272      19204
-/+ buffers/cache:     484988      30992
Swap:      1951856       7992    1943864


Regards

Christian Leber

-- 
  "Omnis enim res, quae dando non deficit, dum habetur et non datur,
   nondum habetur, quomodo habenda est."       (Aurelius Augustinus)
  Translation: <http://gnuhh.org/work/fsf-europe/augustinus.html>
