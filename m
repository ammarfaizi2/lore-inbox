Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbUFETM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUFETM4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 15:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUFETM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 15:12:56 -0400
Received: from laska.dorms.spbu.ru ([195.19.252.72]:62630 "EHLO
	laska.dorms.spbu.ru") by vger.kernel.org with ESMTP id S262170AbUFETMx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 15:12:53 -0400
Date: Sat, 5 Jun 2004 23:12:51 +0400
From: Mikhail Kshevetskiy <kl@laska.dorms.spbu.ru>
To: linux-kernel@vger.kernel.org
Subject: framebuffer trouble with AGP MGA G450 and PCI MGA 2064W videocards.
Message-Id: <20040605231251.1f584e87@laska>
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have two matrox videocard. The primary is dualhead AGP MGA G450 and the
secondary is PCI MGA 2064W. I have a 2.6 kernel compiled with options

CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_MULTIHEAD=y

CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y

In BIOS I select AGP card as primary, but framebuffer initialise PCI card
first. So fb0 point to PCI card, fb1 and fb2 point to AGP card. As a
result framebuffer console working on another monitor. How can I link fb0
and fb1 with AGP card and fb2 with PCI card ?

Please CC me, as i am not subscribed to the list


Mikhail Kshevetskiy
