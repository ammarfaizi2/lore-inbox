Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbTAIIqd>; Thu, 9 Jan 2003 03:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbTAIIqd>; Thu, 9 Jan 2003 03:46:33 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:47489 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S262224AbTAIIqb>; Thu, 9 Jan 2003 03:46:31 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.55] make PCI_LEGACY_PROC depend on PCI
Date: Thu, 9 Jan 2003 09:58:30 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301090958.30536@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

from my point of view this would make sense. Or did I miss something magic?

Rolf Eike Beer

--- linux-2.5.55-caliban/drivers/pci/Kconfig.old        Thu Jan  9 09:55:07 2003
+++ linux-2.5.55-caliban/drivers/pci/Kconfig    Thu Jan  9 09:55:24 2003
@@ -3,6 +3,7 @@
 #
 config PCI_LEGACY_PROC
        bool "Legacy /proc/pci interface"
+       depends on PCI
        ---help---
          This feature enables a procfs file -- /proc/pci -- that provides a
          summary of PCI devices in the system.
