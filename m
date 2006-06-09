Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965298AbWFIU6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965298AbWFIU6r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbWFIU6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:58:46 -0400
Received: from terminus.zytor.com ([192.83.249.54]:59876 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965298AbWFIU6q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:58:46 -0400
Message-ID: <4489E0FF.6030904@zytor.com>
Date: Fri, 09 Jun 2006 13:58:39 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Nickolay <nickolay@protei.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: initramfs: who does cat init.sh >> init ?
References: <4489D93F.7090401@protei.ru> <e6cllv$dnb$1@terminus.zytor.com> <4489DB15.9010506@protei.ru> <4489DC2E.4030004@zytor.com> <4489DE84.309@protei.ru> <4489DF03.6020600@zytor.com> <4489E030.2090602@protei.ru>
In-Reply-To: <4489E030.2090602@protei.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nickolay wrote:
> H. Peter Anvin wrote:
> 
>> Nickolay wrote:
>>
>>>
>>> yes, i can't grep init.sh in the kernel tree too, this is because i 
>>> start asking...
>>> But anyway, the problem is still...
>>>
>>
>> Perhaps you should show more context... what comes around this 
>> mysterious invocation in your make V=1 log. Also your .config would help.
>>
>> -hpa
> 
> OK. Here it is:
> 
> --------------------------------------------------------------------------------------------------- 
> 
> bash-3.00# make zImage V=1
> rm -f .kernelrelease
> echo 2.6.17-rc4-g3bcc86f5-dirty > .kernelrelease
        ^^^^^^^^^^^^^^^^^^^^^^^^^^

Modified kernel source.

	-hpa
