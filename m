Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751409AbWFEUQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWFEUQz (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWFEUQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:16:54 -0400
Received: from orfeus.profiwh.com ([82.100.20.117]:33041 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S1751409AbWFEUQy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:16:54 -0400
Message-id: <2005123213211@nnikde.cz>
Subject: [PATCH 0/3 #3] avoid pci_find_device
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com,
        netdev@vger.kernel.org, khali@linux-fr.org, lm-sensors@lm-sensors.org,
        stevel@mvista.com, source@mvista.com, mb@bu3sch.de, st3@riseup.net,
        linville@tuxdriver.com
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Date: Mon, 5 Jun 2006 16:16:54 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

there are some patches to avoid pci_find_device in drivers.
I will make a bcm43xx patch against wireless git too.

Take #3.

It's against 2.6.17-rc5-mm3 tree.

01-i2c-scx200-acb-avoid-pci-find-device.patch
02-bcm43xx-avoid-pci-find-device.patch
03-gt96100eth-avoid-pci-find-device.patch

 i2c/busses/scx200_acb.c             |    9 ++++++---
 net/gt96100eth.c                    |   23 ++++++++++++++++++-----
 net/wireless/bcm43xx/bcm43xx_main.c |   21 ++++++++++++++++-----
 3 files changed, 40 insertions(+), 13 deletions(-)

Thanks.
