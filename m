Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271129AbTHHA7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 20:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271134AbTHHA7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 20:59:21 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:46229
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S271129AbTHHA7T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 20:59:19 -0400
Date: Thu, 7 Aug 2003 20:59:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [bk patches] 2.4.x net driver updates
Message-ID: <20030808005919.GA14081@gtf.org>
Reply-To: netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(this will be sent to Marcelo when 2.4.23-pre1 opens)

BK users:

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.4

GNU diff:

ftp://ftp.??.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.22-rc1-netdrvr1.patch.bz2

This will update the following files:

 drivers/net/bonding/bond_main.c |   17 +++--------------
 drivers/net/bonding/bonding.h   |    2 +-
 drivers/net/net_init.c          |    3 ++-
 drivers/net/wireless/airo.c     |   31 +++++++++++++++++++------------
 include/linux/netdevice.h       |    2 ++
 5 files changed, 27 insertions(+), 28 deletions(-)

through these ChangeSets:

<amir.noam@intel.com> (03/08/07 1.1072)
   [netdrvr bonding] embed stats struct inside bonding private struct
   
   Simplification: Don't allocate the stats struct via kmalloc,
   embed it inside it's parent bonding_t.

<amir.noam@intel.com> (03/08/07 1.1071)
   [net] export alloc_netdev

<achirica@telefonica.net> (03/08/07 1.1070)
   [PATCH] Fix adhoc config

<achirica@telefonica.net> (03/08/07 1.1069)
   [PATCH] Safer unload code

<achirica@telefonica.net> (03/08/07 1.1068)
   [PATCH] MIC support with newer firmware

<achirica@telefonica.net> (03/08/07 1.1067)
   [PATCH] Missing lines for Wireless Extensions 16

<achirica@telefonica.net> (03/08/07 1.1066)
   [netdrvr airo] MAC type changed to unsigned

<achirica@telefonica.net> (03/08/07 1.1065)
   [netdrvr airo] Missing defines (only for documentation)

