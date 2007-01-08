Return-Path: <linux-kernel-owner+w=401wt.eu-S1750831AbXAHXrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbXAHXrr (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbXAHXrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:47:47 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58500 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750831AbXAHXrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:47:46 -0500
Date: Tue, 9 Jan 2007 10:47:28 +1100
From: David Chinner <dgc@sgi.com>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
       akpm@osdl.org
Subject: bd_mount_mutex -> bd_mount_sem (was Re: xfs_file_ioctl / xfs_freeze: BUG: warning at kernel/mutex-debug.c:80/debug_mutex_unlock())
Message-ID: <20070108234728.GC33919298@melbourne.sgi.com>
References: <20070104001420.GA32440@m.safari.iki.fi> <20070107213734.GS44411608@melbourne.sgi.com> <20070108110323.GA3803@m.safari.iki.fi> <45A27416.8030600@sandeen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A27416.8030600@sandeen.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 10:40:54AM -0600, Eric Sandeen wrote:
> Sami Farin wrote:
> > On Mon, Jan 08, 2007 at 08:37:34 +1100, David Chinner wrote:
> > ...
> >>> fstab was there just fine after -u.
> >> Oh, that still hasn't been fixed?
> > 
> > Looked like it =)
> 
> Hm, it was proposed upstream a while ago:
> 
> http://lkml.org/lkml/2006/9/27/137
> 
> I guess it got lost?

Seems like it. Andrew, did this ever get queued for merge?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
