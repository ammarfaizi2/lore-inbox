Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWCaIZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWCaIZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 03:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWCaIZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 03:25:59 -0500
Received: from a80-127-56-249.adsl.xs4all.nl ([80.127.56.249]:47805 "EHLO
	nasng.slim") by vger.kernel.org with ESMTP id S1751268AbWCaIZ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 03:25:58 -0500
Subject: Non-Fatal Error PCI Express messages
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
Reply-To: gtm.kramer@inter.nl.net
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 31 Mar 2006 10:25:50 +0200
Message-Id: <1143793550.3331.4.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.16 (from FC5s 2.6.16-1.2080_FC5smp) I am getting a lot of

Mar 31 09:35:16 paragon kernel: Non-Fatal Error PCI Express B
Mar 31 09:35:17 paragon kernel: Non-Fatal Error PCI Express B
Mar 31 09:35:17 paragon kernel: Non-Fatal Error PCI Express B
Mar 31 09:35:18 paragon kernel: Non-Fatal Error PCI Express B
Mar 31 09:35:18 paragon kernel: Non-Fatal Error PCI Express B
Mar 31 09:35:20 paragon kernel: Non-Fatal Error PCI Express B
Mar 31 09:35:20 paragon kernel: Non-Fatal Error PCI Express B
Mar 31 09:35:39 paragon kernel: Non-Fatal Error PCI Express B

messages which presumably come from

Mar 31 09:17:15 paragon kernel: MC: drivers/edac/edac_mc.c version
edac_mc  Ver: 2.0.0 Mar 28 2006
Mar 31 09:17:15 paragon kernel: EDAC MC0: Giving out device to
"e752x_edac" E7525: PCI 0000:00:00.0

Is there really something broken here of just a noisy driver?

BTW this is on a Asus NCT-D mobo with Intel E7525 chipset.

Jurgen


