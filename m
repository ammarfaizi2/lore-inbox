Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbWALGgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWALGgK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 01:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbWALGgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 01:36:10 -0500
Received: from dvhart.com ([64.146.134.43]:20866 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932498AbWALGgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 01:36:09 -0500
Message-ID: <43C5F8C8.60908@mbligh.org>
Date: Wed, 11 Jan 2006 22:35:52 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
Cc: Con Kolivas <kernel@kolivas.org>, Peter Williams <pwil3058@bigpond.net.au>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, apw@shadowen.org
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C58117.9080706@bigpond.net.au> <43C5A8C6.1040305@bigpond.net.au> <200601121218.47744.kernel@kolivas.org> <43C5B945.3000903@google.com>
In-Reply-To: <43C5B945.3000903@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:

>
>> This is a shot in the dark. We haven't confirmed 1. there is a 
>> problem 2. that this is the problem nor 3. that this patch will fix 
>> the problem. I say we wait for the results of 1. If the improved smp 
>> nice handling patch ends up being responsible then it should not be 
>> merged upstream, and then this patch can be tested on top.
>>
>> Martin I know your work move has made it not your responsibility to 
>> test backing out this change, but are you aware of anything being 
>> done to test this hypothesis?
>
>
OK, backing out that patch seems to fix it. Thanks Andy ;-)

M.


