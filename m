Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132507AbRACRNA>; Wed, 3 Jan 2001 12:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132587AbRACRMv>; Wed, 3 Jan 2001 12:12:51 -0500
Received: from mail-4.tiscalinet.it ([195.130.225.150]:52579 "EHLO
	mail.tiscalinet.it") by vger.kernel.org with ESMTP
	id <S132507AbRACRMk>; Wed, 3 Jan 2001 12:12:40 -0500
Message-Id: <3.0.6.32.20010103174545.00b76100@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Wed, 03 Jan 2001 17:45:45 +0100
To: linux-kernel@vger.kernel.org
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: swapoff and 2.4.0-prerelease
Cc: torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I run 'swapoff -a' in the middle of 'make j10 bzImage'
with 32M (by lilo) and got this:

Jan  3 17:30:07 lenstra kernel: VM: Undead swap entry 000f3100
Jan  3 17:30:07 lenstra kernel: VM: Bad swap entry 000f3100
Jan  3 17:30:07 lenstra kernel: VM: Bad swap entry 000f3100
Jan  3 17:30:07 lenstra kernel: Unused swap offset entry in swap_count
000f3100
Jan  3 17:30:07 lenstra kernel: VM: Bad swap entry 000f3100

I that moment the swap was about 20-25M.
(ok, maybe swapoff by root is rather "unfair" but.. :-)

--
Lorenzo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
