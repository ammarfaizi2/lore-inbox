Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750753AbWFEIeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWFEIeA (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWFEIeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:34:00 -0400
Received: from peabody.ximian.com ([130.57.169.10]:16782 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1750753AbWFEId7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:33:59 -0400
Subject: [PATCH 0/9] PCI power management updates
From: Adam Belay <abelay@novell.com>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Type: text/plain
Date: Mon, 05 Jun 2006 04:45:35 -0400
Message-Id: <1149497136.7831.154.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series of patches is my first pass in an effort to improve PCI
power management.  They are against 2.6.17-rc5.  The changes include
various PCI PM improvements and fixes, with a focus on low-level
infrastructure.  All code has been tested on a limited set of hardware,
and seems to work well, but additional testing coverage will likely be
necessary.  I look forward to any suggestions or comments.

Thanks,
Adam


