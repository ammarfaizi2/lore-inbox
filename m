Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVADTOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVADTOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVADTOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:14:41 -0500
Received: from mail209.megamailservers.com ([216.251.41.29]:63930 "EHLO
	mail209.megamailservers.com") by vger.kernel.org with ESMTP
	id S261823AbVADTDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:03:39 -0500
X-Authenticated-User: jiri.gaisler.com
Message-ID: <41DAE8BB.7050501@gaisler.com>
Date: Tue, 04 Jan 2005 20:04:27 +0100
From: Jiri Gaisler <jiri@gaisler.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: sparclinux@vger.kernel.org
CC: linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: [5/7] LEON SPARC V8 processor support for linux-2.6.10
Content-Type: multipart/mixed;
 boundary="------------070905020909070305050406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070905020909070305050406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Leon3 serial+ethermac driver:

[5/7] diff2.6.10_arch_sparc_Kocnfig.diff  diff for arch/sparc/Kconfig

--------------070905020909070305050406
Content-Type: text/plain;
 name="diff2.6.10_arch_sparc_Kocnfig.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff2.6.10_arch_sparc_Kocnfig.diff"

--- ../linux-2.6.10-driver/arch/sparc/Kconfig	2005-01-03 18:03:49.000000000 +0100
+++ linux-2.6.10/arch/sparc/Kconfig	2005-01-03 18:01:44.000000000 +0100
@@ -239,12 +239,6 @@
 	  Say Y here if you are running on a Leon3 from grlib
 	  (download from www.gaisler.com). 
 
-if LEON_3
-
-source "drivers/amba/Kconfig"
-
-endif
-
 endif
 
           

--------------070905020909070305050406--
