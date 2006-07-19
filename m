Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932560AbWGSW5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbWGSW5d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 18:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWGSW5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 18:57:33 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38340 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932560AbWGSW5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 18:57:33 -0400
Date: Thu, 20 Jul 2006 08:56:36 +1000
From: Nathan Scott <nathans@sgi.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Torsten Landschoff <torsten@debian.org>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com
Subject: Re: XFS breakage in 2.6.18-rc1
Message-ID: <20060720085636.D1947140@wobbly.melbourne.sgi.com>
References: <20060718222941.GA3801@stargate.galaxy> <20060719085731.C1935136@wobbly.melbourne.sgi.com> <200607190908.30727.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200607190908.30727.s0348365@sms.ed.ac.uk>; from s0348365@sms.ed.ac.uk on Wed, Jul 19, 2006 at 09:08:30AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 09:08:30AM +0100, Alistair John Strachan wrote:
> On Tuesday 18 July 2006 23:57, Nathan Scott wrote:
> [snip]
> > > of programs fail in mysterious ways. I tried to recover using xfs_repair
> > > but I feel that my partition is thorougly borked. Of course no data was
> > > lost due to backups but still I'd like this bug to be fixed ;-)
> >
> > 2.6.18-rc1 should be fine (contains the corruption fix).  Did you
> > mkfs and restore?  Or at least get a full repair run?  If you did,
> > and you still see issues in .18-rc1, please let me know asap.
> 
> Just out of interest, I've got a few XFS volumes that were created 24 months 
> ago on a machine that I upgraded to 2.6.17 about a month ago. I haven't seen 
> any crashes so far.
> 
> Assuming I get the newest XFS repair tools on there, what's the disadvantage 
> of repairing versus creating a new filesystem? What special circumstances are 
> required to cause a crash?

There should be no disadvantage to repairing.  I will update the FAQ
shortly to describe all the details of the problem, recommendations
on how to address it, which kernel version is affected, etc.

cheers.

-- 
Nathan
