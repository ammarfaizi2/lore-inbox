Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287625AbSAEJZI>; Sat, 5 Jan 2002 04:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287629AbSAEJY6>; Sat, 5 Jan 2002 04:24:58 -0500
Received: from ns2.auctionwatch.com ([64.14.24.2]:18705 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id <S287625AbSAEJYp>; Sat, 5 Jan 2002 04:24:45 -0500
Date: Sat, 5 Jan 2002 01:24:42 -0800
From: Petro <petro@auctionwatch.com>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020105092442.GC26154@auctionwatch.com>
In-Reply-To: <200201040019.BAA30736@webserver.ithnet.com> <3C360D6E.9020207@athlon.maya.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C360D6E.9020207@athlon.maya.org>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"We" (Auctionwatch.com) are experiencing problems that appear to be
related to VM, I realize that this question was not directed at me:

On Fri, Jan 04, 2002 at 09:15:42PM +0100, Andreas Hartmann wrote:
> Stephan von Krawczynski wrote:
> Question is: which nature is your application / load of the system? You 
> wrote something about database server. How much rows alltogether? What's 

    Mysql running a dual 650 PIII, 2 gig ram. Rows? Dunno, but several
    million tables (about 85 gig of tables averaging 45-50k IIRC). 

> the size of the table(s)? How many concurrent accesses do you have? Do

    We will have 2-400+ tables open at once. 

> you do "easy" searches where all of the conditions are located in the 
> index? How big is your index? How big is the throughput of your 
> database? Do you have your tables on raw partitions (without caching; as 
> you can do it with UDB)?

    I don't know much about the specific design, other than I've been
    told it's non-optimal. 

> How big are the partitions you are mounting at once? In my case, all the 
> partitions together have about 70GB (all reiserfs).

    One 250G logical volume, a couple smaller ones (3 gig, 30 gig). 

-- 
Share and Enjoy. 
