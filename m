Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbVJAWuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbVJAWuQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 18:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbVJAWuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 18:50:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36113 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750839AbVJAWuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 18:50:15 -0400
Date: Sun, 2 Oct 2005 00:50:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alexander Nyberg <alexn@telia.com>
Cc: Neil Brown <neilb@suse.de>, Nathan Scott <nathans@sgi.com>,
       Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20051001225012.GE4212@stusta.de>
References: <20050902003915.GI3657@stusta.de> <20050902053356.GA20603@taniwha.stupidest.org> <20050902162931.A4496772@wobbly.melbourne.sgi.com> <17175.62454.623678.209697@cse.unsw.edu.au> <20050913080552.GA1815@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913080552.GA1815@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 10:05:52AM +0200, Alexander Nyberg wrote:
> On Fri, Sep 02, 2005 at 04:40:54PM +1000 Neil Brown wrote:
> 
> > On Friday September 2, nathans@sgi.com wrote:
> > > On Thu, Sep 01, 2005 at 10:33:56PM -0700, Chris Wedgwood wrote:
> > > > On Fri, Sep 02, 2005 at 02:39:15AM +0200, Adrian Bunk wrote:
> > > > 
> > > > > 4Kb kernel stacks are the future on i386, and it seems the problems
> > > > > it initially caused are now sorted out.
> > > > 
> > > > Not entirely.
> > > > 
> > > > XFS when mixed with raid/lvm/nfs still blows up.  It's probably not
> > > > alone in this respect but worse than ext2/3.
> > > 
> > > To clarify, you mean AND not OR (/) there -- in other words,
> > > raid[+raid]+dm[+dm]+xfs+nfs can be fatal, yes.
> > 
> > It should be reasonably simple to remove this problem of stacked
> > drivers.
> > There really isn't any need for md and dm (or md and md or ..) to use
> > the stack and the same time.
> > 
> 
> Sorry to bump in so late - but there seems to be a reporter who is
> suffering from these issues now:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=5210

Nathan, can you look into this bug?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

