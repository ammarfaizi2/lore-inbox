Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbTIZOGm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 10:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbTIZOGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 10:06:41 -0400
Received: from dsc01-aui-tx-207-221-253-75.rasserver.net ([207.221.253.75]:41486
	"EHLO deb22r2-48.mckemie.org") by vger.kernel.org with ESMTP
	id S262232AbTIZOGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 10:06:39 -0400
Date: Fri, 26 Sep 2003 07:53:30 -0500
From: Willie McKemie <mckemie@spamcop.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: no Compaq USB on 2.4.22
Message-ID: <20030926075330.L14320@mckemie.austinfarm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just installed a 2.4.22 on my Libranet 2.8 system and find the 
following in dmesg:

---
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/usb-uhci.c: $Revision: 1.275 $ time 10:48:58 Sep 25 2003
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
host/usb-ohci.c: USB OHCI at membase 0xca826000, IRQ -19
host/usb-ohci.c: usb-00:0e.2, Compaq Computer Corporation ZFMicro
Chipset USB
usb.c: new USB bus registered, assigned bus number 1
host/usb-ohci.c: request interrupt -19 failed
usb.c: USB bus 1 deregistered
---

The kernel was compiled, apparently without problem, with the standard 
Libranet 2.8 configuration which includes almost everything as modules. 
The "stock" 2.4.20 kernel does not have the last two lines in dmesg and 
USB works.  This on a Compaq Armada 7800, 266mhz, 180mb.  Other LN2.8 
users report no problems on non-Compaq systems.

-- 
Willie, ashamed that dixie chicks are from Austin
Are YOU an html abuser?  http://www.expita.com/nomime.html
Linux system uptime  110 days 12 hours 28 minutes
