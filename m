Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbTIPDGk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 23:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTIPDEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 23:04:39 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:17902 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261766AbTIPDDg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 23:03:36 -0400
Message-ID: <1063681408.3f667d8031f3a@dubai.stillhq.com>
Date: Tue, 16 Sep 2003 13:03:28 +1000
From: Michael Still <mikal@stillhq.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [2.6 Patch] Kernel-doc updates 4 of 15 -- /drivers/serial/8250.c
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 203.17.68.210
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes kernel-doc errors reported whilst doing
a make mandocs on 2.6-test4-bk5

Linus, please apply.

Cheers,
Mikal


--------------------------


diff -Nur linux-2.6.0-test4-bk5-mandocs/drivers/serial/8250.c
linux-2.6.0-test4-bk5-mandocs_tweaks/drivers/serial/8250.c
--- linux-2.6.0-test4-bk5-mandocs/drivers/serial/8250.c	2003-09-04
10:56:01.000000000 +1000
+++ linux-2.6.0-test4-bk5-mandocs_tweaks/drivers/serial/8250.c	2003-09-10
13:23:05.000000000 +1000
@@ -2097,7 +2097,8 @@
 
 /**
  *	serial8250_suspend_port - suspend one serial port
- *	@line: serial line number
+ *	@line:  serial line number
+ *      @level: the level of port suspension, as per uart_suspend_port
  *
  *	Suspend one serial port.
  */
@@ -2108,7 +2109,8 @@
 
 /**
  *	serial8250_resume_port - resume one serial port
- *	@line: serial line number
+ *	@line:  serial line number
+ *      @level: the level of port resumption, as per uart_resume_port
  *
  *	Resume one serial port.
  */

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
