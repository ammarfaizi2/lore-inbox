Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVEFRyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVEFRyr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 13:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVEFRyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 13:54:47 -0400
Received: from fsmlabs.com ([168.103.115.128]:44218 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261242AbVEFRyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 13:54:46 -0400
Date: Fri, 6 May 2005 11:57:16 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Natalie.Protasevich@unisys.com
cc: akpm@osdl.org, ak@suse.de, len.brown@intel.com,
       venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeon processors
 in EM64T mode (x86_64)
In-Reply-To: <20050505221117.508BB42AE4@linux.site>
Message-ID: <Pine.LNX.4.61.0505061151190.11469@montezuma.fsmlabs.com>
References: <20050505221117.508BB42AE4@linux.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2005 Natalie.Protasevich@unisys.com wrote:

> 
> 
> This patch disables unique IO_APIC_ID check for xAPIC systems running in 
> EM64T mode. Xeon-based ES7000s panic failing this unnecessary check. I 
> added IOAPIC_ID_CHECK config option and turned it off for Intel 
> processors. Also added the boot option that overrides default and turnes 
> this check on/off in case it is needed for some reason. Hope this is 
> acceptable way to fix the problem.

Perhaps just make it unconditional on xAPIC, i also can't see when you'd 
need the kernel parameter, so perhaps lets just leave that out.

Thanks,
	Zwane

