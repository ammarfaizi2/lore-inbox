Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbULOAXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbULOAXs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbULOAXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:23:34 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:18611 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261740AbULOAWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 19:22:23 -0500
Message-ID: <41BF8514.1030208@jp.fujitsu.com>
Date: Wed, 15 Dec 2004 09:28:04 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org, ak@suse.de,
       Yasunori Goto <ygoto@us.fujitsu.com>
Subject: Re: [PATCH 0/3] NUMA boot hash allocation interleaving
References: <B8E391BBE9FE384DAA4C5C003888BE6F028C1639@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F028C1639@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luck, Tony wrote:
>>this behavior is turned on by default only for IA64 NUMA systems
> 
> 
>>A boot line parameter "hashdist" can be set to override the default
>>behavior.
> 
> 
> 
> Note to node hot-plug developers ... if this patch goes in you
> will also want to disable this behaviour, otherwaise all nodes
> become non-removeable (unless you can transparently re-locate the
> physical memory backing all these tables).
(adding CC to LHMS)

I think GFP_HOTREMOVABLE , which Goto is proposing, will work well
when we want MEMORY_HOTPLUG.


Thnaks.
--Kame <kamezawa.hiroyu@jp.fujitsu.com>

 >
 > -Tony


