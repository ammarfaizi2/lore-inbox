Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263529AbUERUXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbUERUXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 16:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263551AbUERUXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 16:23:13 -0400
Received: from mail2.iserv.net ([204.177.184.152]:27037 "EHLO mail2.iserv.net")
	by vger.kernel.org with ESMTP id S263529AbUERUXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 16:23:09 -0400
Message-ID: <40AA70B6.1050405@didntduck.org>
Date: Tue, 18 May 2004 16:23:18 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [patch] kill off PC9800
References: <1084729840.10938.13.camel@mulgrave> <20040516142123.2fd8611b.akpm@osdl.org> <20040518201416.GT5414@waste.org>
In-Reply-To: <20040518201416.GT5414@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:

> On Sun, May 16, 2004 at 02:21:23PM -0700, Andrew Morton wrote:
> 
>>James Bottomley <James.Bottomley@SteelEye.com> wrote:
>>
>>>    Randy.Dunlap" <rddunlap@osdl.org> wrote:
>>>    >
>>>    >  PC9800 sub-arch is incomplete, hackish (at least in IDE), maintainers
>>>    >  don't reply to emails and haven't touched it in awhile.
>>>    
>>>    And the hardware is obsolete, isn't it?  Does anyone know when they were
>>>    last manufactured, and how popular they are?
>>>    
>>>Hey, just being obsolete is no grounds for eliminating a
>>>subarchitecture...
>>
>>Well it's a question of whether we're likely to see increasing demand for
>>it in the future.  If so then it would be prudent to put some effort into
>>fixing it up rather than removing it.
>>
>>Seems that's not the case.  I don't see a huge rush on this but if after
>>this discussion nobody steps up to take care of the code over the next few
>>weeks, it's best to remove it.
> 
> 
> Perhaps a nicer way to do this is to add a compile warning or error:
> 
> #warning "arch/i386/mach-pc9800 unmaintained since xx/xx/xx, nominated
> for removal xx/xx/xx if unclaimed"
> 
> ..where the second date is, say, 3+ months after the warning goes in.
> Then people can nominate stuff for removal with one liners and users
> will get ample opportunity to complain.
> 

You're missing the point that this code doesn't compile *at all*. 
Nobody would ever see the warning.

--
				Brian Gerst
