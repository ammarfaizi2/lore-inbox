Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVGJEU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVGJEU5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 00:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVGJEU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 00:20:57 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:9393 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261403AbVGJEUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 00:20:55 -0400
Date: Sun, 10 Jul 2005 14:20:22 +1000
From: Nathan Scott <nathans@sgi.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS Oops Under 2.6.12.2
Message-ID: <20050710142021.B2904172@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.63.0507090614290.21767@p34>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.63.0507090614290.21767@p34>; from jpiszcz@lucidpixels.com on Sat, Jul 09, 2005 at 06:20:53AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Sat, Jul 09, 2005 at 06:20:53AM -0400, Justin Piszcz wrote:
> After a couple hours of use, I get this error on a linear RAID under 
> 2.6.12.2 using loop-AES w/AES-256 encrypted filesystem.
> 
> Anyone know what is wrong?

This is not an Oops as your subject line states ... its a forced
filesystem shutdown due to (what looks like) corruption in a btree
block in a directory inode.

> Filesystem "loop1": XFS internal error xfs_da_do_buf(2) at line 2271 of 
> file fs/xfs/xfs_da_btree.c.  Caller 0xc025e807

Is this reproducible?  In particular, is it reproducible if you take
some of the MD/loop/encryption complexities out of the picture (just
to try to narrow down the source of the failure).  And if so, could
you send me a recipe describing how to reproduce it... thanks!

cheers.

-- 
Nathan
