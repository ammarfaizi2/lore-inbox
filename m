Return-Path: <linux-kernel-owner+w=401wt.eu-S1751589AbXALENq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbXALENq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbXALENp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:13:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:26473 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbXALENp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:13:45 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:subject;
        b=jMbdmkzG70J5H3+kZm9AfU284OWrBojVlQ+q64JEeC45E63N1STJVzToTD38swlGJBgOjg/Qlv+G/uKQsmqPKjo+WXltoRadtRN5AjHZqPyAFlY9WvmRy/AKsV8t8EPnuXSRwoink0N4lvK01XDZi3/huyGojIk4gfYJcNisRus=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2007 05:17:20 +0100
Message-Id: <20070112041720.28755.49663.sendpatchset@localhost.localdomain>
Subject: [PATCH 0/19] new IDE quilt tree
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

My working IDE tree (against Linus' tree) now resides here:

	http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/patches/

and is managed by quilt.


Currently it contains the following changes:

* all IDE patches from 2.6.20-rc3-mm1
  (great work done by Sergei Shtylyov <sshtylyov@ru.mvista.com>)

* atiixp fixes [in -mm already]
  (from Conke Hu <conke.hu@amd.com>)

* pci/generic update for jmicron [in -mm already]
  (from Alan Cox <alan@redhat.com>) 

* new IT8213 driver
  (from Jack Lee <Jack.Lee@ite.com.tw> and Alan Cox, some fixes by me)

* add pci_get_legacy_ide_irq() to ia64 [fixes amd74xx build] (by me)

* add missing __init tags to IDE PCI host drivers (by me)

* bunch of cleanups (by me)

diffstat:
 51 files changed, 1918 insertions(+), 1498 deletions(-)


I'm sending only new patches for review/comments.

If you would like to see the full quilt series (or to get combined patch)
against 2.6.20-rc3-mm1 / 2.6.20-rc4, they are available here:

	http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/releases/

Thanks,
Bart
