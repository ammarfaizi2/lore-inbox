Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274032AbRISLD6>; Wed, 19 Sep 2001 07:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274029AbRISLDt>; Wed, 19 Sep 2001 07:03:49 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:11276 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S274031AbRISLDn>;
	Wed, 19 Sep 2001 07:03:43 -0400
Date: Wed, 19 Sep 2001 13:03:06 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 2.4.10-pre12] sonypi driver merge error
Message-ID: <20010919130306.E27091@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While merging the sonypi driver from the -ac tree, the
following patch was not included, making impossible to
compile this driver.

Linus, please apply.

Stelian.

--- linux-2.4.10-pre12.orig/include/linux/sonypi.h	Wed Jul  4 23:41:33 2001
+++ linux-2.4.10-pre12/include/linux/sonypi.h	Wed Sep 19 12:33:27 2001
@@ -67,6 +67,10 @@
 #define SONYPI_EVENT_FNKEY_S			29
 #define SONYPI_EVENT_FNKEY_B			30
 #define SONYPI_EVENT_BLUETOOTH_PRESSED		31
+#define SONYPI_EVENT_PKEY_P1                    32
+#define SONYPI_EVENT_PKEY_P2                    33
+#define SONYPI_EVENT_PKEY_P3                    34
+
 
 /* brightness etc. ioctls */
 #define SONYPI_IOCGBRT	_IOR('v', 0, __u8)


-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
