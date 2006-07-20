Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWGTHOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWGTHOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 03:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWGTHOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 03:14:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20864 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964846AbWGTHOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 03:14:07 -0400
Date: Thu, 20 Jul 2006 17:13:10 +1000
From: Nathan Scott <nathans@sgi.com>
To: Kasper Sandberg <lkml@metanurb.dk>,
       Justin Piszcz <jpiszcz@lucidpixels.com>,
       Torsten Landschoff <torsten@debian.org>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: FAQ updated (was Re: XFS breakage...)
Message-ID: <20060720171310.B1970528@wobbly.melbourne.sgi.com>
References: <20060718222941.GA3801@stargate.galaxy> <20060719085731.C1935136@wobbly.melbourne.sgi.com> <1153304468.3706.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1153304468.3706.4.camel@localhost>; from lkml@metanurb.dk on Wed, Jul 19, 2006 at 12:21:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 12:21:08PM +0200, Kasper Sandberg wrote:
> On Wed, 2006-07-19 at 08:57 +1000, Nathan Scott wrote:
> > On Wed, Jul 19, 2006 at 12:29:41AM +0200, Torsten Landschoff wrote:
> > > 
> > > Jul 17 07:33:53 pulsar kernel: xfs_da_do_buf: bno 16777216
> > > Jul 17 07:33:53 pulsar kernel: dir: inode 54526538
> > 
> > I suspect you had some residual directory corruption from using the
> > 2.6.17 XFS (which is known to have a lurking dir2 corruption issue,
> > fixed in the latest -stable point release).

Correction there - no -stable exists with this yet, I guess that'll
be 2.6.17.7 once its out though.

> what action do you suggest i do now?

I've captured the state of this issue here, with options and ways
to correct the problem:
	http://oss.sgi.com/projects/xfs/faq.html#dir2

Hope this helps.

cheers.

-- 
Nathan
