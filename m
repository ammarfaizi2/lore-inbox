Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270584AbRHQToC>; Fri, 17 Aug 2001 15:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270618AbRHQTnx>; Fri, 17 Aug 2001 15:43:53 -0400
Received: from e24.nc.us.ibm.com ([32.97.136.230]:65186 "EHLO
	e24.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S270584AbRHQTni>; Fri, 17 Aug 2001 15:43:38 -0400
Date: Fri, 17 Aug 2001 12:42:46 -0700 (PDT)
From: Brian Beattie <bbeattie@sequent.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: Brian Beattie <bbeattie@sequent.com>, linux-kernel@vger.kernel.org
Subject: Re: md/multipath: Multipath, Multiport support and prototype patch
 for round robin routing (fwd)
Message-ID: <Pine.PTX.4.10.10108171239370.25286-100000@eng2.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having a little trouble wity the email setup oin my laptop, (the first
mail was sent on 7/23 but hid in my laptop untill I came back from
vacation 8/15 :) ).

Anyway here is my reply while I work on the laptop :).

Brian Beattie
IBM Linux Technology Center - MPIO/SAN
bbeattie@sequent.com
503.578.5899  Des2-3C-5

---------- Forwarded message ----------
Date: Thu, 16 Aug 2001 17:42:24 -0700
From: Brian Beattie <bbeattie@beaverton.ibm.com>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Brian Beattie <bbeattie@beaverton.ibm.com>, linux-kernel@vger.kernel.org,
     mingo@redhat.com
Subject: Re: md/multipath: Multipath,
     Multiport support and prototype patch for round robin routing

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

