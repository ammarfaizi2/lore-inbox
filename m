Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264607AbTDZEFZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 00:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbTDZEFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 00:05:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41133 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264607AbTDZEFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 00:05:21 -0400
Message-ID: <3EAA0852.9040605@pobox.com>
Date: Sat, 26 Apr 2003 00:17:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] misc merges
Content-Type: multipart/mixed;
 boundary="------------080008020203020108080200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080008020203020108080200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------080008020203020108080200
Content-Type: text/plain;
 name="misc-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.5.txt"

Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/misc-2.5

This will update the following files:

 arch/i386/kernel/io_apic.c |    2 -
 drivers/char/hw_random.c   |    4 +--
 drivers/scsi/ncr53c8xx.c   |   31 +++++++++++-------------
 drivers/scsi/sym53c8xx.c   |   57 ++++++++++++++++++++++-----------------------
 include/linux/interrupt.h  |    2 -
 include/linux/quotaops.h   |    1 
 include/linux/sched.h      |    2 -
 include/linux/timer.h      |    2 -
 sound/oss/trident.c        |    4 +--
 9 files changed, 52 insertions(+), 53 deletions(-)

through these ChangeSets:

<Valdis.Kletnieks@vt.edu> (03/04/25 1.1256)
   cpp cleanups: use KERNEL_VERSION macro from linux/version.h
   
   Updated ncr53c8xx and sym53c8xx scsi drivers.

<Valdis.Kletnieks@vt.edu> (03/04/25 1.1255)
   cpp cleanups for ia32/io_apic.c, sound/oss/trident.c

<jgarzik@redhat.com> (03/04/25 1.1254)
   [hw_random] fix bug, bump version
   
   Fix ugly bug in read(2) path for odd buffer sizes.
   Noticed by Joseph Chan @ Via.
   
   Bump version to 1.0.0.

<pixi@burble.org> (03/04/25 1.1253)
   [quota] provide no-op sync_dquots_dev, one .config case wants it

<jgarzik@redhat.com> (03/04/25 1.1252)
   s/#if/#ifdef/ for a few CONFIG_SMP tests in public headers
   
   Headers touched: linux/interrupt.h, linux/sched.h, linux/timer.h


--------------080008020203020108080200--

