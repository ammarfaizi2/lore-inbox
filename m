Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWDMRr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWDMRr0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 13:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWDMRr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 13:47:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:28958 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751123AbWDMRrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 13:47:25 -0400
X-IronPort-AV: i="4.04,118,1144047600"; 
   d="scan'208"; a="23625625:sNHT49113225"
Date: Thu, 13 Apr 2006 10:47:20 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: davej@codemonkey.org.uk, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture independent manner V2
Message-ID: <20060413174720.GA15183@agluck-lia64.sc.intel.com>
References: <20060412232036.18862.84118.sendpatchset@skynet> <20060413095207.GA4047@skynet.ie> <20060413171942.GA15047@agluck-lia64.sc.intel.com> <20060413173008.GA19402@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413173008.GA19402@skynet.ie>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Double counted a hole here, then went downhill. Does the following fix
> it?

Yes, that boots.  What's more the counts of pages in DMA/Normal
zone match the kernel w/o your patches too.  So for tiger_defconfig
you've now exactly matched the old behaivour.

I'll try to test generic and sparse kernels later, but I have to
look at another issue now.

-Tony
