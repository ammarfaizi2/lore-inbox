Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbUEKGXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUEKGXT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUEKGXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:23:19 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.29]:5995 "EHLO
	mwinf0203.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262170AbUEKGW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:22:57 -0400
Date: Tue, 11 May 2004 08:22:51 +0200
From: Christophe Lucas <c.lucas@ifrance.com>
To: linux-kernel@vger.kernel.org
Message-ID: <20040511062251.GC11015@rhum.iomeda.fr>
Mime-Version: 1.0
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux / 2.6.3 (i686)
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-SA-Exim-Mail-From: clucas@iomeda.fr
Subject: [PATCH] trivial && usb.h
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
X-SA-Exim-Version: 3.1 (built mer oct 29 11:46:13 CET 2003)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I send you this tiny patch.
Sorry, if my diff format is not correct.

Please be patient with this a newbie :-)

HTH

PS: Please cc me, if it is not correct, and explain me. I am here to
learn.
-- 
Amicalement

Christophe 

* GNU/Linux & UNIX developer and network administrator
* Membre RotomaLUG (http://www.rotomalug.org)
* Registered User #271267
* Email: c.lucas@ifrance.com
* Web Site: http://odie.mcom.fr/~clucas/

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-linux-2.6.6-usb-h.diff"

diff -ruNbB linux-2.6.6/include/linux/usb.h linux-2.6.6-patched/include/linux/usb.h
--- linux-2.6.6/include/linux/usb.h	2004-05-10 04:32:29.000000000 +0200
+++ linux-2.6.6-patched/include/linux/usb.h	2004-05-11 08:15:03.000000000 +0200
@@ -676,7 +676,7 @@
  * URB_NO_SETUP_DMA_MAP indicate which buffers have already been mapped.
  * URB_NO_SETUP_DMA_MAP is ignored for non-control URBs.
  *
- * Interrupt UBS must provide an interval, saying how often (in milliseconds
+ * Interrupt URBs must provide an interval, saying how often (in milliseconds
  * or, for highspeed devices, 125 microsecond units)
  * to poll for transfers.  After the URB has been submitted, the interval
  * field reflects how the transfer was actually scheduled.

--ibTvN161/egqYuK8--
