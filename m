Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262047AbSI3M4M>; Mon, 30 Sep 2002 08:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262048AbSI3M4M>; Mon, 30 Sep 2002 08:56:12 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:43923 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262047AbSI3M4K> convert rfc822-to-8bit; Mon, 30 Sep 2002 08:56:10 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] [PATCH] Linux-2.5.39-mcp1
Date: Mon, 30 Sep 2002 14:58:36 +0200
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: wolk-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209301237.38390.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

first: anything that _should_ be merged into 2.5 devel tree and is _not_ 
merged so far for some good reason (f.e. needs testing, further development, 
etc.), please send me those patches and I'll integrate them into the -mcp 
tree! :) ... (if not already done) ... thnx!

Dominik, gratulations for CPU Frequency in Mainline now :-)


here we go, -mcp1 for 2.5.39 vanilla.

 o indicates new add/update
 - indicates removed

 Changes in 2.5.39-mcp1:
 -----------------------
 o  2.5.39-mm1                                          (Andrew Morton)
 o  RCU fixes for 2.5.39-mm1                            (Dipankar Sarma)
 o  ReiserFS temporary fix for 2.5.39-mm1               (Andrew Morton)
 o  CPU-Frequency scaling fix 2.5.39                    (Dominik Brodowski)
 o  ALSA Updates 10/10                                  (Jaroslav Kysela)
 o  ALSA Update fix                                     (Arador)
 o  i8xx series chipsets patches (3/3)                  (Wim Van Sebroeck)
 o  sg.c and USER_HZ, kernel 2.5.39                     (Rolf Fokkens)
 o  timer.c negative shift, kernel 2.5.39               (Rolf Fokkens)
 o  net/Config.in (IPX, Appletalk)                      (Andries Brouwer)
 o  SMB fixes (3/3)                                     (Urban Widmark)
 o  use fff/ffff/fffffff instead
     of ff8/fff8/ffffff8 for EOF of FAT                 (Ogawa Hirofumi)
 o  remove fat_search_long() in vfat_add_entry()        (Ogawa Hirofumi)
 o  sigfix-2.5.39-D0                                    (Ingo Molnar)
 -  ReiserFS fix (now in 2.5.39)


 Changes in 2.5.38-mcp3:
 -----------------------
 o  2.5.38-mm3                                          (Andrew Morton)
 o  ReiserFS fix                                        (Hans Reiser)
 o  include missing in drivers/usb/host/ohci-hcd.c      (Luc Van Oostenryck)
 o  AccessFS 2.5.35[8]-0.5                              (Olaf Dietsche)
 o  files_struct_rcu patch for 2.5.38                   (Dipankar Sarma)
 o  Rename "Second extended fs" to
     "Ext2 file system support"                         (me)
 o  Moved every Journalling Filesystem in
     an extra menu option                               (me)
 -  UP_APIC linkage problem fix (now in -mmX)
 -  2.5.38 EBTables breakage fix (now in -mmX)
 -  2.5.38 floppy build problem fix (now in -mmX)
 -  oops at boot in ide_toggle_bounce fix (now in -mmX)


 Changes in 2.5.38-mcp2:
 -----------------------
 o  2.5.38-mm2                                          (Andrew Morton)
 o  AccessFS 2.5.34-0.4                                 (Olaf Dietsche)
 o  export find_task_by_pid fix                         (Hiroshi Takekawa)
 o  make bzImage fails on 2.5.38                        (Hiroshi Takekawa)
 o  xtime to do_gettimeofday() in drivers/atm/*c        (Francois Romieu)
 o  drivers/char/sx.c __FUNCTION__ breakage fix         (Adrian Bunk)
 o  drivers/char/generic_serial.c __FUNCTION__ fix      (Adrian Bunk)
 o  UP_APIC linkage problem fix                         (Mikael Pettersson)
 o  CPU-Frequency scaling for 2.5.38                    (Dominik Brodowski)
 o  2.5.38 floppy build problem fix                     (Philipp M. Hahn)
 o  2.5.38 EBTables breakage fix                        (Bert Hubert)
 o  sound/oss cli() fixup all in one fix                (Peter Waechtler)
 o  oopses at boot in ide_toggle_bounce fix             (Jens Axboe)
 o  IDE oopses on vmware fix                            (Jens Axboe)
 -  schedule in_atomic() check (now in 2.5.38)
 -  recognize MAP_LOCKED in mmap() call (in 2.5.38)
 -  clean up RPC over TCP transport (now in 2.5.38)
 -  RCU (Read-Copy Update) 2.5.36 (now in -mmX)


 Changes in 2.5.36-mcp2:
 -----------------------
 o  RCU (Read-Copy Update) for 2.5.36 + Fix             (Dipankar Sarma)
 o  real preempt <-> mmX fix (not a workaround :)       (Robert Love)
      thnx to Steven Cole <elenstev@mesatop.com>
      for pointing me to the real fix :)
 o  recognize MAP_LOCKED in mmap() call                 (Hubertus Franke)
 o  core file naming                                    (Jes Rahbek Klinke)
      This is in the WOLK series for a long time now
      and I really like this feature and want to see
      this in 2.5.xx mainline! :)
 o  clean up RPC over TCP transport socket connect      (Chuck Lever)
 o  CPU-Frequency scaling for 2.5.36                    (Dominik Brodowski)


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
ef4f1f492fc082917a7c8030012342cf *linux-2.5.39-mcp1.patch.bz2
b38e4ae8b87d48e6f0bc9e8c1cfea4fc *linux-2.5.39-mcp1.patch.gz


URL:
----
http://prdownloads.sf.net/wolk/linux-2.5.39-mcp1.patch.bz2?download
http://prdownloads.sf.net/wolk/linux-2.5.39-mcp1.patch.gz?download


Thanks goes out to all the great developers who made this possible !!

Feedback welcome :) ... Have fun!


-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


