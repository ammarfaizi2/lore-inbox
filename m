Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVEPPkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVEPPkj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 11:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVEPPjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 11:39:46 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:54433 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261717AbVEPPi5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 11:38:57 -0400
X-ORBL: [69.107.61.180]
From: David Brownell <david-b@pacbell.net>
Subject: Fwd: ANNOUNCE:  usbutils 0.71
Date: Mon, 16 May 2005 08:38:55 -0700
User-Agent: KMail/1.7.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505160838.56045.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



----------  Forwarded Message  ----------

Subject: ANNOUNCE:  usbutils 0.71
Date: Monday 16 May 2005 8:36 am
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net

A new version of "usbutils" is available from the linux-usb download
area at SourceForge.net:

  http://sourceforge.net/project/showfiles.php?group_id=3581&package_id=142529

Changes in the 4+ months since version 0.70 are primarily small bugfixes
and cleanups, plus parsing for some more CDC class descriptors.  ChangeLog
entries are below.

Thanks to those of you who've contributed patches (see below), Stephen
Gowdy (helping maintain that download area), and Vojtech Pavlik (for
maintaining the usb.ids file).

- Dave




2005-05-14 David Brownell <dbrownell nospam users.sourceforge.net>
        Label as version 0.71
        * usb.ids: update to current version

2005-05-13 Toby Ernst <tee nospam sgi.com>
        * lsusb.c: /proc/bus/usb/BBB/DDD numbers are decimal not octal
        * lsusb.8: ditto

2005-04-29 Olaf Hering <olh nospam suse.de>
        * lsusb.c: fix some compiler warnings

2005-04-14 David Brownell <dbrownell nospam users.sourceforge.net>
        * lsusb.c: add some more CDC WHCM dumping, matching a Sony 3G phone

2005-03-28 Aurelien Jarno <aurelien nospam aurel32.net>
        * lsusb.c: disallow decimal product and vendor codes (hex only)

2005-03-05 David Brownell <dbrownell nospam users.sourceforge.net>
        * lsusb.c: add basic CDC MDLM dumping, to cope with new CDC
          conformance lies from a Zaurus C-860

2005-02-11 Thierry Vignaud <tvignaud nospam mandrakesoft.com>
        * usbmodules.8: fix --device /proc/usb/usb/BBB/DDD typo

2005-02-02 David Brownell <dbrownell nospam users.sourceforge.net>
        * configure.in: fix typo, recommend libusb 0.1.8 not 1.8

2005-01-30 David Brownell <dbrownell nospam users.sourceforge.net>
        Fix some more warnings reported by Aurelian, and configure
        gcc for "-W -Wunused" to discourage more from appearing.

2005-01-27 Aurelien Jarno <aurelien nospam aurel32.net>
        Fix "configure --enable-usbmodules" glitch, and remove
        some warnings reported by GCC 4.0 (and "gcc -Wall -W").



-------------------------------------------------------
