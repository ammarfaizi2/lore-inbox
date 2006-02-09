Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422804AbWBIF4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422804AbWBIF4y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 00:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422807AbWBIF4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 00:56:54 -0500
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:46491 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1422804AbWBIF4y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 00:56:54 -0500
Date: Wed, 8 Feb 2006 23:56:39 -0600
From: Matt Mackall <mpm@selenic.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc2-mm1 patches don't apply
Message-ID: <20060209055638.GV13729@waste.org>
References: <20060208194359.bd1c1a4b.pj@sgi.com> <20060208201644.568379d6.akpm@osdl.org> <20060208213025.ef61a679.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208213025.ef61a679.pj@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 09:30:25PM -0800, Paul Jackson wrote:
> Andrew wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/broken-out/linus.patch
> > applies cleanly to
> > ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.16-rc2.tar.bz2
> 
> Indeed.  That combination does work.
> 
> And that's the same linus.patch as I extracted from:
> 
>   ~akpm/patches/2.6/2.6.16-rc2//2.6.16-rc2-mm1/2.6.16-rc2-mm1-broken-out.tar.bz2
> 
> So no problem with you linus.patch.
> 
> The difference -might- be a different linux-2.6.16-rc2 with the above
> than with hg's http://www.kernel.org/hg/linux-2.6, with the command "hg
> co 19933", which is the release tagged v2.6.16-rc2:
> 
>     changeset:   19933:6a79f5a2de38
>     tag:         v2.6.16-rc2
>     user:        Linus Torvalds <torvalds@g5.osdl.org>
>     date:        Fri Feb  3 14:03:08 2006 +0800
>     summary:     Linux v2.6.16-rc2
> 
> My current suspicions ... a combination of:
> 
>  1) a congenital mental defect that causes me to find git difficult to use,
>     and led to me thinking something had failed when it had not, and
>  2) further fallout from some apparent burp in the production of the hg
>     (mercurial) linux trees that Matt fixed today.

The git->hg conversion script may be borked right now. The upgrade of
master.kernel.org to AMD64 happened to coincide with a new Mercurial
release with a new convert-repo script which may have introduced a
bug. I'll try to sort it out tomorrow.

-- 
Mathematics is the supreme nostalgia of our time.
