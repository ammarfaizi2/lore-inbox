Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbTE2XRj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 19:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTE2XRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 19:17:39 -0400
Received: from air-2.osdl.org ([65.172.181.6]:29332 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263169AbTE2XRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 19:17:37 -0400
Message-Id: <200305292330.h4TNUmd30434@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Mark Peloquin <peloquin@austin.ibm.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Nightly regression runs against current bk tree 
In-Reply-To: Message from Andreas Dilger <adilger@clusterfs.com> 
   of "Thu, 29 May 2003 17:17:03 MDT." <20030529171703.U29153@schatzie.adilger.int> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 May 2003 16:30:48 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On May 29, 2003  17:48 -0500, Mark Peloquin wrote:
> > Your correct. We're just getting started with this effort and we used 
> > this mix to get things going. Once ppl are happy with the presentation 
> > of data, we planned to add more tests to provide a more balanced mix. 
> > But since you asked, we have added lmbench to our -bk3 regression run. :)
> 
> Mark, it would be nice to get a graph of the combined results for each
> test.  Something like:
> 
>                  tiobench sequential write rate
>   |                                  +++++++++++++++++      + = -mm-ext3
> M |        ++++++++++++++++++++++++++*****************      * = linus-ext3
> B | +++++++*****************   ######                       # = -ac-ext3
> / |                                                         . = -mm-XFS
> s |                                                         = = -ac-XFS
>   |                         *********                       etc
>   |
>   +----------------------------------------------------
> 			date
> 
> This allows at-a-glance trends for each group of tests and (as in the
> example above you could see easily when a performance bug was added
> and fixed in -ac before in the linus kernel, for example).  Probably
> having all of the comparable results on the same page, or even in the
> same graph results is a win.
> 
> Bonus points if you can click on a spot in the graph and get the results
> page for that date/test ;-).

This idea the STP team really, really likes. We'll start working on getting 
this type of report
into our framework. 

Thanks much, Andreas - great explaination. 
cliffw

> 
> Cheers, Andreas
> --
> Andreas Dilger
> http://sourceforge.net/projects/ext2resize/
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


