Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbTESHME (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 03:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbTESHME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 03:12:04 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.29]:31282 "EHLO
	mwinf0201.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262142AbTESHMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 03:12:02 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: David Woodhouse <dwmw2@infradead.org>, marcelo@conectiva.com.br
Subject: Re: [PATCH] Shared crc32 for 2.4.
Date: Mon, 19 May 2003 09:24:53 +0200
User-Agent: KMail/1.5.1
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <1053193432.9218.13.camel@imladris.demon.co.uk>
In-Reply-To: <1053193432.9218.13.camel@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305190924.53700.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.4/Documentation/Configure.help.orig	2003-05-16 16:15:52.000000000 +0200
+++ linux-2.4/Documentation/Configure.help	2003-05-19 09:23:08.000000000 +0200
@@ -26525,6 +26525,13 @@
 
   If unsure, say N.
 
+CRC32 functions
+CONFIG_CRC32
+  This option is provided for the case where no in-kernel-tree
+  modules require CRC32 functions, but a module built outside the
+  kernel tree does. Such modules that use library CRC32 functions
+  require M here.
+
 #
 # A couple of things I keep forgetting:
 #   capitalize: AppleTalk, Ethernet, DOS, DMA, FAT, FTP, Internet,
