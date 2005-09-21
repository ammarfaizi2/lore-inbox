Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVIUJGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVIUJGM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 05:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVIUJGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 05:06:11 -0400
Received: from relay.wplus.net ([195.131.52.142]:63048 "EHLO relay.wplus.net")
	by vger.kernel.org with ESMTP id S1750783AbVIUJGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 05:06:10 -0400
From: Vitaly Fertman <vitaly@namesys.com>
To: reiserfs-list@namesys.com
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Date: Wed, 21 Sep 2005 13:05:12 +0400
User-Agent: KMail/1.7.1
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jonathan Briggs <jbriggs@esoft.com>,
       David Masover <ninja@slaphack.com>, Pavel Machek <pavel@suse.cz>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <1127240326.10407.22.camel@localhost> <20050920211136.GA6179@thunk.org>
In-Reply-To: <20050920211136.GA6179@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509211305.13934.vitaly@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 September 2005 01:11, Theodore Ts'o wrote:
> On Tue, Sep 20, 2005 at 12:18:46PM -0600, Jonathan Briggs wrote:
> > 
> > I use Reiser3 and Reiser4 on all my systems and fsck has always worked
> > even if it has been much slower than I would like.  The only problems
> > I've experienced have been on the same level as when an ext2/3
> > filesystem fsck dumps several directories of unlabeled files into lost
> > +found.
> 
> You've obviously never kept several dozen reiserfs filesystem images
> (for use with Xen or User-Mode Linux) on a reiserfs filesystem, and
> then had a hardware failure bad enough that the fsck had to try to
> rebuild the b-tree, I take it?

loop device XOR encryption for your images is the simple solution 
for reiserfs V3.

-- 
Thanks,
Vitaly Fertman
