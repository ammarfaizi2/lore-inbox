Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271514AbRHUEAF>; Tue, 21 Aug 2001 00:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271507AbRHUD7p>; Mon, 20 Aug 2001 23:59:45 -0400
Received: from dsl254-035-224.sea1.dsl.speakeasy.net ([216.254.35.224]:29632
	"EHLO dhcp12.pdx.beattie-home.net") by vger.kernel.org with ESMTP
	id <S271514AbRHUD7f>; Mon, 20 Aug 2001 23:59:35 -0400
Date: Thu, 16 Aug 2001 17:42:24 -0700
From: Brian Beattie <bbeattie@sequent.com>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Brian Beattie <bbeattie@beaverton.ibm.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com
Subject: Re: md/multipath: Multipath, Multiport support and prototype patch for round robin routing
Message-ID: <20010816174223.A1381@dyn9-47-16-223.des.beaverton.ibm.com>
Mail-Followup-To: Christoph Hellwig <hch@ns.caldera.de>,
	Brian Beattie <bbeattie@beaverton.ibm.com>,
	linux-kernel@vger.kernel.org, mingo@redhat.com
In-Reply-To: <20010723133242.B970@dyn9-47-16-69.des.beaverton.ibm.com> <200108152034.f7FKYrM26636@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108152034.f7FKYrM26636@ns.caldera.de>; from hch@ns.caldera.de on Wed, Aug 15, 2001 at 10:34:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2001 at 10:34:53PM +0200, Christoph Hellwig wrote:
> In article <20010723133242.B970@dyn9-47-16-69.des.beaverton.ibm.com> you wrote:

> 
> The second comment actually goes to you, Brian:  could you please try to
> create unified diffs (diff -u)?  It's sooo much easier to read..
> 

I'm just back from vacation and still getting back into the groove,
I'll try to do that and post it in a day or two.


> > + 
> > + static struct multipath_dev_table multipath_dev_template = {
> > +         "",
> > + 	{
> > + 		{MULTIPATH_ROUTING, "routing", NULL, sizeof(int), 0644,
> > + 			NULL, &proc_dointvec},
> 
> Shouldn't this be a property of the md device, instead of a sysctl?
> I planned to write that information in the md superblock for my design.

I'm not sure what you mean here.  This is not a really complete thing
here.  Adding the information to the superblock sounds, like a good idea,
but I'm also looking at dynamically modifying the operating parameters.

> 
> 	Christoph
> 
> -- 
> Of course it doesn't work. We've performed a software upgrade.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Brian Beattie
IBM Linux Technology Center - MPIO/SAN
bbeattie@sequent.com
503.578.5899  Des2-3C-5
