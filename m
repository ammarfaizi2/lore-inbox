Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbTFZXSe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 19:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbTFZXSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 19:18:34 -0400
Received: from aneto.able.es ([212.97.163.22]:47765 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262366AbTFZXSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 19:18:32 -0400
Date: Fri, 27 Jun 2003 01:32:44 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] kill duplicate pci_id
Message-ID: <20030626233244.GQ3827@werewolf.able.es>
References: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva>; from marcelo@conectiva.com.br on Fri, Jun 27, 2003 at 00:03:02 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.27, Marcelo Tosatti wrote:
> 
> Hello,
> 
> Here goes -pre2 with a big number of changes, including the new aic7xxx
> driver.
> 
> I wont accept any big changes after -pre4: I want 2.4.22 timecycle to be
> short.
> 

--- linux-2.4.20.orig/include/linux/pci_ids.h	2003-05-30 00:43:12.000000000=
 +0200
+++ linux-2.4.20/include/linux/pci_ids.h	2003-05-30 00:44:37.000000000 +020=
0
@@ -1029,7 +1029,6 @@
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
 #define PCI_DEVICE_ID_VIA_P4X333   0x3168
 #define PCI_DEVICE_ID_VIA_8235        0x3177
-#define PCI_DEVICE_ID_VIA_8377_0  0x3189
 #define PCI_DEVICE_ID_VIA_8377_0	0x3189
 #define PCI_DEVICE_ID_VIA_8237     0x3227
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-2mdk))
