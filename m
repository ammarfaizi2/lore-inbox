Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLRVBX>; Mon, 18 Dec 2000 16:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130642AbQLRVBO>; Mon, 18 Dec 2000 16:01:14 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:2573 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S129391AbQLRVAw>; Mon, 18 Dec 2000 16:00:52 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Mon, 18 Dec 2000 13:30:17 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="iso-8859-1"
To: linux-kernel@vger.kernel.org
Subject: ReiserFS now works with 2.4.0-test12 and test13-pre1,2,3
MIME-Version: 1.0
Message-Id: <00121813301601.00924@spc.esa.lanl.gov>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the benefit of those who want to run 2.4.0-test12 and
2.4.0-test13-preX kernels with ReiserFS and who are not actively
monitoring the reiserfs-list, the following information may be
of interest.

Reiserfs version 3.6.22 (only) now works with these latest kernels, but
two additional patches for 2.4.0-test12 and a third patch for test13-preX are 
necessary.

Reiserfs-3.6.22 is available at:
ftp://ftp.namesys.com/pub/2.4/linux-2.4.0-test10-reiserfs-3.6.22-patch.gz

The first two additional patches are available here:
ftp://ftp.reiserfs.org/pub/2.4/beta/reiserfs-test12-patches.tar.gz

This tar contains:
readpage-uptodate.diff    Linus's version (Test12 ll_rw_block thread)
reiserfs-3622-test12.diff

For 2.4.0-test13-pre1,2,3, the following Makefile patch is needed:
ftp://ftp.reiserfs.org/pub/2.4/beta/test13-preX/reiserfs-Makefile-patch

If you apply these patches in this order, you shouldn't get any rejects.
(Apply the test13-preX patch first).

Have fun,
Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
