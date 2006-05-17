Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWEQRaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWEQRaM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 13:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWEQRaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 13:30:12 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27333 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750776AbWEQRaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 13:30:11 -0400
Subject: PATCH: Clarify maintainers and include security info (Version 2)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20060516090315.421e5166.rdunlap@xenotime.net>
References: <1147795421.2151.80.camel@localhost.localdomain>
	 <20060516090315.421e5166.rdunlap@xenotime.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 17 May 2006 18:43:07 +0100
Message-Id: <1147887787.10470.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This version has the advanced new feature of including the correct email
address (duh sorry), and also another hint about the Signed-off-by:
bits. It goes on top of the original patch. Below this is a second diff
if the first wrong change was not applied.


Signed-off-by: Alan Cox <alan@redhat.com) (or is that Screwed-up-by: ..)


--- linux-2.6.17-rc4/MAINTAINERS~	2006-05-17 13:06:37.922464048 +0100
+++ linux-2.6.17-rc4/MAINTAINERS	2006-05-17 13:06:37.923463896 +0100
@@ -40,12 +40,17 @@
 	PLEASE document known bugs. If it doesn't work for everything
 	or does something very odd once a month document it.
 
+	PLEASE remember that submissions must be made under the terms
+	of the OSDL certificate of contribution
+	(http://www.osdl.org/newsroom/press_releases/2004/2004_05_24_dco.html)
+	and should include a Signed-off-by: line.
+
 6.	Make sure you have the right to send any changes you make. If you
 	do changes at work you may find your employer owns the patch
 	not you.
 
 7.	When sending security related changes or reports to a maintainer
-	please Cc: linux-security@kernel.org, especially if the maintainer
+	please Cc: security@kernel.org, especially if the maintainer
 	does not respond.
 
 8.	Happy hacking.



or alternatively:

--- linux.vanilla-2.6.17-rc4/MAINTAINERS	2006-05-15 15:46:01.000000000 +0100
+++ linux-2.6.17-rc4/MAINTAINERS	2006-05-17 13:06:37.923463896 +0100
@@ -40,11 +40,20 @@
 	PLEASE document known bugs. If it doesn't work for everything
 	or does something very odd once a month document it.
 
+	PLEASE remember that submissions must be made under the terms
+	of the OSDL certificate of contribution
+	(http://www.osdl.org/newsroom/press_releases/2004/2004_05_24_dco.html)
+	and should include a Signed-off-by: line.
+
 6.	Make sure you have the right to send any changes you make. If you
 	do changes at work you may find your employer owns the patch
 	not you.
 
-7.	Happy hacking.
+7.	When sending security related changes or reports to a maintainer
+	please Cc: security@kernel.org, especially if the maintainer
+	does not respond.
+
+8.	Happy hacking.
 
  		-----------------------------------
 

