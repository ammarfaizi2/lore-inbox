Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265301AbSJRVTk>; Fri, 18 Oct 2002 17:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265312AbSJRVTk>; Fri, 18 Oct 2002 17:19:40 -0400
Received: from mail.firstinspire.net ([212.83.62.162]:3972 "EHLO
	NS.firstinspire.net") by vger.kernel.org with ESMTP
	id <S265301AbSJRVTi>; Fri, 18 Oct 2002 17:19:38 -0400
Date: Fri, 18 Oct 2002 23:25:32 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: patch for linux/usb.h
Message-ID: <20021018212532.GE32609@net-m.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="JBi0ZxuS5uaEhkUZ"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.4.20-pre5 i586
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, finger me at johoho@212.83.62.165 or send an email with the subject 'public key request' to wodecki@gmx.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi there,

missing urb_t typedef

-- 
Regards,

Wiktor Wodecki      |    http://johoho.eggheads.org

--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=usb_patch

diff -bur linux/include/linux/usb.h linux-2.4.20-pre9.kirk/include/linux/usb.h
--- linux/include/linux/usb.h	2002-10-18 22:56:49.000000000 +0200
+++ linux-2.4.20-pre9.kirk/include/linux/usb.h	2002-10-18 23:15:35.000000000 +0200
@@ -525,7 +525,7 @@
 	usb_complete_t complete;	// pointer to completion routine
 	//
 	struct iso_packet_descriptor iso_frame_desc[0];
+} urb_t;
-};
 
 /**
  * FILL_CONTROL_URB - macro to help initialize a control urb

--JBi0ZxuS5uaEhkUZ--
