Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUCSSUC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 13:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUCSSUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 13:20:02 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49307 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263100AbUCSST7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 13:19:59 -0500
Date: Fri, 19 Mar 2004 19:19:55 +0100
From: Jens Axboe <axboe@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] barrier patch set
Message-ID: <20040319181955.GC2423@suse.de>
References: <20040319153554.GC2933@suse.de> <200403191748.17414@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403191748.17414@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19 2004, Marc-Christian Petersen wrote:
> On Friday 19 March 2004 16:35, Jens Axboe wrote:
> 
> Hi Jens,
> 
> > A first release of a collected barrier patchset for 2.6.5-rc1-mm2. I
> > have a few changes planned to support dm/md + sata, I'll do those
> > changes over the weekend.
> > Reiser has the best barrier support, ext3 works but only if things don't
> > go wrong. So only attempt to use the barrier feature on ext3 if on ide
> > drives, not SCSI nor SATA.
> > reiserfs-barrier-2.6.5-rc1-mm2-1
> > 	reiser part.
> 
> is this intended? ;)
> 
> -rw-------    1 axboe    axboe        3377 Mar 19 07:32 
> reiserfs-barrier-2.6.5-rc1-mm2-1.bz2
> -rw-------    1 axboe    axboe         248 Mar 19 07:32 
> reiserfs-barrier-2.6.5-rc1-mm2-1.bz2.sign
> -rw-------    1 axboe    axboe        3473 Mar 19 07:32 
> reiserfs-barrier-2.6.5-rc1-mm2-1.gz
> -rw-------    1 axboe    axboe         248 Mar 19 07:32 
> reiserfs-barrier-2.6.5-rc1-mm2-1.gz.sign
> -rw-------    1 axboe    axboe         248 Mar 19 07:32 
> reiserfs-barrier-2.6.5-rc1-mm2-1.sign
> 
> means permission denied for us.

Corrected, thanks.

-- 
Jens Axboe

