Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319050AbSHSV5B>; Mon, 19 Aug 2002 17:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319051AbSHSV5A>; Mon, 19 Aug 2002 17:57:00 -0400
Received: from pina.terra.com.br ([200.176.3.17]:58782 "EHLO pina.terra.com.br")
	by vger.kernel.org with ESMTP id <S319050AbSHSV47>;
	Mon, 19 Aug 2002 17:56:59 -0400
Subject: [PATCH] OSS - synchronize_irq missing argument 2.5.31...
From: Lucio Maciel <abslucio@terra.com.br>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 19 Aug 2002 19:03:47 -0300
Message-Id: <1029794627.3319.116.camel@walker>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for this mail...
the other one is the real patch....

Sorry....


All calls to synchronize_irq are missing a argument.. 
this patch fix this.... 


diff -uNr /usr/src/linux-2.5.31/sound/oss/cmpci.c sound/oss/cmpci.c
--- /usr/src/linux-2.5.31/sound/oss/cmpci.c	2002-08-10 22:41:16.000000000 -0300
+++ sound/oss/cmpci.c	2002-08-19 14:53:52.000000000 -0300
@@ -1791,14 +1791,14 @@
 
-- 
::: Lucio F. Maciel
::: abslucio@terra.com.br
::: icq 93065464
::: Absoluta.net

