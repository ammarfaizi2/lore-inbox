Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVJXI6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVJXI6v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 04:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVJXI6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 04:58:51 -0400
Received: from mail.ncipher.com ([82.108.130.24]:33970 "EHLO mail.ncipher.com")
	by vger.kernel.org with ESMTP id S1750796AbVJXI6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 04:58:50 -0400
Message-ID: <435CA241.8050605@f0rmula.com>
Date: Mon, 24 Oct 2005 09:58:41 +0100
From: James Hansen <linux-kernel-list@f0rmula.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: Information on ioctl32
References: <4358CF73.3020602@f0rmula.com> <20051021173612.06f1dadd.rdunlap@xenotime.net> <200510231603.58364.arnd@arndb.de>
In-Reply-To: <200510231603.58364.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the info.

 From what they say over on lwn.net, I need to apply a patch, but my 
current kernel (debian for amd64) is already trying to call it ioctl32.

Problem is, the kernel headers don't seem to have an entry in the 
file_operations struct for compat_ioctl.  Does anyone know if there's 
any other place (struct) I should be looking to put this function?

I thought it a bit odd that the prebuilt default kernel is trying to 
call this function, but the headers for this kernel don't seem to allow 
me to insert it into the fops struct.

Thanks,

James

Arnd Bergmann wrote:

>On Sünnavend 22 Oktober 2005 02:36, Randy.Dunlap wrote:
>  
>
>>On Fri, 21 Oct 2005 12:22:27 +0100 James Hansen wrote:
>>
>>I don't see ioctl32 here, but lwn.net also has driver-porting info at:
>>  http://lwn.net/Articles/driver-porting/
>>
>>    
>>
>>>Is there anywhere that I can find some more information on this, such as 
>>>a howto?  I've been googling but have only really stumbled across some 
>>>brief info on lwn.net.
>>>      
>>>
>
>The currently relevant info at lwn.net is http://lwn.net/Articles/119652/
>
>	Arnd <><
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
>  
>

