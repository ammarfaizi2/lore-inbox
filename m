Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131339AbRAVWmw>; Mon, 22 Jan 2001 17:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131022AbRAVWmm>; Mon, 22 Jan 2001 17:42:42 -0500
Received: from hera.cwi.nl ([192.16.191.1]:34966 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130760AbRAVWm3>;
	Mon, 22 Jan 2001 17:42:29 -0500
Date: Mon, 22 Jan 2001 23:42:25 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101222242.XAA202146.aeb@vlet.cwi.nl>
To: bug-parted@gnu.org, clausen@conectiva.com.br,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Partition IDs in the New World TM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Clausen writes:

> can anyone remember why we have partition IDs?

Partition IDs are not necessary. Linux works fine
when you have no partition table at all, and have a
parttab file in an initrd disk telling the kernel where
the partitions are supposed to be.

No kernel changes required. Today you do not need partition IDs.
Today you can dynamically add and delete partitions,
without involving anything like a partition table.

But people use various schemes to partition their disks,
mainly because also other operating systems like DOS or MacOS
use the same disks. In such a situation it is useful to
agree with the other OS on where the partitions are.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
