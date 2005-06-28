Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVF2ADj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVF2ADj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVF2ACn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:02:43 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:5563 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262257AbVF1XyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:54:15 -0400
Date: Tue, 28 Jun 2005 18:54:01 -0500
To: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Greg KH <greg@kroah.com>,
       ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: [PATCH 0/13] PCI Error Recovery Overview
Message-ID: <20050628235401.GA6272@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

The next 13 patches implement PCI error recovery along the 
lines of earlier discussions.  Its broken out into little 
pieces for easy digestability.

These should apply cleanly against kernel-2.6.12-git10

Details of what this is, and how it works, are in a
documentation file, part way down the patch.

These patches implement "native" error recovery for five devices:
-- the e100, e1000 and ixgb network cards
-- the ipr and sym53c8xx_2 scsi device drivers


[PATCH 1/13]: PCI Err: pci.h header file changes
[PATCH 2/13]: PCI Err: Overview Documentation
[PATCH 3/13]: PCI Err: IPR scsi device driver recovery
[PATCH 4/13]: PCI Err: e100 ethernet driver recovery
[PATCH 5/13]: PCI Err: e1000 ethernet driver recovery
[PATCH 6/13]: PCI Err: ixgb ethernet driver recovery
[PATCH 7/13]: PCI Err: Symbios SCSI  driver recovery
[PATCH 8/13]: PCI Err: Event delivery utility
[PATCH 9/13]: PCI Err: Whitespace janitoring
[PATCH 10/13]: PCI Err: PPC64-specific recovery infrastructure
[PATCH 11/13]: PCI Err: RPA-PHP janitoring
[PATCH 12/13]: PCI Err: RPA-PHP clarification
[PATCH 13/13]: PCI Err: RPA-PHP-specific error recovery driver


--linas
