Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbULCO0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbULCO0U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 09:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbULCO0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 09:26:19 -0500
Received: from ns1.q-leap.de ([153.94.51.193]:44937 "EHLO mail.q-leap.de")
	by vger.kernel.org with ESMTP id S261484AbULCO0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 09:26:17 -0500
From: Roland Fehrenbacher <rf@q-leap.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16816.30598.368287.762457@gargle.gargle.HOWL>
Date: Fri, 3 Dec 2004 15:26:14 +0100
To: linux-kernel@vger.kernel.org
Subject: Trouble with swiotlb
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: rf@q-leap.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when building 2.4.28 or 2.4.27 on x86_64 with IOMMU and SWIOTLB support
enabled I get unresolved symbol for 3 modules:

depmod: *** Unresolved symbols in /lib/modules/2.4.28/kernel/drivers/net/e1000/e1000.o
depmod: *** Unresolved symbols in /lib/modules/2.4.28/kernel/drivers/usb/host/uhci.o
depmod: *** Unresolved symbols in /lib/modules/2.4.28/kernel/drivers/usb/host/usb-uhci.o

When modprobing any of the modules I get:
unresolved symbol swiotlb

The kernel boots fine on Opterons and EM64T Xeons otherwise.

Any ideas.

Cheers,

Roland

