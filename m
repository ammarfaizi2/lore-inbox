Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317107AbSGXMKO>; Wed, 24 Jul 2002 08:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317110AbSGXMKO>; Wed, 24 Jul 2002 08:10:14 -0400
Received: from [195.63.194.11] ([195.63.194.11]:18957 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317107AbSGXMKN>; Wed, 24 Jul 2002 08:10:13 -0400
Message-ID: <3D3E98A2.1090306@evision.ag>
Date: Wed, 24 Jul 2002 14:08:02 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: martin@dalecki.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: please DON'T run 2.5.27 with IDE!
References: <Pine.SOL.4.30.0207241248380.17154-100000@mion.elka.pw.edu.pl> <3D3E90E4.3080108@evision.ag> <20020724115322.GC5159@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> 
> Care to enlighten us on exactly which block drivers call
> blk_start_queue() from request_fn?

Well, admittedly, my direct suspect (cpqarry.c) turned out after a 
closer look to be "not guilty" :-). Still a bit of docu found be nice 
there. And you can of course guess what the bounty is I'm hunting for:
removal of IDE_BUSY ... so I did the mistake myself in first place 8-).



