Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265824AbTFVTqq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 15:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265837AbTFVTqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 15:46:31 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:48900 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S265824AbTFVTq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 15:46:27 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200306222000.QAA12975@clem.clem-digital.net>
Subject: 2.5.73 fails complile (hotplug.c)
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Sun, 22 Jun 2003 16:00:31 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

drivers/pci/hotplug.c: In function `pci_remove_bus_device':
drivers/pci/hotplug.c:262: warning: implicit declaration of function `pci_destroy_dev'
drivers/pci/hotplug.c: At top level:
drivers/pci/hotplug.c:224: warning: `pci_free_resources' defined but not used

---

drivers/built-in.o: In function `pci_remove_bus_device':
drivers/built-in.o(.text+0x2402): undefined reference to `pci_destroy_dev'
make: *** [.tmp_vmlinux1] Error 1

-- 
Pete Clements 
clem@clem.clem-digital.net
