Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbTIIVXX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbTIIVXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:23:22 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:8864 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S264434AbTIIVUB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:20:01 -0400
Message-ID: <3F5E16EE.1090205@terra.com.br>
Date: Tue, 09 Sep 2003 15:07:42 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]  Update driver/cdrom/Kconfig
Content-Type: multipart/mixed;
 boundary="------------040601020703090901020008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040601020703090901020008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Jens,

	If you apply my patch to fix SMP support on cdu535, please apply this 
one as well.

	Thanks,

Felipe

--------------040601020703090901020008
Content-Type: text/plain;
 name="Kconfig-cdrom.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Kconfig-cdrom.patch"

--- linux-2.6.0-test5/drivers/cdrom/Kconfig	Mon Sep  8 16:50:22 2003
+++ linux-2.6.0-test5-fwd/drivers/cdrom/Kconfig	Tue Sep  9 15:04:39 2003
@@ -267,7 +267,7 @@
 
 config CDU535
 	tristate "Sony CDU535 CDROM support"
-	depends on CD_NO_IDESCSI && BROKEN_ON_SMP
+	depends on CD_NO_IDESCSI
 	---help---
 	  This is the driver for the older Sony CDU-535 and CDU-531 CD-ROM
 	  drives. Please read the file <file:Documentation/cdrom/sonycd535>.

--------------040601020703090901020008--

