Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129682AbQK1N6U>; Tue, 28 Nov 2000 08:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130021AbQK1N6B>; Tue, 28 Nov 2000 08:58:01 -0500
Received: from mail.ima.pl ([195.117.13.5]:44807 "EHLO mail.ima.pl")
        by vger.kernel.org with ESMTP id <S129682AbQK1N5v>;
        Tue, 28 Nov 2000 08:57:51 -0500
Message-Id: <5.0.0.25.0.20001128142121.01da9e20@195.117.13.2>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Tue, 28 Nov 2000 14:29:34 +0100
To: reiserfs-list@namesys.com
From: Blizbor <tb670725@ima.pl>
Subject: VFS: brelse message in syslog, its due to ReiserFS or kernel
  failure ?
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Machine: P3 500 on ASUS P2B, WD 15GB IDE drive.
System RH7 with upgraded glibc.

When I'm using 2.2.17 with ReiserFS:
Nov 26 00:05:05 localhost kernel: Linux version 2.2.17 (root@localhost.localdomain) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 relea
se)) #9 Sat Nov 25 17:09:40 CET 2000

I have such messages in syslog and console:
Nov 26 06:00:49 localhost kernel: VFS: brelse: Trying to free free buffer
Nov 26 06:07:41 localhost kernel: VFS: brelse: Trying to free free buffer
Nov 26 06:32:28 localhost kernel: VFS: brelse: Trying to free free buffer

FS size is about 8GB.

When I've switched to 2.4.0-test11 + ReiserFS patch there are no such messages.

Both kerlels are patched with latest ReiserFS patches.


-- 
</Microsoft>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
