Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbVKHStq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbVKHStq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbVKHStq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:49:46 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:32188 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030299AbVKHStp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:49:45 -0500
Message-ID: <4370F346.7020601@us.ibm.com>
Date: Tue, 08 Nov 2005 10:49:42 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: Roland Dreier <rolandd@cisco.com>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] Cleanup kmem_cache_create()
References: <436FF51D.8080509@us.ibm.com> <436FF70D.6040604@us.ibm.com> <52mzkfrily.fsf@cisco.com> <Pine.LNX.4.58.0511080932460.9530@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0511080932460.9530@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:
> On Mon, 7 Nov 2005, Roland Dreier wrote:
> 
> 
>>    > * Replace a constant (4096) with what it represents (PAGE_SIZE)
>>
>>This seems dangerous.  I don't pretend to understand the slab code,
>>but the current code works on architectures with PAGE_SIZE != 4096.
>>Are you sure this change is correct?
> 
> 
> Looks ok to me except that it should be a separate patch (it is not a 
> trivial cleanup because it changes how the code works).
> 
> 			Pekka

That's very reasonable, Pekka.  I will respin 4/8 without that change and
add a 9/8 that is JUST that one change.

Thank you both for the review and comments!

-Matt
