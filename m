Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129792AbRAPPz2>; Tue, 16 Jan 2001 10:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131496AbRAPPzS>; Tue, 16 Jan 2001 10:55:18 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:59255 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S129792AbRAPPzE>; Tue, 16 Jan 2001 10:55:04 -0500
Date: Tue, 16 Jan 2001 16:54:12 +0100 (MET)
From: Armin Schindler <mac@melware.de>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: lock_kernel() ?
Message-ID: <Pine.LNX.4.31.0101161648270.4429-100000@phoenix.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

  I'm writing a driver which uses also kernel_threads
and file operations (/dev and /proc).

I was not able yet to find out why and when to use
[un]lock_kernel()

Can someone please give me a hint where to find some
infos in using lock_kernel() for 2.2 and 2.4.

What exactly is/must be protected by lock_kernel() ?


Thanks,

Armin



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
