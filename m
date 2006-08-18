Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbWHRNKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbWHRNKT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 09:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWHRNKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 09:10:19 -0400
Received: from mga05.intel.com ([192.55.52.89]:32166 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030373AbWHRNKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 09:10:18 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,143,1154934000"; 
   d="scan'208"; a="118092196:sNHT16771496"
Message-ID: <44E5BC2C.80708@linux.intel.com>
Date: Fri, 18 Aug 2006 15:10:04 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 2/5] -fstack-protector feature: Add the Kconfig option
References: <1155746902.3023.63.camel@laptopd505.fenrus.org> <200608181308.07752.ak@suse.de> <1155900206.4494.141.camel@laptopd505.fenrus.org> <200608181605.19520.ak@suse.de>
In-Reply-To: <200608181605.19520.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> the binary search argument in this case is moot, just having a config
>> option doesn't break anything compile wise and each later step is
>> self-compiling..
> 
> Not true when the config used for the binary search has stack protector
> enabled.
>
oh? I thought I was pretty careful about that

looking over the patches again I can't find any reason for a non-compiling/working kernel; at any step..
can you show me the compile error you got or the bug you found?

Also, I generally like this order since this order allows you to bisect stackprotector patches itself, rather than the
artificial "add a bunch of dead code and then suddenly turn the light on" approach..
