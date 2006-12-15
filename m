Return-Path: <linux-kernel-owner+w=401wt.eu-S1751536AbWLOLEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWLOLEW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 06:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWLOLEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 06:04:22 -0500
Received: from smtp41.singnet.com.sg ([165.21.103.142]:35068 "EHLO
	smtp41.singnet.com.sg" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbWLOLEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 06:04:21 -0500
Message-ID: <4582815F.6040906@homeurl.co.uk>
Date: Fri, 15 Dec 2006 19:05:03 +0800
From: Bob <spam@homeurl.co.uk>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Need to enable caches in SMP ? (was Kernel 2.6 SMP very slow
 with ServerWorks LE Chipset)
References: <4577AA11.6020906@homeurl.co.uk>	<4580C054.2080902@homeurl.co.uk> <20061214110324.780b4bf0@localhost.localdomain> <458189FD.2080805@wolfmountaingroup.com>
In-Reply-To: <458189FD.2080805@wolfmountaingroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> Alan wrote:
>>> As per Alan's suggestion I decompressed the kernel source tree with 
>>> the processes pegged to one CPU then the other, and as he predicted 
>>> it took vastly longer on one CPU than the other, but I don't know 
>>> what that implies, or how to fix it.
>>
>>> From the timing it sounds like one processor cache is disabled which 
>>> is a
>> little peculiar to say the least.
>>
> enable the L1 cache in the processor. BIOS settings, no doubt.
> 
> Jeff

The very spartan Phoenix BIOS doesn't have any options to enable or 
disable CPU Cache, which I know full well to enable, but it does have 
something rather vaguely called "Memory Caching" the enabling of which 
seems to have fixed the problem, it's strange it only disabled the cache 
on one CPU and only under 2.6, I'll investigate more in January.

It's good to have the fix search able, this thread would have saved me 
from making an ass of myself.

Thank you for your help.
