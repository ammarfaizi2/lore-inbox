Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317102AbSGXNMt>; Wed, 24 Jul 2002 09:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317110AbSGXNMt>; Wed, 24 Jul 2002 09:12:49 -0400
Received: from [195.63.194.11] ([195.63.194.11]:56333 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317102AbSGXNMs>; Wed, 24 Jul 2002 09:12:48 -0400
Message-ID: <3D3EA74F.4090706@evision.ag>
Date: Wed, 24 Jul 2002 15:10:39 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: martin@dalecki.de, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: please DON'T run 2.5.27 with IDE!
References: <Pine.SOL.4.30.0207241440500.15605-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Wed, 24 Jul 2002, Marcin Dalecki wrote:
> 
> 
>>[root@localhost block]# grep \>special *.c
>>elevator.c:         !rq->waiting && !rq->special)
>>^^^^^^ This one is supposed to have the required barrier effect.
> 
> 
> Go reread, no barrier effect, requests can slip in before your
> REQ_SPECIAL. They cannon only be merged with REQ_SPECIAL.

Erm. Please note that I don't see any problem here. It's just
a matter of completeness.


