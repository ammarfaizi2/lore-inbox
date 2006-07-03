Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWGCWvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWGCWvD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWGCWvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:51:03 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:50071 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932175AbWGCWvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:51:00 -0400
Date: Tue, 4 Jul 2006 08:50:44 +1000
From: Nathan Scott <nathans@sgi.com>
To: Hungerburg <lklm@lazy.shacknet.nu>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: thank you, xfs team
Message-ID: <20060704085044.B1462688@wobbly.melbourne.sgi.com>
References: <20060703221117.GA27898@lazy.shacknet.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060703221117.GA27898@lazy.shacknet.nu>; from lklm@lazy.shacknet.nu on Tue, Jul 04, 2006 at 12:11:17AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 12:11:17AM +0200, Hungerburg wrote:
> hello there,
> 
> I hope this is not the wrong place, yet I have to write this now, before
> I forget about it:

xfs@oss.sgi.com is the best place.

> I had to swap a dying harddrive. after receiving many mails from the
> smart daemon, recent kernel patches to xfs made me aware of the full
> extent of the problem.

Hmm, the second part of that sentence doesn't make sense to me.

> keywords:
> - XFS internal error XFS_WANT_CORRUPTED_RETURN
> - Device: /dev/hda, 1 Currently unreadable (pending) sectors
> - Device: /dev/hda, 1 Offline uncorrectable sectors

This looks like expected behaviour - XFS shut down the filesystem on
detecting IO errors on filesystem metadata blocks.

> the tools to copy what is still there (data) are a boon - they require
> some reading, but the thing is doable (xfs_copy to good disk, then
> xfs_dump from there)

OK, good to hear.

cheers.

-- 
Nathan
