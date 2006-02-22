Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWBVMTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWBVMTq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 07:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWBVMTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 07:19:46 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:27048 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S1751223AbWBVMTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 07:19:45 -0500
Message-ID: <43FC574A.4000100@qazi.f2s.com>
Date: Wed, 22 Feb 2006 12:21:30 +0000
From: Asfand Yar Qazi <ay0106@qazi.f2s.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060217)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 'vga=' parameter wierdness
References: <43FC1624.8090607@qazi.f2s.com> <200602221130.13872.vda@ilport.com.ua> <43FC54B8.7070706@qazi.f2s.com> <mj+md-20060222.121130.6225.albireo@ucw.cz>
In-Reply-To: <mj+md-20060222.121130.6225.albireo@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> Hello!
> 
> 
>>OK, will try that.  decimal of octal(0164) = decimal(116)
> 
> 
> This won't work -- the mode numbers are hexadecimal, not octal.
> Use 356 (decimal).

You're right.  I thought '0164' was octal - 0 prefix.

> 
> 
>>When the modes come up on screen, they are numbered (0, 1, 2, ... a, b, 
>>etc.) This is what the 'a' refers to.  Hey, it worked through LILO on 2.4 
>> kernels.
> 
> 
> Beware, these menu item numbers are _not_ meant to be stable across
> kernel upgrades. Better use the "long" mode numbers like 0164 or 030c.

Yep, I realise that now :-)

> 
> 
>>Before I type in scan, the number for the 132x60 mode is actually 030C.  
>>After I've typed in 'scan', then it comes up as 0164.  If I enter 0164 
>>BEFORE I type in 'scan' at the vid mode, it still works.  But not if I give 
>>it as argument to GRUB.  As I said, will try giving decimal equivalent 
>>(116) as argument to GRUB.
> 
> 
> You can also try giving 0x164 to GRUB.

I'll try that as well.

> 
> 				Have a nice fortnight

err... you too :-)
