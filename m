Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130539AbRALJ4x>; Fri, 12 Jan 2001 04:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130745AbRALJ4n>; Fri, 12 Jan 2001 04:56:43 -0500
Received: from mx7.sac.fedex.com ([199.81.194.38]:2052 "EHLO mx7.sac.fedex.com")
	by vger.kernel.org with ESMTP id <S130539AbRALJ40>;
	Fri, 12 Jan 2001 04:56:26 -0500
Date: Fri, 12 Jan 2001 17:54:27 +0800 (SGT)
From: Jeff Chua <jeffchua@fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.1-pre3 says 2.4.1-pre2 
Message-ID: <Pine.LNX.4.31.0101121751500.2623-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


patch-2.4.1-pre3.bz2 didn't update Makefile correctly.

Should be +EXTRAVERSION =-pre3 instead of -pre2


diff -u --recursive --new-file v2.4.0/linux/Makefile linux/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
-SUBLEVEL = 0
-EXTRAVERSION =
+SUBLEVEL = 1
+EXTRAVERSION =-pre2


Thanks,
Jeff Chua
[ jchua@fedex.com ]

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
