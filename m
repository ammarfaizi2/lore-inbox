Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbTJZKlU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 05:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTJZKlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 05:41:19 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:39119 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262927AbTJZKlS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 05:41:18 -0500
Message-ID: <3F9BB322.8030502@cyberone.com.au>
Date: Sun, 26 Oct 2003 22:42:26 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.org>
CC: Con Kolivas <kernel@kolivas.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Autoregulate vm swappiness cleanup
References: <200310232337.50538.kernel@kolivas.org> <8720000.1066920153@[10.10.2.4]> <200310240103.19336.kernel@kolivas.org> <200310251658.23070.kernel@kolivas.org> <3F9BAE6F.5070009@cyberone.com.au> <3F9BA3BB.6030502@kolivas.org>
In-Reply-To: <3F9BA3BB.6030502@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

> Nick Piggin wrote:
>
>>
>> Hi Con,
>> If this indeed makes VM behaviour better, why not just merge the 
>> calculation
>> with the swap_tendancy calculation and leave vm_swappiness there as a 
>> tunable?
>
>
> Because the whole point of it is to remove the tunable and make it 
> auto tuning. We could do away with the vm_swappiness variable 
> altogether too (which I would actually prefer to do) but this leaves 
> it intact to see what the vm is doing.


Right. This just had me a bit confused. No worries.


