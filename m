Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTLIX77 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 18:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTLIX77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 18:59:59 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:22040 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263527AbTLIX76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 18:59:58 -0500
Date: Wed, 10 Dec 2003 10:58:32 +1100
From: Nathan Scott <nathans@sgi.com>
To: Christoph Hellwig <hch@lst.de>, pinotj@club-internet.fr, torvalds@osdl.org,
       neilb@cse.unsw.edu.au, manfred@colorfullife.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Message-ID: <20031209235832.GG783@frodo>
References: <mnet2.1070931455.23402.pinotj@club-internet.fr> <20031209020322.GA1798@frodo> <20031209072131.GD24599@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209072131.GD24599@lst.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 08:21:32AM +0100, Christoph Hellwig wrote:
> On Tue, Dec 09, 2003 at 01:03:22PM +1100, Nathan Scott wrote:
> > [ Christoph, is this failure expected?  I think you/Steve made
> > some changes there to use __GFP_NOFAIL and assume it wont fail?
> > (in 2.4 we do memory allocations differently to better handle
> > failures, but that code was removed...) ]
> 
> It looks like the slab allocator doesn't like __GFP_NOFAIL, we'll
> probably have to revert the XFS memory allocation wrappers to the
> 2.4 versions.
> 

OK, thanks - I'll look into it.

cheers.

-- 
Nathan
