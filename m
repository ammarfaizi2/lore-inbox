Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUGVUTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUGVUTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 16:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267198AbUGVUTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 16:19:10 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29651 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261234AbUGVUTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 16:19:05 -0400
Date: Thu, 22 Jul 2004 22:18:58 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: corbet@lwn.net, linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-ID: <20040722201858.GG19329@fs.tum.de>
References: <40FEEEBC.7080104@quark.didntduck.org> <20040721231123.13423.qmail@lwn.net> <20040721235228.GZ14733@fs.tum.de> <20040722025539.5d35c4cb.akpm@osdl.org> <20040722193337.GE19329@fs.tum.de> <20040722160112.177fc07f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722160112.177fc07f.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 04:01:12PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> > my personal opinon is that this new development model isn't a good 
> > idea from the point of view of users:
> > 
> > There's much worth in having a very stable kernel. Many people use for 
> > different reasons self-compiled ftp.kernel.org kernels. 
> 
> Well.  We'll see.  2.6 is becoming stabler, despite the fact that we're
> adding features.

4kb stacks were added after 2.6.0 and now 4KSTACKS=y results in Oops'es 
under some circumstances if using XFS.

2.6 currently still becomes stabler, but every new/changed feature bears 
the risk of breaking something.

> I wouldn't be averse to releasing a 2.6.20.1 which is purely stability
> fixes against 2.6.20 if there is demand for it.  Anyone who really cares
> about stability of kernel.org kernels won't be deploying 2.6.20 within a
> few weeks of its release anyway, so by the time they doodle over to
> kernel.org they'll find 2.6.20.2 or whatever.

Who will maintain the many subtrees of 2.6 this implies?

Even after 2.6.20 was already released, you might have to release a 
2.6.19.5 with a few additional security fixes since according to your 
advice users should continue to use 2.6.19 for a few weeks which 
implies that someone will have to maintain at least the 2.6.19 tree for 
at least a few weeks after the release of 2.6.20 .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

