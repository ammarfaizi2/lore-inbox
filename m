Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131998AbRAVNCl>; Mon, 22 Jan 2001 08:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132203AbRAVNCb>; Mon, 22 Jan 2001 08:02:31 -0500
Received: from stud3.tuwien.ac.at ([193.170.75.13]:38925 "EHLO
	stud3.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S131998AbRAVNCU>; Mon, 22 Jan 2001 08:02:20 -0500
Date: Mon, 22 Jan 2001 14:02:15 +0100 (MET)
From: Stefan Ring <e9725446@student.tuwien.ac.at>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at file.c:79! (using vfat)
Message-ID: <Pine.HPX.4.10.10101221401180.19909-100000@stud3.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel BUG at file.c:79!
Invalid operand

fat and vfat are compiled as modules
Compiler used: stock rh6.2 (egcs-1.1.2)

I get this error with 2.4.0 when I do

dd if=/dev/zero of=/<somewhere>/huge bs=1k

on a vfat partition and the file size reaches the 4G mark.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
