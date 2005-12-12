Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVLLUCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVLLUCI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbVLLUCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:02:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:42917 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932193AbVLLUCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:02:05 -0500
Date: Mon, 12 Dec 2005 12:00:44 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 0/4] Small fixes for 2.6.15-rc5
Message-ID: <20051212200044.GA27657@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some small fixes for your current 2.6.15-rc5 git tree.  They
have all been in the past -mm releases, and fix problems.  The PCI
patches were also sent by Andi to you, so you might receive them through
his emails too.

Here's the diffstat of the combined patches.

 arch/i386/pci/direct.c           |    8 +-
 arch/i386/pci/mmconfig.c         |  141 ++++++++++++++++++++++++++++++++-------
 arch/i386/pci/pci.h              |   14 +++
 arch/x86_64/pci/mmconfig.c       |  133 ++++++++++++++++++++++++++++++------
 drivers/i2c/busses/i2c-mv64xxx.c |   25 +++---
 drivers/usb/host/uhci-hcd.c      |    6 +
 6 files changed, 261 insertions(+), 66 deletions(-)

thanks,

greg k-h
