Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbTFEUzV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbTFEUyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:54:09 -0400
Received: from mail.uptime.at ([62.116.87.11]:51352 "EHLO mail.uptime.at")
	by vger.kernel.org with ESMTP id S265161AbTFEUxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:53:37 -0400
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: FW: Linux 2.4.20
Date: Thu, 5 Jun 2003 23:06:48 +0200
Organization: UPtime system solutions
Message-ID: <000301c32ba6$6135ff00$1311a8c0@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0004_01C32BB7.24BECF00"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-MailScanner-Information: Please contact UPtime Systemloesungen for more information
X-MailScanner: clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-3.5, required 4.1,
	BAYES_20 -2.60, EMAIL_ATTRIBUTION -0.50, QUOTED_EMAIL_TEXT -0.38)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0004_01C32BB7.24BECF00
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi folks!

Andreas de Pretis wrote:
> das Documentation/DocBook/journal-api.tmpl hat nen Bug (mach 
> mal ein 'make htmldocs') ... Patch ist anbei.

As German understading people can read above, Mr. Andreas de Pretis, sent me
this patch to forward it to the lkml. The problem seems to be, that he was not
able to do a 'make htmldocs', because of some (wrong) SGML tags in
journal-api.tmpl.

Please have a look at it, patch is attached (simple, but working. :-) ).

Best regards,
 Oliver

------=_NextPart_000_0004_01C32BB7.24BECF00
Content-Type: application/octet-stream;
	name="linux-2.4.20-journal-api-sgml.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux-2.4.20-journal-api-sgml.patch"

--- Documentation/DocBook/journal-api.tmpl.orig	Thu Jun  5 22:04:31 2003=0A=
+++ Documentation/DocBook/journal-api.tmpl	Thu Jun  5 22:04:35 2003=0A=
@@ -208,7 +208,7 @@=0A=
 if you allow unprivileged userspace to trigger codepaths containing =
these=0A=
 calls.=0A=
 =0A=
-<para>=0A=
+</para>=0A=
 </sect1>=0A=
 <sect1>=0A=
 <title>Summary</title>=0A=
@@ -244,7 +244,8 @@=0A=
    }=0A=
    journal_destroy(my_jrnl);=0A=
 </programlisting>=0A=
-=0A=
+</para>=0A=
+</sect1>=0A=
 </chapter>=0A=
 =0A=
   <chapter id=3D"adt">=0A=

------=_NextPart_000_0004_01C32BB7.24BECF00--

