Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWC0Xnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWC0Xnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 18:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWC0Xnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 18:43:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:30675 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751156AbWC0Xna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 18:43:30 -0500
Date: Tue, 28 Mar 2006 09:43:17 +1000
From: Nathan Scott <nathans@sgi.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: XFS: 2.6.16-git13 warning??
Message-ID: <20060328094316.A865430@wobbly.melbourne.sgi.com>
References: <20060327154310.c5776847.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060327154310.c5776847.rdunlap@xenotime.net>; from rdunlap@xenotime.net on Mon, Mar 27, 2006 at 03:43:10PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 03:43:10PM -0800, Randy.Dunlap wrote:
> 
> fs/xfs/linux-2.6/xfs_ioctl32.c:114: warning: initialization from incompatible pointer type
> 
> 	vnode_t		*vp = vn_to_inode(inode);
> 
> vn_to_inode() wants a vnode, not an inode.
> 
> should that be vn_from_inode(inode) ??

Yep, thanks Randy - I'll get that fixed up.

cheers.

-- 
Nathan
