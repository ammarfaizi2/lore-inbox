Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932781AbVINVnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781AbVINVnA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 17:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932782AbVINVnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 17:43:00 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:60556 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S932781AbVINVm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 17:42:59 -0400
Message-ID: <43289932.7090604@f2s.com>
Date: Wed, 14 Sep 2005 22:42:10 +0100
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>, adobriyan@gmail.com,
       domen@coderock.org, linux-kernel@vger.kernel.org, philb@gnu.org
Subject: Re: [PATCH] Remove drivers/parport/parport_arc.c
References: <20050914202420.GK19491@mipter.zuzino.mipt.ru>	<20050914220837.D30746@flint.arm.linux.org.uk> <20050914141631.1567758b.akpm@osdl.org>
In-Reply-To: <20050914141631.1567758b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
>>On Thu, Sep 15, 2005 at 12:24:20AM +0400, Alexey Dobriyan wrote:
>>
>>>From: Domen Puncer <domen@coderock.org>
>>>
>>>Remove nowhere referenced file (grep "parport_arc\." didn't find anything).
>>
>>Maybe Ian Molton might like to ensure that this is linked in to the
>>build.
>
> Yeah, except it's also unused in 2.4 and includes non-existent header
> files.  Probably it's an ex-parrot but it'd be worth an attempt to get it
> to compile before we remove it.

Well unless the parport stuff changed to support ports where one cant 
read the data latch, its still needed. It is true this hasnt ever 
*worked* although the code looks ok (with the exception of the ECP/EPP 
stuff thats in there).

I'll see if I can find some time for a bit of arm26 TLC once I've move 
house (could be 6 months though) as I'll actually have enough space to 
get the machine out of its packing box again...
