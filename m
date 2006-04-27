Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWD0URq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWD0URq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWD0URp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:17:45 -0400
Received: from cantor.suse.de ([195.135.220.2]:20663 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030221AbWD0URo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:17:44 -0400
Date: Thu, 27 Apr 2006 13:16:17 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI fixes for 2.6.17-rc3
Message-ID: <20060427201617.GC2101@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some small PCI fixes against your latest git tree.  They have
all been in the -mm tree for a while with no problems.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing list, if anyone
wants to see them.

thanks,

greg k-h


 Documentation/pci.txt |   12 +++++++++++-
 arch/i386/pci/irq.c   |    1 -
 drivers/pci/msi.c     |    4 +++-
 drivers/pci/quirks.c  |    6 ++++--
 4 files changed, 18 insertions(+), 5 deletions(-)

---------------

Chris Wedgwood:
      PCI quirk: VIA IRQ fixup should only run for VIA southbridges

Greg Kroah-Hartman:
      PCI: fix via irq SATA patch

Ingo Oeser:
      PCI: Documentation: no more device ids

Jesper Juhl:
      PCI: fix potential resource leak in drivers/pci/msi.c

