Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263904AbTDGXax (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbTDGXag (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:30:36 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17025
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263739AbTDGXUX (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:20:23 -0400
Date: Tue, 8 Apr 2003 01:39:18 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080039.h380dIqv009294@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: more audiov ersion scrubbing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/ac97_codec.c linux-2.5.67-ac1/sound/oss/ac97_codec.c
--- linux-2.5.67/sound/oss/ac97_codec.c	2003-02-10 18:37:59.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/ac97_codec.c	2003-04-03 23:52:57.000000000 +0100
@@ -43,7 +43,6 @@
  *	Isolated from trident.c to support multiple ac97 codec
  */
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
