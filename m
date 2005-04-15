Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVDODSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVDODSX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 23:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVDODSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 23:18:23 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:49032
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261728AbVDODSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 23:18:13 -0400
Message-ID: <425F32E8.8090407@linuxwireless.org>
Date: Thu, 14 Apr 2005 22:20:08 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Lessem <linux-kernel@lists.lessem.org>
CC: Matti Aarnio <matti.aarnio@zmailer.org>, Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: IBM Thinkpad T42 - Looking for a Developer.
References: <003901c54136$6ba545c0$9f0cc60a@amer.sykes.com> <Pine.LNX.4.62.0504142317480.3466@dragon.hyggekrogen.localhost> <20050414223641.M49815@linuxwireless.org> <20050414231513.GN3858@mea-ext.zmailer.org> <200504142354.j3ENsYj3028900@ibg.colorado.edu>
In-Reply-To: <200504142354.j3ENsYj3028900@ibg.colorado.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> This is located in my home PC, Won't be the fastest downloads...
>>>>> 
>>>>> http://wifitux.com/finger/
>>>>>          
>>>>>
>>>> 
>>>>Under what terms did you obtain these documents and from where? Are 
>>>>they completely freely distributable or are there strings attached?
>>>>        
>>>>
>>>I emailed the guys and they told me, "Hey, here you go, let me know if you
>>>want more information"
>>>
>>>I guess it can't be more distributable. But as far as I got to read. The
>>>documents don't have too much information like for us to do a great Job. I
>>>think it also requires the making of a firmware.
>>>
>>>I don't want to dissapoint you, but I hope I'm lost and that a driver can be
>>>done out of this.
>>>      
>>>
>>There were two PDF documents.
>>The more useful one tells that there are two possible interfaces:
>>- Async serial
>>- USB
>>
>>Could you show what    /sbin/lsusb -vv    tells in your T42 ?
>>Do that without external devices attached.
>>    
>>
>
>I'm appending the lsusb -vv from my Thinkpad T43 for comparison.  This
>also has a builtin USB fingerprint scanner, but I don't know if it is
>the same one as used on the T42.  It is "Bus 004 Device 002: ID
>0483:2016 SGS Thomson Microelectronics".  There are no other USB devices
>connecting.
>
>  
>
Matti,

    Where do we stand here? Now that you have two of those outputs, so I 
can have some hope... Do you think we can make the driver for this hardware?

    How about the firmware that the documents mention? Could there be a 
layer in the hardware itself that might prevents us from reading the 
fingerprint image?

    Will BioAPI help us at all, or the best approach here is not to make 
dll wrapping?

Thanks for you all time,

- Alejandro
