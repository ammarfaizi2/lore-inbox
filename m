Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbULVMIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbULVMIm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 07:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbULVMIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 07:08:41 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:52110 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261973AbULVMHE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 07:07:04 -0500
X-Qmail-Scanner-Mail-From: solt2@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.23 (Clear:RC:0(213.238.96.94):. Processed in 0.133797 secs)
Message-ID: <012f01c4e81f$f4bddbd0$0e25fe0a@pysiak>
From: "Maciej Soltysiak" <solt2@dns.toxicfilms.tv>
To: <linux-kernel@vger.kernel.org>
References: <00be01c4e819$aca09cd0$0e25fe0a@pysiak> <41C95B88.1070409@trash.net>
Subject: Re: what/where is ss tool ?
Date: Wed, 22 Dec 2004 13:15:14 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_012C_01C4E828.4616ED20"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_012C_01C4E828.4616ED20
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit

Thanks Patrick!

Maybe we could add a line to the help so people, like me, that were
not aware that ss exists.
AFAICS ss appeared not so long ago, I think many distributions are
still using versions that do not have ss.
Or I may be wrong.

Regards,
Maciej
diff -ru linux.orig/net/ipv4/Kconfig linux/net/ipv4/Kconfig
--- linux.orig/net/ipv4/Kconfig	2004-12-22 12:58:03.000000000 +0100
+++ linux/net/ipv4/Kconfig	2004-12-22 13:00:36.000000000 +0100
@@ -355,7 +355,8 @@
 	default y
 	---help---
 	  Support for TCP socket monitoring interface used by native Linux
-	  tools such as ss.
+	  tools such as ss. ss comes from iproute2.
+	  http://developer.osdl.org/dev/iproute2/
 	  
 	  If unsure, say Y.
 

------=_NextPart_000_012C_01C4E828.4616ED20
Content-Type: application/octet-stream;
	name="Kconfig_ss.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="Kconfig_ss.diff"

diff -ru linux.orig/net/ipv4/Kconfig linux/net/ipv4/Kconfig=0A=
--- linux.orig/net/ipv4/Kconfig	2004-12-22 12:58:03.000000000 +0100=0A=
+++ linux/net/ipv4/Kconfig	2004-12-22 13:00:36.000000000 +0100=0A=
@@ -355,7 +355,8 @@=0A=
 	default y=0A=
 	---help---=0A=
 	  Support for TCP socket monitoring interface used by native Linux=0A=
-	  tools such as ss.=0A=
+	  tools such as ss. ss comes from iproute2.=0A=
+	  http://developer.osdl.org/dev/iproute2/=0A=
 	  =0A=
 	  If unsure, say Y.=0A=
 =0A=

------=_NextPart_000_012C_01C4E828.4616ED20--

