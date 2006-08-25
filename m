Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWHYH4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWHYH4t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 03:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWHYH4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 03:56:48 -0400
Received: from mga05.intel.com ([192.55.52.89]:27175 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751222AbWHYH4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 03:56:48 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,167,1154934000"; 
   d="scan'208"; a="121029304:sNHT33611655"
Message-ID: <44EEAD35.9050005@linux.intel.com>
Date: Fri, 25 Aug 2006 09:56:37 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: [RFC] maximum latency tracking infrastructure
References: <1156441295.3014.75.camel@laptopd505.fenrus.org> <20060824225236.GT19707@waste.org>
In-Reply-To: <20060824225236.GT19707@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Thu, Aug 24, 2006 at 07:41:35PM +0200, Arjan van de Ven wrote:
>> Subject: [RFC] maximum latency tracking infrastructure
>> From: Arjan van de Ven <arjan@linux.intel.com>
>>
>> The patch below adds infrastructure to track "maximum allowable latency" for power
>> saving policies.
> 
> Looks good. But it will also be important to have a user-level way to
> report who is constraining us from power saving and by how much of a
> margin.
> 

there is in the patch:

echo l > /proc/sysreq-trigger
