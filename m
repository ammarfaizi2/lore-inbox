Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVIJMTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVIJMTn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVIJMTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:19:43 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:22664 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750771AbVIJMTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:19:42 -0400
Date: Sat, 10 Sep 2005 14:19:17 +0200
Message-Id: <200509101219.j8ACJHeb017063@localhost.localdomain>
Subject: [PATCH 0/10] drivers/char: pci_find_device remove
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set of patches, which removes pci_find_device from drivers/char subtree.

 ip2main.c               |    8 +++++---
 istallion.c             |    9 +++++----
 mxser.c                 |    3 ++-
 rocket.c                |    2 +-
 specialix.c             |    9 ++++++---
 stallion.c              |    6 ++++--
 sx.c                    |    2 +-
 watchdog/alim1535_wdt.c |   12 +++++++++---
 watchdog/alim7101_wdt.c |    9 +++++++--
 watchdog/i8xx_tco.c     |    5 +++--
 10 files changed, 43 insertions(+), 22 deletions(-)
