Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSEYNDo>; Sat, 25 May 2002 09:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSEYNDn>; Sat, 25 May 2002 09:03:43 -0400
Received: from smtp04.wxs.nl ([195.121.6.59]:45766 "EHLO smtp04.wxs.nl")
	by vger.kernel.org with ESMTP id <S314546AbSEYNDm>;
	Sat, 25 May 2002 09:03:42 -0400
Message-ID: <3CEF8815.C7C13D39@wxs.nl>
Date: Sat, 25 May 2002 14:48:21 +0200
From: Gert Vervoort <Gert.Vervoort@wxs.nl>
Organization: Planet Internet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.18 ide-scsi compile fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- ide-scsi.c.1	Sat May 25 14:21:28 2002
+++ ide-scsi.c	Sat May 25 14:21:37 2002
@@ -804,7 +804,7 @@
 };
 
 
-static int __init idescsi_init(void)
+int __init idescsi_init(void)
 {
 	int ret;
 	ret = ata_driver_module(&idescsi_driver);
