Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSEXXUj>; Fri, 24 May 2002 19:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312991AbSEXXUi>; Fri, 24 May 2002 19:20:38 -0400
Received: from [195.63.194.11] ([195.63.194.11]:50962 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312962AbSEXXUi>; Fri, 24 May 2002 19:20:38 -0400
Message-ID: <3CEEBBE7.40401@evision-ventures.com>
Date: Sat, 25 May 2002 00:17:11 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] change of ->bd_op->open() semantics
In-Reply-To: <Pine.GSO.4.21.0205241821580.9792-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alexander Viro napisa?:
> 
> On Fri, 24 May 2002, Linus Torvalds wrote:

> Now, I've already sent a patch that does (1) and (2) (last one sent on
> Wednesday), but it doesn't show up on bkbits.  If there were any problems
> with it - please, tell.  If not - I can
> 	* resend it, following it by (3)
> 	* send (3) alone
> 	* wait for 2.5.18, rediff and send (1)--(3).
> Take your pick...
> 
> I'd definitely like to have a testing point between (3) and (4)--(7), so
> unless you are going to release 2.5.18 right now I'd prefer to get (1)--(3)
> into it...

I would love to be warned about it, since the ATA code is
very well tricky in the way in esp. partition scanning goes on.
Plese not as well the the recently added attach() method
for ATA/ATAPI device type drivers may very well come
in between as well. (patch nr. 70.)

