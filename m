Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWBBTix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWBBTix (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 14:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWBBTix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 14:38:53 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:34022 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751087AbWBBTiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 14:38:52 -0500
Message-ID: <43E2602C.2090008@tmr.com>
Date: Thu, 02 Feb 2006 14:40:28 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CD writing - related question
References: <43DEA195.1080609@tmr.com> <20060201210433.GC8552@ucw.cz>
In-Reply-To: <20060201210433.GC8552@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Mon 30-01-06 18:30:29, Bill Davidsen wrote:
> 
>>Please take this as a question to elicit information, not 
>>an invitation for argument.
>>
>>In Linux currently:
>> SCSI - liiks like SCSI
>> USB - looks like SCSI
>> Firewaire - looks like SCSI
>> SATA - looks like SCSI
>> Compact flash and similar - looks like SCSI
> 
> 
> Your definition of "looks like scsi" is way too broad. CF looks like
> PCMCIA and that in turn is ide chip on isa-like bus.
> 
> (unless you plug it to usb reader)
> 
I was unaware of any serious use of PCMCIA reader cards therese days, as 
you note the CD shows up as an sd device. I have a laptop which might 
have a card slot, if it takes CD I'll pull one from my camera and try it 
there instead of the USB reader.

The question is still why not make all devices look like SCSI, and use 
one set of drivers and a bit of glue. Redhat used to use ide-scsi by 
default if my memory serves, and the overhead wasn't an issue even back 
on my 1st Linux laptop running Slackware on a Thinkpad 486-25 (the fat 
one, not the 486-16 -;).

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
