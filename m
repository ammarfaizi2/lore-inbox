Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTEIGrv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 02:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTEIGrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 02:47:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26325 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262312AbTEIGru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 02:47:50 -0400
Date: Fri, 9 May 2003 09:00:07 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: rusty@rustcorp.com.au, laforge@netfilter.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: kernel BUG at net/core/skbuff.c:1028!
Message-ID: <20030509070007.GU20941@suse.de>
References: <20030507.042003.26512841.davem@redhat.com> <20030508012101.36E012C01B@lists.samba.org> <20030508.102010.90804594.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508.102010.90804594.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08 2003, David S. Miller wrote:
>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Thu, 08 May 2003 11:20:27 +1000
> 
>    Yep, culprit is obvious stupid bug.  This indicates a serious lack of
>    testing on my part 8(
>    
>    Jens, does this help?
> 
> There were two cases of the same bug, you fixed only one
> instance :-)
> 
> Jens, try this patch instead.

I went to apply it to bk-current as of this morning, but I see it's
already in. And bk-current does indeed boot and (appears to :) work,
thanks Dave!

-- 
Jens Axboe

