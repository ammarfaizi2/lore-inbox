Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVDRMrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVDRMrJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 08:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVDRMrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 08:47:08 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:2291 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262063AbVDRMqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 08:46:52 -0400
Message-ID: <4263AC46.5010703@in.ibm.com>
Date: Mon, 18 Apr 2005 18:17:02 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][x86_64] Introducing the memmap= kernel command line option
References: <425F5BA3.3050001@in.ibm.com> <20050415173040.GK50241@muc.de>
In-Reply-To: <20050415173040.GK50241@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Fri, Apr 15, 2005 at 11:43:55AM +0530, Hariprasad Nellitheertha wrote:
> 
>>Hi Andi,
>>
>>In order to port kdump to x86_64, we need to have the 
>>memmap= kernel command line option available. This is so 
>>that the dump-capture kernel can be booted with a custom 
>>memory map.
>>
>>The attached patch adds the memmap= functionality to the 
>>x86_64 kernel. It is against 2.6.12-rc2-mm3. I have done 
>>some amount of testing and it is working fine.
>>
>>Could you kindly review this patch and let me know your 
>>thoughts on it.
> 
> 
> You should add a __setup somewhere, otherwise the kernel
> will complain about unknown arguments or generate a memmap
> variable in inits environment. 

Sure. Will add that.

> 
> Comma parsing would be nice.

Will add this for i386 as well and send out another patch

> 
> Otherwise it looks ok.

Thanks!

- Hari

