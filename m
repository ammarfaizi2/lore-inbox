Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129913AbQKGMmS>; Tue, 7 Nov 2000 07:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130024AbQKGMmI>; Tue, 7 Nov 2000 07:42:08 -0500
Received: from memphis.cbn.net.id ([202.158.3.16]:49168 "HELO
	memphis.cbn.net.id") by vger.kernel.org with SMTP
	id <S129913AbQKGMl5>; Tue, 7 Nov 2000 07:41:57 -0500
Date: Tue, 7 Nov 2000 19:40:57 +0700 (JAVT)
From: imel96 <imel96@trustix.co.id>
To: linux-kernel@vger.kernel.org
Subject: [2.4.0-test10] zImage, pcmcia, and ufs(44bsd)
Message-ID: <Pine.LNX.4.21.0011071928210.27540-100000@asmuni.trustix.co.id>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



	hi all,


	just a few reports:

	1. zImage in test10 somehow isn't working properly. i have a
	zImage sized a bit more than 500kb on my harddrive which hangs at
	the loading process (the one showing dots).
	i write the image to a floppy, and it boots just fine. if i
	recompiled my kernel so the zImage size is around 490kb, the
	image gets loaded just fine.

	2. pcmcia is still missing from the test* series. it still only
	cardbus and no pcmcia. i still have to edit autoconf.h myself
	which is working just fine for me.

	3. i use ufs to mount my freebsd4 partition, following the
	instruction (including read-write support). i can read the
	partition, but i can't write. mount(8) shows that the partition
	is mounted rw. i also get:
	UFS-fs error (device 03:05):  ufs_add_entry: internal error
		fragoff xxx

	just drop me a line if you want me to test bugfix.



		imel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
