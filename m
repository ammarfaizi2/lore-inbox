Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTL2QMc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 11:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbTL2QMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 11:12:32 -0500
Received: from jik.kamens.brookline.ma.us ([66.92.77.120]:40064 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id S263620AbTL2QMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 11:12:30 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16368.21101.740917.165853@jik.kamens.brookline.ma.us>
Date: Mon, 29 Dec 2003 11:12:29 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Is it safe to ignore UDMA BadCRC errors?
In-Reply-To: <16368.20794.147453.255239@jik.kamens.brookline.ma.us>
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-Bogosity: No, tests=bogofilter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suppose if I were less of an idiot I would have mentioned my kernel
version in my message :-).  I'm using 2.4.22-ac4.  Here are the IDE
and PDC settings that are enabled in my .config:

  CONFIG_IDE=y
  CONFIG_BLK_DEV_IDE=y
  CONFIG_BLK_DEV_IDEDISK=y
  CONFIG_IDEDISK_MULTI_MODE=y
  CONFIG_BLK_DEV_IDECD=y
  CONFIG_BLK_DEV_IDETAPE=m
  CONFIG_BLK_DEV_IDESCSI=m
  CONFIG_BLK_DEV_IDEPCI=y
  CONFIG_IDEPCI_SHARE_IRQ=y
  CONFIG_BLK_DEV_IDEDMA_PCI=y
  CONFIG_IDEDMA_PCI_AUTO=y
  CONFIG_BLK_DEV_IDEDMA=y
  CONFIG_BLK_DEV_PDC202XX_OLD=y
  CONFIG_IDEDMA_AUTO=y
  CONFIG_BLK_DEV_PDC202XX=y
  CONFIG_BLK_DEV_IDE_MODES=y

Thanks again,

  jik
