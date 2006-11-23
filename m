Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757193AbWKWAFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757193AbWKWAFG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 19:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757201AbWKWAFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 19:05:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28683 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1757193AbWKWAFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 19:05:04 -0500
Date: Thu, 23 Nov 2006 01:05:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.16.33
Message-ID: <20061123000507.GC3557@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Security fixes since 2.6.16.32:
- CVE-2005-4352: security/seclvl.c: fix time wrap


Location:
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/

git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

RSS feed of the git tree:
http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=rss


Changes since 2.6.16.32:

Adrian Bunk (5):
      security/seclvl.c: fix time wrap (CVE-2005-4352)
      drivers/scsi/psi240i.c: fix an array overrun
      V4L/DVB: Saa7134: rename dmasound_{init,exit}
      Linux 2.6.16.33-rc1
      Linux 2.6.16.33

Alexey Dobriyan (1):
      ipmi_si_intf.c: fix "&& 0xff" typos

Andrew Morton (1):
      disable debugging version of write_lock()

Artur Skawina (1):
      sis900 adm7001 PHY support

Badari Pulavarty (1):
      ext3 -nobh option causes oops

Benjamin Herrenschmidt (1):
      POWERPC: Make alignment exception always check exception table

Bob Moore (1):
      Reduce ACPI verbosity on null handle condition

Daniel Drake (1):
      sata_promise: Support FastTrak TX4300/TX4310

Daniel Ritz (1):
      fix via586 irq routing for pirq 5

Daniele Venzano (1):
      Add new PHY to sis900 supported list

David Miller (1):
      [RTNETLINK]: Fix IFLA_ADDRESS handling.

Diego Calleja (1):
      Fix BeFS slab corruption

Dmitry Mishin (1):
      Fix timer race in dst GC code

Michael Chan (1):
      [TG3]: Fix array overrun in tg3_read_partno().

Michael-Luke Jones (1):
      Old IDE, fix SATA detection for cabling

Paul Fulghum (1):
      synclink_gt fix receive tty error handling


 Makefile                                   |    2 +-
 arch/i386/pci/irq.c                        |    4 ++--
 arch/powerpc/kernel/traps.c                |   18 ++++++++++--------
 arch/ppc/kernel/traps.c                    |   18 ++++++++++--------
 drivers/acpi/namespace/nsxfeval.c          |    5 +++--
 drivers/char/ipmi/ipmi_si_intf.c           |    6 +++---
 drivers/char/synclink_gt.c                 |   14 +++++++-------
 drivers/ide/ide-iops.c                     |    4 ++++
 drivers/media/video/saa7134/saa7134-alsa.c |   10 +++++-----
 drivers/media/video/saa7134/saa7134-core.c |   16 ++++++++--------
 drivers/media/video/saa7134/saa7134-oss.c  |   10 +++++-----
 drivers/media/video/saa7134/saa7134.h      |    4 ++--
 drivers/net/sis900.c                       |    2 ++
 drivers/net/tg3.c                          |   19 ++++++++++++-------
 drivers/scsi/psi240i.c                     |    2 +-
 drivers/scsi/sata_promise.c                |    2 ++
 fs/befs/linuxvfs.c                         |   11 +++++++++--
 fs/ext3/inode.c                            |    6 +++---
 lib/spinlock_debug.c                       |   10 ++++++----
 net/core/dst.c                             |    3 +--
 net/core/rtnetlink.c                       |   15 ++++++++++++++-
 security/seclvl.c                          |    2 ++
 22 files changed, 112 insertions(+), 71 deletions(-)
