Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275997AbSIUW4u>; Sat, 21 Sep 2002 18:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276004AbSIUW4u>; Sat, 21 Sep 2002 18:56:50 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:13959 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S275997AbSIUW4t>;
	Sat, 21 Sep 2002 18:56:49 -0400
Date: Sun, 22 Sep 2002 01:01:57 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200209212301.BAA08451@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: 2.5.37 broke the floppy driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.5.37, doing a write to floppy makes the kernel print
"blk: request botched" and a few seconds later instantly reboot
the machine (w/o any further messages). 2.5.36 works fine.

"dd bs=8k if=bzImage of=/dev/fd0" triggers this every time.

/Mikael
