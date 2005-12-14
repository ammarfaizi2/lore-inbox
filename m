Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVLNGnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVLNGnV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 01:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbVLNGnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 01:43:21 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:60778 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S1750782AbVLNGnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 01:43:20 -0500
Message-ID: <439FBEF4.6020802@ru.mvista.com>
Date: Wed, 14 Dec 2005 09:43:00 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] [patch 2.6.15-rc5-mm2] SPI, priority inversion
 tweak
References: <200512131028.49291.david-b@pacbell.net> <439F4206.2040406@ru.mvista.com> <200512131421.10231.david-b@pacbell.net>
In-Reply-To: <200512131421.10231.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, sorry, I've misundastood that.

Vitaly

David Brownell wrote:

>On Tuesday 13 December 2005 1:49 pm, Vitaly Wool wrote:
>  
>
>>So you're turning this to be unsafe if the buffer is in use, right? Funny...
>>    
>>
>
>I have no idea what you mean by that comment.  The parameters to that
>function have always been documented as "will copy", and the two branches
>(busy/not) differ only in _which_ buffer they use from the heap (the
>fast pre-allocated one, or a freshly allocated scratch buffer).  Heap
>buffers are by definition DMA-safe.
>
>- Dave
>
>
>  
>
>>David Brownell wrote:
>>
>>    
>>
>>>This is an updated version of the patch from Mark Underwood, handling
>>>the no-memory case better and using SLAB_KERNEL not SLAB_ATOMIC.
>>>
>>>      
>>>
>
>
>  
>

