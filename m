Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263881AbUE1VkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbUE1VkC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbUE1Vgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:36:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:21425 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263885AbUE1Ve7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:34:59 -0400
Date: Fri, 28 May 2004 14:33:21 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI fixes for 2.6.7-rc1
Message-ID: <20040528213321.GA12726@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some small PCI patches for 2.6.7-rc1.  They are a few pci id
updates, janitor fixes, and a suspend bus fix patch.  They have all been
in the last few -mm releases.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 drivers/pci/pci-driver.c |   26 ++++++++++++++++++++++++--
 drivers/pci/pci.c        |    5 +++++
 drivers/pci/pci.ids      |   26 +++++++++++++-------------
 drivers/pci/probe.c      |    2 ++
 include/linux/pci.h      |    5 +++++
 include/linux/pci_ids.h  |   16 ++++++++++++++++
 6 files changed, 65 insertions(+), 15 deletions(-)
-----

<trimmer:infiniconsys.com>:
  o PCI: Add InfiniCon PCI ID to pci_ids.h

Arjan van de Ven:
  o PCI: restore pci config space on resume

Greg Kroah-Hartman:
  o Reversed pci.ids changes, as Linus already fixed them in his tree
  o PCI: fix up build warnings in pci.ids file

Luiz Capitulino:
  o PCI: fix pci/probe.c possible NULL pointer

Roland Dreier:
  o PCI: Add InfiniBand HCA IDs to pci_ids.h

