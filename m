Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUDNUTO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUDNUTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:19:13 -0400
Received: from outmx016.isp.belgacom.be ([195.238.2.115]:52104 "EHLO
	outmx016.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261624AbUDNUSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:18:00 -0400
Subject: [PATCH 2.6.5-mm4] SMP doc fix
From: Fabian Frederick <Fabian.Frederick@skynet.be>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-y6vzHPHPKbsOFey6v3Tq"
Message-Id: <1081974032.9612.43.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 14 Apr 2004 22:20:32 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx016.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y6vzHPHPKbsOFey6v3Tq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Any suggestions verrrry welcome !
Application to current kernel would be so comfortable indeed ...

Regards,
Fabian

--=-y6vzHPHPKbsOFey6v3Tq
Content-Disposition: attachment; filename=smp2.diff
Content-Type: text/x-patch; name=smp2.diff; charset=
Content-Transfer-Encoding: 7bit

diff -Naur orig/Documentation/smp.txt edited/Documentation/smp.txt
--- orig/Documentation/smp.txt	2004-04-04 05:37:44.000000000 +0200
+++ edited/Documentation/smp.txt	2004-04-13 17:04:09.000000000 +0200
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

--=-y6vzHPHPKbsOFey6v3Tq--

