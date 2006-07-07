Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWGGAn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWGGAn3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWGGAn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:43:28 -0400
Received: from mga06.intel.com ([134.134.136.21]:53144 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751117AbWGGAn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:43:28 -0400
X-IronPort-AV: i="4.06,215,1149490800"; 
   d="scan'208"; a="61636018:sNHT43816612"
Date: Thu, 6 Jul 2006 17:36:07 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, vatsa@in.ibm.com,
       nickpiggin@yahoo.com.au, mingo@elte.hu, hawkes@sgi.com, dino@in.ibm.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH 2.6.16-mm1 2/2] sched_domains: Allocate sched_groups dynamically
Message-ID: <20060706173607.F13512@unix-os.sc.intel.com>
References: <20060325082804.GB17011@in.ibm.com> <20060706170151.cdb1dc6c.pj@sgi.com> <20060706170824.E13512@unix-os.sc.intel.com> <20060706173417.e7d1e39e.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060706173417.e7d1e39e.pj@sgi.com>; from pj@sgi.com on Thu, Jul 06, 2006 at 05:34:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 05:34:17PM -0700, Paul Jackson wrote:
> > In short, multi-core was broken too and Srivatsa's patch fixed it.
> 
> Thanks for your quick response, Suresh.
> 
> My test earlier today that showed multi-core -not- broken must
> have been flawed.
> 
> I will rerun them tomorrow, carefully.

It is quite possible that the kernel you are testing doesn't have multi-core
scheduler domain. If so, then you may not run into this issue.

thanks,
suresh
