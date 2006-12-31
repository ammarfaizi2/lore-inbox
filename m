Return-Path: <linux-kernel-owner+w=401wt.eu-S932579AbWLaBoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbWLaBoq (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 20:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbWLaBoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 20:44:46 -0500
Received: from av2.karneval.cz ([81.27.192.122]:2755 "EHLO av2.karneval.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932579AbWLaBoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 20:44:46 -0500
X-Greylist: delayed 1131 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Dec 2006 20:44:46 EST
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: tali@admingilde.org, rdunlap@xenotime.net, linux-kernel@vger.kernel.org
Subject: [PATCH] DocBook/HTML: Generate chapter/section level TOCs for functions
Date: Sun, 31 Dec 2006 02:27:46 +0100
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612310227.47721.pisa@cmp.felk.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple increase of section TOC level generation significantly
enhances navigation experience through generated kernel
API documentation.

This change restores back state from SGML tools time.

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Index: linux-2.6.19/Documentation/DocBook/stylesheet.xsl
===================================================================
--- linux-2.6.19.orig/Documentation/DocBook/stylesheet.xsl
+++ linux-2.6.19/Documentation/DocBook/stylesheet.xsl
@@ -4,4 +4,5 @@
 <param name="funcsynopsis.style">ansi</param>
 <param name="funcsynopsis.tabular.threshold">80</param>
 <!-- <param name="paper.type">A4</param> -->
+<param name="generate.section.toc.level">2</param>
 </stylesheet>
