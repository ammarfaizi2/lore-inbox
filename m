Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWDUA2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWDUA2Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWDUA2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:28:25 -0400
Received: from mga06.intel.com ([134.134.136.21]:54932 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932178AbWDUA2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:28:24 -0400
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25826642:sNHT15964368"
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25845504:sNHT16065280"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25826640:sNHT16452002"
Date: Thu, 20 Apr 2006 17:25:53 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, pwil3058@bigpond.net.au,
       efault@gmx.de, nickpiggin@yahoo.com.au, mingo@elte.hu,
       kernel@kolivas.org, kenneth.w.chen@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] smpnice: don't consider sched groups which are lightly loaded for balancing
Message-ID: <20060420172553.A12394@unix-os.sc.intel.com>
References: <20060329145242.A11376@unix-os.sc.intel.com> <442B1AE8.5030005@bigpond.net.au> <20060329165052.C11376@unix-os.sc.intel.com> <442B3111.5030808@bigpond.net.au> <20060401204824.A8662@unix-os.sc.intel.com> <442F7871.4030405@bigpond.net.au> <20060419182444.A5081@unix-os.sc.intel.com> <444719F8.2050602@bigpond.net.au> <20060420095408.A10267@unix-os.sc.intel.com> <20060420164936.5988460d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060420164936.5988460d.akpm@osdl.org>; from akpm@osdl.org on Thu, Apr 20, 2006 at 04:49:36PM -0700
X-OriginalArrivalTime: 21 Apr 2006 00:28:22.0787 (UTC) FILETIME=[7F4A6D30:01C664DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 04:49:36PM -0700, Andrew Morton wrote:
> "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
> >
> > updated patch appended. thanks.
> 
> Where are we up to with smpnice now?  Are there still any known
> regressions/problems/bugs/etc?  Has sufficient testing been done for us to
> know this?

Based on the code review, so far I have been giving load balancing examples 
which break. Peter is also plannning to fix outstanding issues which are open.

In the coming days, we are planning to run some benchmarks.

Nick, it will be great if you can review and provide your feedback.

thanks,
suresh
