Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbTDDSen (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 13:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263869AbTDDSen (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 13:34:43 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:62992 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S263868AbTDDSem (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 13:34:42 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Keep de2104x quiet
References: <wrpsmsydtv2.fsf@hina.wild-wind.fr.eu.org>
	<20030404181256.GA26315@gtf.org>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 04 Apr 2003 20:40:51 +0200
Message-ID: <wrphe9eds24.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030404181256.GA26315@gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jgarzik@pobox.com> writes:

Jeff> Note the netif_msg_timer() test.  Just remove that bit from the
Jeff> default message bit settings.

Ok. Neat... :-)

Would you take that patch instead ?

        M.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1004  -> 1.1005 
#	drivers/net/tulip/de2104x.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/04	maz@hina.wild-wind.fr.eu.org	1.1005
# Keep the de2104x timer quiet...
# --------------------------------------------
#
diff -Nru a/drivers/net/tulip/de2104x.c b/drivers/net/tulip/de2104x.c
--- a/drivers/net/tulip/de2104x.c	Fri Apr  4 20:40:23 2003
+++ b/drivers/net/tulip/de2104x.c	Fri Apr  4 20:40:23 2003
@@ -77,7 +77,6 @@
 #define DE_DEF_MSG_ENABLE	(NETIF_MSG_DRV		| \
 				 NETIF_MSG_PROBE 	| \
 				 NETIF_MSG_LINK		| \
-				 NETIF_MSG_TIMER	| \
 				 NETIF_MSG_IFDOWN	| \
 				 NETIF_MSG_IFUP		| \
 				 NETIF_MSG_RX_ERR	| \

-- 
Places change, faces change. Life is so very strange.
