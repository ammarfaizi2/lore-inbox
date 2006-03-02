Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWCBDP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWCBDP5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 22:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbWCBDP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 22:15:57 -0500
Received: from rtr.ca ([64.26.128.89]:25829 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750949AbWCBDP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 22:15:56 -0500
Message-ID: <44066378.1080408@rtr.ca>
Date: Wed, 01 Mar 2006 22:16:08 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, Jens Axboe <axboe@suse.de>,
       Tejun Heo <htejun@gmail.com>,
       Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
References: <1141239617.23202.5.camel@rousalka.dyndns.org>	 <4405F471.8000602@rtr.ca>	 <1141254762.11543.10.camel@rousalka.dyndns.org>	 <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>	 <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>	 <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>	 <44065C7C.6090509@pobox.com> <311601c90603011900q7fe21fbx1020e4ba4062dc24@mail.gmail.com> <44066132.4010205@pobox.com>
In-Reply-To: <44066132.4010205@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
..
> Sounds like un-blacklisting the drive, and adding ATA_FLAG_NO_FUA is the 
> way to go...

Might as well add sata_mv to that blacklist as well.

And while I'm at it, the pdc_adma and sata_qstor controllers/drivers are fine with FUA.

-ml
