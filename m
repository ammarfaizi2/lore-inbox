Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVFDCPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVFDCPz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 22:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVFDCPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 22:15:55 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:37514 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261222AbVFDCPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 22:15:50 -0400
Message-ID: <42A10ED2.7020205@yahoo.com.au>
Date: Sat, 04 Jun 2005 12:15:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: mbligh@mbligh.org, davem@davemloft.net, jschopp@austin.ibm.com,
       mel@csn.ul.ie, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version
 12
References: <E1DeNiA-0008Ap-00@gondolin.me.apana.org.au>
In-Reply-To: <E1DeNiA-0008Ap-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>network code. If the latter, that would suggest at least in theory
>>it could use noncongiguous physical pages.
> 
> 
> With Dave's latest super-TSO patch, TCP over loopback will only be
> doing order-0 allocations in the common case.  UDP and others may
> still do large allocations but that logic is all localised in
> ip_append_data.
> 
> So if we wanted we could easily remove most large allocations over
> the loopback device.

I would be very interested to look into that. I would be
willing to do benchmarks on a range of machines too if
that would be of any use to you.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
