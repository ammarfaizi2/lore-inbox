Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbVKJOXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbVKJOXh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbVKJOXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:23:37 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:35950 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750727AbVKJOXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:23:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=jaHMewrsCjz7P3uKacCQedSnDNvBZzvdNZoyln8IWzulxwXw4DRfTCCRFWkUzlwNAIEVnR9Jg5jkYk33l4c1jc8U9/WZyJUq7I3Qiig6Ca1CU0yEjImSH2psT81I/nZIJSv5F3ydVSuf/WtpDBtuy0XrmKhfgMrxJsGa823O7MA=
Message-ID: <43735766.3070205@gmail.com>
Date: Thu, 10 Nov 2005 22:21:26 +0800
From: Tony <tony.uestc@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MOD_INC_USE_COUNT
References: <437347B5.6080201@gmail.com> <Pine.LNX.4.61.0511100859400.18912@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511100859400.18912@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Thu, 10 Nov 2005, Tony wrote:
> 
> 
>>Hello All,
>>Usually, when a net_device->open is called, it will MOD_INC_USE_COUNT on
>>success. It is removed since 2.5.x, then should I increase the use
>>count? how? thx.
> 
> 
> Gone! Don't use INC or DEC_USE_COUNT anymore. The kernel takes
> care of that for you. Also, the count shown in `lsmod` no longer
> means anything you can use programmaticly.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
> Warning : 98.36% of all statistics are fiction.
> .
> 
> ****************************************************************
> The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
> 
> Thank you.
> 
But when the module is used by a net_device(interface is up), rmmod also 
works. Strange, isn't it?
