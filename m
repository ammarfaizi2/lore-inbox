Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265394AbTFWWXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbTFWWXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:23:52 -0400
Received: from leviathan.kumin.ne.jp ([211.9.65.12]:22417 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP id S265394AbTFWWWX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:22:23 -0400
Message-Id: <200306232236.AA00004@prism.kumin.ne.jp>
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
Date: Tue, 24 Jun 2003 07:36:09 +0900
To: linux-kernel@vger.kernel.org
Subject: linux-2.5.73 compile error
In-Reply-To: <200211220246.AA00001@prism.kumin.ne.jp>
References: <200211220246.AA00001@prism.kumin.ne.jp>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I update to linux-2.5.73 from linux-2.5.72.
compile error occured.

cddrivers/ide/ide-probe.c: In function `hwif_check_region':
drivers/ide/ide-probe.c:644: warning: `check_region' is deprecated (declared at include/linux/ioport.h:116)
drivers/pci/hotplug.c: In function `pci_remove_bus_device':
drivers/pci/hotplug.c:262: warning: implicit declaration of function `pci_destroy_dev'
include/linux/module.h: At top level:
drivers/pci/hotplug.c:224: warning: `pci_free_resources' defined but not used
net/ipv4/igmp.c: In function `igmp_rcv':
net/ipv4/igmp.c:851: warning: `skb_linearize' is deprecated (declared at include/linux/skbuff.h:1129)
drivers/built-in.o(.text+0x2f26): In function `pci_remove_bus_device':
: undefined reference to `pci_destroy_dev'
make: *** [vmlinux] Error 1

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
