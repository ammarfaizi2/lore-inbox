Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbULTAxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbULTAxV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 19:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbULTAxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 19:53:21 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:61863 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S261365AbULTAxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 19:53:17 -0500
Date: Mon, 20 Dec 2004 01:52:54 +0100
To: akpm@osdl.org
Cc: rth@twiddle.net, rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch/alpha/Kconfig: Kill stale reference to Documentation/smp.tex
Message-ID: <20041220005254.GA13452@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This reference to the long gone Documentation/smp.tex somehow evaded Randy's
cleanup from circa March. This marks off the last of those stale references.

Against 2.6.9. Applies cleanly against 2.6.10-rc3. Thanks.

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>

 Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -uprN a/arch/alpha/Kconfig b/arch/alpha/Kconfig
--- a/arch/alpha/Kconfig	2004-12-19 10:40:37.000000000 +0100
+++ b/arch/alpha/Kconfig	2004-12-19 10:44:39.000000000 +0100
@@ -485,7 +485,7 @@ config SMP
 	  singleprocessor machines. On a singleprocessor machine, the kernel
 	  will run faster if you say N here.
 
-	  See also the <file:Documentation/smp.tex>, and the SMP-HOWTO
+	  See also the <file:Documentation/smp.txt>, and the SMP-HOWTO
 	  available at <http://www.tldp.org/docs.html#howto>.
 
 	  If you don't know what to do here, say N.
