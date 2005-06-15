Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVFOFfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVFOFfe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 01:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVFOFdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 01:33:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:7336 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261499AbVFOFda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 01:33:30 -0400
Date: Tue, 14 Jun 2005 22:29:16 -0700
From: Greg KH <gregkh@suse.de>
To: len.brown@intel.com, ak@suse.de
Cc: acpi-devel@lists.sourceforge.net, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: [PATCH 00/04] PCI: add proper MCFG support to let AMD boxes support MMCONFIG
Message-ID: <20050615052916.GA23394@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an update of the patch that I sent out yesterday adding MCFG
table parsing to the PCI and ACPI code.  It is now 4 patches long and
should cover parsing and using the MCFG tables properly for MMCONFIG PCI
accesses for x86_64 and i386 boxes.

I've tested this series on my i386 boxes that have MCFG tables, and
cross-compiled it for x86_64, but not run it on that arch yet (will do
so tomorrow.)  Any testing that people might be able to do on AMD boxes
that have not had MMCONFIG PCI support yet would be greatly appreciated.

Comments appreciated.  These patches are now in my pci patch set and
should show up in the next -mm release.

thanks,

greg k-h
