Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262774AbVGHTJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbVGHTJJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbVGHTJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:09:09 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27529
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262774AbVGHTJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:09:08 -0400
Date: Fri, 08 Jul 2005 12:08:09 -0700 (PDT)
Message-Id: <20050708.120809.116352369.davem@davemloft.net>
To: linville@tuxdriver.com
Cc: ink@jurassic.park.msu.ru, rmk+lkml@arm.linux.org.uk, matthew@wil.cx,
       grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       ambx1@neo.rr.com
Subject: Re: [patch 2.6.13-rc2] pci: restore BAR values from
 pci_set_power_state for D3hot->D0
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050708183452.GB13445@tuxdriver.com>
References: <20050708.003333.28789082.davem@davemloft.net>
	<20050708122043.A8779@jurassic.park.msu.ru>
	<20050708183452.GB13445@tuxdriver.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "John W. Linville" <linville@tuxdriver.com>
Date: Fri, 8 Jul 2005 14:34:56 -0400

> The cleanest implementation of pci_restore_bars was to call
> pci_update_resource.  Unfortunately, that does not currently exist
> for the sparc64 architecture.  The patch below includes a stub
> implemenation of pci_update_resource for sparc64.

I have no problems with the sparc64 part.
