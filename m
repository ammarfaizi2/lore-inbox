Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbTJFGup (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 02:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264000AbTJFGup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 02:50:45 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:38450 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S262801AbTJFGun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 02:50:43 -0400
To: <akpm@osdl.org>
Subject: [PATCH 2.6.0-test6mm1] smp doc improved
From: <ffrederick@prov-liege.be>
Cc: <linux-kernel@vger.kernel.org>
Date: Sun, 5 Oct 2003 08:51:53 PDT
Reply-To: <ffrederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.30]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S262801AbTJFGun/20031006065043Z+8586@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
         Here's a patch to improve smp doc.

Could you apply ?

Regards,
Fabian

diff -Naur orig/Documentation/smp.txt edited/Documentation/smp.txt
--- orig/Documentation/smp.txt	2003-09-28 00:50:48.000000000 +0000
+++ edited/Documentation/smp.txt	2003-10-05 23:51:04.000000000 +0000
@@ -1,4 +1,14 @@
-To set up SMP
+Documentation for SMP (Symmetric Multi-Processing). Kernel version 2.6.0-test6
+Some improvements by Fabian Frederick <ffrederick@users.sourceforge.net> 2003
+
+===============================================================================
+
+Linux 2.2.X kernel series was the very beginning of multi-processor support.
+Here are some tips to manage SMP and to figure out it works properly.
+
+===============================================================================
+
+How to setup SMP:
 
 Configure the kernel and answer Y to CONFIG_SMP.
 
@@ -20,3 +30,21 @@
 If you are using some Compaq MP compliant machines you will need to set
 the operating system in the BIOS settings to "Unixware" - don't ask me
 why Compaqs don't work otherwise.
+
+===============================================================================
+
+How to know SMP is running properly:
+
+You can cat /proc/cpuinfo for instance.That will display each processor with all its properties.
+
+processor	:0
+vendor_id 
+....
+processor	:1
+....
+
+For a simple status you can also cat /proc/stat where first entries display
+cpu statistics.First line titled 'cpu' is a grand total.'cpu0' 'cpu1' processor units. 
+
+
+


___________________________________



