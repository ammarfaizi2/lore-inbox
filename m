Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbVH2F5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbVH2F5q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 01:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbVH2F5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 01:57:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3215 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750977AbVH2F5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 01:57:45 -0400
Date: Mon, 29 Aug 2005 07:57:49 +0200
From: Jens Axboe <axboe@suse.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
Message-ID: <20050829055745.GX4018@suse.de>
References: <20050823123235.GG16461@suse.de> <20050824010346.GA1021@frodo> <20050824070809.GA27956@suse.de> <20050824171931.H4209301@wobbly.melbourne.sgi.com> <20050824072501.GA27992@suse.de> <20050824092838.GB28272@suse.de> <20050829045359.GA1784@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050829045359.GA1784@frodo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29 2005, Nathan Scott wrote:
> On Wed, Aug 24, 2005 at 11:28:39AM +0200, Jens Axboe wrote:
> > ...
> > Patch attached is against 2.6.13-rc6-mm2. Still a good idea to apply the
> > relayfs read update from the previous mail [*] as well.
> 
> Hi Jens,
> 
> There's a minor config botch in there, I get this:
> 
> scripts/kconfig/conf -s arch/i386/Kconfig
> drivers/block/Kconfig:466:warning: 'select' used by config symbol 'BLK_DEV_IO_TRACE' refer to undefined symbol 'RELAYFS'
> 
> The patch below seems to resolve it.

Thanks, you are right, the name is indeed RELAYFS_FS.

-- 
Jens Axboe

