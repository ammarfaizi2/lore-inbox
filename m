Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129347AbQKXIwi>; Fri, 24 Nov 2000 03:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129453AbQKXIw2>; Fri, 24 Nov 2000 03:52:28 -0500
Received: from adsl-63-194-96-244.dsl.snlo01.pacbell.net ([63.194.96.244]:51973
        "HELO alpha.dyndns.org") by vger.kernel.org with SMTP
        id <S129347AbQKXIwO>; Fri, 24 Nov 2000 03:52:14 -0500
Message-ID: <3A1E2556.CC9B24B1@i.am>
Date: Fri, 24 Nov 2000 00:22:46 -0800
From: "Mark W. McClelland" <mwm@i.am>
X-Mailer: Mozilla 4.61 [en] (OS/2; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert L Martin <robertlmarti@earthlink.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: "Hyper-Mount" option possible???
In-Reply-To: <3A1D3DF9.9199C744@earthlink.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert L Martin wrote:
> 
> Not on list just throwing an idea out.
> One thing that "bugs" me is if a given drive has more than one partion
> each partion has to be mounted seperatly.
> With CDs this also means you can not mount "split" cds in full if you
> want to. Soo  Given that Super-Mount is already taken, How about (in
> 2.5??)  hashing out a Hypermount option.

This would also make it easier to mount media that only have one
partition. For example, some of my Zip disks have to be mounted as
"sdb", some as "sdb1", and some as "sdb4", depending on what OS
formatted it.

I think this might also be good for multisession CDs, though I'm not
really sure how they are currently handled.

> The way it could work is if you mount a full drive say "hdd" and have
> each partion mounted on a tree from the mount point
> of the drive.

This would require mount to check for a partition table first, since
"hdd" could either mean "hdd as a partitionless device" or "all devices
on hdd". This check could probably even be done in user space, along
with "hyper-mount". Maybe someone has done it already; I'll have to
check freshmeat :) 

-- 
Mark McClelland
mwm@i.am
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
