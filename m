Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWDLPqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWDLPqg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 11:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWDLPqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 11:46:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:31033 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750781AbWDLPqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 11:46:35 -0400
X-IronPort-AV: i="4.04,115,1144047600"; 
   d="scan'208"; a="23109290:sNHT48661522"
Date: Wed, 12 Apr 2006 08:46:33 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Mel Gorman <mel@skynet.ie>
Cc: linuxppc-dev@ozlabs.org, davej@codemonkey.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture independent manner
Message-ID: <20060412154633.GA10589@agluck-lia64.sc.intel.com>
References: <20060411103946.18153.83059.sendpatchset@skynet> <20060411222029.GA7743@agluck-lia64.sc.intel.com> <Pine.LNX.4.64.0604112352230.6624@skynet.skynet.ie> <20060412000500.GA8532@agluck-lia64.sc.intel.com> <Pine.LNX.4.64.0604121001590.24819@skynet.skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604121001590.24819@skynet.skynet.ie>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2006 at 11:50:31AM +0100, Mel Gorman wrote:

Patch got corrupted in transit and won't apply (looks like something stripped
trailing spaces from empty lines).  E.g.

> diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/ia64/Kconfig linux-2.6.17-rc1-105-ia64_use_init_nodes/arch/ia64/Kconfig
> --- linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/ia64/Kconfig	2006-04-03 04:22:10.000000000 +0100
> +++ linux-2.6.17-rc1-105-ia64_use_init_nodes/arch/ia64/Kconfig	2006-04-11 23:31:38.000000000 +0100
> @@ -352,6 +352,9 @@ config NUMA
>   	  Access).  This option is for configuring high-end multiprocessor
>   	  server systems.  If in doubt, say N.
> 
> +config ARCH_POPULATES_NODE_MAP
> +	def_bool y
> +
>   # VIRTUAL_MEM_MAP and FLAT_NODE_MEM_MAP are functionally equivalent.
>   # VIRTUAL_MEM_MAP has been retained for historical reasons.
>   config VIRTUAL_MEM_MAP
