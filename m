Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162300AbWKPXWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162300AbWKPXWe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 18:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162302AbWKPXWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 18:22:34 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:47575 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1162300AbWKPXWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 18:22:33 -0500
Date: Fri, 17 Nov 2006 10:20:57 +1100
From: David Chinner <dgc@sgi.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, David Chinner <dgc@sgi.com>,
       Alasdair G Kergon <agk@redhat.com>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061116232057.GH11034@melbourne.sgi.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611152100.35054.rjw@sisk.pl> <20061115202348.GB3875@elf.ucw.cz> <200611152258.52160.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611152258.52160.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 10:58:51PM +0100, Rafael J. Wysocki wrote:
> On Wednesday, 15 November 2006 21:23, Pavel Machek wrote:
> > > I think I'll prepare a patch for freezing the work queues and we'll see what
> > > to do next.
> > 
> > Thanks!
> 
> Okay, the patch follows.
> 
> I've been running it for some time on my boxes and it doesn't seem to break
> anything.  However, I don't use XFS, so well ...

So you haven't actually tested whether it fixes anything or whether
it introduces any regressions?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
