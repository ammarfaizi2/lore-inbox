Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132247AbQKXI2m>; Fri, 24 Nov 2000 03:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132249AbQKXI2c>; Fri, 24 Nov 2000 03:28:32 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:64526
        "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
        id <S132247AbQKXI20>; Fri, 24 Nov 2000 03:28:26 -0500
Date: Thu, 23 Nov 2000 23:58:02 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alexander Viro <viro@math.psu.edu>
cc: Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <Pine.GSO.4.21.0011240148410.12702-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10011232321560.4479-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2000, Alexander Viro wrote:

> <shrug> I don't see any attempts to tag you (or ATA subsystem, for that matter)
> in that thread. And thread is hardly bogus... I agree that changes in

We agree that the "thread" is valid, trust that point.
There was a quick pointed question that present, "Is it an IDE disk?" to
paraphase the statement.

> drivers/ide/* are very unlikely to be the source of that, but information
> of that kind can help to weed out some of the changes in ll_rw_blk.c.

What may be even more helpful is when I get arround to making an option, 
for some outstanding patches for 2.5, that would allow for user-space
pattern pushing through the driver that gets properly inserted in to the
list/buffer-head to make it pass through the block layer.  This kind of
testing will allow for nibble level tracing through everything, I hope.

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
