Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263283AbUJ2A3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263283AbUJ2A3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbUJ2A3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:29:10 -0400
Received: from inx.pm.waw.pl ([195.116.170.20]:61373 "EHLO inx.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263274AbUJ2A1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:27:35 -0400
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/wan/n2.c: remove an unused function
References: <20041028230822.GZ3207@stusta.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 29 Oct 2004 02:25:46 +0200
In-Reply-To: <20041028230822.GZ3207@stusta.de> (Adrian Bunk's message of
 "Fri, 29 Oct 2004 01:08:22 +0200")
Message-ID: <m3ekjixtdh.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> The patch below removes an unused function from drivers/net/wan/n2.c

Right.

A similar thing, for C101 card.
Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>
--- linux-2.6/drivers/net/wan/c101.c	20 Oct 2004 01:26:30 -0000	1.15
+++ linux-2.6/drivers/net/wan/c101.c	29 Oct 2004 00:18:31 -0000
@@ -113,9 +113,6 @@
 }
 
 
-#define close_windows(card) {} /* no hardware support */
-
-
 #include "hd6457x.c"
 
 


