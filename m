Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVE1XVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVE1XVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 19:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVE1XUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 19:20:23 -0400
Received: from coderock.org ([193.77.147.115]:50310 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261204AbVE1XSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 19:18:15 -0400
Message-Id: <20050528231738.769299000@nd47.coderock.org>
Date: Sun, 29 May 2005 01:17:40 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@nuerscht.ch>,
       domen@coderock.org
Subject: [patch 6/7] Remove duplicate file in Documentation/networking (00-INDEX)
Content-Disposition: inline; filename=delete-Documentation_networking_wanpipe.txt_00-INDEX
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Klauser <tklauser@nuerscht.ch>


wanpipe.txt and wan-router.txt in Documentation/networking
contain the exact same information (diff between the two shows no
difference). This patch removes the reference to this document in
Documentation/networking/00-INDEX as pointed out by Randy Dunlap.

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 00-INDEX |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

Index: quilt/Documentation/networking/00-INDEX
===================================================================
--- quilt.orig/Documentation/networking/00-INDEX
+++ quilt/Documentation/networking/00-INDEX
@@ -114,9 +114,7 @@ tuntap.txt
 vortex.txt
 	- info on using 3Com Vortex (3c590, 3c592, 3c595, 3c597) Ethernet cards.
 wan-router.txt
-	- Wan router documentation
-wanpipe.txt
-	- WANPIPE(tm) Multiprotocol WAN Driver for Linux WAN Router
+	- WAN router documentation
 wavelan.txt
 	- AT&T GIS (nee NCR) WaveLAN card: An Ethernet-like radio transceiver
 x25.txt

--
