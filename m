Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277746AbRJWPPD>; Tue, 23 Oct 2001 11:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277730AbRJWPMu>; Tue, 23 Oct 2001 11:12:50 -0400
Received: from finch-post-12.mail.demon.net ([194.217.242.41]:64016 "EHLO
	finch-post-12.mail.demon.net") by vger.kernel.org with ESMTP
	id <S277733AbRJWPMe>; Tue, 23 Oct 2001 11:12:34 -0400
Subject: Re: NTFS causes tainted kernel?
From: Richard Russon <rich@flatcap.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, Mike Fedyk <mfedyk@matchmail.com>,
        Anton Altaparmakov <aia21@cam.ac.uk>
In-Reply-To: <20011022204336.A432@mikef-linux.matchmail.com>
In-Reply-To: <20011022204336.A432@mikef-linux.matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 23 Oct 2001 16:12:57 +0100
Message-Id: <1003849984.16858.13.camel@home.flatcap.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Alan.

Please can you apply the following patch to pre6/ac5.
It adds a module license to the NTFS driver.
(Anton's happy with the patch).

Cheers,
  FlatCap (Rich)
  ntfs@flatcap.org


diff -urN linux-2.4.13-pre6/fs/ntfs/fs.c linux-2.4.13-pre6-ntfs/fs/ntfs/fs.c
--- linux-2.4.13-pre6/fs/ntfs/fs.c	Tue Oct 23 15:49:53 2001
+++ linux-2.4.13-pre6-ntfs/fs/ntfs/fs.c	Tue Oct 23 15:50:23 2001
@@ -1159,6 +1159,7 @@
  */
 MODULE_AUTHOR("Anton Altaparmakov <aia21@cus.cam.ac.uk>");
 MODULE_DESCRIPTION("Linux NTFS driver");
+MODULE_LICENSE("GPL");
 #ifdef DEBUG
 MODULE_PARM(ntdebug, "i");
 MODULE_PARM_DESC(ntdebug, "Debug level");


