Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270627AbTHJTJQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 15:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270628AbTHJTJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 15:09:16 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:42824 "EHLO
	DYN320019.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S270627AbTHJTJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 15:09:15 -0400
Date: Sun, 10 Aug 2003 05:06:17 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@digeo.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Convert do_no_page() to a hook to avoid DFS race
Message-ID: <20030810120616.GA1638@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20030530164150.A26766@us.ibm.com> <20030530180027.75680efd.akpm@digeo.com> <20030531235123.GC1408@us.ibm.com> <20030809195011.A20269@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030809195011.A20269@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 07:50:11PM +0100, Christoph Hellwig wrote:
> On Sat, May 31, 2003 at 04:51:23PM -0700, Paul E. McKenney wrote:
> > > I don't think there's a lot of point in making changes until the code which
> > > requires those changes is accepted into the tree.  Otherwise it may be
> > > pointless churn, and there's nothing in-tree to exercise the new features.
> > 
> > A GPLed use of these DFS features is expected Real Soon Now...
> 
> So we get to see all the kernel C++ code from GPRS? [1] Better not, IBM
> might badly scare customers away if it the same quality as the C glue
> code layer..
> 
> [1] http://oss.software.ibm.com/linux/patches/?patch_id=923

I will let the GPFS guys worry about that.  ;-)

							Thanx, Paul
