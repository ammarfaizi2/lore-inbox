Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWJFMSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWJFMSw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 08:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWJFMSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 08:18:51 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:64684 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750767AbWJFMSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 08:18:50 -0400
Date: Fri, 06 Oct 2006 08:18:48 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: usb resets [Was Re: Merge window closed: v2.6.19-rc1]
In-reply-to: <20061006083613.GA5658@cepheus.pub>
To: linux-kernel@vger.kernel.org
Cc: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Message-id: <200610060818.49058.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
 <200610051141.50018.gene.heskett@verizon.net>
 <20061006083613.GA5658@cepheus.pub>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 October 2006 04:36, Uwe Zeisberger wrote:
>Hello,
>
>Gene Heskett wrote:
>> But once my usual .config was achieved, it back to business as
>> usual, complete with my logs being littered with this message:
>>
>> Oct  5 11:14:40 coyote kernel: usb 3-2.1: reset low speed USB device
>> using ohci_hcd and address 3
>>
>> This is my only (so far) minor nit to pick.
>>
>> [root@coyote linux-2.6.19-rc1]# lsusb
>> [...]
>> Bus 003 Device 003: ID 045e:008c Microsoft Corp.
>> [...]
>
>I saw that, too.  But I have
>
>        zeisberg@cepheus:~$ lsusb
>        Bus 001 Device 002: ID 046d:c00b Logitech, Inc. MouseMan Wheel
> Bus 001 Device 001: ID 0000:0000
> Bus 004 Device 001: ID 0000:0000
> Bus 003 Device 001: ID 0000:0000
> Bus 002 Device 001: ID 0000:0000
>
>And whenever the reset occured, my keyboard produced mulitple key events
>when a key was pressed.
>
My keyboard, a ps2 microsoftie thats about got the legends worn from the 
keycaps, has not exhibited any such behaviour.

>And since I didn't connect my usb cardreader anymore, the problem
>disapeared.  (Yes, it is not listed above.  I'll try to find the time to
>do some further testing.)
>
>> This started at about the same time I jumped from a 2.6.16-something to
>> the 2nd rc of 2.6.18
>
>Same for me.  (But at the same time I upgraded my machine from a Duron
> 600 to a Pentium D 940.  So I thought it has to do with that.)

No hardware updates here recently, the most recent addition being a wap11 
for my lappy.  And I believe that was up and running for at least 2 months 
before this started.  Mobo is an older (now) biostar, gig of ram, XP-2800 
Athlon, 333 fsb.  Accessory 4 port usb1.1 hub in front panel for usb 
expansion. 7 usb devices total.  But only 5 are alive ATM, and one of 
those doesn't properly ID itself, a pl2303 usb-seriel adaptor thats 
plugged in but not in use. $40 and it doesn't honor flow control either 
style or way.

Thanks Uwe.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
