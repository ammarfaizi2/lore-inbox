Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157297AbQGaNrj>; Mon, 31 Jul 2000 09:47:39 -0400
Received: by vger.rutgers.edu id <S157402AbQGaNrT>; Mon, 31 Jul 2000 09:47:19 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:1399 "EHLO master.linux-ide.org") by vger.rutgers.edu with ESMTP id <S157136AbQGaNrD>; Mon, 31 Jul 2000 09:47:03 -0400
Date: Mon, 31 Jul 2000 07:05:08 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Xuan Baldauf <xuan--reiserfs@baldauf.org>
Cc: Russell King <rmk@arm.linux.org.uk>, reiserfs@devlinux.com, linux-kernel@vger.rutgers.edu
Subject: Re: (reiserfs) Re: sync: why disk cannot spin down
In-Reply-To: <3985680D.49B19846@baldauf.org>
Message-ID: <Pine.LNX.4.10.10007310700001.6252-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-kernel@vger.rutgers.edu

On Mon, 31 Jul 2000, Xuan Baldauf wrote:

> Now I made all my partitions noatime, and wow,
> 
> sync; hdparm -C -Y /dev/hda; sync; hdparm -C /dev/hda
> 
> does not necessarily spin up the disk!

Because you have to issue a drive reset.

Andre Hedrick
The Linux ATA/IDE guy


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
