Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbVLQQJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbVLQQJW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 11:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbVLQQJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 11:09:22 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:2459 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932599AbVLQQJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 11:09:22 -0500
Date: Sat, 17 Dec 2005 17:09:20 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Dianogsing a hard lockup
Message-ID: <Pine.LNX.4.61.0512171655390.2227@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,


some time after I load drivers (any, rt2500 or via ndiswrap) for a 
rt2500-based wlan card, the box locks up hard. Sysrq does not work, so I 
suppose it is during irq-disabled context. How could I find out where this 
happens?


Jan Engelhardt
-- 
