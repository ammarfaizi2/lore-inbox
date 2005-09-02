Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbVIBVWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbVIBVWw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbVIBVWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:22:52 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:21129 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1161049AbVIBVWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:22:37 -0400
Date: Fri, 2 Sep 2005 23:22:22 +0200
Message-Id: <200509022122.j82LMMwV030426@wscnet.wsc.cz>
Subject: [PATCH 0/6] include, sound: pci_find_device remove
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set of patches, which removes pci_find_device from include and sound subtree.

 include/asm-i386/ide.h        |    7 ++++++-
 include/sound/cs46xx.h        |    1 -
 sound/core/memalloc.c         |   10 +++++-----
 sound/pci/ali5451/ali5451.c   |   16 +++++++++-------
 sound/pci/au88x0/au88x0.c     |   26 ++++++++++++++++----------
 sound/pci/cs46xx/cs46xx_lib.c |   13 +++++++++----
 sound/pci/via82xx.c           |    3 ++-
