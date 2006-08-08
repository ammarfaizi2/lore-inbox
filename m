Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbWHHWnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbWHHWnZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 18:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWHHWnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 18:43:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:24215 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S965064AbWHHWnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 18:43:22 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.07,222,1151910000"; 
   d="scan'208"; a="113657379:sNHT18262706"
Message-ID: <44D91351.2020702@intel.com>
Date: Tue, 08 Aug 2006 15:42:25 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: a.p.zijlstra@chello.nl, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, phillips@google.com, jesse.brandeburg@intel.com
Subject: Re: [RFC][PATCH 3/9] e1000 driver conversion
References: <20060808193325.1396.58813.sendpatchset@lappy>	<20060808193355.1396.71047.sendpatchset@lappy>	<44D8F919.7000006@intel.com> <20060808.153210.52118365.davem@davemloft.net>
In-Reply-To: <20060808.153210.52118365.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Aug 2006 22:43:22.0285 (UTC) FILETIME=[0D569DD0:01C6BB3C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> From: Auke Kok <auke-jan.h.kok@intel.com>
> Date: Tue, 08 Aug 2006 13:50:33 -0700
> 
>> can we really delete these??
> 
> netdev_alloc_skb() does it for you

yeah I didn't spot that patch #2 in that series introduces that code - my bad. 
Thanks.

Auke
