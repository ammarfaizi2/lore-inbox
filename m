Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266425AbRGCCpV>; Mon, 2 Jul 2001 22:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266426AbRGCCpL>; Mon, 2 Jul 2001 22:45:11 -0400
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:14803 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S266425AbRGCCpE>; Mon, 2 Jul 2001 22:45:04 -0400
Message-Id: <3.0.6.32.20010702224503.007ab870@popserver.panix.com>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Mon, 02 Jul 2001 22:45:03 -0400
To: linux-kernel@vger.kernel.org
From: Jim Rankin <jrankin@panix.com>
Subject: RH kernel 2.2.19-6.2.7, md_setup_drive, reference undefined
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I attempt to build a custom version of the Red Hat kernel 2.2.19-6.2.7
in Red Hat 6.2, the compile aborts with

init/main.o(.data.init+0x13c): undefined reference to `md_setup'
drivers/block/block.a(genhd.o): In function `device_setup':
genhd.o(.text.init+0x13a): undefined reference to `md_setup_drive'
make: *** [vmlinux] Error 1

Anybody know what's wrong?

Jim




