Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWB1Pb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWB1Pb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 10:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWB1Pb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 10:31:57 -0500
Received: from rtr.ca ([64.26.128.89]:24277 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932227AbWB1Pb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 10:31:56 -0500
Message-ID: <44046CE6.60803@rtr.ca>
Date: Tue, 28 Feb 2006 10:31:50 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: David Greaves <david@dgreaves.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com>
In-Reply-To: <44042863.2050703@dgreaves.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Greaves wrote:
>
> scsi1 : sata_sil
>   Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
>   Type:   Direct-Access                      ANSI SCSI revision: 05

I wonder if the non-FUA component here is the sata_sil,
rather than the two Maxtor drives.

Also, your drives have different firmware,
but both have trouble with FUA here.

(sdb is slightly newer, and larger, than sda).

Cheers


