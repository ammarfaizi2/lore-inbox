Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWB1DlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWB1DlM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 22:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWB1DlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 22:41:11 -0500
Received: from fmr20.intel.com ([134.134.136.19]:50155 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750723AbWB1DlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 22:41:10 -0500
Subject: Re: [PATCH] Enable mprotect on huge pages
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       kenneth.w.chen@intel.com,
       "yanmin.zhang@intel.com" <yanmin.zhang@intel.com>, davem@davemloft.net,
       paulus@samba.org, benh@kernel.crashing.org, wli@holomorphy.com,
       lethal@linux-sh.org, kkojima@rr.iij4u.or.jp,
       "tony.luck@intel.com" <tony.luck@intel.com>
In-Reply-To: <20060228033220.GA2570@localhost.localdomain>
References: <1140664780.12944.26.camel@ymzhang-perf.sh.intel.com>
	 <20060224142844.77cbd484.akpm@osdl.org>
	 <20060226230903.GA24422@localhost.localdomain>
	 <1141018592.1256.37.camel@ymzhang-perf.sh.intel.com>
	 <1141022034.1256.44.camel@ymzhang-perf.sh.intel.com>
	 <20060227173449.26c79a44.akpm@osdl.org>
	 <1141097034.3898.10.camel@ymzhang-perf.sh.intel.com>
	 <20060228033220.GA2570@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1141097870.3898.17.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 28 Feb 2006 11:37:50 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-28 at 11:32, David Gibson wrote:
> On Tue, Feb 28, 2006 at 11:23:54AM +0800, Zhang, Yanmin wrote:
> > On Tue, 2006-02-28 at 09:34, Andrew Morton wrote:
> > > "Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:
> > > >
> > > > > > > > 2.6.16-rc3 uses hugetlb on-demand paging, but it doesn_t support hugetlb
> > > >  > > > > mprotect. My patch against 2.6.16-rc3 enables this capability.
> > > > 

> If you could adapt this testcase to fit into the libhugetlbfs
> testsuite, that would be really great (from
> git://ozlabs.org/~dgibson/git/libhugetlbfs.git).  Otherwise I guess I
> will..
Frankly, I wrote a hugetlb test suite with dozens of test cases. It could
run on i386/x86_64/ia64 and caught many hugetlb bugs effectively. I am
not sure if I could distribute it out of intel.


