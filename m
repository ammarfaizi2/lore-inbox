Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbQKPLlE>; Thu, 16 Nov 2000 06:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129060AbQKPLky>; Thu, 16 Nov 2000 06:40:54 -0500
Received: from [209.249.10.20] ([209.249.10.20]:61138 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129132AbQKPLkg>; Thu, 16 Nov 2000 06:40:36 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 16 Nov 2000 03:10:14 -0800
Message-Id: <200011161110.DAA13775@baldur.yggdrasil.com>
To: davem@redhat.com
Subject: Re: sunhme.c patch for new PCI interface (UNTESTED)
Cc: linux-kernel@vger.kernel.org, willy@meta-x.org, wtarreau@yahoo.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Sorry, I don't like this change.

	Can you at least add the MODULE_DEVICE_TABLE declaration
and the pci_device_id table that it refers to, even if the code
does not directly reference it?  (You can make it as __initdata
rather than __devinitdata, since it can safely be thrown away.)
That was automatic PCI ID recognition will work.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
