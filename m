Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTICNgW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 09:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbTICNgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 09:36:22 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:29902 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S262188AbTICNgK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 09:36:10 -0400
Message-ID: <3F55EEA2.9030605@terra.com.br>
Date: Wed, 03 Sep 2003 10:37:38 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] kill unneeded versio.h include
Content-Type: multipart/mixed;
 boundary="------------020409020407090208090608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020409020407090208090608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi,

	Patch against 2.6-test4.

	Based on Randy's checkversion.pl script.

	Please consider applying.

	Cheers,

Felipe

--------------020409020407090208090608
Content-Type: text/plain;
 name="sound-checkversion.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sound-checkversion.patch"

diff -ur -X ./dontdiff linux-2.6.0-test4/sound/core/memalloc.c linux-2.6.0-test4-fwd/sound/core/memalloc.c
--- linux-2.6.0-test4/sound/core/memalloc.c	Fri Aug 22 21:01:48 2003
+++ linux-2.6.0-test4-fwd/sound/core/memalloc.c	Wed Sep  3 10:09:47 2003
@@ -22,7 +22,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
diff -ur -X ./dontdiff linux-2.6.0-test4/sound/core/oss/pcm_oss.c linux-2.6.0-test4-fwd/sound/core/oss/pcm_oss.c
--- linux-2.6.0-test4/sound/core/oss/pcm_oss.c	Fri Aug 22 20:58:59 2003
+++ linux-2.6.0-test4-fwd/sound/core/oss/pcm_oss.c	Wed Sep  3 10:09:07 2003
@@ -27,7 +27,6 @@
 #endif
 
 #include <sound/driver.h>
-#include <linux/version.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/time.h>
diff -ur -X ./dontdiff linux-2.6.0-test4/sound/core/pcm_native.c linux-2.6.0-test4-fwd/sound/core/pcm_native.c
--- linux-2.6.0-test4/sound/core/pcm_native.c	Fri Aug 22 20:54:17 2003
+++ linux-2.6.0-test4-fwd/sound/core/pcm_native.c	Wed Sep  3 10:09:20 2003
@@ -20,7 +20,6 @@
  */
 
 #include <sound/driver.h>
-#include <linux/version.h>
 #include <linux/mm.h>
 #include <linux/file.h>
 #include <linux/slab.h>
diff -ur -X ./dontdiff linux-2.6.0-test4/sound/core/sound.c linux-2.6.0-test4-fwd/sound/core/sound.c
--- linux-2.6.0-test4/sound/core/sound.c	Fri Aug 22 20:57:49 2003
+++ linux-2.6.0-test4-fwd/sound/core/sound.c	Wed Sep  3 10:09:29 2003
@@ -20,7 +20,6 @@
  */
 
 #include <sound/driver.h>
-#include <linux/version.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/time.h>
diff -ur -X ./dontdiff linux-2.6.0-test4/sound/drivers/dummy.c linux-2.6.0-test4-fwd/sound/drivers/dummy.c
--- linux-2.6.0-test4/sound/drivers/dummy.c	Fri Aug 22 20:59:42 2003
+++ linux-2.6.0-test4-fwd/sound/drivers/dummy.c	Wed Sep  3 10:09:57 2003
@@ -19,7 +19,6 @@
  */
 
 #include <sound/driver.h>
-#include <linux/version.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/slab.h>
diff -ur -X ./dontdiff linux-2.6.0-test4/sound/oss/ac97_codec.c linux-2.6.0-test4-fwd/sound/oss/ac97_codec.c
--- linux-2.6.0-test4/sound/oss/ac97_codec.c	Fri Aug 22 20:52:22 2003
+++ linux-2.6.0-test4-fwd/sound/oss/ac97_codec.c	Wed Sep  3 10:07:58 2003
@@ -46,7 +46,6 @@
  *	Isolated from trident.c to support multiple ac97 codec
  */
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/string.h>
diff -ur -X ./dontdiff linux-2.6.0-test4/sound/oss/ali5455.c linux-2.6.0-test4-fwd/sound/oss/ali5455.c
--- linux-2.6.0-test4/sound/oss/ali5455.c	Fri Aug 22 20:58:43 2003
+++ linux-2.6.0-test4-fwd/sound/oss/ali5455.c	Wed Sep  3 10:08:45 2003
@@ -47,7 +47,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/ioport.h>
diff -ur -X ./dontdiff linux-2.6.0-test4/sound/oss/au1000.c linux-2.6.0-test4-fwd/sound/oss/au1000.c
--- linux-2.6.0-test4/sound/oss/au1000.c	Fri Aug 22 20:57:21 2003
+++ linux-2.6.0-test4-fwd/sound/oss/au1000.c	Wed Sep  3 10:08:27 2003
@@ -50,7 +50,6 @@
  *                channels [stevel].
  *
  */
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
diff -ur -X ./dontdiff linux-2.6.0-test4/sound/oss/ite8172.c linux-2.6.0-test4-fwd/sound/oss/ite8172.c
--- linux-2.6.0-test4/sound/oss/ite8172.c	Fri Aug 22 20:53:03 2003
+++ linux-2.6.0-test4-fwd/sound/oss/ite8172.c	Wed Sep  3 10:08:35 2003
@@ -54,7 +54,6 @@
  *    07.30.2003  Removed initialisation to zero for static variables
  *		   (spdif[NR_DEVICE], i2s_fmt[NR_DEVICE], and devindex)
  */
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
diff -ur -X ./dontdiff linux-2.6.0-test4/sound/oss/swarm_cs4297a.c linux-2.6.0-test4-fwd/sound/oss/swarm_cs4297a.c
--- linux-2.6.0-test4/sound/oss/swarm_cs4297a.c	Fri Aug 22 20:56:28 2003
+++ linux-2.6.0-test4-fwd/sound/oss/swarm_cs4297a.c	Wed Sep  3 10:08:12 2003
@@ -59,7 +59,6 @@
 *******************************************************************************/
 
 #include <linux/list.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/ioport.h>

--------------020409020407090208090608--

