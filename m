Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270621AbTGNMhT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270578AbTGNMg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:36:56 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:52868
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270584AbTGNMTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:19:41 -0400
Date: Mon, 14 Jul 2003 13:33:41 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141233.h6ECXfDN030980@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: fix agpgart list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/include/linux/agp_backend.h linux.22-pre5-ac1/include/linux/agp_backend.h
--- linux.22-pre5/include/linux/agp_backend.h	2003-07-14 12:27:43.000000000 +0100
+++ linux.22-pre5-ac1/include/linux/agp_backend.h	2003-07-14 13:05:58.000000000 +0100
@@ -66,6 +66,7 @@
 	VIA_APOLLO_KM266,
 	VIA_APOLLO_KT400,
 	VIA_APOLLO_P4M266,
+	VIA_APOLLO_P4X400,
 	SIS_GENERIC,
 	AMD_GENERIC,
 	AMD_IRONGATE,
