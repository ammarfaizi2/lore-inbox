Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310435AbSDXJXZ>; Wed, 24 Apr 2002 05:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310470AbSDXJXY>; Wed, 24 Apr 2002 05:23:24 -0400
Received: from [195.63.194.11] ([195.63.194.11]:48906 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310435AbSDXJXX>; Wed, 24 Apr 2002 05:23:23 -0400
Message-ID: <3CC66AE2.3060606@evision-ventures.com>
Date: Wed, 24 Apr 2002 10:20:50 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Miles Lane <miles@megapathdsl.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC51494.8040309@evision-ventures.com> <1019583551.1392.5.camel@turbulence.megapathdsl.net> <1019584497.1393.8.camel@turbulence.megapathdsl.net> <3CC66794.5040203@evision-ventures.com> <20020424091151.GD812@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>OK I assume that the oops happens inside the ide-scsi module.
>>This will be fixed in one of the forthcomming patch sets.
> 
> 
> Are you sure this isn't just due to ->special being set, and
> ide_end_request() assuming it's an ar? From ide-cd, that is.

Yes right. Thank you for reminding me. I will have to
redo the stuff from the "draft" patch I did send you once...

