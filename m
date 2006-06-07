Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWFGBKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWFGBKJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 21:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWFGBKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 21:10:08 -0400
Received: from mga07.intel.com ([143.182.124.22]:23867 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750783AbWFGBKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 21:10:07 -0400
X-IronPort-AV: i="4.05,215,1146466800"; 
   d="scan'208"; a="47115490:sNHT1373080268"
Date: Tue, 6 Jun 2006 18:06:22 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>, nickpiggin@yahoo.com.au,
       mingo@elte.hu, pwil3058@bigpond.net.au, akpm@osdl.org
Subject: Re: [Patch] sched: mc/smt power savings sched policy
Message-ID: <20060606180622.B18026@unix-os.sc.intel.com>
References: <20060606112521.A18026@unix-os.sc.intel.com> <200606070959.09216.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200606070959.09216.kernel@kolivas.org>; from kernel@kolivas.org on Wed, Jun 07, 2006 at 09:59:08AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 09:59:08AM +1000, Con Kolivas wrote:
> This MC code is a maze of #ifdefs within functions and getting harder to 
> follow with each subsequent patch. Can we not deviate so much from kernel 
> style?

build_sched_domains() originally was not designed with this many sched
domains in mind.. I can take a look at cleaning up of the sched domains
setup..

thanks,
suresh
