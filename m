Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTJMPy7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 11:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTJMPy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 11:54:58 -0400
Received: from imladris.surriel.com ([66.92.77.98]:57278 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S261799AbTJMPyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 11:54:55 -0400
Date: Mon, 13 Oct 2003 11:54:46 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] question marks again
Message-ID: <Pine.LNX.4.55L.0310131154110.27244@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No question about it.

diff -urNp linux-5110/drivers/scsi/imm.c linux-10010/drivers/scsi/imm.c
--- linux-5110/drivers/scsi/imm.c
+++ linux-10010/drivers/scsi/imm.c
@@ -322,10 +322,10 @@ static unsigned char imm_wait(int host_n
      * STR      imm     imm
      * ===================================
      * 0x80     S_REQ   S_REQ
-     * 0x40     !S_BSY  (????)
+     * 0x40     !S_BSY  (?)
      * 0x20     !S_CD   !S_CD
      * 0x10     !S_IO   !S_IO
-     * 0x08     (????)  !S_BSY
+     * 0x08     (?)  !S_BSY
      *
      * imm      imm     meaning
      * ==================================
@@ -927,7 +927,7 @@ static void imm_interrupt(void *data)
 	printk("imm: told to abort\n");
 	break;
     case DID_PARITY:
-	printk("imm: parity error (???)\n");
+	printk("imm: parity error (?)\n");
 	break;
     case DID_ERROR:
 	printk("imm: internal driver error\n");
@@ -936,7 +936,7 @@ static void imm_interrupt(void *data)
 	printk("imm: told to reset device\n");
 	break;
     case DID_BAD_INTR:
-	printk("imm: bad interrupt (???)\n");
+	printk("imm: bad interrupt (?)\n");
 	break;
     default:
 	printk("imm: bad return code (%02x)\n", (cmd->result >> 16) & 0xff);
