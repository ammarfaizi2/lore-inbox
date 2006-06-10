Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWFJDjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWFJDjK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 23:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWFJDjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 23:39:10 -0400
Received: from fmr18.intel.com ([134.134.136.17]:47840 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932283AbWFJDjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 23:39:08 -0400
Date: Fri, 9 Jun 2006 20:37:36 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>, Sonny Rao <sonny@burdell.org>,
       jeff@garzik.org, hch@infradead.org, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610033735.GH10524@goober>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <20060609091327.GA3679@infradead.org> <20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org> <20060609095620.22326f9d.akpm@osdl.org> <4489AAD9.80806@garzik.org> <20060609103543.52c00c62.akpm@osdl.org> <20060609214200.GA18213@kevlar.burdell.org> <20060609151553.30097b44.akpm@osdl.org> <20060609231151.GL5964@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609231151.GL5964@schatzie.adilger.int>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 05:11:52PM -0600, Andreas Dilger wrote:
> On Jun 09, 2006  15:15 -0700, Andrew Morton wrote:
> > 
> > We're continuing to nurse along a few basically-15-year-old filesystems
> > while we do have the brains, manpower and processes to implement a new,
> > really great one.
> > 
> > It's just this feeling I have ;)
> 
> I think many people share this feeling (me included), hence the linux
> filesystem meeting next week...  The problem is that even getting a
> half-decent disk filesystem is many years of work, and large disks are
> here before then.  The ZFS code took 10 years to get to its current state,
> I understand, so I don't anticipate we will get there overnight.

I helped bring up the first instance of ZFS running as a kernel module
on Halloween, 2002 (one fun week staying up all night hacking with
Jeff Bonwick).  The earliest code was written in either 2001 or just
possibly 2000 - so 5-6 years in elapsed time.  On the other hand, in
terms of total programmer staff-years put into ZFS, it's on the order
of 25 years.

I'm not sure either what the best route to the next big Linux file
system is - start from scratch or reuse a lot of code.  One of the
things I want to talk about at the workshop is creative reuse of
existing code, a la the continuation inode idea.

-VAL
