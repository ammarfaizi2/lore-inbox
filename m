Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292944AbSBZBhD>; Mon, 25 Feb 2002 20:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292631AbSBZBgx>; Mon, 25 Feb 2002 20:36:53 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:35458 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S293342AbSBZBgs>;
	Mon, 25 Feb 2002 20:36:48 -0500
Date: Mon, 25 Feb 2002 20:36:50 -0500
From: Michael Cohen <me@ohdarn.net>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: Submissions for 2.4.19-pre [Rage128 Device ID]
Message-Id: <20020225203650.740f01d9.me@ohdarn.net>
Organization: OhDarn.net
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first of several mails containing patches to be included in 2.4.19.  Some are worthy of dicussion prior to inclusion and have been marked as such.  The majority of these patches were found on lkml; the remaining ones have URLs listed.

------
Michael Cohen
OhDarn.net

diff -Nru linux-2.4.19-pre1/drivers/video/aty128fb.c linux-patched/drivers/video/aty128fb.c
--- linux-2.4.19-pre1/drivers/video/aty128fb.c	Mon Feb 25 14:38:07 2002
+++ linux-patched/drivers/video/aty128fb.c	Mon Feb 25 20:18:20 2002
@@ -164,6 +164,7 @@
     {"Rage128 Pro PF (AGP)", PCI_DEVICE_ID_ATI_RAGE128_PF, rage_128_pro},
     {"Rage128 Pro PR (PCI)", PCI_DEVICE_ID_ATI_RAGE128_PR, rage_128_pro},
     {"Rage128 Pro TR (AGP)", PCI_DEVICE_ID_ATI_RAGE128_U3, rage_128_pro},
+    {"Rage128 Pro TF (AGP)", PCI_DEVICE_ID_ATI_RAGE128_U1, rage_128_pro},
     {"Rage Mobility M3 (PCI)", PCI_DEVICE_ID_ATI_RAGE128_LE, rage_M3},
     {"Rage Mobility M3 (AGP)", PCI_DEVICE_ID_ATI_RAGE128_LF, rage_M3},
     {NULL, 0, rage_128}
