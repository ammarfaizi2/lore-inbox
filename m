Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131997AbQKZQBF>; Sun, 26 Nov 2000 11:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132032AbQKZQAy>; Sun, 26 Nov 2000 11:00:54 -0500
Received: from [209.249.10.20] ([209.249.10.20]:10120 "EHLO
        freya.yggdrasil.com") by vger.kernel.org with ESMTP
        id <S131997AbQKZQAq>; Sun, 26 Nov 2000 11:00:46 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 26 Nov 2000 07:30:44 -0800
Message-Id: <200011261530.HAA09799@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: initdata for modules?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	In reading include/linux/init.h, I was surprised to discover
that __init{,data} expands to nothing when compiling a module.
I was wondering if anyone is contemplating adding support for
__init{,data} in module loading, to reduce the memory footprints
of modules after they have been loaded.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
