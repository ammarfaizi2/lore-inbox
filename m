Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263328AbTDVSQA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 14:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTDVSOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 14:14:41 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:33800 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S263332AbTDVSOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 14:14:30 -0400
Date: Tue, 22 Apr 2003 11:04:34 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Remove duplicated inclusion in include/sound/mpu401.h
Message-ID: <20030422160434.GE7260@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Looks like the merge of this file went a little off. No need to include
the same header twice.

Art Haas

===== include/sound/mpu401.h 1.10 vs edited =====
--- 1.10/include/sound/mpu401.h	Mon Apr 21 12:36:31 2003
+++ edited/include/sound/mpu401.h	Tue Apr 22 10:05:09 2003
@@ -24,7 +24,6 @@
 
 #include <linux/interrupt.h>
 #include "rawmidi.h"
-#include <linux/interrupt.h>
 
 #define MPU401_HW_MPU401		1	/* native MPU401 */
 #define MPU401_HW_SB			2	/* SoundBlaster MPU-401 UART */
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
