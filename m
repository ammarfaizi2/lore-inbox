Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbTHaBOL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 21:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTHaBOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 21:14:11 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:35786 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S262284AbTHaBOH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 21:14:07 -0400
Message-ID: <3F514CDC.9060203@terra.com.br>
Date: Sat, 30 Aug 2003 22:18:20 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Needed include in usb/gadget/net2280
Content-Type: multipart/mixed;
 boundary="------------060704060708020304070509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060704060708020304070509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Greg,

	Attached is a trivial patch which includes the needed linux/version.h 
header file.

	This is based on Randy's checkversion.pl script.

	Please consider applying.

	Thanks,

Felipe
-- 
It's most certainly GNU/Linux, not Linux. Read more at
http://www.gnu.org/gnu/why-gnu-linux.html

--------------060704060708020304070509
Content-Type: text/plain;
 name="net2280-include.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net2280-include.patch"

diff -ur linux-2.6.0-test4/drivers/usb/gadget/net2280.c linux-2.6.0-test4-fwd/drivers/usb/gadget/net2280.c
--- linux-2.6.0-test4/drivers/usb/gadget/net2280.c	Fri Aug 22 20:51:41 2003
+++ linux-2.6.0-test4-fwd/drivers/usb/gadget/net2280.c	Sat Aug 30 22:13:44 2003
@@ -53,6 +53,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
+#include <linux/version.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/sched.h>

--------------060704060708020304070509--

