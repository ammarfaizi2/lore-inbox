Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266863AbUBEV33 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266818AbUBEV24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:28:56 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:33768 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266882AbUBEV1X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:27:23 -0500
Subject: Re: BUG in jfscode
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Tobias Bengtsson <tobbe@tobbe.nu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>
In-Reply-To: <20040203123709.GB23130@debian.as>
References: <20040203123709.GB23130@debian.as>
Content-Type: text/plain
Message-Id: <1076016133.25034.95.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 05 Feb 2004 15:22:13 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-03 at 06:37, Tobias Bengtsson wrote:
> Hi!

Hi, Sorry it's taken me so long to respond.

> kernel BUG at fs/jfs/jfs_dmap.c:2686!

I've seen a similar bug reported before, but it occurs only rarely.  I'm
not sure what the cause is.  My initial thought was the the block map
got corrupted, but after digging through the code I don't know if it's
that simple.

I would be interested if you can recreate the problem.  If so, I may be
able to put in some debug code to help determine where JFS is getting
confused.  Also, if it is block map corruption, running fsck -f against
the volume should fix that.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

