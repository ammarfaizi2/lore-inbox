Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbUBTUSR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 15:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbUBTUO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 15:14:58 -0500
Received: from tantale.fifi.org ([216.27.190.146]:22151 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S261329AbUBTUJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 15:09:57 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Clean-up after ieee1364
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 20 Feb 2004 12:09:52 -0800
Message-ID: <87n07d3433.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

That should be trivial enough to get into 2.4.26.

Phil.

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=linux-2.4.25-ieee1394-clean.patch

diff -ruN linux-2.4.25.orig/Makefile linux-2.4.25/Makefile
--- linux-2.4.25.orig/Makefile	Wed Feb 18 05:36:32 2004
+++ linux-2.4.25/Makefile	Wed Feb 18 13:34:25 2004
@@ -221,6 +221,7 @@
 	drivers/scsi/aic7xxx/aicasm/y.tab.h \
 	drivers/scsi/53c700_d.h \
 	drivers/tc/lk201-map.c \
+	drivers/ieee1394/oui.c \
 	net/khttpd/make_times_h \
 	net/khttpd/times.h \
 	submenu*

--=-=-=--
