Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267784AbUG3SMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267784AbUG3SMf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 14:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267781AbUG3SMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 14:12:34 -0400
Received: from omx3-ext.SGI.COM ([192.48.171.20]:55961 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267784AbUG3SME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 14:12:04 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Exposing ROM's though sysfs
Date: Fri, 30 Jul 2004 11:06:26 -0700
User-Agent: KMail/1.6.2
Cc: Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <20040730165339.76945.qmail@web14929.mail.yahoo.com> <20040730182410.A12171@infradead.org> <200407301057.12445.jbarnes@engr.sgi.com>
In-Reply-To: <200407301057.12445.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407301106.26575.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+	if (pdev->resource[PCI_ROM_RESOURCE].start) {

And before you say anything, I've already fixed this to use 
pci_resource_len(pdev, PCI_ROM_RESOURCE) instead.

Jesse
