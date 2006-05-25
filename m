Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWEYA1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWEYA1b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 20:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWEYA1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 20:27:31 -0400
Received: from orfeus.profiwh.com ([82.100.20.117]:10249 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S932346AbWEYA1b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 20:27:31 -0400
Message-id: <200500919343.119285689fuj@nikdo.nikde.nikam.cz>
Subject: [PATCH 0/3] avoid pci_find_device
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Date: Wed, 24 May 2006 20:27:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

there are some patches to avoid pci_find_device in drivers, next will come in
future.

It's against 2.6.17-rc4-mm3 tree.

01-i2c-scx200-acb-use-pci-probing.patch
02-bcm43xx-kill-pci-find-device.patch
03-gt96100eth-use-pci-probing.patch

 i2c/busses/scx200_acb.c             |  106 +++++++++++-----------
 net/gt96100eth.c                    |  167 +++++++++++++++++++++++-------------
 net/wireless/bcm43xx/bcm43xx_main.c |    3 
 3 files changed, 163 insertions(+), 113 deletions(-)

Thanks.
