Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVGJRxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVGJRxl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 13:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVGJRxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 13:53:41 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:50075 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261987AbVGJRxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 13:53:40 -0400
Date: Sun, 10 Jul 2005 21:53:46 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "David S. Miller" <davem@davemloft.net>, rmk+lkml@arm.linux.org.uk,
       matthew@wil.cx, grundler@parisc-linux.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, greg@kroah.com, ambx1@neo.rr.com
Subject: Re: [patch 2.6.13-rc2] pci: restore BAR values from pci_set_power_state for D3hot->D0
Message-ID: <20050710215346.A1304@den.park.msu.ru>
References: <20050708095104.A612@den.park.msu.ru> <20050707.233530.85417983.davem@davemloft.net> <20050708110358.A8491@jurassic.park.msu.ru> <20050708.003333.28789082.davem@davemloft.net> <20050708122043.A8779@jurassic.park.msu.ru> <20050708183452.GB13445@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050708183452.GB13445@tuxdriver.com>; from linville@tuxdriver.com on Fri, Jul 08, 2005 at 02:34:56PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 02:34:56PM -0400, John W. Linville wrote:
> Some PCI devices lose all configuration (including BARs) when
> transitioning from D3hot->D0.  This leaves such a device in an
> inaccessible state.  The patch below causes the BARs to be restored
> when enabling such a device, so that its driver will be able to
> access it.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>

Acked-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

Ivan.
