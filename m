Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292273AbSBBNRV>; Sat, 2 Feb 2002 08:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292274AbSBBNRL>; Sat, 2 Feb 2002 08:17:11 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:4536 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S292273AbSBBNRE>;
	Sat, 2 Feb 2002 08:17:04 -0500
Message-Id: <m16X01j-000OVeC@amadeus.home.nl>
Date: Sat, 2 Feb 2002 13:16:19 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: axboe@suse.de (Jens Axboe)
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020202135749.B4934@suse.de>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020202135749.B4934@suse.de> you wrote:
>> include/linux/blk.h
>> 
>>         Changed NR_REQUEST from 256 to 16.  This reduces the number of
>>         requests that can be queued.  The size of the queue is reduced
>>         from 16K to 1K.

> You can do even more than this -- I dunno what I/O interface these
> embedded system generally uses (the mtd stuff?)

the MTD stuff wants CONFIG_BLOCKLAYER ;)
flash + jffs2 doesn't need any blocklayer at all ;)
