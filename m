Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261464AbSJYQZv>; Fri, 25 Oct 2002 12:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261472AbSJYQZv>; Fri, 25 Oct 2002 12:25:51 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:60170 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261464AbSJYQZu>; Fri, 25 Oct 2002 12:25:50 -0400
Date: Fri, 25 Oct 2002 17:31:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paul Larson <plars@linuxtestproject.org>
Cc: Andrew Morton <akpm@digeo.com>, chrisl@vmware.com,
       Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       chrisl@gnuchina.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021025173157.A28960@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Larson <plars@linuxtestproject.org>,
	Andrew Morton <akpm@digeo.com>, chrisl@vmware.com,
	Andrea Arcangeli <andrea@suse.de>,
	lkml <linux-kernel@vger.kernel.org>, chrisl@gnuchina.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <20021024175718.GA1398@vmware.com> <20021024183327.GS3354@dualathlon.random> <20021024191531.GD1398@vmware.com> <3DB85C1B.62D14184@digeo.com> <20021024212313.GF1398@vmware.com> <3DB86650.1C48F044@digeo.com> <1035562304.5646.171.camel@plars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1035562304.5646.171.camel@plars>; from plars@linuxtestproject.org on Fri, Oct 25, 2002 at 11:11:41AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 11:11:41AM -0500, Paul Larson wrote:
> On Thu, 2002-10-24 at 16:29, Andrew Morton wrote:
> > -ac kernels have an lru per zone and so would not be bitten
> > by this failure.  If indeed you are striking this problem,
> > which is described at
> > http://mail.nl.linux.org/linux-mm/2002-08/msg00049.html
> Is it the 2.4 or 2.5 (or both) ac kernels that have the per zone lru?  I
> have some stuff I'd like to try with that.

2.4-rmap, 2.4-ac and any 2.5 (including -ac).

