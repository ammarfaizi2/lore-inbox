Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVKFSoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVKFSoD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 13:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbVKFSoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 13:44:03 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:1669 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750772AbVKFSoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 13:44:01 -0500
Message-ID: <436E4EFA.2000307@free.fr>
Date: Sun, 06 Nov 2005 19:44:10 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
CC: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, usbatm@lists.infradead.org
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
References: <4363F9B5.6010907@free.fr> <20051101224510.GB28193@kroah.com> <43691E7E.5090902@free.fr>
In-Reply-To: <43691E7E.5090902@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

matthieu castet wrote:

>>> + *
>>> + * This software is available to you under a choice of one of two
>>> + * licenses. You may choose to be licensed under the terms of the GNU
>>> + * General Public License (GPL) Version 2, available from the file
>>> + * COPYING in the main directory of this source tree, or the
>>> + * BSD license below:
>>> + *
>>> + * Redistribution and use in source and binary forms, with or without
>>> + * modification, are permitted provided that the following conditions
>>> + * are met:
>>
>>
>>
>> <snip>  You don't need the whole GPL 2 copy here, just put the first
>> paragraph you have before this one in.
>>
> The paragraph you quote is the BSD licence, and point 1 is :
> Redistributions of source code must retain the above copyright
>  *    notice unmodified, this list of conditions, and the following
>  *    disclaimer
> 
> So could I remove it ?
> 
> 
>>
>>> diff -rNu -x '*.ko*' -x '*.mod*' -x '*.o*' 
>>> linux-2.6.14/drivers/usb/atm.old/ueagle-atm.h 
>>> linux-2.6.14/drivers/usb/atm/ueagle-atm.h
>>> --- linux-2.6.14/drivers/usb/atm.old/ueagle-atm.h    1970-01-01 
>>> 01:00:00.000000000 +0100
>>> +++ linux-2.6.14/drivers/usb/atm/ueagle-atm.h    2005-10-30 
>>> 00:25:27.000000000 +0200
>>
>>
>>
>> Why do you need a header file for a single .c file?
>>
> I think it makes things cleaner. I even like the bsd style where there 
> is an header for reg (hardware values) and an other for val (driver 
> structures).
> 

We patched our driver with the comments sent, but we still don't know 
what to do with this 2 points :
- For the license stuff, all the dual bsd/gpl drivers I saw in the 
kernel tree have the complete bsd header.
- For the header file I prefer a separate header file, but if Linux 
policy is to merge header and source file, that's fine.


Regards,

Matthieu
