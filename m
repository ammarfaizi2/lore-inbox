Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVGVEEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVGVEEr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 00:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVGVEEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 00:04:47 -0400
Received: from mta10.srv.hcvlny.cv.net ([167.206.4.205]:44860 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261973AbVGVEEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 00:04:46 -0400
Date: Fri, 22 Jul 2005 00:07:21 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: 2.6.13-rc3-mm1 (ckrm)
In-reply-to: <20050721204631.1fb4d9a5.pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, matthltc@us.ibm.com, akpm@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org, gh@us.ibm.com
Message-id: <42E070F9.6010009@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <20050715013653.36006990.akpm@osdl.org>
 <20050715150034.GA6192@infradead.org> <20050715131610.25c25c15.akpm@osdl.org>
 <20050717082000.349b391f.pj@sgi.com> <1121985448.5242.90.camel@stark>
 <20050721163227.661a5169.pj@sgi.com> <42E03DD2.6020308@mbligh.org>
 <20050721204631.1fb4d9a5.pj@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Martin wrote:
> 
>>No offense, but I really don't see why this matters at all ... the stuff
>>in -mm is what's under consideration for merging - what's in SuSE is ...
> 
> 
> Yes - what's in SuSE doesn't matter, at least not directly.
> 
> No - we are not just considering the CKRM that is in *-mm now, but also
> what can be expected to be proposed as part of CKRM in the future.
> 
> If the CPU controller is not in *-mm now, but if one might reasonably
> expect it to be proposed as part of CKRM in the future, then we need to
> understand that.  This is perhaps especially important in this case,
> where there is some reason to suspect that this additional piece is
> both non-trivial and essential to CKRM's purpose.
> 

The CKRM design explicitly considered this problem of some controllers 
being more unacceptable than the rest and part of the indirections 
introduced in CKRM are to allow the kernel community the flexibility of 
cherry-picking acceptable controllers. So if the current CPU controller 
   implementation is considered too intrusive/unacceptable, it can be 
reworked or (and we certainly hope not) even rejected in perpetuity. 
Same for the other controllers as and when they're introduced and 
proposed for inclusion.


-- Shailabh




