Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261824AbSI2Vw4>; Sun, 29 Sep 2002 17:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261827AbSI2Vw4>; Sun, 29 Sep 2002 17:52:56 -0400
Received: from host187.south.iit.edu ([216.47.130.187]:30848 "EHLO
	host187.south.iit.edu") by vger.kernel.org with ESMTP
	id <S261824AbSI2Vwy>; Sun, 29 Sep 2002 17:52:54 -0400
Message-ID: <3D97773A.40402@host187.south.iit.edu>
Date: Sun, 29 Sep 2002 16:57:14 -0500
From: Stephen Marz <smarz@host187.south.iit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel BUG in usb-ohci.c:902!
References: <Pine.LNX.4.44.0209291549390.1911-100000@host187.south.iit.edu> <3D977492.4070604@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its so nice how these things work out :).

Thanks for your time and help,

Stephen Marz

David Brownell wrote:

>> code.  Here is my call trace:
>>
>> uhci-irq [uchi-hcd]
>> usb_hcd_irq_Rfba60562 [usbcore]
>> handle_IRQ_event
>> do_IRQ
>> ...
>>
>> I am apparently hitting a different bug, but it inevitably comes from
>> the uhci-hcd driver (according to the panic).
>
>
> As I said:  you're not seeing "this problem".  And it's not a BUG().
> So now we agree ... ;-)
>
> You might try sending the full oops report to the maintainer
> of that driver, or at least to the linux-usb-devel list.
> (The 2.5.39 code gives more info than you snipped...)  So far
> as I know, this problem has not been reported there.
>
> - Dave
>
>
>
>> Regards,
>>
>> Stephen Marz
>>
>>
>>>> I have noticed this problem in 2.5.39 except it occurs with the module
>>>> uhci-hcd.
>>>
>>>
>>
>>> No you haven't.  It doesn't have a file of that name, so you
>>> didn't see such a BUG().  And I don't know about you, but my
>>> copy of 2.5.39 has no BUG() anywhere in the ohci-hcd driver,
>>> so it'd be hard seeing _any_ BUG() coming from there.
>>
>>
>>
>>> You might be hitting a different BUG(), but in that case you
>>> would need to get your bug reports straight.
>>
>>
>>
>>> - Dave
>>
>>
>>
>>
>>
>>
>>
>>
>
>
>
>



