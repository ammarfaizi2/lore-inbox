Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTI0Alf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 20:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTI0Alf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 20:41:35 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:35027 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261743AbTI0Ald (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 20:41:33 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: joe.korty@ccur.com
Cc: Jim Deas <jdeas@jadsystems.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030926211740.GA27352@tsunami.ccur.com>
References: <1064609623.16160.11.camel@ArchiveLinux>
	 <20030926211740.GA27352@tsunami.ccur.com>
Message-Id: <1064623209.631.26.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 27 Sep 2003 02:40:10 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: Prefered method to map PCI memory into userspace.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Albert Cahalan wrote a patch, for 2.6, that makes mmappable all PCI device
> memory regions.  They show up as files in the appropriate subdirectories
> under /proc/bus/pci.  See http://lkml.org/lkml/2003/7/13/258 for the
> patch and details.

mmap of /proc/bus/pci is a standard thing in 2.4 already and so in 2.6
as well, though not all archs may implement it..

Regarding bus mastering, there's no way to do that without a kernel
driver.

Ben.


