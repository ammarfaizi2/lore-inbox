Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbVCPSq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVCPSq5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVCPSpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:45:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45001 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262733AbVCPSne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:43:34 -0500
Message-ID: <42387E48.1090902@pobox.com>
Date: Wed, 16 Mar 2005 13:43:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ppc32: Update 8260_io/fcc_enet.c to function again
References: <20050315182537.GW8345@smtp.west.cox.net>
In-Reply-To: <20050315182537.GW8345@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> There's too many things in here that've sat too long (I'd been hoping to
> just delete the driver, but that hasn't happened yet, so).  A cobbled
> together list of changes is:
> 
> - Update MDIO support for workqueues.
> - Make use of <linux/mii.h>
> - Add RPX6 support.
> - Comment out set_multicast_list (broken).
> - Rework tx_ring stuff so we have tx_free, not tx_Full/n_pkts.
> - Other PHY updates/fixes.
> - Leo Li: Rework FCC clock configuration, make it easier.
> - 2.4 : VLAN header room, other misc bits.
> - Kill MII_REG_NNN in favor of defines from <linux/mii.h>
> - DM9161 PHY support (2.4, Myself & alebas@televes.com)
> - PQ2ADS and PQ2FADS support bits (Myself & alebas@televes.com

Please make sure I and netdev@oss.sgi.com are CC'd on all net driver 
patches.

Also, it would be nice to move this into drivers/net/*

	Jeff


