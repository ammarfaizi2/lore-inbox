Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSD1KAh>; Sun, 28 Apr 2002 06:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSD1KAg>; Sun, 28 Apr 2002 06:00:36 -0400
Received: from nydalah028.sn.umu.se ([130.239.118.227]:33934 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S290289AbSD1KAg>; Sun, 28 Apr 2002 06:00:36 -0400
Message-ID: <011e01c1ee9b$9b5f2510$0201a8c0@homer>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.19-pre7 Sparc64 & PPC64 fails to compile due to wrong Bluetooth IOCTLs
Date: Sun, 28 Apr 2002 12:01:03 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch against 2.4.19-pre7

--- linux-2.4.19-pre7/arch/sparc64/kernel/ioctl32.c.org Sun Apr 28 02:00:28
2002
+++ linux-2.4.19-pre7/arch/sparc64/kernel/ioctl32.c     Sun Apr 28 12:04:57
2002
@@ -4550,8 +4550,8 @@
 COMPATIBLE_IOCTL(HCIDEVUP)
 COMPATIBLE_IOCTL(HCIDEVDOWN)
 COMPATIBLE_IOCTL(HCIDEVRESET)
-COMPATIBLE_IOCTL(HCIRESETSTAT)
-COMPATIBLE_IOCTL(HCIGETINFO)
+COMPATIBLE_IOCTL(HCIDEVRESTAT)
+COMPATIBLE_IOCTL(HCIGETDEVINFO)
 COMPATIBLE_IOCTL(HCIGETDEVLIST)
 COMPATIBLE_IOCTL(HCISETRAW)
 COMPATIBLE_IOCTL(HCISETSCAN)
--- linux-2.4.19-pre7/arch/ppc64/kernel/ioctl32.c.org   Sun Apr 28 12:02:08
2002
+++ linux-2.4.19-pre7/arch/ppc64/kernel/ioctl32.c       Sun Apr 28 12:05:23
2002
@@ -4159,8 +4159,8 @@
 COMPATIBLE_IOCTL(HCIDEVUP),
 COMPATIBLE_IOCTL(HCIDEVDOWN),
 COMPATIBLE_IOCTL(HCIDEVRESET),
-COMPATIBLE_IOCTL(HCIRESETSTAT),
-COMPATIBLE_IOCTL(HCIGETINFO),
+COMPATIBLE_IOCTL(HCIDEVRESTAT),
+COMPATIBLE_IOCTL(HCIGETDEVINFO),
 COMPATIBLE_IOCTL(HCIGETDEVLIST),
 COMPATIBLE_IOCTL(HCISETRAW),
 COMPATIBLE_IOCTL(HCISETSCAN),


