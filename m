Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbQKUGKc>; Tue, 21 Nov 2000 01:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129625AbQKUGKX>; Tue, 21 Nov 2000 01:10:23 -0500
Received: from logger.gamma.ru ([194.186.254.23]:46088 "EHLO logger.gamma.ru")
	by vger.kernel.org with ESMTP id <S129610AbQKUGKQ>;
	Tue, 21 Nov 2000 01:10:16 -0500
To: linux-kernel@vger.kernel.org
Path: pccross!not-for-mail
From: crosser@average.org (Eugene Crosser)
Newsgroups: linux.kernel
Subject: 2.4.0-test11: "_isofs_bmap: block < 0"
Date: 21 Nov 2000 08:14:51 +0300
Organization: Average
Message-ID: <8vd0cb$5a0$1@pccross.average.org>
Mime-Version: 1.0
X-Newsreader: knews 0.9.8
Content-Type: text/plain; charset=koi8-r
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a cdrom with iso9660+RR filesystem, with a few hundred files in
ten directories.  With all previous kernels (checked up to test11-pre3),
I had no problems with it.  With test11 final, "ls" command shows
zero entries on the mounted CD, and each "ls" attempt causes this
kernel message:

_isofs_bmap: block < 0

If I open a file directly, it opens and is read fine, so it's only
readdir() that is not working.  Tell me if I need to provide more info.

Eugene
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
