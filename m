Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVLIPVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVLIPVo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbVLIPVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:21:43 -0500
Received: from ap1.cs.vt.edu ([128.173.40.39]:64213 "EHLO ap1.cs.vt.edu")
	by vger.kernel.org with ESMTP id S932228AbVLIPVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:21:43 -0500
Date: Fri, 9 Dec 2005 10:21:38 -0500
From: Matt Tolentino <metolent@cs.vt.edu>
Message-Id: <200512091521.jB9FLcEA006687@ap1.cs.vt.edu>
To: ak@muc.de, akpm@osdl.org, len.brown@intel.com
Subject: [patch 2/3] rm unused attr var in acpi memory hotplug driver
Cc: linux-kernel@vger.kernel.org, matthew.e.tolentino@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch to remove an unused variable in the acpi 
memory hotplug driver.

Signed-off-by: Matt Tolentino <matthew.e.tolentino@intel.com>
---

diff -urNp linux-2.6.15-rc5/drivers/acpi/acpi_memhotplug.c linux-2.6.15-rc5-mt/drivers/acpi/acpi_memhotplug.c
--- linux-2.6.15-rc5/drivers/acpi/acpi_memhotplug.c	2005-12-04 00:10:42.000000000 -0500
+++ linux-2.6.15-rc5-mt/drivers/acpi/acpi_memhotplug.c	2005-12-08 15:43:43.000000000 -0500
@@ -250,7 +250,6 @@ static int acpi_memory_disable_device(st
 	int result;
 	u64 start = mem_device->start_addr;
 	u64 len = mem_device->end_addr - start + 1;
-	unsigned long attr = mem_device->read_write_attribute;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_disable_device");
 
