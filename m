Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbTEKOiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 10:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbTEKOiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 10:38:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:11994 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261603AbTEKOiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 10:38:24 -0400
Date: Sun, 11 May 2003 16:47:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] remove all #include <blk.h>'s
Message-ID: <20030511144752.GN837@suse.de>
References: <20030510163043.GJ1107@fs.tum.de> <20030511135736.GM837@suse.de> <20030511144510.GJ1107@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030511144510.GJ1107@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11 2003, Adrian Bunk wrote:
> On Sun, May 11, 2003 at 03:57:36PM +0200, Jens Axboe wrote:
> > On Sat, May 10 2003, Adrian Bunk wrote:
> > > all #include <blk.h>'s for 2.5 and blk.h does now #error. If people 
> > 
> > I think that's _really_ stupid. Make it a warning ala
> > 
> > #warning blk.h is deprecated, use blkdev.h
> > 
> > like we did with malloc.h in 2.4.
> >...
> 
> Changed patch is attached.

Cool thanks, I greatly prefer this variant. And thanks for doing this
work, btw.

-- 
Jens Axboe

