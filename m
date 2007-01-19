Return-Path: <linux-kernel-owner+w=401wt.eu-S964827AbXASENG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbXASENG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 23:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbXASENG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 23:13:06 -0500
Received: from smtp-out.google.com ([216.239.45.13]:16507 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964827AbXASENF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 23:13:05 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=LZzm9z0/aW98A05Q7g6STKvuyJGbxFf6DhuSoLhgujjJafOmEme7FWlKUUqWzMFT9
	GZmX/8txy+OYyiYpmh9iQ==
Message-ID: <45B04547.5030904@google.com>
Date: Thu, 18 Jan 2007 20:12:55 -0800
From: Al Borchers <alb@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomasz Chmielewski <mangoo@wpkg.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel cmdline: root=/dev/sdb1,/dev/sda1 "fallback"?
References: <E1H7Uqx-0003X0-0u@llonio.corp.google.com> <45AF827C.4020902@wpkg.org>
In-Reply-To: <45AF827C.4020902@wpkg.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Chmielewski wrote:
> Al Borchers wrote:
> 
>> Thomas Chmielewski wrote:
>>
>>> These all unpleasant tasks could be avoided if it was possible to 
>>> have a "fallback" device. For example, consider this hypothetical 
>>> command line:
>>>
>>> root=/dev/sdb1,/dev/sda1
>>
>>
>> Here is a patch to do this, though it sounds like you might have other
>> solutions.
>>
>> This patch is for 2.6.18.1--thanks to Ed Falk for updating my original
>> 2.6.11 patch.  If people are interested I can update and test this on
>> the current kernel.  It was tested on 2.6.11.
> 
> 
> Yes, I'd be interested in a patch against a 2.6.19. It is way simpler to 
> do it this way than to do it with initramfs (although not as flexible).

I will look do it, but I will be out next week so it may take a while.

-- Al

> 
> I tried your patch against 2.6.19, with some minor changes (as it 
> wouldn't apply), but it didn't work for me (perhaps I just screwed 
> something).
> 
> 

