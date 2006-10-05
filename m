Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWJEDCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWJEDCK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 23:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWJEDCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 23:02:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30106 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751424AbWJEDCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 23:02:06 -0400
Message-Id: <20061005025847.PS6380080000@infradead.org>
Date: Wed, 04 Oct 2006 23:58:47 -0300
From: mchehab@infradead.org
To: torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] V4L/DVB updates
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Those are the two last patches for the 2-week window.
Please pull these from master branch at:
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

It contains the following stuff:

   - Add WinTV-HVR3000 DVB-T support
   - Cx88: Add support for VIDIOC_INT_[SR]_REGISTER ioctls

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 Documentation/video4linux/CARDLIST.cx88 |    2 +-
 drivers/media/video/cx88/cx88-cards.c   |   21 +++++++++++++++++++++
 drivers/media/video/cx88/cx88-dvb.c     |   17 +++++++++++++++++
 drivers/media/video/cx88/cx88-input.c   |    2 ++
 drivers/media/video/cx88/cx88-video.c   |   24 ++++++++++++++++++++++++
 5 files changed, 65 insertions(+), 1 deletions(-)

