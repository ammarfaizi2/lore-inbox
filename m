Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131070AbQK2MNM>; Wed, 29 Nov 2000 07:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131092AbQK2MND>; Wed, 29 Nov 2000 07:13:03 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:43023 "HELO
        hermine.idb.hist.no") by vger.kernel.org with SMTP
        id <S131070AbQK2MMh>; Wed, 29 Nov 2000 07:12:37 -0500
Message-ID: <3A24EB83.5E842526@idb.hist.no>
Date: Wed, 29 Nov 2000 12:41:55 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ext2 errors in test12-pre2 (freeing blocks not in datazone)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed something strange in my syslog today:

Nov 29 10:59:18 hh kernel: Trying to open MFT
Nov 29 10:59:23 hh kernel: EXT2-fs error (device ide0(3,4)):
ext2_free_blocks: Freeing blocks not in datazone - block = 3301007960,
count = 1
Nov 29 10:59:23 hh kernel: EXT2-fs error (device ide0(3,4)):
ext2_free_blocks: Freeing blocks not in datazone - block = 3301007960,
count = 1
Nov 29 10:59:23 hh kernel: EXT2-fs error (device ide0(3,4)):
ext2_free_blocks: Freeing blocks not in datazone - block = 3301009112,
count = 1
Nov 29 10:59:23 hh kernel: EXT2-fs error (device ide0(3,4)):
ext2_free_blocks: Freeing blocks not in datazone - block = 3301009112,
count = 1
Nov 29 10:59:23 hh kernel: EXT2-fs error (device ide0(3,4)):
ext2_free_blocks: Freeing blocks not in datazone - block = 3301010648,
count = 1
Nov 29 10:59:23 hh kernel: EXT2-fs error (device ide0(3,4)):
ext2_free_blocks: Freeing blocks not in datazone - block = 3301010648,
count = 1

6 errors with 3 blocks.  This was with test12-pre2 UP, compiled for
pentium II with gcc 2.95.2

Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
