Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVFGCmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVFGCmp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 22:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVFGCmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 22:42:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54423 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261469AbVFGCmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 22:42:20 -0400
Date: Mon, 6 Jun 2005 22:41:59 -0400
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rcX] make hgafb depend on ISA
Message-ID: <20050607024159.GA21323@nostromo.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Saw it pop up as an option on x86_64, which just seemed wrong.
AFAIK, all of these are 8-bit ISA cards.

Comment about obsolescence updated while I was there; it appears
to date from 2000.

Bill

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hercules.patch"

--- linux-2.6.11/drivers/video/Kconfig.foo	2005-06-06 22:36:07.000000000 -0400
+++ linux-2.6.11/drivers/video/Kconfig	2005-06-06 22:37:10.000000000 -0400
@@ -496,7 +496,7 @@
 
 config FB_HGA
 	tristate "Hercules mono graphics support"
-	depends on FB && X86
+	depends on FB && X86 && ISA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -507,7 +507,7 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called hgafb.
 
-	  As this card technology is 15 years old, most people will answer N
+	  As this card technology is 20 years old, most people will answer N
 	  here.
 
 config FB_HGA_ACCEL

--17pEHd4RhPHOinZp--
