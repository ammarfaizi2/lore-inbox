Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265627AbTFXCSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 22:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265628AbTFXCSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 22:18:07 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:16028
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S265627AbTFXCSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 22:18:04 -0400
Date: Mon, 23 Jun 2003 22:32:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [BK PATCHES] net driver merges
Message-ID: <20030624023211.GA2592@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

Others may download the patch from

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.5/2.5.73-bk1-netdrvr1.patch.bz2

This will update the following files:

 drivers/net/sk98lin/skge.c   |  598 +++++++++++++++++++++----------------------
 drivers/net/wan/sdla_chdlc.c |    4 
 drivers/net/wan/sdla_fr.c    |    4 
 drivers/net/wan/sdla_ppp.c   |    4 
 drivers/net/wan/sdla_x25.c   |    4 
 5 files changed, 297 insertions(+), 317 deletions(-)

through these ChangeSets:

<romieu@fr.zoreil.com> (03/06/23 1.1413)
   [netdrvr sk98lin] PCI API conversion, and some cleanups
   
   
   - PCI API init style conversion for drivers/net/sk98lin/skge.c;
   - new helpers: SkGeDev{Init/CleanUp};
   - sk_devs_lock moved around as it's needed early.
   
   Compiles without error. Untested.

<rusty@rustcorp.com.au> (03/06/23 1.1412)
   [PATCH] [PATCH 2.5.72] Use mod_timer in drivers_net_wan_sdla_chdlc.c
   
   From:  Vinay K Nallamothu <vinay-rc@naturesoft.net>

<rusty@rustcorp.com.au> (03/06/23 1.1411)
   [PATCH] [PATCH 2.5.72] Use mod_timer in drivers_net_wan_sdla_x25.c
   
   From:  Vinay K Nallamothu <vinay-rc@naturesoft.net>

<rusty@rustcorp.com.au> (03/06/23 1.1410)
   [PATCH] [PATCH 2.5.72] Use mod_timer in drivers_net_wan_sdla_ppp.c
   
   From:  Vinay K Nallamothu <vinay-rc@naturesoft.net>

<rusty@rustcorp.com.au> (03/06/23 1.1409)
   [PATCH] {PATCH 2.5.72] Use mod_timer in drivers_net_wan_sdla_fr.c
   
   From:  Vinay K Nallamothu <vinay-rc@naturesoft.net>

