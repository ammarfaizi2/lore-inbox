Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262025AbSJJMeR>; Thu, 10 Oct 2002 08:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262318AbSJJMeR>; Thu, 10 Oct 2002 08:34:17 -0400
Received: from ifaedi.insa-lyon.fr ([134.214.104.16]:33687 "EHLO
	ifaedi.insa-lyon.fr") by vger.kernel.org with ESMTP
	id <S262025AbSJJMeQ>; Thu, 10 Oct 2002 08:34:16 -0400
Subject: Small Patch for docbook documentation typo
From: Joaquim Fellmann <mljf@altern.org>
Reply-To: mljf@altern.org
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-M6OMmEpBIcF37pOimJ44"
Organization: 
Message-Id: <1034253606.676.24.camel@I401.resi.insa-lyon.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 10 Oct 2002 14:40:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-M6OMmEpBIcF37pOimJ44
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Here's a small patch that fixes the scsidrivers.templ typo.
It seems that using underscore char in id="" fields prevent from
compiling the docs.

Against current 2.5 bk tree

Regards



-- 
Joaquim Fellmann <mljf@altern.org>

--=-M6OMmEpBIcF37pOimJ44
Content-Description: 
Content-Disposition: inline; filename=patch-docbook-documentation.diff
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux/Documentation/DocBook/scsidrivers.tmpl.orig	2002-10-10 14:34:51.000000000 +0200
+++ linux/Documentation/DocBook/scsidrivers.tmpl	2002-10-10 14:35:45.000000000 +0200
@@ -60,7 +60,7 @@
 </para>
   </chapter>
 
-  <chapter id="driver_struct">
+  <chapter id="driver-struct">
       <title>Driver structure</title>
   <para>
 Traditionally a lower level driver for the scsi subsystem has been

--=-M6OMmEpBIcF37pOimJ44--

