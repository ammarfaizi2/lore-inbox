Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262029AbSIYRDS>; Wed, 25 Sep 2002 13:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262030AbSIYRDS>; Wed, 25 Sep 2002 13:03:18 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:33472 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262029AbSIYRDR> convert rfc822-to-8bit; Wed, 25 Sep 2002 13:03:17 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: wolk-devel@lists.sourceforge.net, wolk-announce@lists.sourceforge.net
Subject: [ANNOUNCE] WOLK v3.6.1 UPDATE for v3.6 FINAL
Date: Wed, 25 Sep 2002 19:07:22 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209251905.45357.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

this is an update (v3.6.1) for v3.6 FINAL of WOLK. Sorry for the delay.
I really wanted to fix the strange ALSA unresolved symbols problem :)


Here we go, Changelog from v3.6 -> v3.6.1
-----------------------------------------
o   add:    Fair Scheduler v2.4.19 2nd edition          (Rik van Riel)
o   fixed:  ext3 htree build/linking problem            (me)
o   fixed:  ext2 compression (e2compr) build problem    (me)
o   fixed:  cryptoloop.c: 'loop_iv_t'
             previously declared here                   (me)
o   fixed:  timepeg INTLAT build problem
             when CONFIG_PREEMPT is set                 (me)
o   fixed:  unix.o: unresolved symbols:
             gr_handle_create/gr_check_create           (me)
o   fixed:  HTB Configure.help entry missed
             while updating to HTB3.6                   (me)
o   fixed:  FINALLY: the unresolved symbols for
             midi/synth stuff with ALSA                 (me)
o   fixed:  irda-usb: irda-usb.c compile error          (me)
o   fixed:  HID (full support) compile error            (me)
o   fixed:  zftape: zftape-init.c compile error         (Eyal Lebedinsky)
o   fixed:  missed AIO <-> grsec stuff in
             include/asm-i386/a.out.h                   (Brad Spengler)
o   update: htree ext3 v2.4.19-2-dxdir                  (Theodore Ts'o)
o   update: CPU Frequency Scaling v2.4.19-4             (Dominik Brodowski)


!!! Do not use htree in userspace with versions < 1.29 of e2fsprogs !!!
    See e2fsprogs release notes for 1.29:
    http://e2fsprogs.sourceforge.net/e2fsprogs-release.html#1.29

    "Fixed a bug in e2fsck which could corrupt a directory when optimizing it
     (via the -D option) or rebuiliding the hash tree index with a 1 in 512
     probability, due to a fence post error."

Debian packages (unofficial, by me) are available at:
- http://wolk.sf.net/e2fsprogs/



Release Info:
-------------
Date   : September, 25th, 2002
Time   : 7:00 pm CET
URL    : http://sf.net/projects/wolk


md5sums:
--------
9ecbb8911ce3da94a0eaa2d132a60965 *linux-2.4.18-wolk3.6-to-3.6.1.patch.bz2
c92b1a47785bd3bd96aad3debb721dd2 *linux-2.4.18-wolk3.6-to-3.6.1.patch.gz


Direkt download links:
----------------------
http://prdownloads.sf.net/wolk/linux-2.4.18-wolk3.6-to-3.6.1.patch.bz2
http://prdownloads.sf.net/wolk/linux-2.4.18-wolk3.6-to-3.6.1.patch.gz


Have fun!

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
