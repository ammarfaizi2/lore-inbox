Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVKSS7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVKSS7j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 13:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbVKSS7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 13:59:39 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:57484 "EHLO
	mtiwmhc11.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1750740AbVKSS7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 13:59:39 -0500
From: Larry.Finger@att.net (Larry.Finger@lwfinger.net)
To: linux-kernel@vger.kernel.org
Subject: DMA mode locked off when via82cxxx ide driver built as module in 2.6.14
Date: Sat, 19 Nov 2005 18:59:37 +0000
Message-Id: <111920051859.9281.437F7619000700AC0000244121603763169D0A09020700D2979D9D0E04@att.net>
X-Mailer: AT&T Message Center Version 1 (Nov 10 2005)
X-Authenticated-Sender: TGFycnkuRmluZ2VyQGF0dC5uZXQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My HP ze1115 notebook uses the via82cxxx ide driver. If I configure the kernel build to make that driver as a module, the driver is correctly added to initrd and is loaded at boot time; however, DMA mode is turned off. It cannot be turned on even if I use an 'hdparm -d1 /dev/hda' command.

Is this a bug, or do I need some kind of IDE=XXX boot command? As expected, system performance in this mode is horrible.
