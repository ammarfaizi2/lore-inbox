Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTJMP4q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 11:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTJMP4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 11:56:45 -0400
Received: from imladris.surriel.com ([66.92.77.98]:57278 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S261845AbTJMP4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 11:56:44 -0400
Date: Mon, 13 Oct 2003 11:56:35 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] triple question marks in ppa.c
Message-ID: <Pine.LNX.4.55L.0310131155460.27244@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't ask me why???  Triple question marks are a C trigraph in ansi C.

diff -urNp linux-5110/drivers/scsi/ppa.c linux-10010/drivers/scsi/ppa.c
--- linux-5110/drivers/scsi/ppa.c
+++ linux-10010/drivers/scsi/ppa.c
@@ -824,7 +824,7 @@ static void ppa_interrupt(void *data)
 	printk("ppa: told to abort\n");
 	break;
     case DID_PARITY:
-	printk("ppa: parity error (???)\n");
+	printk("ppa: parity error (?)\n");
 	break;
     case DID_ERROR:
 	printk("ppa: internal driver error\n");
@@ -833,7 +833,7 @@ static void ppa_interrupt(void *data)
 	printk("ppa: told to reset device\n");
 	break;
     case DID_BAD_INTR:
-	printk("ppa: bad interrupt (???)\n");
+	printk("ppa: bad interrupt (?)\n");
 	break;
     default:
 	printk("ppa: bad return code (%02x)\n", (cmd->result >> 16) & 0xff);
