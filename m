Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTLJM1z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 07:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTLJM1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 07:27:55 -0500
Received: from math.ut.ee ([193.40.5.125]:1184 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262353AbTLJM1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 07:27:54 -0500
Date: Wed, 10 Dec 2003 14:27:47 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: unresolved symbol in 2.4+BK (PPC): init_cmd640_vlb
Message-ID: <Pine.GSO.4.44.0312101424350.26871-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This 2.4.23+todays BK. Modular IDE has a problem with CMD 640:

depmod: *** Unresolved symbols in /lib/modules/2.4.24-pre1/kernel/drivers/ide/ide-core.o
depmod:         init_cmd640_vlb

CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASK_IOCTL=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_BLK_DEV_SL82C105=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y

-- 
Meelis Roos (mroos@linux.ee)

