Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263798AbUDTTG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbUDTTG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 15:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUDTTG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 15:06:27 -0400
Received: from zasran.com ([198.144.206.234]:62087 "EHLO zasran.com")
	by vger.kernel.org with ESMTP id S263858AbUDTTGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 15:06:23 -0400
Message-ID: <408574AD.2090105@bigfoot.com>
Date: Tue, 20 Apr 2004 12:06:21 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
References: <200404201522.i3KFMk120352@tag.witbe.net> <1082475417.6543.3.camel@amilo.bradney.info>
In-Reply-To: <1082475417.6543.3.camel@amilo.bradney.info>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Bradney wrote:
> I've got 4 PCs all with logitech cordless optical mice.. all work
> perfectly with Gentoo dev sources 2.6.5.. as well as 2.6.3, 2.6.1 etc

   can you please send:

   - related parts kernel config
   - usb or ps2 port?
   - which device (/dev/input or /dev/psaux or...)

   is it stock kernel or does gentoo provide any patches?

   thanks,

	erik

> 
> Craig
> 
> On Tue, 2004-04-20 at 17:22, Paul Rolland wrote:
> 
>>Hello,
>>
>>
>>>   it looks that after update to 2.6.5 kernel (debian source 
>>>package but 
>>>I guess it would be the same with stock 2.6.5) the mouse 
>>>wheel and side 
>>>button on Logitech Cordless MouseMan Wheel mouse do not work.
>>
>>I've got a new mouse with a wheel, and I've got the same problem,
>>though I can't tell if it was working before...
>>
>>
>>>Here's the most basic/simple situation/symptoms:
>>>
>>>   I stop X, read bytes from /dev/psaux (c program, using open and 
>>>read). for each mouse action there are few bytes read, usually number 
>>
>>Could you provide me with the program so that I can test too ?
>>
>>
>>>   BTW X windows is confused in the same way (I guess because that's 
>>>what it gets from kernel driver - using xev I found that it 
>>>thinks the 
>>>sidebutton is button 2 and that turning the wheel is not an 
>>>event at all).
>>
>>Got the same : wheel is no-op :-(
>>
>>I guess I should try a stock 2.4.x kernel to see if it working or
>>not...
>>
>>Regards,
>>Paul
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

