Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTEASlY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 14:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbTEASlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 14:41:24 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:1527 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S261820AbTEASlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 14:41:23 -0400
Date: Thu, 1 May 2003 12:52:27 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Christoph Hellwig <hch@lst.de>, Adrian Bunk <bunk@fs.tum.de>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make <linux/blk.h> obsolete
Message-ID: <20030501125227.X26054@schatzie.adilger.int>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Adrian Bunk <bunk@fs.tum.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030501200719.A16182@lst.de> <20030501183804.GC21168@fs.tum.de> <20030501204012.A16641@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030501204012.A16641@lst.de>; from hch@lst.de on Thu, May 01, 2003 at 08:40:12PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 01, 2003  20:40 +0200, Christoph Hellwig wrote:
> On Thu, May 01, 2003 at 08:38:04PM +0200, Adrian Bunk wrote:
> > #warning linux/blk.h is deprecated, use linux/blkdev.h instead.
> > #include <linux/blkdev.h>
> > 
> > or simply remove the blk.h and fix all files trying to include it?
> 
> Later.  First thing is to kill the content, next the users.
> Adding the warning now would make a normal compile very verbose..

And if you leave it around for a while (with warning) after you remove
the in-kernel users, people who have out-of-tree users of that header
at least have an idea of what to do to fix their code.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

