Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266497AbSIRMxN>; Wed, 18 Sep 2002 08:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266501AbSIRMxN>; Wed, 18 Sep 2002 08:53:13 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:40146 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266497AbSIRMxM> convert rfc822-to-8bit; Wed, 18 Sep 2002 08:53:12 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] [PATCH] Linux-2.5.36-mcp1
Date: Wed, 18 Sep 2002 14:50:13 +0200
X-Mailer: KMail [version 1.4]
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209181448.36520.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

here we go, -mcp1 for 2.5.36 vanilla.

 o indicates new add/update
 - indicates removed


 Changes in 2.5.36-mcp1:
 -----------------------
 o  2.5.36-mm1                                          (Andrew Morton)
 o  2.5.35-lsm1 (Linux Security Module)                 (LSM Team)
 o  2.5.36 i2c core drivers module_init/exit cleanup    (Albert Cranford)
 o  2.5.36 i2c new adapter id's                         (Albert Cranford)
 o  2.5.36 i2c new adapter i2c-pport driver             (Albert Cranford)
 -  XFS (now in 2.5.36, finally :))
 -  thread-exec-fix-2.5.35-A5 (now in 2.5.36)
 -  ebtables - Ethernet bridge tables (now in 2.5.36)
 -  NTFS unresolved symbol fix (now in 2.5.36)


 Changes in 2.5.35-mcp1:
 -----------------------
 o  2.5.35-mm1                                          (Andrew Morton)
 o  ebtables - Ethernet bridge tables, for 2.5.35       (Bart De Schuymer)
 o  XFS DMAPI compile fix                               (Thunder f. the hill)
 o  ptrace breakage fix (2nd try :)                     (Ogawa Hirofumi)
 o  thread-exec-fix-2.5.35-A5                           (Ingo Molnar)
 o  NTFS - module build - unresolved symbol fix         (me)
 -  INPUT Fixes (7/7) (for now in 2.5.35)


 Changes in 2.5.34-mcp4:
 -----------------------
 o   2.5.34-mm4                                         (Andrew Morton)
 o   ALSA v0.9.0rc3                                     (ALSA Team)
      thanks to Martin Loschwitz for re-integrating this
 o   INPUT Fixes (7/7)                                  (Vojtech Pavlik)
 o   Preempt <-> -mmX workaround                        (Steven Cole)


 Changes in 2.5.34-mcp3:
 -----------------------
 o   2.5.34-mm3                                         (Andrew Morton)


 Changes in 2.5.34-mcp2:
 -----------------------
 o   2.5.34-mm2                                         (Andrew Morton)
 o   Low level fb console driver for VGA text mode      (Petr Vandrovec)
 o   Entropy Fixes (11/11)                              (Oliver Xymoron)
 o   Preempt - no more spurious warnings at reboot/halt (Robert Love)
 o   IRQ-stack 4kb                                      (Dave Hansen)
 -   ftape damage fix (for now in -mm2)
 -   floppy driver init/exit fixes (for now in -mm2)
 -   devfs fix (for now in -mm2)
 -   do_syslog__down_try lock lockup (for now in -mm2)
 -   ALSA v0.9.0rc3
      causes non-compilable sound module with devfs


 Changes in 2.5.34-mcp1:
 -----------------------
 o   2.5.34-mm1                                         (Andrew Morton)
 o   ftape damage fix                                   (Mikael Pettersson)
 o   floppy driver init/exit fixes                      (Mikael Pettersson)
 o   ALSA v0.9.0rc3                                     (ALSA Team)
 o   XFS + KDB (2.5.33-20020908-cvs)                    (XFS Team)
 o   aty128 Framebuffer fixes                           (Paul Mackerras)
 o   devfs fix                                          (Alexander Viro)
 o   do_syslog__down_try lock lockup                    (Ingo Molnar)
 o   pcibios_fixup_irqs-static                          (Adam J. Richter)
 o   ext3 version information fix                       (me)
 o   some tuning                                        (me)
     - OPEN_MAX 1024
     - NR_FILE 65536
     - NR_RESERVED_FILES 128
     - TCP_KEEPALIVE_TIME (5*60*HZ)
     - int sysctl_local_port_range[2] = { 1024, 9999 };


If anyone is interrested in seperated patches of each above I'll
make a patch SET also available!


md5sums:
--------
1d2b9d29db0e589e0ff7bbc7182bbbe3 *linux-2.5.36-mcp1.patch.bz2
4b4f23f5b814eb751ca6976acb01b2a4 *linux-2.5.36-mcp1.patch.gz


URL:
----
http://prdownloads.sf.net/wolk/linux-2.5.36-mcp1.patch.bz2?download
http://prdownloads.sf.net/wolk/linux-2.5.36-mcp1.patch.gz?download



Thanks goes out to all the great developers who made this possible !!

Feedback welcome :) ... Have fun!


-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


