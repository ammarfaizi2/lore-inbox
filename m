Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbSLHRkg>; Sun, 8 Dec 2002 12:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261446AbSLHRkg>; Sun, 8 Dec 2002 12:40:36 -0500
Received: from port-212-202-202-214.reverse.qdsl-home.de ([212.202.202.214]:8454
	"EHLO el-zoido.localnet") by vger.kernel.org with ESMTP
	id <S261433AbSLHRke>; Sun, 8 Dec 2002 12:40:34 -0500
Message-ID: <3DF385D0.6040908@trash.net>
Date: Sun, 08 Dec 2002 18:48:00 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021204 Debian/1.2.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@redhat.com
Subject: [PATCH] 2.5.50-ac1 trival compile fix
Content-Type: multipart/mixed;
 boundary="------------010408020306040005080405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010408020306040005080405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The patch adds missing declaration of sis_apic_bug in drivers/pci/quirks.c.

Bye,
Patrick

--------------010408020306040005080405
Content-Type: text/plain;
 name="linux-2.5.50-ac1-quirks.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.5.50-ac1-quirks.diff"

--- linux-2.5.50/drivers/pci/quirks.c.orig	2002-12-08 18:25:53.000000000 +0100
+++ linux-2.5.50/drivers/pci/quirks.c	2002-12-08 18:43:25.000000000 +0100
@@ -302,6 +302,7 @@
 
 #ifdef CONFIG_X86_IO_APIC 
 extern int nr_ioapics;
+extern int sis_apic_bug;
 
 /*
  * VIA 686A/B: If an IO-APIC is active, we need to route all on-chip

--------------010408020306040005080405--

