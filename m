Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUB2FyM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 00:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbUB2FyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 00:54:12 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:38295 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261980AbUB2FyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 00:54:09 -0500
Message-ID: <40417E66.3060707@matchmail.com>
Date: Sat, 28 Feb 2004 21:53:42 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olof Johansson <olof@austin.ibm.com>
CC: Andi Kleen <ak@suse.de>, torvalds@osdl.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: [PATCH] ppc64: Add iommu=on for enabling DART on small-mem machines
References: <Pine.A41.4.44.0402280818060.43148-100000@forte.austin.ibm.com>
In-Reply-To: <Pine.A41.4.44.0402280818060.43148-100000@forte.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson wrote:
> On 28 Feb 2004, Andi Kleen wrote:
> 
> 
>>olof@austin.ibm.com writes:
>>
>>
>>>Below patch makes it possible for people like me with a small-mem G5 to
>>>enable the DART. I see two reasons for wanting to do so:
>>
>>Could you call it iommu=force ?
>>
>>It would be the same name as on x86-64 for the same thing then and
>>a consistent name may be easier to get to driver developers.
> 
> 
> 
> Ack! I was wavering between the two options and finally went with =on. :)
> Either way is fine with me.

And maybe even some generic code? :-D
