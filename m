Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266702AbTATTFA>; Mon, 20 Jan 2003 14:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266717AbTATTE7>; Mon, 20 Jan 2003 14:04:59 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:7558 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S266702AbTATTEb>; Mon, 20 Jan 2003 14:04:31 -0500
Message-Id: <5.1.0.14.2.20030120103726.04c1d618@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 20 Jan 2003 11:13:29 -0800
To: torvalds@transmeta.com
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: [BK] Add module refcounting for TTY line disciplines.
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

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

http://bluez.sf.net
http://vtun.sf.net

