Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbUBXWWl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUBXWWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:22:41 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:3210 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262493AbUBXWW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:22:27 -0500
Message-ID: <403BCE9E.7080607@matchmail.com>
Date: Tue, 24 Feb 2004 14:22:22 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>
In-Reply-To: <20040222172200.1d6bdfae.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm3/

Hi,

I have 2.6.3 on the 1.5GB RAM server that started the "large slab" thread.

Which patches should I apply from -mm to test for improvements?

Do these below have any dependencies not listed?

> vmscan-remove-priority.patch
>   mm/vmscan.c: remove unused priority argument.
> 
> kswapd-throttling-fixes.patch
>   kswapd throttling fixes
> 
> vm-dont-rotate-active-list.patch
>   vmscan: avoid rotation of the active list
> 
> vm-dont-rotate-active-list-padding.patch
>   vmscan: align scan_page per node
> 
> vm-lru-info.patch
>   vmscan: make better use of referenced info
> 
> vm-shrink-zone.patch
>   vmscan: several tuneups
> 
> vm-shrink-zone-div-by-0-fix.patch
> 
> vm-tune-throttle.patch
>   vmscan: delay throttling a little
> 
> shrink_slab-for-all-zones.patch
>   vm: scan slab in response to highmem scanning
> 

> zone-balancing-fix.patch
>   vmscan: zone balancing fix
> 
> zone-balancing-batching.patch
>   vmscan: fix inter-zone reclaim balancing
> 
What about Nick's fix up patch for the two patches above?  Should I 
include that one also?

Thanks,

Mike

