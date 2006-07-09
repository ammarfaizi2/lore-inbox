Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWGIKlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWGIKlH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 06:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWGIKlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 06:41:07 -0400
Received: from aun.it.uu.se ([130.238.12.36]:45197 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932154AbWGIKlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 06:41:05 -0400
Date: Sun, 9 Jul 2006 12:40:58 +0200 (MEST)
Message-Id: <200607091040.k69AewNu019891@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: davem@davemloft.net
Subject: 2.6.18-rc1 fails to boot on Ultra 5
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.17-git7 was the last development kernel to boot on my U5.
2.6.17-git8 to -git15 all hang immediately after being loaded.
2.6.17-git16 to 2.6.18-rc1 partially boot but crash and burn in
different places depending on kernel configuration: my standard
config got alignment exceptions in the floppy driver followed by
(sabre?) PCI errors and a hang; a minimal kernel gets further but
fails "su" probe and then oopses hard when the /dev/hda partition
table is about to be printed.

I'll try to capture the kernel messages soon, but I don't have
a null-modem serial cable to the U5 yet, and my attempts to use
a digital camera only resulted in blurry pictures of the screen :-(

/Mikael
