Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbUB0DQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 22:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbUB0DQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 22:16:00 -0500
Received: from mail.tmr.com ([216.238.38.203]:18821 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261191AbUB0DP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 22:15:58 -0500
Message-ID: <403EB692.60309@tmr.com>
Date: Thu, 26 Feb 2004 22:16:34 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: "Nakajima, Jun" <jun.nakajima@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD x86-64
References: <7F740D512C7C1046AB53446D37200173EA288C@scsmsx402.sc.intel.com> <403E1914.5060209@techsource.com>
In-Reply-To: <403E1914.5060209@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> 
> 
> Nakajima, Jun wrote:
> 
>> Yes, that's the very reason I said "useless for compilers." The way
>> IP/RIP is updated is different (and implementation specific) on those
>> processors if 66H is used with a near branch. For example, RIP may be
>> zero-extended to 64 bits (from IP), as you observed before.
>>
> 
> This is obviously an extremely minor nit-pick, because we're talking 
> about one instruction here with an interpretation that is far from 
> obvious, but given that there are now only two architectures which 
> support x86-64, did Intel choose to do it differently from AMD because 
> it was poorly defined, or because it wasn't important enough to want to 
> impact the efficiency of the design?

How about because they messed up trying to clone the instruction set? 
Never attribute to malice what can be explained by stupidity. <-(quote)
> 
> There are people who would go way out of their way to get a 5% 
> improvement in performance or decrease in size.  If using 66H with near 
> branches could in some way do that, they would really really want to use 
> it.  This is why I'm curious.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
