Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbUFGHzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUFGHzU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 03:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUFGHzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 03:55:20 -0400
Received: from ozlabs.org ([203.10.76.45]:981 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261897AbUFGHzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 03:55:16 -0400
Date: Mon, 7 Jun 2004 17:55:01 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: wli@holomorphy.com, pj@sgi.com, mikpe@csd.uu.se, nickpiggin@yahoo.com.au,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net, miltonm@bga.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040607075501.GB7412@krispykreme>
References: <20040603094339.03ddfd42.pj@sgi.com> <20040603101010.4b15734a.pj@sgi.com> <1086313667.29381.897.camel@bach> <40BFD839.7060101@yahoo.com.au> <20040603221854.25d80f5a.pj@sgi.com> <16576.16748.771295.988065@alkaid.it.uu.se> <20040604090314.56d64f4d.pj@sgi.com> <20040604165601.GC21007@holomorphy.com> <20040604190803.GA6651@krispykreme> <20040604132819.44c4e7b5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604132819.44c4e7b5.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> aargh!  It's back!

Its stalking you.

> There's something about this patch which make me break out in hives.  Does
> it *really* need to be that complicated?

If we dont want maximum backwards compatibility we can get rid of the <
sizeof(long) bits.

> iirc, the last time I looked through this I was unable to convince myself
> that it was endianness-correct.  Is it?

Should be, but we could boot it on something 64bit little endian to prove
it.

Anton
