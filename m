Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVBXMN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVBXMN2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 07:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVBXMN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 07:13:28 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:51324 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262283AbVBXMNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 07:13:21 -0500
Message-ID: <421DC4DA.7000102@yahoo.com.au>
Date: Thu, 24 Feb 2005 23:13:14 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] remove aggressive idle balancing
References: <1109229362.5177.67.camel@npiggin-nld.site> <1109229415.5177.68.camel@npiggin-nld.site> <1109229491.5177.71.camel@npiggin-nld.site> <1109229542.5177.73.camel@npiggin-nld.site> <1109229650.5177.78.camel@npiggin-nld.site> <1109229700.5177.79.camel@npiggin-nld.site> <1109229760.5177.81.camel@npiggin-nld.site> <1109229867.5177.84.camel@npiggin-nld.site> <1109229935.5177.85.camel@npiggin-nld.site> <1109230031.5177.87.camel@npiggin-nld.site> <20050224084118.GB10023@elte.hu>
In-Reply-To: <20050224084118.GB10023@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>> [PATCH 6/13] no aggressive idle balancing
>>
>> [PATCH 8/13] generalised CPU load averaging
>> [PATCH 9/13] less affine wakups
>> [PATCH 10/13] remove aggressive idle balancing
> 
> 
> they look fine, but these are the really scary ones :-) Maybe we could
> do #8 and #9 first, then #6+#10. But it's probably pointless to look at
> these in isolation.
> 

Oh yes, they are very scary and I guarantee they'll cause
problems :P

I didn't have any plans to get these in for 2.6.12 (2.6.13 at the
very earliest). But it will be nice if Andrew can pick these up
early so we try to get as much regression testing as possible.

I pretty much agree with your ealier breakdown of the patches (ie.
some are fixes, others fairly straightfoward improvements that may
get into 2.6.12, of course). Thanks very much for the review.

I expect to rework the patches, and things will get tuned and
changed around a bit... Any problem with you taking these now
though Andrew?

Nick


