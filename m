Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWBIFad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWBIFad (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 00:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWBIFad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 00:30:33 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:50916 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932311AbWBIFac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 00:30:32 -0500
Date: Wed, 8 Feb 2006 21:30:25 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>
Subject: Re: 2.6.16-rc2-mm1 patches don't apply
Message-Id: <20060208213025.ef61a679.pj@sgi.com>
In-Reply-To: <20060208201644.568379d6.akpm@osdl.org>
References: <20060208194359.bd1c1a4b.pj@sgi.com>
	<20060208201644.568379d6.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/broken-out/linus.patch
> applies cleanly to
> ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.16-rc2.tar.bz2

Indeed.  That combination does work.

And that's the same linus.patch as I extracted from:

  ~akpm/patches/2.6/2.6.16-rc2//2.6.16-rc2-mm1/2.6.16-rc2-mm1-broken-out.tar.bz2

So no problem with you linus.patch.

The difference -might- be a different linux-2.6.16-rc2 with the above
than with hg's http://www.kernel.org/hg/linux-2.6, with the command "hg
co 19933", which is the release tagged v2.6.16-rc2:

    changeset:   19933:6a79f5a2de38
    tag:         v2.6.16-rc2
    user:        Linus Torvalds <torvalds@g5.osdl.org>
    date:        Fri Feb  3 14:03:08 2006 +0800
    summary:     Linux v2.6.16-rc2

My current suspicions ... a combination of:

 1) a congenital mental defect that causes me to find git difficult to use,
    and led to me thinking something had failed when it had not, and
 2) further fallout from some apparent burp in the production of the hg
    (mercurial) linux trees that Matt fixed today.

I can't do much about (1).  I will see if I can nail down (2), and send
Matt details, if I get far enough to be useful.

Thanks, Andrew, for running your <wget, wget> test.

That got me back on the road again.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
