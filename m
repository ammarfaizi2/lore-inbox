Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261301AbSKGPxM>; Thu, 7 Nov 2002 10:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261317AbSKGPxM>; Thu, 7 Nov 2002 10:53:12 -0500
Received: from c2bapps5.btconnect.com ([193.113.209.26]:14987 "HELO
	c2bapps5.btconnect.com") by vger.kernel.org with SMTP
	id <S261301AbSKGPxK>; Thu, 7 Nov 2002 10:53:10 -0500
Subject: [patch] Documentation/DocBook/journal-api.sgml
From: Andy Wallace <andyw2@btconnect.com>
To: rgammans@computer-surgery.co.uk, sct@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-As+AUut6GaTdgHKmiDdG"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Nov 2002 16:01:08 +0000
Message-Id: <1036684868.2032.76.camel@pavilion>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1-pre3 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-As+AUut6GaTdgHKmiDdG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

make psdocs failed to compile journal-api.sgml for me with a couple of
errors on 2.5.46.

The attached patch fixes these errors and allows it to compile
successfully.

Cheers,

Andy Wallace





--=-As+AUut6GaTdgHKmiDdG
Content-Disposition: attachment; filename=psdocs.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=psdocs.patch; charset=ISO-8859-15

--- journal-api.old.sgml	Thu Nov  7 15:16:36 2002
+++ journal-api.sgml	Thu Nov  7 15:14:12 2002
@@ -208,7 +208,7 @@
 if you allow unprivileged userspace to trigger codepaths containing these
 calls.
=20
-<para>
+</para>
 </sect1>
 <sect1>
 <title>Summary</title>
@@ -244,7 +244,8 @@
    }
    journal_destroy(my_jrnl);
 </programlisting>
-
+</para>
+</sect1>
 </chapter>
=20
   <chapter id=3D"adt">

--=-As+AUut6GaTdgHKmiDdG--

