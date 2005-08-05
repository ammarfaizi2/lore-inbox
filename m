Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263000AbVHEMay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbVHEMay (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 08:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbVHEMax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 08:30:53 -0400
Received: from crl-mail-dmz.crl.hpl.hp.com ([192.58.210.9]:64228 "EHLO
	crl-mailb.crl.dec.com") by vger.kernel.org with ESMTP
	id S263000AbVHEMav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 08:30:51 -0400
Message-ID: <42F35BAA.1070506@hp.com>
Date: Fri, 05 Aug 2005 08:29:30 -0400
From: Jamey Hicks <jamey.hicks@hp.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Purdie <rpurdie@rpsys.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jamey@handhelds.org, anpaza@mail.ru, rmk@arm.linux.org.uk
Subject: Re: platform-device-driver-for-mq11xx-graphics-chip.patch added to
 -mm tree
References: <200508050719.j757J9KO032652@shell0.pdx.osdl.net> <1123228133.7649.4.camel@localhost.localdomain>
In-Reply-To: <1123228133.7649.4.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-HPLC-MailScanner-Information: Please contact the ISP for more information
X-HPLC-MailScanner: Found to be clean
X-HPLC-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-4.9, required 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:

>On Fri, 2005-08-05 at 00:18 -0700, akpm@osdl.org wrote:
>  
>
>>The patch titled
>>
>>     platform-device driver for MQ11xx graphics chip
>>
>>has been added to the -mm tree.  Its filename is
>>
>>     platform-device-driver-for-mq11xx-graphics-chip.patch
>>
>> drivers/platform/.tmp_versions/mq11xx_base.mod |    2 
>>    
>>
>
>I doubt that should be there...
>
>  
>
>> drivers/platform/Kconfig                       |   23 
>> drivers/platform/Makefile                      |    5 
>> drivers/platform/mq11xx.h                      |  925 ++++++++++++++++
>> drivers/platform/mq11xx_base.c                 | 1390 +++++++++++++++++++++++++
>>    
>>
>
>I'm also still wondering if drivers/mfd would be better in the long term
>for code like this (as mentioned in various threads on LKML). That way
>it is doesn't have to be platform device specific...
>
>  
>
I do not have a problem with moving these drivers to drivers/mfd.  I do 
want to have a policy that says where such drivers should go.

Jamey

