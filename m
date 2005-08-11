Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVHKCkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVHKCkA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 22:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVHKCkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 22:40:00 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:24569 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932236AbVHKCj7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 22:39:59 -0400
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1123727560.30850.1.camel@mindpipe>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123726394.32531.33.camel@cog.beaverton.ibm.com>
	 <1123727560.30850.1.camel@mindpipe>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 19:39:54 -0700
Message-Id: <1123727994.32531.62.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-10 at 22:32 -0400, Lee Revell wrote:
> On Wed, 2005-08-10 at 19:13 -0700, john stultz wrote:
> > All,
> > 	Here's the next rev in my rework of the current timekeeping subsystem.
> > No major changes, only some cleanups and further splitting the larger
> > patches into smaller ones.
> 
> Last I heard this made gettimeofday() 20% slower on x86.  Is this still
> the case?

Ah, I've got a patch on my laptop that takes that down to ~2% or less. I
didn't include it in this patch set but I'll work to get it integrated
before the next release. Sorry about that.

If you have any suggestions for further performance improvements, please
let me know.

thanks
-john

