Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTGRPCp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270085AbTGROyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:54:14 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:33925
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S266555AbTGROOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:14:04 -0400
Date: Fri, 18 Jul 2003 15:28:24 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181428.h6IESOtS017844@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix unused symbol in ad1889
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Francois Romieu)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/sound/oss/ad1889.c linux-2.6.0-test1-ac2/sound/oss/ad1889.c
--- linux-2.6.0-test1/sound/oss/ad1889.c	2003-07-14 14:11:57.000000000 +0100
+++ linux-2.6.0-test1-ac2/sound/oss/ad1889.c	2003-07-14 14:48:51.000000000 +0100
@@ -245,7 +245,6 @@
 		dmabuf->ready = 0;
 		dmabuf->rate = 44100;
 	}
-out:
 	return dev;
 
 err_free_dmabuf:
