Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbVH2WU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbVH2WU4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 18:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVH2WU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 18:20:56 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:46985 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751323AbVH2WUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 18:20:55 -0400
Date: Tue, 30 Aug 2005 00:20:37 +0200
Message-Id: <200508292220.j7TMKbNC019793@wscnet.wsc.cz>
Subject: [PATCH 0/7] arch: pci_find_device remove
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set of patches, which removes pci_find_device from arch subtree.

 alpha/kernel/sys_alcor.c                |    3 ++-
 alpha/kernel/sys_sio.c                  |    6 +++---
 frv/mb93090-mb00/pci-frv.c              |    8 ++------
 frv/mb93090-mb00/pci-irq.c              |    4 +---
 ppc/kernel/pci.c                        |   21 +++++++++++----------
 ppc/platforms/85xx/mpc85xx_cds_common.c |   11 +++++++----
 sparc64/kernel/ebus.c                   |   17 ++++++-----------
 7 files changed, 32 insertions(+), 38 deletions(-)
