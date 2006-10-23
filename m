Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWJWFrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWJWFrV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 01:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWJWFrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 01:47:21 -0400
Received: from mga06.intel.com ([134.134.136.21]:31139 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751389AbWJWFrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 01:47:20 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,341,1157353200"; 
   d="scan'208"; a="149069236:sNHT19947473"
Date: Sun, 22 Oct 2006 22:26:52 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: Martin Bligh <mbligh@google.com>, nickpiggin@yahoo.com.au, akpm@osdl.org,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       dino@in.ibm.com, rohitseth@google.com, holt@sgi.com,
       dipankar@in.ibm.com, suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-ID: <20061022222652.B2526@unix-os.sc.intel.com>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com> <4537527B.5050401@yahoo.com.au> <20061019120358.6d302ae9.pj@sgi.com> <4537D056.9080108@yahoo.com.au> <4537D6E8.8020501@google.com> <20061022035135.2c450147.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061022035135.2c450147.pj@sgi.com>; from pj@sgi.com on Sun, Oct 22, 2006 at 03:51:35AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 03:51:35AM -0700, Paul Jackson wrote:
> Martin wrote:
> > We (Google) are planning to use it to do some partitioning, albeit on
> > much smaller machines. I'd really like to NOT use cpus_allowed from
> > previous experience - if we can get it to to partition using separated
> > sched domains, that would be much better.
> 
> Why not use cpus_allowed for this, via cpusets and/or sched_setaffinity?

group of pinned tasks can completely skew the system load balancing..
