Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272101AbRH2WM1>; Wed, 29 Aug 2001 18:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272104AbRH2WMR>; Wed, 29 Aug 2001 18:12:17 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:34096 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S272101AbRH2WMC>; Wed, 29 Aug 2001 18:12:02 -0400
Date: Wed, 29 Aug 2001 23:00:33 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] fs/ntfs/unistr.c wont compile in 2.4.9
Message-ID: <Pine.LNX.3.96.1010829225754.23969A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In case you haven't already fixed it in a pre- kernel.. min() is
unrecognized without linux/kernel.h included here.

--- unistr.c~   Thu Aug 30 23:48:34 2001
+++ unistr.c    Thu Aug 30 23:58:39 2001
@@ -22,6 +22,7 @@
  */
 
 #include <linux/string.h>
+#include <linux/kernel.h>
 #include <asm/byteorder.h>
 
 #include "unistr.h"


