Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWDXT3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWDXT3K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWDXT3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:29:10 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:10939 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751155AbWDXT3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:29:09 -0400
Date: Mon, 24 Apr 2006 14:28:24 -0500
From: Robin Holt <holt@sgi.com>
To: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Anderw Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@americas.sgi.com>, Dean Nelson <dnc@americas.sgi.com>,
       Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>
Subject: Re: [(take 2)patch 0/7] Notify page fault call chain
Message-ID: <20060424192824.GA10893@lnx-holt.americas.sgi.com>
References: <20060420232456.712271992@csdlinux-2.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420232456.712271992@csdlinux-2.jf.intel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anil,

This set definitely improves things.  My timings from last week must
have been off.  I think I may have still had the notify_die() call in
the fault path.  This week, I see a 35 nSec slowdown between with/without
KRPOBES.  Last week, I thought they were roughly equivalent.


Thanks,
Robin Holt
