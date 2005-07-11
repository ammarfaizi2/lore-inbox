Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVGKRWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVGKRWN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 13:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVGKRUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 13:20:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:39340 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261357AbVGKRTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 13:19:36 -0400
Date: Mon, 11 Jul 2005 10:18:30 -0700
From: Greg KH <greg@kroah.com>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Lennert Buytenhek <buytenh+lkml@liacs.nl>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       "David S. Miller" <davem@davemloft.net>, rmk+lkml@arm.linux.org.uk,
       matthew@wil.cx, grundler@parisc-linux.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, ambx1@neo.rr.com, byjac@matfyz.cz,
       herbertb@cs.vu.nl
Subject: Re: [patch 2.6.13-rc2] PCI: Add symbol exports for pci_restore_bars
Message-ID: <20050711171830.GA31050@kroah.com>
References: <20050708095104.A612@den.park.msu.ru> <20050707.233530.85417983.davem@davemloft.net> <20050708110358.A8491@jurassic.park.msu.ru> <20050708.003333.28789082.davem@davemloft.net> <20050708122043.A8779@jurassic.park.msu.ru> <20050708183452.GB13445@tuxdriver.com> <20050711144844.A16143@tin.liacs.nl> <20050711131518.GB23093@tuxdriver.com> <20050711131859.GC23093@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050711131859.GC23093@tuxdriver.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 09:19:03AM -0400, John W. Linville wrote:
> Globalize and add EXPORT_SYMBOL for pci_restore_bars.

EXPORT_SYMBOL_GPL() perhaps as this is a new function?

thanks,

greg k-h
