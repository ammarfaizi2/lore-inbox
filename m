Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270612AbTGTDOr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 23:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270613AbTGTDOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 23:14:47 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:37862
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S270612AbTGTDOo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 23:14:44 -0400
Date: Sat, 19 Jul 2003 23:29:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [BK PATCHES] more 2.4.x net driver merges
Message-ID: <20030720032943.GA12272@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(just sent to Marcelo; he already merged an earlier batch)


BK users may do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.4

Others may download the patch from

ftp://ftp.??.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.22-pre7-netdrvr3.patch.bz2

This will update the following files:

 Documentation/networking/ifenslave.c |   90 +++-
 drivers/net/wireless/airo.c          |  663 ++++++++++++++++++++---------------
 2 files changed, 455 insertions(+), 298 deletions(-)

through these ChangeSets:

<shmulik.hen@intel.com> (03/07/19 1.1032)
   [bonding] fix ifenslave ABI bug

<achirica@telefonica.net> (03/07/19 1.1031)
   [wireless airo] Update to wireless extensions 16 (new spy API).

<achirica@telefonica.net> (03/07/19 1.1030)
   [wireless airo] Update to wireless extensions 15 (add monitor mode).

<achirica@telefonica.net> (03/07/19 1.1029)
   [wireless airo] Return channel in infrastructure mode.

<achirica@telefonica.net> (03/07/19 1.1028)
   [wireless airo] Checks for small packets before transmitting them.

<achirica@telefonica.net> (03/07/19 1.1027)
   [wireless airo] Returns proper status in case of transmission error.

<achirica@telefonica.net> (03/07/19 1.1026)
   [wireless airo] Fix small endianness bug.

<achirica@telefonica.net> (03/07/19 1.1025)
   [wireless airo] Don't call MIC functions if the card doesn't support them.

<achirica@telefonica.net> (03/07/19 1.1024)
   [wireless airo] Don't sleep when the stats are requested.

<achirica@telefonica.net> (03/07/19 1.1023)
   [wireless airo] Make locking "per thread" so it's fully preemptive.

<achirica@telefonica.net> (03/07/19 1.1022)
   [wireless airo] Update  structs with the new fields in latest firmwares.

<achirica@telefonica.net> (03/07/19 1.1021)
   [wireless airo] Simplify dynamic buffer code in Cisco extensions.

<achirica@telefonica.net> (03/07/19 1.1020)
   [wireless airo] sync with 2.6
   
   Trivialities: spelling, stack usage, checking return vals, etc.

