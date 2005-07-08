Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262637AbVGHGgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbVGHGgS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 02:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVGHGgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 02:36:18 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36066
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262646AbVGHGgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 02:36:07 -0400
Date: Thu, 07 Jul 2005 23:35:30 -0700 (PDT)
Message-Id: <20050707.233530.85417983.davem@davemloft.net>
To: ink@jurassic.park.msu.ru
Cc: linville@tuxdriver.com, rmk+lkml@arm.linux.org.uk, matthew@wil.cx,
       grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       ambx1@neo.rr.com
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci: restore BAR
 values in pci_enable_device_bars
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050708095104.A612@den.park.msu.ru>
References: <20050708005701.GA13384@tuxdriver.com>
	<20050707.201103.41635951.davem@davemloft.net>
	<20050708095104.A612@den.park.msu.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Date: Fri, 8 Jul 2005 09:51:04 +0400

> Why not just implement sparc64 version of pci_update_resource elsewhere
> (perhaps a dummy one, if you don't need PCI PM), rather than force the
> rest of the world to duplicate the code?

That's fine, what would be the most minimal implementation?
