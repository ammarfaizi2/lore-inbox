Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265870AbRGDQKb>; Wed, 4 Jul 2001 12:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265865AbRGDQKV>; Wed, 4 Jul 2001 12:10:21 -0400
Received: from smtp102.urscorp.com ([64.17.27.233]:30468 "EHLO
	smtp102.urscorp.com") by vger.kernel.org with ESMTP
	id <S265870AbRGDQKG>; Wed, 4 Jul 2001 12:10:06 -0400
To: Marco Colombo <marco@esi.it>
Cc: linux-kernel@vger.kernel.org, Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: VM Requirement Document - v0.0
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
From: mike_phillips@urscorp.com
Message-ID: <OFFB52F611.7DF28620-ON84256A7F.0046980E@urscorp.com>
Date: Wed, 4 Jul 2001 12:08:25 -0400
X-MIMETrack: Serialize by Router on SMTP102/URSCorp(Release 5.0.5 |September 22, 2000) at
 07/04/2001 12:04:08 PM,
	Serialize complete at 07/04/2001 12:04:08 PM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Remember that the first message was about a laptop. At 4:00AM there's
> no activity but the updatedb one (and the other cron jobs). Simply,
> there's no 'accessed-often' data.  Moreover, I'd bet that 90% of the
> metadata touched by updatedb won't be accessed at all in the future.
> Laptop users don't do find /usr/share/terminfo/ so often.

Maybe, but I would think that most laptops get switched off at night. Then 
when turned on again in the morning, anacron realizes it missed the 
nightly cron jobs and then runs everything. 

This really does make an incredible difference to the system. If I remove 
the updatedb job from cron.daily, the machine won't touch swap all day and 
runs like charm. (That's with vmware, mozilla, openoffice, all 
applications that like big chunks of memory)

Mike



