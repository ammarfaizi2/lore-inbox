Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRABPto>; Tue, 2 Jan 2001 10:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRABPtf>; Tue, 2 Jan 2001 10:49:35 -0500
Received: from mx3.sac.fedex.com ([199.81.208.11]:13582 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S129267AbRABPtT>; Tue, 2 Jan 2001 10:49:19 -0500
Date: Tue, 2 Jan 2001 23:14:51 +0800
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
Message-Id: <200101021514.f02FEp302397@silk.corp.fedex.com>
To: Alan.Cox@linux.org, linux@silk.corp.fedex.com,
        linux-kernel@silk.corp.fedex.com, lermen@fgan.de, jchua@fedex.com
Subject: can't boot 2.2.x
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got problem booting on Celeron or when initrd filesystem>4MB.

Environment:
	Linux 2.2.19pre3 or any 2.2.x
	Linux 2.4.0-prerelease or any 2.4.x
	Gcc 2.95.2
	Glib 2.1.3
	loadlin 1.6b


1) Pentium3
	When the initrd ramdisk is greater than 4MB
		linux 2.2.x failed
		2.4.x still boot up

2) Celeron
	When the initrd ramdisk is greater than 4MB
		linux 2.2.x failed
		linux 2.4.x failed


Message on console:

	Less than 4MB of memory.

	-- System halted


No problem booting when initrd ramdisk <4MB

I don't know where the problem is.

Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
