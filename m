Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131720AbQK2UZ3>; Wed, 29 Nov 2000 15:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131905AbQK2UZS>; Wed, 29 Nov 2000 15:25:18 -0500
Received: from eax.student.umd.edu ([129.2.228.67]:16388 "EHLO
        eax.student.umd.edu") by vger.kernel.org with ESMTP
        id <S131720AbQK2UZK>; Wed, 29 Nov 2000 15:25:10 -0500
Date: Wed, 29 Nov 2000 15:55:42 -0500 (EST)
From: Adam <adam@eax.com>
To: Tigran Aivazian <tigran@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 'holey files' not holey enough.
In-Reply-To: <Pine.LNX.4.21.0011291306260.883-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0011291554110.1152-100000@eax.student.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Tigran Aivazian wrote:

> > 	[adam@pepsi /tmp]$  dd if=/dev/zero of=holed.file bs=1000 seek=5000 count=1000
> > 	[adam@pepsi /tmp]$ ls -l holed.file 
> > 	-rw-rw-r--    1 adam     adam      6000000 Nov 29 08:52 holed.file
> > 	[adam@pepsi /tmp]$ du -sh holed.file 
> > 	1.9M    holed.file
> 
> what filesystem type? on ext2 filesystem on 2.4.0-test12-pre3 I get
> expected result:

More datapoints. I have asked around, and I have two users of
2.4.0-test10. One is getting expected 1mb, other is getting (just like me)
1.9mb.

So far I don't see pattern, here. It does not seems to depend on block
size, nor packet writing patches.

-- 
Adam
http://www.eax.com      The Supreme Headquarters of the 32 bit registers


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
