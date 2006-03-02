Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbWCBQOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWCBQOw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbWCBQOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:14:52 -0500
Received: from mx.laposte.net ([81.255.54.11]:10516 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S1751078AbWCBQOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:14:51 -0500
Message-ID: <24130.192.54.193.25.1141315944.squirrel@rousalka.dyndns.org>
In-Reply-To: <44066132.4010205@pobox.com>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>	
    <4405F471.8000602@rtr.ca>	
    <1141254762.11543.10.camel@rousalka.dyndns.org>	
    <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>	
    <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>	
    <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>	
    <44065C7C.6090509@pobox.com>
    <311601c90603011900q7fe21fbx1020e4ba4062dc24@mail.gmail.com>
    <44066132.4010205@pobox.com>
Date: Thu, 2 Mar 2006 17:12:24 +0100 (CET)
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, "Jens Axboe" <axboe@suse.de>,
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


Le Jeu 2 mars 2006 04:06, Jeff Garzik a écrit :
> Eric D. Mudama wrote:
>> The "failing dmesg" has the plextor connected to sata_nv, and the two
>> Maxtor drives connected to sata_sil, if I read it correctly.  They're
>> ata5/ata6 ports, mapped as sda/sdb.
>>
>> Nicolas' comment in the thread "Re: LibPATA code issues / 2.6.15.4"
>> seemed to say it was the same adapter:
>>
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=114123989405668&w=2
>
> Sounds like un-blacklisting the drive, and adding ATA_FLAG_NO_FUA is the
> way to go...

Please add the ATA_FLAG_NO_FUA flag and *after* unblacklist the drive as I
distinctly have no wish to do fsck stressing again.

-- 
Nicolas Mailhot

