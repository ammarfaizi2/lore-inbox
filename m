Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267864AbUG3WZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267864AbUG3WZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 18:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267861AbUG3WZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 18:25:15 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:4579 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267726AbUG3WVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 18:21:53 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: colpatch@us.ibm.com
Subject: Re: [Lse-tech] [RFC][PATCH] Change pcibus_to_cpumask() to pcibus_to_node()
Date: Fri, 30 Jul 2004 15:21:03 -0700
User-Agent: KMail/1.6.2
Cc: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>
References: <1090887007.16676.18.camel@arrakis> <200407300836.32812.jbarnes@engr.sgi.com> <1091225824.5925.1.camel@arrakis>
In-Reply-To: <1091225824.5925.1.camel@arrakis>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407301521.03422.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 30, 2004 3:17 pm, Matthew Dobson wrote:
> On Fri, 2004-07-30 at 08:36, Jesse Barnes wrote:
> > I think this will work.  My tree didn't have nodemask_t though, so it
> > didn't compile :)  Here's a first stab at an ia64 portion of the patch.
> >
> > Jesse
>
> Andrew picked it up in 2.6.8-rc2-mm1, so if you base your patch against
> that it should compile...  That's what I based my patch off.  Our lab
> has been down for a few days so I hope to do some testing on Monday for
> my patches.  If all goes well, I'll add your code into my patch and
> submit it early next week, ok?

Sounds good, but it will probably need some fixes before it works correctly 
(my stuff I mean), so when you have something that looks good give me a few 
minutes with it before you send it on to Andrew if you would.

Thanks,
Jesse
