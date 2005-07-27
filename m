Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVG0PU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVG0PU6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVG0PU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:20:57 -0400
Received: from main.gmane.org ([80.91.229.2]:35496 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261209AbVG0PU4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:20:56 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Hans-Juergen Tappe (SYSGO AG)" <hjt@sysgo.com>
Subject: [PATCH] 2.6 net/ipv4 Kconfig syntax fix
Date: Wed, 27 Jul 2005 17:10:08 +0200
Message-ID: <42E7A3D0.8050907@sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Complaints-To: usenet@sea.gmane.org
Cc: akpm@osdl.org, torvalds@osdl.org
X-Gmane-NNTP-Posting-Host: 62.8.134.2
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: de, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a small patch to fix an LKC syntax error.

Yours,
Hans-Juergen



--- linux/net/ipv4/Kconfig.orig	2005-06-17 21:48:29.000000000 +0200
+++ linux/net/ipv4/Kconfig	2005-07-27 16:29:56.215398144 +0200
@@ -92,7 +92,7 @@

 config IP_ROUTE_MULTIPATH_CACHED
 	bool "IP: equal cost multipath with caching support (EXPERIMENTAL)"
-	depends on: IP_ROUTE_MULTIPATH
+	depends on IP_ROUTE_MULTIPATH
 	help
 	  Normally, equal cost multipath routing is not supported by the
 	  routing cache. If you say Y here, alternative routes are cached



-- 
Hans-Jürgen Tappe
SYSGO AG
Am Pfaffenstein 14
D-55270 Klein-Winternheim
Germany
Phone: +49-61 36-99 48-0
Fax:   +49-61 36-99 48-10
hjtappe@sysgo.com
www.sysgo.com
www.elinos.com


