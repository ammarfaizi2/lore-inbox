Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261810AbSI2VkE>; Sun, 29 Sep 2002 17:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261812AbSI2VkD>; Sun, 29 Sep 2002 17:40:03 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:11690 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S261810AbSI2VkA>; Sun, 29 Sep 2002 17:40:00 -0400
Date: Sun, 29 Sep 2002 14:45:54 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: PROBLEM: kernel BUG in usb-ohci.c:902!
To: Stephen Marz <smarz@host187.south.iit.edu>
Cc: linux-kernel@vger.kernel.org
Message-id: <3D977492.4070604@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <Pine.LNX.4.44.0209291549390.1911-100000@host187.south.iit.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> code.  Here is my call trace:
> 
> uhci-irq [uchi-hcd]
> usb_hcd_irq_Rfba60562 [usbcore]
> handle_IRQ_event
> do_IRQ
> ...
> 
> I am apparently hitting a different bug, but it inevitably comes from
> the uhci-hcd driver (according to the panic).

As I said:  you're not seeing "this problem".  And it's not a BUG().
So now we agree ... ;-)

You might try sending the full oops report to the maintainer
of that driver, or at least to the linux-usb-devel list.
(The 2.5.39 code gives more info than you snipped...)  So far
as I know, this problem has not been reported there.

- Dave



> Regards,
> 
> Stephen Marz
> 
> 
>>>I have noticed this problem in 2.5.39 except it occurs with the module
>>>uhci-hcd.
>>
> 
>>No you haven't.  It doesn't have a file of that name, so you
>>didn't see such a BUG().  And I don't know about you, but my
>>copy of 2.5.39 has no BUG() anywhere in the ohci-hcd driver,
>>so it'd be hard seeing _any_ BUG() coming from there.
> 
> 
>>You might be hitting a different BUG(), but in that case you
>>would need to get your bug reports straight.
> 
> 
>>- Dave
> 
> 
> 
> 
> 
> 
> 



