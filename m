Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261532AbSIZWaW>; Thu, 26 Sep 2002 18:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261534AbSIZWaW>; Thu, 26 Sep 2002 18:30:22 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:57589 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S261532AbSIZWaV>; Thu, 26 Sep 2002 18:30:21 -0400
Message-ID: <3D938BA6.2000001@mvista.com>
Date: Thu, 26 Sep 2002 15:35:18 -0700
From: Mark Bellon <mbellon@mvista.com>
Organization: Monta Vista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Porter <porter@cox.net>
CC: Jeff Garzik <jgarzik@pobox.com>, Mike Anderson <andmike@us.ibm.com>,
       Michael Clark <michael@metaparadigm.com>,
       "David S. Miller" <davem@redhat.com>, wli@holomorphy.com, axboe@suse.de,
       akpm@digeo.com, linux-kernel@vger.kernel.org, patman@us.ibm.com
Subject: Re: [PATCH] deadline io scheduler
References: <3D92B450.2090805@pobox.com> <20020926.001343.57159108.davem@redhat.com> <3D92B83E.3080405@pobox.com> <20020926.003503.35357667.davem@redhat.com> <3D92C206.2050905@metaparadigm.com> <20020926174148.GB1843@beaverton.ibm.com> <3D934BE7.8010907@pobox.com> <20020926154154.A16484@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Porter wrote:

>On Thu, Sep 26, 2002 at 02:03:19PM -0400, Jeff Garzik wrote:
>  
>
>>Mike Anderson wrote:
>>    
>>
>>>We have had good results using the Qlogic's driver. We are currently
>>>running the v6.x version with Failover tunred off on 23xx cards. We have
>>>run a lot on > 4GB systems also.
>>>      
>>>
>>Has anybody put work into cleaning this driver up?
>>
>>The word from kernel hackers that work on it is, they would rather write 
>>a new driver than spend weeks cleaning it up :/
>>    
>>
>
>I added Mark Bellon to this since he has spent a lot of time working
>with QLogic to get this cleaned up for the OSDL tree.  He can probably
>address some specific questions.
>
I fought with them for quite some time to get the major rewrite that 
occured between
level 5 and level 6. The level 6 driver in TLT and OSDL is a version 
that has many of
my suggestions and a few enhancements in it. It is "much better than a 
stick in the eye".
We should now be in sync with their releases. I haven't looked recently 
to see if there
is something newer than the one I checked in.

It still has a long way to go. I have threatened to rewrite it more than 
once. However,
there is a plan to get Qlogic to do all of this and the presentation 
keeps getting put off.
It needs to be rewritten for the "so called" hardend driver stuff and 
that would be a
good juncture to make the rewrite happen.

Hacking the driver source is next to useless - Qlogic releases from 
their own tree
constantly. They are OK about taking things back but are a bit slow.

I can help with any suggested changes and cleanups.

mark



