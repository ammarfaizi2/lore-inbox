Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133037AbRDLBcX>; Wed, 11 Apr 2001 21:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133038AbRDLBcO>; Wed, 11 Apr 2001 21:32:14 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:58632 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S133037AbRDLBcC>;
	Wed, 11 Apr 2001 21:32:02 -0400
Date: Wed, 11 Apr 2001 18:29:30 -0700
From: Anton Blanchard <anton@samba.org>
To: Maneesh Soni <smaneesh@in.ibm.com>
Cc: lse tech <lse-tech@lists.sourceforge.net>,
        lkml <linux-kernel@vger.kernel.org>, Paul.McKenney@us.ibm.com,
        ak@suse.de, hawkes@engr.sgi.com, dipankar@sequent.com
Subject: Re: [RFC][PATCH] Scalable FD Management using Read-Copy-Update
Message-ID: <20010411182929.A16665@va.samba.org>
In-Reply-To: <20010409201311.D9013@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010409201311.D9013@in.ibm.com>; from smaneesh@in.ibm.com on Mon, Apr 09, 2001 at 08:13:11PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch provides a very good performance improvement in file 
> descriptor management for SMP linux kernel on a 4-way machine with the 
> expectation of even higher gains on higher end machines. The patch uses the 
> read-copy-update mechanism for Linux, published earlier at the sourceforge
> site under Linux Scalablity Effort project.
>        http://lse.sourceforge.net/locking/rclock.html.

Good stuff!

It would be interesting to try a filesystem benchmark such as dbench. On
a quad PPC fget was chewing up more than its fair share of cpu time.

Anton
