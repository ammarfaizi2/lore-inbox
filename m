Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030551AbVKCX7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030551AbVKCX7Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030553AbVKCX7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:59:25 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:11155
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1030551AbVKCX7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:59:24 -0500
Date: Thu, 3 Nov 2005 17:59:18 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 0/42] PCI Error Recovery for PPC64 and misc device drivers
Message-ID: <20051103235918.GA25616@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What follows is a long sequence of mostly small patches to implement
PCI Error Recovery by adding notification callbacks to the PCI device
driver structure, implementing the recovery in 5 device drivers
(3 ethernet, two scsi drivers), and adding the actual error detection
and recovery code to the ppc64/powerpc arch tree.

Highlights:

-- Patches 1-14: Misc required ppc64/powerpc cleanup/bugfixes/restructuring
-- Patch 15: Overview documentation
-- Patch 16: changes to include/linux/pci.h
-- Patches 17-26: error detection and recovery for pSeries PCI bridge chips
-- Patchs 27-32: recovery patches for ethernet, scsi device drivers
-- Patches 33-42: More misc ppc64-specific changes

Signed-off-by: Linas Vepstas  <linas@austin.ibm.com>

