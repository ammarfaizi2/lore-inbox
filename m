Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275231AbTHISuS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 14:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275249AbTHISuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 14:50:18 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:55310 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S275231AbTHISuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 14:50:16 -0400
Date: Sat, 9 Aug 2003 19:50:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [RFC][PATCH] Convert do_no_page() to a hook to avoid DFS race
Message-ID: <20030809195011.A20269@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <20030530164150.A26766@us.ibm.com> <20030530180027.75680efd.akpm@digeo.com> <20030531235123.GC1408@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030531235123.GC1408@us.ibm.com>; from paulmck@us.ibm.com on Sat, May 31, 2003 at 04:51:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 04:51:23PM -0700, Paul E. McKenney wrote:
> > I don't think there's a lot of point in making changes until the code which
> > requires those changes is accepted into the tree.  Otherwise it may be
> > pointless churn, and there's nothing in-tree to exercise the new features.
> 
> A GPLed use of these DFS features is expected Real Soon Now...

So we get to see all the kernel C++ code from GPRS? [1] Better not, IBM
might badly scare customers away if it the same quality as the C glue
code layer..

[1] http://oss.software.ibm.com/linux/patches/?patch_id=923

