Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVBJTY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVBJTY2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 14:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVBJTWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 14:22:23 -0500
Received: from mail.tmr.com ([216.238.38.203]:5003 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261475AbVBJTTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 14:19:39 -0500
Message-ID: <420BB77B.3080508@tmr.com>
Date: Thu, 10 Feb 2005 14:35:23 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Arjan van de Ven <arjan@infradead.org>,
       Martins Krikis <mkrikis@yahoo.com>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
References: <420631BF.7060407@pobox.com><420582C6.7060407@pobox.com> <58cb370e05020607197db9ecf4@mail.gmail.com>
In-Reply-To: <58cb370e05020607197db9ecf4@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Sun, 06 Feb 2005 10:03:27 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Arjan van de Ven wrote:
>>
>>>>I consider it not a new feature, but a missing feature, since otherwise
>>>>user data cannot be accessed in the RAID setups.
>>>
>>>
>>>the same is true for all new hardware drivers and hardware support
>>>patches. And for new DRM (since new X may need it) and new .. and
>>>new ... where is the line?
>>>
>>>for me a deep maintenance mode is about keeping existing stuff working;
>>>all new hw support and derivative hardware support (such as this) can be
>>>pointed at the new stable series... which has been out for quite some
>>>time now..
>>
>>Red herring.
>>
>>2.4.x has ICH5/6 support -- but is missing the RAID support component.
>>
>>We are talking about hardware that is ALREADY supported by 2.4.x kernel,
>>not new hardware.
>>
>>We are also talking about inability to access data on hardware supported
>>by 2.4.x, not something that can easily be ignored or papered over with
>>a compatibility mode.
> 
> 
> the same arguments can be used for crypto support etc.,
> answer is - use 2.6.x or add extra patches to get 2.4.x working

It's fix in a sense. The hardware is supported now, just not very well. 
If an IDE chipset was capable of UDA4 and the driver only allowed UDA2 
it would be a fix, in this case thehardware is supported partially, the 
RAID conponent isn't working, and this is the fix.

It is stretching a point, but adding support for all the features of 
hardware which is currently supported just seems to be a valud operation 
to me. New crypto feels more like adding a whole new device.

Opinion offered for clarification only, I don't feel strongly on this or 
crypto, but I do identify because I have hardware with a 2.4 driver and 
I can't use it unless I give up 2.6.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
