Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755485AbWKVRDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485AbWKVRDr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755905AbWKVRDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:03:46 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:46561 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1755485AbWKVRDq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:03:46 -0500
Date: Wed, 22 Nov 2006 17:03:44 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andre Noll <maan@systemlinux.org>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>, Mel Gorman <mel@skynet.ie>
Subject: Re: [discuss] 2.6.19-rc6: known regressions (v4)
In-Reply-To: <20061122160549.GD27761@skl-net.de>
Message-ID: <Pine.LNX.4.64.0611221703060.31195@skynet.skynet.ie>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
 <20061121212424.GQ5200@stusta.de> <200611221142.21212.ak@suse.de>
 <20061122160549.GD27761@skl-net.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006, Andre Noll wrote:

> On 11:42, Andi Kleen wrote:
>> ject    : x86_64: Bad page state in process 'swapper'
>>> References : http://lkml.org/lkml/2006/11/10/135
>>>              http://lkml.org/lkml/2006/11/10/208
>>> Submitter  : Andre Noll <maan@systemlinux.org>
>>> Handled-By : David Rientjes <rientjes@cs.washington.edu>
>>> Status     : problem is being debugged
>>
>> Does this still happen with -rc6?
>
> Unfortunately, yes. I tried rc6, current git, and currrent git + David
> Rientjes' patch. They all show the same behaviour.
>
>> It's probably another bug in the memmap parsing rewrite (Mel cc'ed)
>> but the debugging information in the standard kernel unfortunately
>> doesn't give enough output to find out where it happens.
>
> Feel free to send me a debugging patch..
>



You should have received such a patch from me later in the thread. In 
combination with the patch at http://lkml.org/lkml/2006/11/10/198 and a 
copy of the dmesg, I might be able to guess what is going wrong. Thanks

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
