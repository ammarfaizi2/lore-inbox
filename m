Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbVIPUus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVIPUus (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 16:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVIPUus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 16:50:48 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:3557 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751283AbVIPUur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 16:50:47 -0400
Date: Fri, 16 Sep 2005 16:50:45 -0400
To: Hans Reiser <reiser@namesys.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050916205045.GI28578@csclub.uwaterloo.ca>
References: <432AFB44.9060707@namesys.com> <20050916174028.GA32745@infradead.org> <432B1F84.3000902@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432B1F84.3000902@namesys.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 12:39:48PM -0700, Hans Reiser wrote:
> Most of my customers remark that Namesys code is head and shoulders
> above the rest of the kernel code.  So yes, it is different.  In
> particular, they cite the XFS code as being so incredibly hard to read
> that its unreadability is worth hundreds of thousands of dollars in
> license fees for me.  That's cash received, from persons who read it
> all, not commentary made idly.
> 
> May I suggest that you work on the XFS code instead?  Surely with all of
> this energy you have, you could improve XFS a lot before it gets
> accepted into the kernel. 
> 
> As for the indirections, if you figure out how to make VFS indirections
> easy to follow, the same technique should be applicable to Reiser4, and
> I will be happy to fix it. 
> 
> (Note for the record: I actually think XFS acceptance was delayed too
> long, and I think that XFS is a great filesystem, but a rhetorical point
> needed to be made......)

Well my experience with XFS for about 6 months using 2.6 kernels has
been about as good as my experience with reiserfs 3.6 back when 2.4
was fairly new.

That's why I run ext3.

I don't need my filesystem locking up, leaking memory all over the
place, causing processes to be killed byt the out of memory handler,
etc.  I will stick with what works all the time.

Performance and nifty features are fun, but only when they don't break
your system.

Len Sorensen
