Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTE0RCu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263957AbTE0RCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:02:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6590 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263953AbTE0RCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:02:49 -0400
Date: Tue, 27 May 2003 19:16:05 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
Message-ID: <20030527171605.GL845@suse.de>
References: <1053972773.2298.177.camel@mulgrave> <20030526181852.GL845@suse.de> <1053974830.1768.190.camel@mulgrave> <20030526190707.GM845@suse.de> <1053976644.2298.194.camel@mulgrave> <20030526193327.GN845@suse.de> <20030527123901.GJ845@suse.de> <1054045594.1769.24.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054045594.1769.24.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27 2003, James Bottomley wrote:
> On Tue, 2003-05-27 at 08:39, Jens Axboe wrote:
> > James, something like this would be enough then (untested, compiles)?
> 
> Yes...the only concern I would have is that if you downsize the tag map,
> you don't seem to keep any memory of what the high water mark actually
> is.  Thus, I can drop the depth by 8 and then increase it again by 4 and
> you won't see that the increase can be accommodated by the already
> allocated space.

If you increase it again, the maps are resized. Is that a problem? Seems
ok to me.

-- 
Jens Axboe

