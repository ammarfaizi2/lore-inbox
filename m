Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261323AbTCTHxz>; Thu, 20 Mar 2003 02:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261326AbTCTHxz>; Thu, 20 Mar 2003 02:53:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36066 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261323AbTCTHxy>;
	Thu, 20 Mar 2003 02:53:54 -0500
Date: Thu, 20 Mar 2003 09:04:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: WimMark I report for 2.5.65-mm2
Message-ID: <20030320080449.GL4990@suse.de>
References: <20030319232812.GJ2835@ca-server1.us.oracle.com> <20030319175726.59d08fba.akpm@digeo.com> <20030320003858.GM2835@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320003858.GM2835@ca-server1.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19 2003, Joel Becker wrote:
> On Wed, Mar 19, 2003 at 05:57:26PM -0800, Andrew Morton wrote:
> > Joel Becker <Joel.Becker@oracle.com> wrote:
> > >
> > > WimMark I report for 2.5.65-mm2
> > > 
> > > Runs:  1374.22 1487.19 1437.26
> > > 
> > 
> > That is with elevator=as?
> 
> 	Yes, it is as.  On Nick's recommendation I didn't consider a
> deadline run a priority.  The regular deadline runs have been 1550-1590,
> which is indeed statistically significant.

Hmm that's a bit odd IMHO, the deadline runs are nice for comparison. If
there's a variation between -mmX and -mmY, and deadline + as have
consistent scores, then it would be a good clue.

Besides, deadline is still the most solid choice.

-- 
Jens Axboe

