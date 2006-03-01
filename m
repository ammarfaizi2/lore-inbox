Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWCAPDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWCAPDo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 10:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWCAPDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 10:03:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:25508 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932386AbWCAO7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:59:22 -0500
Message-Id: <20060301120529.PS80375900000@infradead.org>
Date: Wed, 01 Mar 2006 09:05:29 -0300
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org
Subject: [PATCH 00/13] V4L/DVB updates
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is also available under v4l-dvb.git tree at:
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

Linus, please pull these from master branch.

It contains the following stuff:

   - Bt8xx documentation authors fix
   - Drivers/media/dvb/frontends/mt312.c: cleanups
   - Make a struct static
   - Upstream sync - make 2 structs static
   - Pinnacle PCTV 40i: add filtered Composite2 input
   - Fixed saa7134 ALSA initialization with multiple cards
   - Cxusb: fix lgdt3303 naming
   - Fix maximum for the saturation and contrast controls.
   - Restore power on defaults of tda9887 after tda8290 probe
   - Dvb: fix __init/__exit section references in av7110 driver
   - Removing personal email from DVB maintainers
   - Fix stv0297 for qam128 on tt c1500 (saa7146)
   - ELSA EX-VISION 500TV: fix incorrect PCI subsystem ID

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
Development Mercurial trees are available at http://linuxtv.org/hg
---

 Documentation/dvb/bt8xx.txt                 |    6 -
 Documentation/video4linux/CARDLIST.saa7134  |    4 
 MAINTAINERS                                 |    1 
 drivers/media/dvb/b2c2/flexcop-fe-tuner.c   |    2 
 drivers/media/dvb/bt8xx/bt878.c             |    2 
 drivers/media/dvb/bt8xx/dst.c               |    2 
 drivers/media/dvb/dvb-usb/cxusb.c           |    8 -
 drivers/media/dvb/frontends/Kconfig         |    2 
 drivers/media/dvb/frontends/mt312.c         |  116 +++++++-------------
 drivers/media/dvb/frontends/mt312.h         |    6 -
 drivers/media/dvb/frontends/stv0297.c       |    4 
 drivers/media/dvb/ttpci/av7110.c            |    7 -
 drivers/media/dvb/ttpci/av7110_ir.c         |    4 
 drivers/media/video/cx25840/cx25840-core.c  |    4 
 drivers/media/video/saa7115.c               |    4 
 drivers/media/video/saa7134/saa7134-alsa.c  |    4 
 drivers/media/video/saa7134/saa7134-cards.c |   12 +-
 drivers/media/video/tda8290.c               |    8 -
 18 files changed, 87 insertions(+), 109 deletions(-)

