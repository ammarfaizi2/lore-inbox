Return-Path: <linux-kernel-owner+w=401wt.eu-S932789AbXASA1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932789AbXASA1B (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932792AbXASA1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:27:01 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:61715 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932789AbXASA1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:27:00 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:subject;
        b=o/w8QhIlL4N2peO5kZrpuxuTR+9hhtM9vJsqdAg3vZbXwV8FLyGcVrUNvpUWXXV4rnEhGJZVEJPtjQzsrQ/zb7w0cV56pLsLcQ0S3zs4X8G4bvcvpNNqdEDq1UY3BY0NW5Ak56yoM3tkTsKVtT8L8yrqUYfEtEF3hPPJ2Nk+b3c=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 19 Jan 2007 01:30:58 +0100
Message-Id: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Subject: [PATCH 0/15] IDE quilt tree updated
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've just updated IDE quilt tree:
	http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/patches/


New patches:

* IDE driver for Delkin/Lexar/ASKA/Workbit/etc. CardBus CF adapters
  (Mark Lord <mlord@pobox.com>)

* ACPI support for IDE devices
  (Hannes Reinecke <hare@suse.de>)

* ide: unregister ide-pnp driver on unload
  (Tejun Heo <htejun@gmail.com>)

* via82cxxx/pata_via: correct PCI_DEVICE_ID_VIA_SATA_EIDE ID and add support
  for CX700 and 8237S
  (Josepch Chan <josephchan@via.com.tw>)

* rework of the code selecting the best DMA transfer mode (~500 LOCs less)
  (me)

* some misc fixes/cleanups (me)

diffstat:
 68 files changed, 3310 insertions(+), 2495 deletions(-)


I'm sending only new patches for review/comments.

If you would like to see the full quilt series (or to get combined patch)
against 2.6.20-rc5, they are available here:

       http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/releases/

Thanks,
Bart
