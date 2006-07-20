Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWGTK3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWGTK3G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 06:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWGTK3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 06:29:06 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:51656 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1030253AbWGTK3F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 06:29:05 -0400
Subject: Re: XFS breakage in 2.6.18-rc1
From: Kasper Sandberg <lkml@metanurb.dk>
To: Nathan Scott <nathans@sgi.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Torsten Landschoff <torsten@debian.org>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com
In-Reply-To: <20060720085636.D1947140@wobbly.melbourne.sgi.com>
References: <20060718222941.GA3801@stargate.galaxy>
	 <20060719085731.C1935136@wobbly.melbourne.sgi.com>
	 <200607190908.30727.s0348365@sms.ed.ac.uk>
	 <20060720085636.D1947140@wobbly.melbourne.sgi.com>
Content-Type: text/plain
Date: Thu, 20 Jul 2006 12:29:02 +0200
Message-Id: <1153391342.31822.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-20 at 08:56 +1000, Nathan Scott wrote:
> On Wed, Jul 19, 2006 at 09:08:30AM +0100, Alistair John Strachan wrote:
> > On Tuesday 18 July 2006 23:57, Nathan Scott wrote:
> > [snip]
> > > > of programs fail in mysterious ways. I tried to recover using xfs_repair
> > > > but I feel that my partition is thorougly borked. Of course no data was
> > > > lost due to backups but still I'd like this bug to be fixed ;-)
> > >
> > > 2.6.18-rc1 should be fine (contains the corruption fix).  Did you
> > > mkfs and restore?  Or at least get a full repair run?  If you did,
> > > and you still see issues in .18-rc1, please let me know asap.
> > 
> > Just out of interest, I've got a few XFS volumes that were created 24 months 
> > ago on a machine that I upgraded to 2.6.17 about a month ago. I haven't seen 
> > any crashes so far.
> > 
> > Assuming I get the newest XFS repair tools on there, what's the disadvantage 
> > of repairing versus creating a new filesystem? What special circumstances are 
> > required to cause a crash?
> 
> There should be no disadvantage to repairing.  I will update the FAQ
> shortly to describe all the details of the problem, recommendations
> on how to address it, which kernel version is affected, etc.
this FAQ, is it this: http://oss.sgi.com/projects/xfs/faq.html#dir2 ?
(btw, it seems that while only in the TOC once, you have the same about
2.6.17 twice..)..

which version of xfsprogs should i use while doing the xfs_check ?

> 
> cheers.
> 

