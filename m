Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131985AbQKZPp3>; Sun, 26 Nov 2000 10:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132074AbQKZPpT>; Sun, 26 Nov 2000 10:45:19 -0500
Received: from [209.249.10.20] ([209.249.10.20]:49287 "EHLO
        freya.yggdrasil.com") by vger.kernel.org with ESMTP
        id <S131985AbQKZPpJ>; Sun, 26 Nov 2000 10:45:09 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 26 Nov 2000 07:15:08 -0800
Message-Id: <200011261515.HAA09753@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Is there some reason why gcc does not put static data that
is explicitly initialized to zero in .bss?  If not, then fixing
gcc would provide more space savings than these patches, and
improve more software than just the Linux kernel.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
