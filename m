Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWAOQin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWAOQin (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 11:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWAOQin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 11:38:43 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:49329 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750835AbWAOQim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 11:38:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=LHqf9knfkQs35D8fjj0J+2m8s3AwIRS+UtqjUAnViQjIj9rW2WflIfn9HTPpWYWsKW39DjJslwtZtF7ekRlw2yxHbNJ69XnkH3gqjLIRbTbnFAqBK4vFfNClibRqf7B2K39qSS5WhQTI5bLl3uq/Pw+xORvw3oK303fm+Fwlq2Q=
Message-ID: <fb249edb0601150838o26251525s@mail.gmail.com>
Date: Sun, 15 Jan 2006 17:38:41 +0100
From: andrzej zaborowski <balrogg@gmail.com>
To: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] Simple typos
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_16788_24853857.1137343121867"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_16788_24853857.1137343121867
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
This corrects some trivial errors in ARM docs and comments,
I first posted to linux-omap list and was told to rather post here.
Regards,
Andrzej Zaborowski
--
balrog 2oo6

Dear Outlook users: Please remove me from your address books
http://www.newsforge.com/article.pl?sid=3D03/08/21/143258

------=_Part_16788_24853857.1137343121867
Content-Type: application/octet-stream; name=linux-typos.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-typos.patch"

diff -Naur linux-omap-2.6.orig/Documentation/arm/Booting linux-omap-2.6/Documentation/arm/Booting
--- linux-omap-2.6.orig/Documentation/arm/Booting	2006-01-14 14:58:51.000000000 +0000
+++ linux-omap-2.6/Documentation/arm/Booting	2006-01-14 15:56:12.000000000 +0000
@@ -118,7 +118,7 @@
 
 In either case, the following conditions must be met:
 
-- Quiesce all DMA capable devicess so that memory does not get
+- Quiesce all DMA capable devices so that memory does not get
   corrupted by bogus network packets or disk data. This will save
   you many hours of debug.
 
diff -Naur linux-omap-2.6.orig/Documentation/arm/README linux-omap-2.6/Documentation/arm/README
--- linux-omap-2.6.orig/Documentation/arm/README	2006-01-14 14:58:51.000000000 +0000
+++ linux-omap-2.6/Documentation/arm/README	2006-01-14 15:56:12.000000000 +0000
@@ -89,7 +89,7 @@
   Although modularisation is supported (and required for the FP emulator),
   each module on an ARM2/ARM250/ARM3 machine when is loaded will take
   memory up to the next 32k boundary due to the size of the pages.
-  Therefore, modularisation on these machines really worth it?
+  Therefore, is modularisation on these machines really worth it?
 
   However, ARM6 and up machines allow modules to take multiples of 4k, and
   as such Acorn RiscPCs and other architectures using these processors can
diff -Naur linux-omap-2.6.orig/Documentation/arm/Setup linux-omap-2.6/Documentation/arm/Setup
--- linux-omap-2.6.orig/Documentation/arm/Setup	2006-01-14 14:58:51.000000000 +0000
+++ linux-omap-2.6/Documentation/arm/Setup	2006-01-14 15:56:12.000000000 +0000
@@ -58,7 +58,7 @@
  video_y
 
    This describes the character position of cursor on VGA console, and
-   is otherwise unused. (should not used for other console types, and
+   is otherwise unused. (should not be used for other console types, and
    should not be used for other purposes).
 
  memc_control_reg
diff -Naur linux-omap-2.6.orig/include/linux/timer.h linux-omap-2.6/include/linux/timer.h
--- linux-omap-2.6.orig/include/linux/timer.h	2006-01-14 15:00:00.000000000 +0000
+++ linux-omap-2.6/include/linux/timer.h	2006-01-14 15:56:12.000000000 +0000
@@ -69,13 +69,13 @@
  * @timer: the timer to be added
  *
  * The kernel will do a ->function(->data) callback from the
- * timer interrupt at the ->expired point in the future. The
+ * timer interrupt at the ->expires point in the future. The
  * current time is 'jiffies'.
  *
- * The timer's ->expired, ->function (and if the handler uses it, ->data)
+ * The timer's ->expires, ->function (and if the handler uses it, ->data)
  * fields must be set prior calling this function.
  *
- * Timers with an ->expired field in the past will be executed in the next
+ * Timers with an ->expires field in the past will be executed in the next
  * timer tick.
  */
 static inline void add_timer(struct timer_list *timer)



------=_Part_16788_24853857.1137343121867--
