Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbTLTDHE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 22:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263768AbTLTDHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 22:07:04 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:34135 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263650AbTLTDHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 22:07:01 -0500
Date: Fri, 19 Dec 2003 19:05:05 -0800
To: Pat Gefre <pfg@sgi.com>, Christoph Hellwig <hch@infradead.org>,
       akpm@osdl.org, davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
Message-ID: <20031220030505.GB6856@sgi.com>
Mail-Followup-To: Pat Gefre <pfg@sgi.com>,
	Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
	davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
References: <20031219114328.A26526@infradead.org> <200312200035.hBK0ZwWR005874@fsgi900.americas.sgi.com> <20031220012428.GA6654@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031220012428.GA6654@sgi.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, I'm ok with these patches (and it looks like Christoph doesn't
find them too repulsive either) and David said he'd rather have you take
them directly if they look ok.  Will you merge them into your tree
please?  Like I said, this gets the tree into a very good state for
people using Altix machines, and contains a number of important bug
fixes.

Thanks,
Jesse

On Fri, Dec 19, 2003 at 05:24:28PM -0800, Jesse Barnes wrote:
> David, can you take these patches into your tree too?  We'll of course
> continue to clean things up, but with the application of these patches,
> the 2.6 kernel becomes something really usable for people with Altix
> machines.
> 
> Thanks,
> Jesse
> 
> On Fri, Dec 19, 2003 at 06:35:57PM -0600, Pat Gefre wrote:
> > Christoph,
> > 
> > Some general comments/questions and then the specifics follow.
> > 
> > First off, some of the changed/reorg'd code is foundation code for a
> > new ASIC that we are working on - so it now looks a little silly and
> > maybe a little like overkill, but we would like to start moving this
> > code into the community base.
> > 
> > I'm not sure where you are going with the IP27 idea. IP27 is mips so
> > the code doesn't belong in the ia64 directories - we also don't support
> > Bridge/Xbridge in our ia64 code which is why we'd like to get rid of it
> > and if you wanted to use the code as framework for other work I would
> > think you could archive a version of the tree now ? So I'm a bit
> > confused - there must be something I'm missing.
> > 
> > Also I did these patches sequentially (hence the numbering) - so in
> > some cases I may have taken out code that wasn't being used at the
> > time, but then added in back in when it was used.
> > 
> > Thanks for reviewing this for me - it sounds like we are making some
> > progress.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
