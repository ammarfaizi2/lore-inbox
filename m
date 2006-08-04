Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161223AbWHDO0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbWHDO0e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWHDO0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:26:34 -0400
Received: from mga03.intel.com ([143.182.124.21]:40868 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030239AbWHDO0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:26:33 -0400
X-IronPort-AV: i="4.07,211,1151910000"; 
   d="scan'208"; a="97733660:sNHT9573473924"
Message-ID: <44D358C6.3080406@intel.com>
Date: Fri, 04 Aug 2006 07:25:10 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Auke Kok <auke-jan.h.kok@intel.com>, linux-kernel@vger.kernel.org,
       jesse.brandeburg@intel.com, john.ronciak@intel.com,
       netdev@vger.kernel.org, arjan@linux.intel.com
Subject: Re: [RFC] irqbalance: Mark in-kernel irqbalance as obsolete, set
 to N by default
References: <44CE3F5E.4010305@intel.com> <20060803194550.9ff31bc1.akpm@osdl.org>
In-Reply-To: <20060803194550.9ff31bc1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Aug 2006 14:26:28.0461 (UTC) FILETIME=[F94319D0:01C6B7D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 31 Jul 2006 10:35:26 -0700
> Auke Kok <auke-jan.h.kok@intel.com> wrote:
> 
>> We've recently seen a number of user bug reports against e1000 that the 
>> in-kernel irqbalance code is detrimental to network latency. The algorithm 
>> keeps swapping irq's for NICs from cpu to cpu causing extremely high network 
>> latency (>1000ms).
> 
> What kernel versions?  Some IRQ balancer fixes went in shortly after 2.6.17.

user reports show 2.6.17.1 having the problem, I'm trying to get more details 
information, and will ask if 2.6.18rc3 or so does better for them.

Cheers,

Auke
