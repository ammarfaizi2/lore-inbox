Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268490AbTBOCIB>; Fri, 14 Feb 2003 21:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268505AbTBOCIB>; Fri, 14 Feb 2003 21:08:01 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:8116 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S268490AbTBOCIA>; Fri, 14 Feb 2003 21:08:00 -0500
Message-Id: <5.1.0.14.2.20030214181403.04882168@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 14 Feb 2003 18:17:44 -0800
To: Linus Torvalds <torvalds@transmeta.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: Linux v2.5.61
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0302141709410.1376-100000@penguin.transmeta.
 com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Is there anything wrong with the TTY line discipline module refcounting 
patch that I've sent (4 times now) earlier ?
I'm holding bunch of Bluetooth patches because they depend on that fix.

---
This changeset adds module refcounting for TTY line disciplines. I've sent the patch to LKM earlier.
No negative comments (actually most people didn't seem to care). This is needed at least for 
Bluetooth and IrDA (Jean is ok with the patch).

Please pull from 
        bk://linux-bt.bkbits.net/ttymodref-2.5

This will update the following files:

 drivers/char/tty_io.c     |   16 ++++++++++++++++
 include/linux/tty_ldisc.h |    3 +++
 2 files changed, 19 insertions(+)

through these ChangeSets:

<maxk@qualcomm.com> (03/01/18 1.957)
   [TTY] Add module reference counting for TTY line disciplines.
 
Thanks

Max

