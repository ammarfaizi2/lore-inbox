Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965128AbVKHTVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbVKHTVJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 14:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbVKHTVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 14:21:08 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:41683 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965128AbVKHTVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 14:21:07 -0500
Message-ID: <4370FA9F.6010800@us.ibm.com>
Date: Tue, 08 Nov 2005 11:21:03 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Roland Dreier <rolandd@cisco.com>, kernel-janitors@lists.osdl.org,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com
Subject: Re: [PATCH 4/8] Cleanup kmem_cache_create()
References: <436FF51D.8080509@us.ibm.com> <436FF70D.6040604@us.ibm.com> <52mzkfrily.fsf@cisco.com> <Pine.LNX.4.62.0511081049520.30907@schroedinger.engr.sgi.com> <4370F6BB.1070409@us.ibm.com> <Pine.LNX.4.62.0511081108340.31060@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0511081108340.31060@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 8 Nov 2005, Matthew Dobson wrote:
> 
> 
>>>A large object in terms of this patch is a object greater than 4096 bytes 
>>>not an object greater than PAGE_SIZE. I think the absolute size is 
>>>desired.
>>
>>Would you be OK with at least NAMING the constant?  I won't name it
>>PAGE_SIZE (of course), but LARGE_OBJECT_SIZE or something?
> 
> 
> Ask Manfred about this. I think he coded it that way and he usually has 
> good reasons for it.
> 
> Thanks for the cleanup work!

Manfred, any reason not to name this constant in slab.c?  If there's a good
reason not to, I'm perfectly happy to leave it alone. :)

-Matt
