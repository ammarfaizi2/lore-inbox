Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVGKAMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVGKAMj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 20:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVGKAKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 20:10:36 -0400
Received: from ns1.suse.de ([195.135.220.2]:54162 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261189AbVGJTfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:13 -0400
Date: Sun, 10 Jul 2005 19:35:12 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Subject: [PATCH 4/82] remove linux/version.h include from arch/mips
Message-ID: <20050710193512.4.TqwKKi2359.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

Signed-off-by: Olaf Hering <olh@suse.de>

arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.h |    1 -
arch/mips/pmc-sierra/yosemite/ht-irq.c            |    1 -
arch/mips/pmc-sierra/yosemite/ht.c                |    1 -
3 files changed, 3 deletions(-)

Index: linux-2.6.13-rc2-mm1/arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.h
+++ linux-2.6.13-rc2-mm1/arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.h
@@ -34,7 +34,6 @@
#include <linux/pci.h>
#include <linux/kernel.h>
#include <linux/slab.h>
-#include <linux/version.h>
#include <asm/pci.h>
#include <asm/io.h>
#include <linux/init.h>
Index: linux-2.6.13-rc2-mm1/arch/mips/pmc-sierra/yosemite/ht-irq.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/mips/pmc-sierra/yosemite/ht-irq.c
+++ linux-2.6.13-rc2-mm1/arch/mips/pmc-sierra/yosemite/ht-irq.c
@@ -26,7 +26,6 @@
#include <linux/types.h>
#include <linux/pci.h>
#include <linux/kernel.h>
-#include <linux/version.h>
#include <linux/init.h>
#include <asm/pci.h>

Index: linux-2.6.13-rc2-mm1/arch/mips/pmc-sierra/yosemite/ht.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/mips/pmc-sierra/yosemite/ht.c
+++ linux-2.6.13-rc2-mm1/arch/mips/pmc-sierra/yosemite/ht.c
@@ -28,7 +28,6 @@
#include <linux/pci.h>
#include <linux/kernel.h>
#include <linux/slab.h>
-#include <linux/version.h>
#include <asm/pci.h>
#include <asm/io.h>

