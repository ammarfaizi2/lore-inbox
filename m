Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTKGWTG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTKGWSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:18:37 -0500
Received: from ns.suse.de ([195.135.220.2]:53726 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263939AbTKGIZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 03:25:39 -0500
Date: Fri, 7 Nov 2003 09:24:36 +0100
From: Jens Axboe <axboe@suse.de>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031107082435.GA504@suse.de>
References: <3FA69CDF.5070908@gmx.de> <3FA8C916.3060702@gmx.de> <20031105095457.GG1477@suse.de> <3FA8CA87.2070201@gmx.de> <boe68a$f3g$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <boe68a$f3g$1@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06 2003, bill davidsen wrote:
> In article <3FA8CA87.2070201@gmx.de>,
> Prakash K. Cheemplavam <prakashkc@gmx.de> wrote:
> 
> | Sorry, I wasn't precise: The data is on the disc, as my DVD-ROM restores 
> | the full image (md5sum matches), but the CD-RW does not.
> 
> There is a problem with ide-scsi in 2.6, and rather than fix it someone
> came up with a patch to cdrecord to allow that application to work
> properly, and perhaps "better" in some way. Since the problem with

You have this completely backwards. A way to eliminate ide-scsi for cd
burning was invented for 2.6, which is both more efficient wrt space
consumption and cpu usage. Naturally, this is now the preferred way to
burns CD's. It works equally well with whatever burner you have, be it
atapi, scsi, or usb.

ide-scsi being broken is an orthogonal issue. The incentive to fix it
isn't that big, because its area of use has diminished a _lot_.

Just setting the record straight.

-- 
Jens Axboe

