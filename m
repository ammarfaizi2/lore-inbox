Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbTEHIVh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 04:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbTEHIVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 04:21:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7825 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261207AbTEHIVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 04:21:36 -0400
Date: Thu, 8 May 2003 10:34:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "David S. Miller" <davem@redhat.com>, laforge@netfilter.org,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Fw: kernel BUG at net/core/skbuff.c:1028!
Message-ID: <20030508083405.GM823@suse.de>
References: <20030507.042003.26512841.davem@redhat.com> <20030508012101.36E012C01B@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508012101.36E012C01B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08 2003, Rusty Russell wrote:
> In message <20030507.042003.26512841.davem@redhat.com> you write:
> > It has to be from some of the skb linearization changes.
> > I can't think of any other change we've made that would
> > make this start to happen.
> 
> Yep, culprit is obvious stupid bug.  This indicates a serious lack of
> testing on my part 8(

One would think so, since it doesn't even get to the login :)

> Jens, does this help?

[snip]

Nope, it still dies hard. I didn't log the oops this time (box is
headless and I need to move it to do so), but it hung hard before it was
done booting.

Want me to log a new oops?

-- 
Jens Axboe

