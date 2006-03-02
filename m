Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751579AbWCBQUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbWCBQUB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbWCBQUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:20:01 -0500
Received: from mx.laposte.net ([81.255.54.11]:31309 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S1751559AbWCBQUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:20:00 -0500
Message-ID: <10368.192.54.193.25.1141315508.squirrel@rousalka.dyndns.org>
In-Reply-To: <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>
References: <1141239617.23202.5.camel@rousalka.dyndns.org> 
    <4405F471.8000602@rtr.ca> 
    <1141254762.11543.10.camel@rousalka.dyndns.org> 
    <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com> 
    <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>
    <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>
Date: Thu, 2 Mar 2006 17:05:08 +0100 (CET)
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, "Jens Axboe" <axboe@suse.de>,
       "Tejun Heo" <htejun@gmail.com>,
       "Nicolas Mailhot" <nicolas.mailhot@gmail.com>,
       "Mark Lord" <liml@rtr.ca>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Carlos Pardo" <carlos.pardo@siliconimage.com>
User-Agent: SquirrelMail/1.4.6 [CVS]-0.cvs20060118.1.fc5.1.nim
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le Jeu 2 mars 2006 03:20, Eric D. Mudama a écrit :
> On 3/1/06, Jeff Garzik <jgarzik@pobox.com> wrote:
>> This also begs the question... what controller was being used, when the
>> single Maxtor device listed in the blacklist was added?  Perhaps it was
>> a problem with the controller, not the device.
>>
>>         Jeff
>
> As reported here:
>
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=177951
>
> the controller was a 3114, and the bug was "fixed" by blacklisting his
> Maxtor drive's FUA support.  I'd like Maxtor drives to be
> un-blacklisted if possible.

BTW Eric you should know :
- these specific drives (and the Maxtor PATA drives they replaced) where
bought because I knew you were hanging on the lists
- I fully intended to ask you if the blacklisting where valif after the
FUA dust had settled a little

Regards,

-- 
Nicolas Mailhot

