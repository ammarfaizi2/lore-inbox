Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbUJXM3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbUJXM3R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 08:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUJXM3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 08:29:16 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:61272 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261455AbUJXM3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 08:29:04 -0400
Message-ID: <417BA006.3030305@yahoo.com.au>
Date: Sun, 24 Oct 2004 22:28:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Alastair Stevens <alastair@altruxsolutions.co.uk>
CC: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-ck1: swap mayhem under UT2004
References: <200410222346.32823.alastair@altruxsolutions.co.uk> <200410231722.59362.alastair@altruxsolutions.co.uk> <417B1A7F.2020607@yahoo.com.au> <200410241138.55618.alastair@altruxsolutions.co.uk>
In-Reply-To: <200410241138.55618.alastair@altruxsolutions.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alastair Stevens wrote:
> On Sunday 24 October 2004 3:59, Nick Piggin wrote:
> 
>>Can you try the following patch to start with, please?
>>(against 2.6.10-rc1, but should apply to most recent kernels I think)
> 
> 
> [vm-pages_scanned-active_list.patch]
> 
> Thanks Nick - seems exemplary so far.  No stuttering or swap thrashing 
> under the time-honoured UT2004 test, even with some phat desktop apps 
> sitting in memory.
> 
> I'm still running on 2.6.9-ck1 for now.  Is there anything else you want 
> me to try?

Not really - just make sure to really give it a good beating so
you can be sure the problem isn't happening.

>  Presumably VM scanning work is ongoing for 2.6.10?

Unfortunately yes. It is really just a few little niggles rather
than anything fundamental, but they're quite annoying :(

>  I might 
> give -rc1 a spin, just for fun....
> 

It would be a good idea to give -rc1 a spin (with, and without the
patch).

Thanks,
Nick
