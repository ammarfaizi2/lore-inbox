Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318217AbSGXTng>; Wed, 24 Jul 2002 15:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318253AbSGXTng>; Wed, 24 Jul 2002 15:43:36 -0400
Received: from server1.mvpsoft.com ([64.105.236.213]:65221 "HELO
	server1.mvpsoft.com") by vger.kernel.org with SMTP
	id <S318217AbSGXTne>; Wed, 24 Jul 2002 15:43:34 -0400
Message-ID: <3D3F037E.7010907@mvpsoft.com>
Date: Wed, 24 Jul 2002 15:43:58 -0400
From: Chris Snyder <csnyder@mvpsoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020713
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: morten.helgesen@nextframe.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems with Mylex DAC960P RAID controller
References: <3D3ED215.3080900@mvpsoft.com> <20020724205019.A2356@sexything> <3D3EF5BD.5070901@mvpsoft.com> <20020724211625.B2356@sexything>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Morten Helgesen wrote:
>>>The DAC960 driver is quite verbose - this is what I`ve got :
>>>
>>>kernel: DAC960: ***** DAC960 RAID Driver Version 2.4.11 of 11 October 2001 
>>>*****
>>>kernel: DAC960: Copyright 1998-2001 by Leonard N. Zubkoff 
>>><lnz@dandelion.com>
>>
>>That's all the info it prints, then it hangs.  It seems to be that 
>>something's happening when it tries to detect the controller.
> 
> 
> Yep - I see ... you haven`t got another linux box around (with a distro actually
> installed :), do you ? I guess
> it would be easier to debug this if you could move the controller to another
> box and actually fiddle with the driver source ... debug printks can actually be
> useful :)
> 
> I noticed that the return value from request_region() is not checked ...

I tried putting the controller and drives into my main work machine 
(running Gentoo Linux 1.2), and it also hangs, though it doesn't even 
display the version info.  This leads me to believe that if I debugged 
it on my machine, the results would be different than if I debugged it 
on the server.

Would there be any way for me to use this card as a normal SCSI card, 
using a SCSI driver, and just not use the RAID functionality?  This 
machine isn't going to be stressed very much, and software RAID should 
be adequate.

