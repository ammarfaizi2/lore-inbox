Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262694AbVAVKiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbVAVKiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 05:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVAVKiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 05:38:25 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:24594 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262694AbVAVKiX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 05:38:23 -0500
Date: Sat, 22 Jan 2005 11:41:09 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] PCI: Kill duplicate definition of INTEL_82801DB_10
Message-Id: <20050122114109.432463d8.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I noticed that PCI_DEVICE_ID_INTEL_82801DB_10 is currently defined twice
in linux-2.4.29/include/linux/pci_ids.h. The trivial patch below kills
the second definition.

Please apply,
thanks:

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.4.29/include/linux/pci_ids.h.orig	2005-01-21 21:51:21.000000000 +0100
+++ linux-2.4.29/include/linux/pci_ids.h	2005-01-22 11:33:41.000000000 +0100
@@ -1937,7 +1937,6 @@
 #define PCI_DEVICE_ID_INTEL_82801EB_5	0x24d5
 #define PCI_DEVICE_ID_INTEL_82801EB_6	0x24d6
 #define PCI_DEVICE_ID_INTEL_82801EB_7	0x24d7
-#define PCI_DEVICE_ID_INTEL_82801DB_10	0x24ca
 #define PCI_DEVICE_ID_INTEL_82801EB_11	0x24db
 #define PCI_DEVICE_ID_INTEL_82801EB_13	0x24dd
 #define PCI_DEVICE_ID_INTEL_ESB_0	0x25a0


-- 
Jean Delvare
http://khali.linux-fr.org/
