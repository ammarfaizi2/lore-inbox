Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130340AbQKWVoD>; Thu, 23 Nov 2000 16:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129295AbQKWVnz>; Thu, 23 Nov 2000 16:43:55 -0500
Received: from 213-120-138-133.btconnect.com ([213.120.138.133]:38155 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S130327AbQKWVUG>;
        Thu, 23 Nov 2000 16:20:06 -0500
Date: Thu, 23 Nov 2000 20:51:42 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Neil Brown <neilb@cse.unsw.edu.au>, "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <Pine.GSO.4.21.0011231205550.11219-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0011232049210.2321-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

I am "hammering" an ext2 filesystem with all sorts (bonnies, make -j8
bzImage, cp -a dir1 dir2 + all these over localhost NFSv3) for a while and
so far it survives. The system is 2way SMP with 1G RAM.

However, I can't say that _without_ your patch the above did _not_
survive. The corruptions usually come from real useful work and not from
articfical tests (unfortunately)....

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
