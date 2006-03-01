Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWCARkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWCARkv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 12:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWCARkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 12:40:51 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:42688 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S932451AbWCARkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 12:40:49 -0500
Message-ID: <4405DCAF.6030500@dgreaves.com>
Date: Wed, 01 Mar 2006 17:41:03 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com>
In-Reply-To: <44046D86.7050809@pobox.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Mark Lord wrote:
>
>> David Greaves wrote:
>>
>>>
>>> scsi1 : sata_sil
>>>   Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
>>>   Type:   Direct-Access                      ANSI SCSI revision: 05
>>>   Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
>>>   Type:   Direct-Access                      ANSI SCSI revision: 05
>>
>>
>>
>> I wonder if the non-FUA component here is the sata_sil,
>> rather than the two Maxtor drives.
>>
>> Also, your drives have different firmware,
>> but both have trouble with FUA here.
>
>
> sata_sil is indeed a piece of hardware that needs to know the opcodes
> ahead of time...
>
>     Jeff
>
I actually have 3 of those drives - one runs through sata_via and
doesn't have the same problem.

(the sata_via ones *do* have :
 ata3: status=0x50 { DriveReady SeekComplete }
 ata3: PIO error
problems with SMART)

David
