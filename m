Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262566AbVEMWJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbVEMWJy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbVEMWJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:09:54 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:59552 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262566AbVEMWJw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:09:52 -0400
Message-Id: <20050513220019.907667000@abc>
Date: Sat, 14 May 2005 00:00:19 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-SA-Exim-Connect-IP: 217.231.56.126
Subject: [DVB patch 00/11] B2C2 / FlexCop driver rewrite
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

the following patchset adds a refactored driver for
DVB PCI cards and USB devices based on the FlexCopII
or FlexCopIII chips by B2C2. It consists of the
following parts:

- drop the abandoned attempt to add USB support based on the
  existing skystar2 driver
- add a modular flexcop driver
- a bunch of fixes for the new driver from CVS

The second patch is probably too large to make it to
the list (130K) but I see no reasonable way to split it.
Just in case, it is also available here:
http://linuxtv.org/downloads/patches/2.6.12-rc4-2/quilt/dvb-b2c2-refactoring.patch

This driver has been in CVS for two months so I
believe it is quite stable by now, and IMHO good for 2.6.12.

Please apply.

Thanks,
Johannes

