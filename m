Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261932AbREPNTm>; Wed, 16 May 2001 09:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261940AbREPNTc>; Wed, 16 May 2001 09:19:32 -0400
Received: from smtp102.urscorp.com ([38.202.96.105]:7433 "EHLO
	smtp102.urscorp.com") by vger.kernel.org with ESMTP
	id <S261939AbREPNT2>; Wed, 16 May 2001 09:19:28 -0400
To: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
Cc: Andrew Morton <andrewm@uow.edu.au>, Jonathan Lundell <jlundell@pobox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
From: mike_phillips@urscorp.com
Message-ID: <OF61000B59.7C828594-ON84256A4E.004122CC@urscorp.com>
Date: Wed, 16 May 2001 09:11:54 -0400
X-MIMETrack: Serialize by Router on SMTP102/URSCorp(Release 5.0.5 |September 22, 2000) at
 05/16/2001 09:14:49 AM,
	Serialize complete at 05/16/2001 09:14:49 AM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The same situation appears when using bonding.o. For several years,
> Don Becker's (and derived) network drivers support changing MAC address
> when the interface is down. So Al's /dev/eth/<n>/MAC has different 
values
> depending on whether bonding is active or not. Should /dev/eth/<n>/MAC
> always have the original value (to be able to uniquely identify this 
card)
> or the in-use value (used by ARP, I believe) ? Or maybe have a
> /dev/eth/<n>/MAC_in_use ?

Token ring has the same problem as well, most token ring adapters support 
setting a LAA. 

Some solution would be useful though. Original mac sounds do-able.

Mike
