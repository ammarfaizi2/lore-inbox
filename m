Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292473AbSBZRtL>; Tue, 26 Feb 2002 12:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292467AbSBZRs5>; Tue, 26 Feb 2002 12:48:57 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:32397 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S292473AbSBZRse>; Tue, 26 Feb 2002 12:48:34 -0500
Message-Id: <200202261700.KAA22908@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Andre Hedrick <andre@linuxdiskcert.org>
Subject: [PATCH] 2.5.5-dj1, add 1 help text to drivers/ide/Config.help
Date: Tue, 26 Feb 2002 10:46:40 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Jens Axboe <axboe@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a help text for CONFIG_BLK_DEV_Q40IDE to drivers/ide/Config.help.
The text was obtained from 2.4.18.

Steven

--- linux-2.5.5-dj1/drivers/ide/Config.help.orig        Mon Feb 25 09:56:23 2002
+++ linux-2.5.5-dj1/drivers/ide/Config.help     Mon Feb 25 09:56:34 2002
@@ -698,6 +698,11 @@
   devices (hard disks, CD-ROM drives, etc.) that are connected to the
   builtin IDE interface.

+CONFIG_BLK_DEV_Q40IDE
+  Enable the on-board IDE controller in the Q40/Q60.  This should
+  normally be on; disable it only if you are running a custom hard
+  drive subsystem through an expansion card.
+
 CONFIG_BLK_DEV_IDE_ICSIDE
   On Acorn systems, say Y here if you wish to use the ICS IDE
   interface card.  This is not required for ICS partition support.
