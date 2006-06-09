Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWFIPbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWFIPbS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbWFIPbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:31:18 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:40852 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S965289AbWFIPbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:31:17 -0400
Date: Fri, 9 Jun 2006 09:31:16 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Alex Tomas <alex@clusterfs.com>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609153116.GM1651@parisc-linux.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <m3r71ycprd.fsf@bzzz.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3r71ycprd.fsf@bzzz.home.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 07:28:22PM +0400, Alex Tomas wrote:
>  JG> "ext3" will become more and more meaningless.  It could mean _any_ of 
>  JG> several filesystem metadata variants, and the admin will have no clue 
>  JG> which variant they are talking to until they try to mount the blkdev 
>  JG> (and possibly fail the mount).
> 
> debugfs <dev> -R stats | grep features ?

... a simple and intuitive command which just trips off the tongue.

I want extents, but I'm still unconvinced that ext3 needs to grow beyond
32-bit blocks.  The scheme posted by Val and Arjan (with the
continuation inodes) seems much neater.
