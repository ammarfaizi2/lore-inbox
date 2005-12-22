Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965167AbVLVOVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbVLVOVP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 09:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbVLVOVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 09:21:15 -0500
Received: from mailserv.intranet.GR ([146.124.14.106]:49818 "EHLO
	mailserv.intranet.gr") by vger.kernel.org with ESMTP
	id S965167AbVLVOVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 09:21:14 -0500
Message-ID: <43AAB508.7000007@intracom.gr>
Date: Thu, 22 Dec 2005 16:15:36 +0200
From: Pantelis Antoniou <panto@intracom.gr>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051101)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Volkov <avolkov@varma-el.com>
CC: jes@trained-monkey.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] genalloc != generic DEVICE memory allocator
References: <43A98F90.9010001@varma-el.com> <43AA65F4.10409@intracom.gr> <43AAAEA2.8030200@varma-el.com>
In-Reply-To: <43AAAEA2.8030200@varma-el.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Volkov wrote:
> Hi Pantelis,
> 
> Pantelis Antoniou wrote:
> 
>>Andrey Volkov wrote:
>>

[snip]

>>
>>Hi Andrey,
>>
>>FYI, on arch/ppc/lib/rheap.c theres an implementation of a remote heap.
>>
>>It is currently used for the management of freescale's CPM1 & CPM2 internal
>>dual port RAM.
>>
>>Take a look, it might be what you have in mind.
>>
>>Regards
>>
>>Pantelis
> 
> 
> Thanks I missed it (and small wonder! :( ).
> 
> Andrew, Is somebody count HOW MANY dev specific implementation
> of buddy/first-fit allocators now in kernel?
> 

Yes, it is indeed messy.

The rheap implementation is generic enough and I believe can fit most of the
special memory allocators needs. If you'd like I could move it somewhere
generic and test it.

Regards

Pantelis

