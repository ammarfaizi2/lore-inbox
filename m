Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbWGJPcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWGJPcR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWGJPcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:32:17 -0400
Received: from potawatomi.web.itd.umich.edu ([141.211.144.171]:27838 "EHLO
	potawatomi.web.itd.umich.edu") by vger.kernel.org with ESMTP
	id S965023AbWGJPcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:32:16 -0400
Message-ID: <20060710113212.5ddn42t40ks44s00@engin.mail.umich.edu>
Date: Mon, 10 Jul 2006 11:32:12 -0400
From: Matt Reuther <mreuther@umich.edu>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Depmod errors on 2.6.17.4/2.6.18-rc1/2.6.18-rc1-mm1
References: <200607100833.00461.mreuther@umich.edu>
	<44B24FE7.2050807@gmail.com>
In-Reply-To: <44B24FE7.2050807@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.4)
X-Remote-Browser: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1;
	.NET CLR 1.1.4322; .NET CLR 2.0.50727)
X-IMP-Server: 141.211.144.247
X-Originating-IP: 71.4.119.66
X-Originating-User: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "Antonino A. Daplas" <adaplas@gmail.com>:

> Matt Reuther wrote:
>> The following errors show up on 'make modules_install' for the 
>> 2.6.18-rc1-mm1
>> kernel. The snd-miro ones have actually been there since at least 2.6.17.4,
>> and they show up in 2.6.18-rc1 as well.
>
>> WARNING: 
>> /lib/modules/2.6.18-rc1-mm1/kernel/drivers/video/backlight/backlight.ko
>> needs unknown symbol fb_unregister_client
>> WARNING: 
>> /lib/modules/2.6.18-rc1-mm1/kernel/drivers/video/backlight/backlight.ko
>> needs unknown symbol fb_register_client
>>
>
> CONFIG_FB=n, CONFIG_BACKLIGHT_CLASS_DEVICE=m should not be possible in
> 2.6.18-rc1-mm1 and 2.6.18-rc1.  Can you run kconfig again?
>
> Tony

I am not at the computer right now, but I will try later.

Here is how I got config-2.6.18-rc1-mm1. I copied this config from 
2.6.18-rc1, which I had created with 'make menuconfig'. I ran 'make 
oldconfig' on the config-2.6.18-rc1 and answered the new questions to 
generate config-2.6.18-rc1-mm1. I compiled it from there. Does 'make 
oldconfig' not work properly anymore?

Matt
