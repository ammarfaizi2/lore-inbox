Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272249AbTHIB3w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 21:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272253AbTHIB3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 21:29:52 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:6087
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S272249AbTHIB3u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 21:29:50 -0400
Date: Fri, 8 Aug 2003 21:29:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [bk patches] irda updates
Message-ID: <20030809012949.GA2193@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull http://gkernel.bkbits.net/irda-2.6

This will update the following files:

 drivers/net/irda/Kconfig      |   18 
 drivers/net/irda/Makefile     |    1 
 drivers/net/irda/donauboe.c   |  140 +--
 drivers/net/irda/irda-usb.c   |   66 +
 drivers/net/irda/tekram-sir.c |   30 
 drivers/net/irda/via-ircc.c   | 1648 ++++++++++++++++++++++++++++++++++++++++++
 drivers/net/irda/via-ircc.h   | 1044 ++++++++++++++++++++++++++
 net/irda/irlap_event.c        |   50 -
 8 files changed, 2856 insertions(+), 141 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/08/08 1.1134)
   [irda] Add VIA FIR driver, via-ircc
   
   Contributed by VIA, via Jean Tourrilhes.

<jt@bougret.hpl.hp.com> (03/08/08 1.1133)
   [PATCH] tekram-sir driver fix
   
   ir260_tekram-sir.diff :
   ~~~~~~~~~~~~~~~~~~~~~
   		<Patch from Martin Diehl>
   	o [CORRECT] Update tekram-sir dongle driver to common power-settling

<jt@bougret.hpl.hp.com> (03/08/08 1.1132)
   [PATCH] irda-usb probe fix
   
   ir260_usb_probe-4.diff :
   ~~~~~~~~~~~~~~~~~~~~~~
   		<Patch from Oliver Neukum and Daniele Bellucci>
   	o [CORRECT] minor fix to the probe failure path of irda-usb.

<jt@bougret.hpl.hp.com> (03/08/08 1.1131)
   [PATCH] IrLAP retry count
   
   ir260_lap_retry_count.diff :
   ~~~~~~~~~~~~~~~~~~~~~~~~~~
   	o [CORRECT] add interoperability workaround for 2.4.X IrDA stacks

<jt@bougret.hpl.hp.com> (03/08/08 1.1130)
   [PATCH] Donauboe probe fix
   
   ir260_donau_cleanup.diff :
   ~~~~~~~~~~~~~~~~~~~~~~~~
   		<Patch from Christian Gennerat>
   	o [CORRECT] Disable chip probing that fail too often
   	o [FEATURE] Cleanup STATIC

