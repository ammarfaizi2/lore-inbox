Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129185AbQJ3HkD>; Mon, 30 Oct 2000 02:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129219AbQJ3Hjx>; Mon, 30 Oct 2000 02:39:53 -0500
Received: from [209.249.10.20] ([209.249.10.20]:60858 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129185AbQJ3Hjj>; Mon, 30 Oct 2000 02:39:39 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 30 Oct 2000 00:39:37 -0800
Message-Id: <200010300839.AAA10601@baldur.yggdrasil.com>
To: aer-list@mailandnews.com
Subject: Re: / on ramfs, possible?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Eriksson <aer-list@mailandnews.com> writes:
>I want my / to be a ramfs filesystem. I intend to populate it from an 
>initrd image, and then remount / as the ramfs filesystem. Is that at 
>all possible? The way I see it the kernel requires / on a device 
>(major,minor) or nfs.
>
>Am I out of luck using ramfs as /? If it's easy to fix, how do I fix it?

	We do that right now with cramfs.  You might want to examine
ftp://ftp.yggdrasil.com/pub/dist/booting/make-ramdisk-0.19.tar.gz.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
