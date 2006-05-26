Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbWEZAH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbWEZAH3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 20:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbWEZAH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 20:07:29 -0400
Received: from orfeus.profiwh.com ([82.100.20.117]:22277 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S965210AbWEZAH2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 20:07:28 -0400
Message-id: <2005009.119285689fuj@nikdo.nikde.cz>
Subject: [PATCH 0/3 #2] avoid pci_find_device
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com,
       netdev@vger.kernel.org, khali@linux-fr.org, lm-sensors@lm-sensors.org,
       stevel@mvista.com, source@mvista.com, mb@bu3sch.de, st3@riseup.net,
       linville@tuxdriver.com
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Date: Thu, 25 May 2006 20:07:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

there are some patches to avoid pci_find_device in drivers, next will come in
future.

Take #2.

It's against 2.6.17-rc4-mm3 tree.

01-i2c-scx200-acb-avoid-pci-find-device.patch
02-bcm43xx-avoid-pci-find-device.patch
03-gt96100eth-avoid-pci-find-device.patch

 i2c/busses/scx200_acb.c             |    9 ++++++---
 net/gt96100eth.c                    |   10 +++++++---
 net/wireless/bcm43xx/bcm43xx_main.c |   20 ++++++++++++++++----
 3 files changed, 29 insertions(+), 10 deletions(-)

Thanks.
