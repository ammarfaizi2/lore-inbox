Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbWHRWzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbWHRWzJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWHRWzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:55:08 -0400
Received: from mga06.intel.com ([134.134.136.21]:42129 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751559AbWHRWzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:55:06 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,147,1154934000"; 
   d="scan'208"; a="111061100:sNHT29504790"
Date: Fri, 18 Aug 2006 15:42:30 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, mingo@redhat.com,
       apw@shadowen.org
Subject: Re: [patch] sched: generic sched_group cpu power setup
Message-ID: <20060818154230.A23214@unix-os.sc.intel.com>
References: <20060815175525.A2333@unix-os.sc.intel.com> <20060815212455.c9fe1e34.pj@sgi.com> <20060816104551.A7305@unix-os.sc.intel.com> <20060818142347.A22846@unix-os.sc.intel.com> <20060818152954.1ef5aa34.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060818152954.1ef5aa34.pj@sgi.com>; from pj@sgi.com on Fri, Aug 18, 2006 at 03:29:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 03:29:54PM -0700, Paul Jackson wrote:
> Suresh wrote:
> > I will post a 'cpu_power' renaming patch shortly.
> 
> Rename to what?

Not yet decided. But both the words "cpu" and "power" will disappear :)
sched group can have one or more cpus.. so having 'cpu' is confusing
and 'power/energy' seems to be confusing too..

I don't like 'task_load' as it kind of refers to current task load in a
sched_group.  Currently I favor for 'load_capacity'. Anyone reading
sched code know what 'load' is.

If any one has a better suggestion, I am open.

thanks,
suresh
