Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVDFLrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVDFLrG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 07:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVDFLrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 07:47:06 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:61119 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262170AbVDFLrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 07:47:02 -0400
Message-Id: <20050406114653.567384000@faui31y>
References: <20050406114610.287064000@faui31y>
Date: Wed, 06 Apr 2005 13:46:12 +0200
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2/6] DocBook: fix <void/> xml tag
Content-Disposition: inline; filename=docbook-fix-xml-void.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: fix <void/> xml tag

This fix is needed to create valid XML.

Signed-off-by: Martin Waitz <tali@admingilde.org>

 scripts/kernel-doc |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-docbook/scripts/kernel-doc
===================================================================
--- linux-docbook.orig/scripts/kernel-doc	2005-04-06 12:24:11.970110331 +0200
+++ linux-docbook/scripts/kernel-doc	2005-04-06 12:25:14.115702254 +0200
@@ -607,7 +607,7 @@ sub output_function_xml(%) {
 	    }
 	}
     } else {
-	print "  <void>\n";
+	print "  <void/>\n";
     }
     print "  </funcprototype></funcsynopsis>\n";
     print "</refsynopsisdiv>\n";

--
Martin Waitz
