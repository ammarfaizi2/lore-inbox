Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbULVMn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbULVMn5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 07:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbULVMn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 07:43:57 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:4751 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id S261983AbULVMnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 07:43:42 -0500
X-Qmail-Scanner-Mail-From: solt2@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.23 (Clear:RC:0(213.238.96.94):. Processed in 0.117383 secs)
Message-ID: <018201c4e825$12f90480$0e25fe0a@pysiak>
From: "Maciej Soltysiak" <solt2@dns.toxicfilms.tv>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] Update IP_TCPDIAG Kconfig help
Date: Wed, 22 Dec 2004 13:51:51 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0165_01C4E82D.6376D100"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0165_01C4E82D.6376D100
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-2";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi!This patch adds some info to the ip_tcpdiag option.Best 
Regards,Maciejdiff -ru linux.orig/net/ipv4/Kconfig linux/net/ipv4/Kconfig
--- linux.orig/net/ipv4/Kconfig	2004-12-22 12:58:03.000000000 +0100
+++ linux/net/ipv4/Kconfig	2004-12-22 13:34:58.000000000 +0100
@@ -355,7 +355,11 @@
 	default y
 	---help---
 	  Support for TCP socket monitoring interface used by native Linux
-	  tools such as ss.
+	  tools such as ss. ss comes from iproute2.
+	  http://developer.osdl.org/dev/iproute2/
+
+	  If you wish to view IPv6 addresses (Local/Peer Address) with ss
+	  IPv6 support must be built into the kernel, not as a module.

 	  If unsure, say Y.


------=_NextPart_000_0165_01C4E82D.6376D100
Content-Type: application/octet-stream;
	name="Kconfig_ss.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="Kconfig_ss.diff"

diff -ru linux.orig/net/ipv4/Kconfig linux/net/ipv4/Kconfig=0A=
--- linux.orig/net/ipv4/Kconfig	2004-12-22 12:58:03.000000000 +0100=0A=
+++ linux/net/ipv4/Kconfig	2004-12-22 13:42:14.000000000 +0100=0A=
@@ -355,7 +355,11 @@=0A=
 	default y=0A=
 	---help---=0A=
 	  Support for TCP socket monitoring interface used by native Linux=0A=
-	  tools such as ss.=0A=
+	  tools such as ss. ss comes from iproute2.=0A=
+	  http://developer.osdl.org/dev/iproute2/=0A=
+	  =0A=
+	  If you wish to view IPv6 addresses (Local/Peer Address) with ss=0A=
+	  IPv6 support must be built into the kernel, not as a module.=0A=
 	  =0A=
 	  If unsure, say Y.=0A=
 =0A=

------=_NextPart_000_0165_01C4E82D.6376D100--

