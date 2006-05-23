Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWEWVha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWEWVha (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 17:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWEWVha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 17:37:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52865 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932298AbWEWVh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 17:37:29 -0400
Message-Id: <20060523212101.PS1689520000@infradead.org>
Date: Tue, 23 May 2006 18:21:01 -0300
From: mchehab@infradead.org
To: torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] V4L/DVB updates
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1-2mdk 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull these from master branch at:
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

It fixes some Makefile/Kconfig stuff on mainstream compilation:

   - Fix some warnings when VIDEO_V4L1_COMPAT=y
   - Include requirement for I2C on some Kconfig modules
   - Fix section warnings on bttv dvb driver
   - Fix compilation on PPC 64 for some V4L devices

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 drivers/media/dvb/Kconfig           |   10 +++++-----
 drivers/media/dvb/b2c2/Kconfig      |    6 +++---
 drivers/media/dvb/bt8xx/Kconfig     |    2 +-
 drivers/media/dvb/bt8xx/dvb-bt8xx.c |    6 +++---
 drivers/media/dvb/dvb-usb/Kconfig   |    2 +-
 drivers/media/dvb/pluto2/Kconfig    |    2 +-
 drivers/media/dvb/ttpci/Kconfig     |    8 ++++----
 drivers/media/video/Kconfig         |    4 ++--
 drivers/media/video/Makefile        |    5 ++++-
 9 files changed, 24 insertions(+), 21 deletions(-)

