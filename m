Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbTEGXLh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTEGXLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:11:33 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:50909 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id S264362AbTEGXKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:10:32 -0400
Date: Wed, 7 May 2003 16:19:20 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WimMark I report for 2.5.69
Message-ID: <20030507231919.GA3989@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <20030507175422.GX3989@ca-server1.us.oracle.com> <20030507154150.005db55e.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030507154150.005db55e.akpm@digeo.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 03:41:50PM -0700, Andrew Morton wrote:
> > Runs:  1462.17 1005.78 1995.99
> > ...
> > This benchmark is sensitive to random system events.
> 
> You can say that again.
> 
> We need to understand why there is such variation.  If we can do that,
> then perhaps we can make those 1.0's and 1.5's go away.

	Some kernels run very very even.  Others do not.  I suspect that
certain kernel behaviors and changes exacerbate the issues.

> Is that a thing you can work on?  One approach would be to vary parameters
> (filesystem type, amount of memory, TCQ lengths, workload, whatever) and
> see which ones the throughput is sensitive to.

	I can try.  I'm currently trying to catch up to the
state-of-the-penguin, as I also have some test patches from Nick to run.
These runs take a while, and I've been busy as well.

Joel

-- 

"Any man who is under 30, and is not a liberal, has not heart;
 and any man who is over 30, and is not a conservative, has no brains."
         - Sir Winston Churchill 

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
