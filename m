Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTESOql (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 10:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbTESOql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 10:46:41 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:5509 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262482AbTESOqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 10:46:40 -0400
To: <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 2.4, 2.5 trivial doc correction
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 18 May 2003 18:42:50 +0200
Message-ID: <m3llx4435h.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

The following patch corrects sethdlc examples in Documentation/networking/
generic-hdlc.txt. Please apply to 2.4 and 2.5 kernel. Thanks.
-- 
Krzysztof Halasa
Network Administrator

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=hdlc-1.14-doc.patch

--- linux-2.4.orig/Documentation/networking/generic-hdlc.txt	2003-04-30 18:13:09.000000000 +0200
+++ linux-2.4/Documentation/networking/generic-hdlc.txt	2003-05-17 23:01:32.000000000 +0200
@@ -32,8 +38,10 @@
 	sethdlc hdlc0 cisco interval 10 timeout 25
 or
 	sethdlc hdlc0 rs232 clock ext
-	sethdlc fr lmi ansi
-	sethdlc create 99
+	sethdlc hdlc0 fr lmi ansi
+	sethdlc hdlc0 create 99
+	ifconfig hdlc0 up
+	ifconfig pvc0 localIP pointopoint remoteIP
 
 In Frame Relay mode, ifconfig master hdlc device up (without assigning
 any IP address to it) before using pvc devices.

--=-=-=--
