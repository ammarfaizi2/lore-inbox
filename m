Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVAJSoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVAJSoY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVAJSoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:44:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3079 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262425AbVAJSnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:43:14 -0500
Date: Mon, 10 Jan 2005 19:43:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove SPF-using wbsd lists from MAINTAINERS
Message-ID: <20050110184307.GB2903@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<--  snip  -->

<wbsd-devel@list.drzeus.cx>:
Connected to 213.115.189.212 but sender was rejected.
Remote host said: 417 SPF error mailout.stusta.mhn.de: Address does not 
pass the
+Sender Policy Framework
I'm not going to try again; this message has been in the queue too long.

<drzeus-wbsd@drzeus.cx>:
Connected to 213.115.189.212 but sender was rejected.
Remote host said: 417 SPF error mailout.stusta.mhn.de: Address does not 
pass the
+Sender Policy Framework
I'm not going to try again; this message has been in the queue too long.

<--  snip  -->



IMHO lists rejecting emails based on some non-standard extension don't 
belong into MAINTAINERS.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/MAINTAINERS.old	2005-01-10 19:20:32.000000000 +0100
+++ linux-2.6.10-mm2-full/MAINTAINERS	2005-01-10 19:26:24.000000000 +0100
@@ -2539,8 +2539,6 @@
 
 W83L51xD SD/MMC CARD INTERFACE DRIVER
 P:	Pierre Ossman
-M:	drzeus-wbsd@drzeus.cx
-L:	wbsd-devel@list.drzeus.cx
 W:	http://projects.drzeus.cx/wbsd
 S:	Maintained
 

