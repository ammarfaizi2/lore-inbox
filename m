Return-Path: <linux-kernel-owner+w=401wt.eu-S1750714AbXAEUmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbXAEUmO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 15:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbXAEUmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 15:42:14 -0500
Received: from cantor.suse.de ([195.135.220.2]:44148 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714AbXAEUmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 15:42:13 -0500
Date: Fri, 5 Jan 2007 12:41:45 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: [GIT PATCH] PCI fix for 2.6.20-rc3
Message-ID: <20070105204145.GB7222@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a PCI fix for 2.6.20-rc3

It disables the multi-threaded PCI initialization code as previously
discussed.

This patch has been in the -mm tree for a while.

Please pull from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patch will be sent to the linux-pci mailing list, if anyone
wants to see it

thanks,

greg k-h


 drivers/pci/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

---------------

Andrew Morton (1):
      PCI: disable PCI_MULTITHREAD_PROBE

