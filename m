Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTFSW6c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 18:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbTFSW6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 18:58:32 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54999 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261820AbTFSW6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 18:58:31 -0400
Date: Fri, 20 Jun 2003 01:12:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: support@moxa.com.tw
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] remove two unused variables from mxser.c
Message-ID: <20030619231222.GF29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes two unused variables from drivers/char/mxser.c .

I've tested the compilation with 2.5.72 and 2.5.72-mm2.

Please apply
Adrian

--- linux-2.5.72-mm2/drivers/char/mxser.c.old	2003-06-20 01:07:39.000000000 +0200
+++ linux-2.5.72-mm2/drivers/char/mxser.c	2003-06-20 01:08:03.000000000 +0200
@@ -498,7 +498,6 @@
 {
 	int i, m, retval, b;
 	int n, index;
-	int ret1, ret2;
 	struct mxser_hwconf hwconf;
 
 	mxvar_sdriver = alloc_tty_driver(MXSER_PORTS + 1);

