Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965228AbVIIBNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbVIIBNk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 21:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVIIBNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 21:13:40 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:31162
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S965225AbVIIBNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 21:13:39 -0400
Subject: Linus Git tree - xfs.o broken?
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Reply-To: abonilla@linuxwireless.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: nathans@sgi.com, xfs-masters@oss.sgi.com,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Thu, 08 Sep 2005 19:12:01 -0600
Message-Id: <1126228321.5043.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I keep posting these messages in LKML because I get no answer from
someone to not do it, or cause I dunno what to do with them.

This is from Linus git tree - Current as per 6PM PDT.

  CC      fs/xfs/linux-2.6/xfs_lrw.o
  CC      fs/xfs/linux-2.6/xfs_super.o
  CC      fs/xfs/linux-2.6/xfs_vfs.o
  CC      fs/xfs/linux-2.6/xfs_vnode.o
  CC      fs/xfs/support/move.o
  CC      fs/xfs/support/uuid.o
  LD      fs/xfs/xfs.o
ld: fs/xfs/quota/: No such file: File format not recognized
make[3]: *** [fs/xfs/xfs.o] Error 1
make[2]: *** [fs/xfs] Error 2
make[1]: *** [fs] Error 2
make[1]: Leaving directory `/root/linux-2.6'
make: *** [stamp-build] Error 2
debian:~/linux-2.6# cd ..

.Alejandro

