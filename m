Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVLOPlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVLOPlE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 10:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVLOPlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 10:41:04 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:33753 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1750774AbVLOPlB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 10:41:01 -0500
Date: Thu, 15 Dec 2005 08:41:00 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org, tony.luck@intel.com, parisc-linux@parisc-linux.org
Subject: Re: 2.6.15-rc5-mm2 can't boot on ia64 due to changing on_each_cpu().
Message-ID: <20051215154100.GB9286@parisc-linux.org>
References: <20051215030040.GA28660@kvack.org> <43A0FE0D.6030100@jp.fujitsu.com> <20051215152450.2445.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215152450.2445.Y-GOTO@jp.fujitsu.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 03:34:27PM +0900, Yasunori Goto wrote:
> Thanks! It works!
> 
> BTW, I found same casted function at on_each_cpu() in parisc code.
>  (arch/parisc/kernel/cache.c
>   arch/parisc/kernel/smp.c
>   arch/parisc/mm/init.c)
> 
> Are they also should fixed? 
> I don't have parisc box. So, I don't know there is same trouble on
> parisc box or not, and I can't test it.

Yes, these  will also need to be changed.  Thanks.
