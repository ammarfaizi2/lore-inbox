Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131154AbQK2MMm>; Wed, 29 Nov 2000 07:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131092AbQK2MMc>; Wed, 29 Nov 2000 07:12:32 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:31237 "EHLO zikova.cvut.cz")
        by vger.kernel.org with ESMTP id <S131070AbQK2MMV>;
        Wed, 29 Nov 2000 07:12:21 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jens Axboe <axboe@suse.de>
Date: Wed, 29 Nov 2000 12:41:28 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.0-test11 ext2 fs corruption
CC: "David S. Miller" <davem@redhat.com>, viro@math.psu.edu,
        linux-kernel@vger.kernel.org, tytso@valinux.com
X-mailer: Pegasus Mail v3.40
Message-ID: <E3B2B45385F@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Nov 00 at 1:43, Jens Axboe wrote:

> Could you try and reproduce with attached patch? If this would trigger
> I would assume fs corruption as well (which doesn't seem to be the
> case for you), but it's worth a shot.

I'll try, but it is not easily reproducible. Fortunately.

BTW, during night, it came to me that maybe I was biased with original
diagnostics (thing written twice), as there was (~3 weeks ago) unpacked
XF4.0.1-0phase?v27 on the same disk. 

As font data did not change between these two versions, it is possible 
that one 27 blocks chunk (*.c files) was lost (or written somewhere where 
I did not found it yet), instead of another one (fonts) duplicated.
                                                Thanks,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
