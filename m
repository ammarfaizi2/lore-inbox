Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271885AbTG2QY0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 12:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271892AbTG2QY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 12:24:26 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:50668
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S271885AbTG2QYD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 12:24:03 -0400
Date: Tue, 29 Jul 2003 12:24:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [BK PATCHES] 2.4.x net driver merges
Message-ID: <20030729162401.GB1920@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BK users, pull from

	bk pull bk://gkernel.bkbits.net/net-drivers-2.4

Others may download the patch from

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.22-pre8-netdrvr1.patch.bz2

This will update the following files:

 Documentation/Configure.help         |   12 
 Documentation/networking/ifenslave.c |   90 +
 drivers/net/Config.in                |    1 
 drivers/net/Makefile                 |    1 
 drivers/net/b44.c                    | 1881 +++++++++++++++++++++++++++++++++++
 drivers/net/b44.h                    |  543 ++++++++++
 drivers/net/wireless/airo.c          |  767 ++++++++------
 7 files changed, 2962 insertions(+), 333 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/07/29 1.1039)
   [netdrvr] add new broadcom 440x net driver, "b44"
   
   By David Miller, with many fixes from Pekka Pietikainen.

<achirica@telefonica.net> (03/07/29 1.1038)
   [wireless airo] adds support for noise level reporting (if available)

<achirica@telefonica.net> (03/07/29 1.1037)
   [wireless airo] makes the card passive when entering monitor mode

<achirica@telefonica.net> (03/07/29 1.1036)
   [wireless airo] eliminate infinite loop
   
   makes sure a possible (never happened, but just in case) infinite
   loop in the transmission code terminates.

<achirica@telefonica.net> (03/07/29 1.1035)
   [wireless airo] safer shutdown sequence
   
   changes the card shutdown sequence to a safer one

<achirica@telefonica.net> (03/07/29 1.1034)
   [wireless airo] fix Tx race

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

