Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267435AbUG2VRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267435AbUG2VRS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267458AbUG2VOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:14:04 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42981 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267435AbUG2VLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:11:46 -0400
Date: Thu, 29 Jul 2004 23:11:37 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Nathan Scott <nathans@sgi.com>,
       "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Steve Lord <lord@xfs.org>, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com,
       Cahya Wirawan <cwirawan@email.archlab.tuwien.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL and XFS on 4KSTACKS=n
Message-ID: <20040729211137.GC23589@fs.tum.de>
References: <20040720114418.GH21918@email.archlab.tuwien.ac.at> <40FD0A61.1040503@xfs.org> <40FD2E99.20707@mnsu.edu> <20040720195012.GN14733@fs.tum.de> <20040729060900.GA1946@frodo> <20040729114219.GN2349@fs.tum.de> <1091101612.2792.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091101612.2792.8.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 01:46:52PM +0200, Arjan van de Ven wrote:
> 
> > > > Mark this combination as BROKEN until XFS is fixed.
> > > 
> > > This part is not useful.  We want to hear about problems
> > > that people hit with 4K stacks so we can try to address
> > > them, and it mostly works as is.
> > 
> > 2.6 is a stable kernel series used in production environments.
> > 
> > Regarding Linus' tree, it's IMHO the best solution to work around it 
> > this way until all issues are sorted out.
> > 
> > Feel free to revert it in -mm later, since there are many brave souls  
> > running -mm you'll still get to hear about problems.
> 
> can you then also mark XFS broken in 2.4 entirely?
> 2.4 has a nett stack of also 4Kb... 

There are reports of breakages with 4kb stacks in 2.6, but AFAIK no 
similar reports for 2.4 .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

